-- How much revenue did the business generate?
USE retail_analytics;

SELECT
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(total_value), 2) AS total_revenue,
    ROUND(AVG(total_value), 2) AS average_transaction_value
FROM fact_sales;