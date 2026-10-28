-- Use database and MART schema
USE DATABASE UPI_DB;
USE SCHEMA MART;

-- Quarterly growth analytics
CREATE OR REPLACE TABLE GROWTH_ANALYTICS AS

WITH quarterly_data AS (

    SELECT
        state,
        year,
        quarter,
        period,

        SUM(transaction_count) AS total_transactions,
        SUM(transaction_amount) AS total_transaction_value

    FROM UPI_DB.STAGING.TRANSACTIONS_CLEAN

    GROUP BY
        state,
        year,
        quarter,
        period
),

with_previous AS (

    SELECT
        state,
        year,
        quarter,
        period,
        total_transactions,
        total_transaction_value,

        LAG(total_transaction_value) OVER (
            PARTITION BY state
            ORDER BY year, quarter
        ) AS previous_quarter_value

    FROM quarterly_data
)

SELECT
    state,
    year,
    quarter,
    period,
    total_transactions,
    total_transaction_value,
    previous_quarter_value,

    ROUND(
        (
            (total_transaction_value - previous_quarter_value)
            / NULLIF(previous_quarter_value, 0)
        ) * 100,
        2
    ) AS qoq_growth_pct

FROM with_previous;