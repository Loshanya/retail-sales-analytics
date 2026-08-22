-- Revenue by loyalty segment 
SELECT
    c.loyalty_segment,
    COUNT(DISTINCT c.cust_id) AS customers,
    COUNT(fs.sale_id) AS transactions,
    SUM(fs.quantity) AS units_purchased,
    ROUND(SUM(fs.total_value), 2) AS revenue,
    ROUND(AVG(fs.total_value), 2) AS avg_transaction_value
FROM fact_sales fs
JOIN dim_customer c
    ON fs.cust_id = c.cust_id
GROUP BY c.loyalty_segment
ORDER BY revenue DESC;