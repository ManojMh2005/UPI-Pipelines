-- Use database and STAGING schema
USE DATABASE UPI_DB;
USE SCHEMA STAGING;

-- Create cleaned staging table
CREATE OR REPLACE TABLE TRANSACTIONS_CLEAN AS
SELECT
    TRIM(state) AS state,
    year,
    quarter,
    TRIM(transaction_type) AS transaction_type,
    transaction_count,
    transaction_amount,
    quarter_label,
    period,
    average_transaction_value
FROM UPI_DB.RAW.TRANSACTIONS
WHERE state IS NOT NULL
  AND year IS NOT NULL
  AND quarter IS NOT NULL
  AND transaction_type IS NOT NULL
  AND transaction_count IS NOT NULL
  AND transaction_amount IS NOT NULL;

-- Check number of cleaned records
SELECT COUNT(*) AS staging_rows
FROM TRANSACTIONS_CLEAN;