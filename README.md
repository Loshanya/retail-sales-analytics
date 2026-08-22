# Retail Sales & Inventory Analytics

## Project Overview

This project focuses on analyzing retail sales and inventory data using Python, MySQL, SQL, and Power BI.

The objective was to transform raw retail data into a structured analytical database, perform SQL-based business analysis, and build an interactive Power BI dashboard to understand sales performance, customer behavior, product performance, store performance, sales channels, and inventory.

The project follows the workflow:

Raw Data → Data Cleaning → MySQL Database → SQL Analysis → Power BI Dashboard

The dataset contains 641K+ sales transactions and multiple entities including customers, products, stores, inventory, and promotions.

---
Tools & Technologies
Programming: Python
Data Cleaning: Jupyter Notebook
Database: MySQL
Analysis: SQL
Visualization: Power BI
Data Modeling: Fact-Dimension / Star Schema
Version Control: Git & GitHub


## Key Components

### 1. Data Cleaning & Preparation

The raw CSV datasets were initially inspected and cleaned using Python and Jupyter Notebook.

The preprocessing included:

- Handling missing values
- Converting columns to appropriate data types
- Cleaning and standardizing date fields
- Handling missing customer IDs
- Preparing the datasets for database loading

The data-cleaning notebook is available in the `data/` directory.

### 2. Database Design

The cleaned data was loaded into MySQL and organized into a relational fact-dimension structure.

The database consists of:

**Fact Tables**
- `fact_sales`
- `fact_inventory`

**Dimension Tables**
- `dim_customer`
- `dim_sku`
- `dim_store`
- `dim_promotion`

A staging table was also used during the data loading process.

The database setup and loading process is available in `sql/01_database_setup.sql`.

### 3. SQL Business Analysis

A series of SQL queries were developed to answer business-oriented questions across sales, customers, products, stores, and inventory.

The analysis covers:

- Overall sales KPIs
- Year-wise sales trends
- Revenue by category
- Top-performing products
- Store performance and rankings
- City-wise store rankings
- High-value customers
- Customer loyalty analysis
- Inventory versus sales
- Inventory coverage
- Inventory movement classification
- Slow-moving inventory
- Inventory turnover
- Sales channel performance
- Year-over-year growth
- Top products by category
- Customer purchase behavior
- Promotion effectiveness

The individual SQL analyses are available in the `sql/` directory.

SQL Concepts Used

The project uses a range of SQL concepts, including:

SELECT, WHERE and CASE
GROUP BY and HAVING
Aggregate functions
INNER and LEFT JOINs
Common Table Expressions (CTEs)
Window functions
RANK and ROW_NUMBER
Partitioning
Date functions
Conditional aggregation
Temporary tables
Subqueries
Percentage and contribution analysis

### 4. Power BI Dashboard

The MySQL database was connected to Power BI to build an interactive analytical dashboard.

The dashboard includes:

- Total Revenue
- Total Transactions
- Total Units Sold
- Average Transaction Value
- Monthly Revenue Trend
- Revenue by Category
- Top 10 Products by Revenue
- Top 10 Stores by Revenue
- Revenue by Customer Segment
- Revenue by Sales Channel
- Inventory by Category

Year and Category slicers were added to allow users to dynamically filter the dashboard.

---

## Project Structure

```text
retail-sales-analytics/
│
├── data/
│   ├── data_cleaning.ipynb
│   └── README.md
│
├── sql/
│   ├── 01_database_setup.sql
│   ├── 02_overall_sales_kpis.sql
│   ├── 03_yearly_sales_trend.sql
│   ├── ...
│   └── 22_final_business_kpis.sql
│
├── powerbi/
│   └── Retail_Sales_Analytics_Dashboard.pbix
│
├── screenshots/
│   └── dashboard.png
│
└── README.md

Results & Insights

The analysis produced several useful business insights:

Analyzed more than 641K sales transactions.
Generated approximately 73.2M in total revenue.
More than 1.67M units were sold across the analyzed period.
Electronics was the largest revenue-contributing category.
Top-performing products and stores were identified using SQL ranking techniques.
Customer segments were compared based on their contribution to revenue.
Sales channels were analyzed to understand their relative contribution to overall sales.
Inventory movement and slow-moving inventory were analyzed to identify potential areas for optimization.

The Power BI dashboard provides an interactive view of these findings and allows users to filter the analysis by year and product category.
