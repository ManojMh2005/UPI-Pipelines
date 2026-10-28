# UPI Digital Payments Analytics

An end-to-end data analytics project that analyzes UPI transaction data across Indian states and transaction categories.

## About the Project

I built this project to practice an end-to-end data analytics workflow, starting from data extraction and transformation and ending with SQL analysis and a Power BI dashboard.

The project uses PhonePe Pulse aggregated and anonymized data for 2023–2024.

The analysis focuses on:

- Transaction volume and value
- State-wise performance
- Transaction categories
- Average transaction value
- Quarterly trends
- Quarter-over-quarter (QoQ) growth

## Tools Used

- **Python** – Data extraction and transformation
- **Pandas** – Data cleaning and processing
- **Snowflake** – Data storage and analytics
- **SQL** – Data analysis
- **Power BI** – Dashboard and visualization
- **Git & GitHub** – Version control

## Project Flow

```text
PhonePe Pulse Data
       ↓
Python + Pandas
       ↓
CSV
       ↓
Snowflake
RAW → STAGING → MART
       ↓
SQL Analysis
       ↓
Power BI Dashboard
```

## What I Worked On

### Python

- Extracted transaction data using Python
- Processed the data using Pandas
- Created reporting periods and average transaction value
- Performed basic data quality checks

### Snowflake & SQL

Created three analytical tables:

- `STATE_ANALYTICS`
- `CATEGORY_ANALYTICS`
- `GROWTH_ANALYTICS`

Used SQL concepts such as:

- `GROUP BY`
- CTEs
- Window functions
- `LAG()`
- `RANK()`
- Data validation

### Power BI

Created a dashboard covering:

- Overall transaction KPIs
- Top states by transaction value
- Transaction category contribution
- Quarterly transaction trends
- QoQ growth analysis

## Dashboard

### Executive Overview

![Executive Overview](screenshots/executive_overview.png)

### State Analysis

![State Analysis](screenshots/state_analysis.png)

### Growth & Category Analysis

![Growth & Category Analysis](screenshots/growth_category_analysis.png)

## Project Structure

```text
UPI-Pipelines/
│
├── data/
├── sql/
├── src/
├── screenshots/
├── tests/
├── requirements.txt
├── .gitignore
└── README.md
```

## What I Learned

Through this project, I gained practical experience in building a small data pipeline, working with Snowflake, writing analytical SQL queries, and creating a Power BI dashboard from processed data.

## Author

**Manoj  M H **

Computer Science Engineering Graduate | Aspiring Data Analyst

[GitHub](https://github.com/ManojMh2005)

[Portfolio](https://manojmh.vercel.app/)
