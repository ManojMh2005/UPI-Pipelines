-- Use database
USE DATABASE UPI_DB;

-- ==========================================
-- 1. RAW DATA VALIDATION
-- ==========================================

SELECT
    COUNT(*) AS total_rows,
    COUNT_IF(transaction_count < 0) AS negative_counts,
    COUNT_IF(transaction_amount < 0) AS negative_amounts,
    COUNT_IF(state IS NULL) AS null_states,
    COUNT_IF(transaction_type IS NULL) AS null_transaction_types
FROM RAW.TRANSACTIONS;


-- ==========================================
-- 2. STAGING DATA VALIDATION
-- ==========================================

SELECT
    COUNT(*) AS total_rows,
    COUNT_IF(transaction_count < 0) AS negative_counts,
    COUNT_IF(transaction_amount < 0) AS negative_amounts,
    COUNT_IF(state IS NULL) AS null_states,
    COUNT_IF(transaction_type IS NULL) AS null_transaction_types
FROM STAGING.TRANSACTIONS_CLEAN;


-- ==========================================
-- 3. CHECK DUPLICATE TRANSACTIONS
-- ==========================================

SELECT
    state,
    year,
    quarter,
    transaction_type,
    COUNT(*) AS record_count

FROM RAW.TRANSACTIONS

GROUP BY
    state,
    year,
    quarter,
    transaction_type

HAVING COUNT(*) > 1;


-- ==========================================
-- 4. MART TABLE RECORD COUNTS
-- ==========================================

SELECT
    'STATE_ANALYTICS' AS table_name,
    COUNT(*) AS records
FROM MART.STATE_ANALYTICS

UNION ALL

SELECT
    'CATEGORY_ANALYTICS',
    COUNT(*)
FROM MART.CATEGORY_ANALYTICS

UNION ALL

SELECT
    'GROWTH_ANALYTICS',
    COUNT(*)
FROM MART.GROWTH_ANALYTICS;


-- ==========================================
-- 5. TOP STATES
-- ==========================================

SELECT
    state,
    total_transactions,
    total_transaction_value,
    avg_transaction_value,
    state_rank

FROM MART.STATE_ANALYTICS

ORDER BY state_rank

LIMIT 10;


-- ==========================================
-- 6. CATEGORY VALIDATION
-- ==========================================

SELECT
    transaction_type,
    total_transactions,
    total_transaction_value,
    value_contribution_pct

FROM MART.CATEGORY_ANALYTICS

ORDER BY value_contribution_pct DESC;


-- ==========================================
-- 7. GROWTH VALIDATION
-- ==========================================

SELECT
    state,
    period,
    qoq_growth_pct

FROM MART.GROWTH_ANALYTICS

WHERE qoq_growth_pct IS NOT NULL

ORDER BY qoq_growth_pct DESC

LIMIT 10;