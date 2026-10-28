-- Use database and MART schema
USE DATABASE UPI_DB;
USE SCHEMA MART;

-- State-level analytics
CREATE OR REPLACE TABLE STATE_ANALYTICS AS
SELECT
    state,
    SUM(transaction_count) AS total_transactions,
    SUM(transaction_amount) AS total_transaction_value,
    AVG(average_transaction_value) AS avg_transaction_value,

    RANK() OVER (
        ORDER BY SUM(transaction_amount) DESC
    ) AS state_rank

FROM UPI_DB.STAGING.TRANSACTIONS_CLEAN

GROUP BY state;