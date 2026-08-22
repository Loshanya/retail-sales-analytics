-- Final business KPI summary
SELECT
    COUNT(*) AS total_transactions,
    SUM(quantity) AS total_units_sold,
    ROUND(SUM(total_value), 2) AS total_revenue,
    ROUND(AVG(total_value), 2) AS avg_transaction_value,
    ROUND(MIN(total_value), 2) AS smallest_transaction,
    ROUND(MAX(total_value), 2) AS largest_transaction,
    COUNT(DISTINCT sku_id) AS active_skus,
    COUNT(DISTINCT store_id) AS active_stores,
    COUNT(DISTINCT cust_id) AS identified_customers
FROM fact_sales;
