# E-Commerce Analytics System

## Overview

This project is an end-to-end data analytics system built using Python, Pandas, MySQL, and SQL. It simulates an e-commerce business by generating synthetic datasets, cleaning inconsistent data, loading it into a relational database, and performing advanced SQL analytics to derive business insights.

The system also includes a Command-Line Interface (CLI) reporting tool that generates dynamic reports from the database.

---

## Objectives

- Generate realistic e-commerce datasets
- Introduce intentional inconsistencies
- Clean and validate data using Pandas
- Maintain referential integrity
- Load cleaned data into MySQL
- Perform SQL analytics
- Build a CLI reporting tool
- Handle edge cases

---

## Technologies Used

- Python 3.x
- Pandas
- NumPy
- Faker
- SQLAlchemy
- MySQL
- VS Code
- MySQL Workbench

---

## Project Structure

```
ecommerce-analytics-system/
│
├── data/
│   ├── raw/
│   └── cleaned/
│
├── database/
│
├── scripts/
│   ├── generate_data.py
│   ├── clean_data.py
│   ├── load_database.py
│   └── report_cli.py
│
├── sql/
│   ├── schema.sql
│   ├── aggregations.sql
│   ├── window_functions.sql
│   ├── cohort_analysis.sql
│   └── customer_segmentation.sql
│
├── output/
│   └── sample_reports/
│
└── README.md
```

---

## Dataset

The project generates four datasets:

- Customers
- Products
- Orders
- Order Items

Intentional inconsistencies include:

- Missing values
- Duplicate records
- Invalid product prices
- Invalid customer IDs
- Invalid order IDs
- Negative quantities
- Future order dates

---

## Data Cleaning

Cleaning includes:

- Removing duplicates
- Filling missing values
- Correcting data types
- Removing invalid records
- Enforcing referential integrity

---

## Database

Database: **MySQL**

Tables:

- customers
- products
- orders
- order_items

Constraints:

- Primary Keys
- Foreign Keys
- NOT NULL
- CHECK constraints

---

## SQL Analytics

The project performs:

### Joins

- Revenue per customer
- Revenue by category
- Revenue by month

### Aggregations

- Total sales
- Average Order Value
- Top products
- Top customers

### Window Functions

- RANK()
- DENSE_RANK()
- ROW_NUMBER()
- Running Totals
- Moving Average
- Monthly Growth

### Cohort Analysis

- Cohort Size
- Monthly Retention
- Churn Analysis

### Customer Segmentation

- Purchase Frequency
- Spend Tier
- RFM Analysis

---

## Running the Project

### 1 Generate Dataset

```bash
python scripts/generate_data.py
```

### 2 Clean Dataset

```bash
python scripts/clean_data.py
```

### 3 Load into MySQL

```bash
python scripts/load_database.py
```

### 4 Run Reports

Revenue

```bash
python scripts/report_cli.py --report revenue
```

Top Customers

```bash
python scripts/report_cli.py --report top_customers
```

Top Products

```bash
python scripts/report_cli.py --report top_products
```

Retention

```bash
python scripts/report_cli.py --report retention
```

RFM

```bash
python scripts/report_cli.py --report rfm
```

---

## Edge Cases Handled

- Invalid customer IDs
- Invalid product IDs
- Future dates
- Duplicate rows
- Missing values
- Empty query results
- Database connection errors
- Invalid CLI arguments

---

## Sample Reports

The CLI generates reports such as:

- Monthly Revenue
- Top Customers
- Top Products
- Cohort Retention
- RFM Analysis

---

## Business Insights

The analytics help answer questions like:

- Who are the highest-value customers?
- Which products generate the most revenue?
- Which product categories perform best?
- How much revenue is generated each month?
- Which customers are retained over time?
- Which customers are likely to churn?
- How should customers be segmented based on purchasing behavior?

---

## Author

Sanjay Kumar Sah

Celebal Technologies Internship Assignment

2026
