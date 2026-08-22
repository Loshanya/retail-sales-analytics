-- Identify high-value customers
SELECT
    c.cust_id,
    c.age,
    c.gender,
    c.city,
    c.loyalty_segment,
    COUNT(fs.sale_id) AS transactions,
    SUM(fs.quantity) AS units_purchased,
    ROUND(SUM(fs.total_value), 2) AS total_spent,
    ROUND(AVG(fs.total_value), 2) AS avg_transaction_value
FROM fact_sales fs
JOIN dim_customer c
    ON fs.cust_id = c.cust_id
GROUP BY
    c.cust_id,
    c.age,
    c.gender,
    c.city,
    c.loyalty_segment
ORDER BY total_spent DESC
LIMIT 20;