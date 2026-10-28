-- Use database and RAW schema
USE DATABASE UPI_DB;
USE SCHEMA RAW;

-- Create raw transaction table
CREATE OR REPLACE TABLE TRANSACTIONS (
    state VARCHAR,
    year INTEGER,
    quarter INTEGER,
    transaction_type VARCHAR,
    transaction_count BIGINT,
    transaction_amount FLOAT,
    quarter_label VARCHAR,
    period VARCHAR,
    average_transaction_value FLOAT
);

-- Create CSV file format
CREATE OR REPLACE FILE FORMAT UPI_CSV_FORMAT
TYPE = 'CSV'
FIELD_OPTIONALLY_ENCLOSED_BY = '"'
SKIP_HEADER = 1;

-- Create Snowflake stage for CSV upload
CREATE OR REPLACE STAGE UPI_STAGE
FILE_FORMAT = UPI_CSV_FORMAT;