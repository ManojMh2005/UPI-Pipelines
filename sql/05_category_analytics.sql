-- Use database and MART schema
USE DATABASE UPI_DB;
USE SCHEMA MART;

-- Transaction category analytics
CREATE OR REPLACE TABLE CATEGORY_ANALYTICS AS
SELECT
    transaction_type,
    SUM(transaction_count) AS total_transactions,
    SUM(transaction_amount) AS total_transaction_value,

    ROUND(
        SUM(transaction_amount) * 100.0
        / SUM(SUM(transaction_amount)) OVER (),
        2
    ) AS value_contribution_pct

FROM UPI_DB.STAGING.TRANSACTIONS_CLEAN

GROUP BY transaction_type;