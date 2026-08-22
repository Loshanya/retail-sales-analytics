-- Repeat vs one-time customers
WITH customer_orders AS (
    SELECT
        cust_id,
        COUNT(*) AS order_count,
        SUM(total_value) AS total_spent
    FROM fact_sales
    WHERE cust_id IS NOT NULL
    GROUP BY cust_id
)

SELECT
    CASE
        WHEN order_count = 1 THEN 'One-time'
        WHEN order_count BETWEEN 2 AND 5 THEN 'Repeat'
        ELSE 'Loyal'
    END AS customer_type,
    COUNT(*) AS customers,
    ROUND(SUM(total_spent), 2) AS revenue,
    ROUND(AVG(total_spent), 2) AS avg_customer_spend
FROM customer_orders
GROUP BY customer_type
ORDER BY revenue DESC;
