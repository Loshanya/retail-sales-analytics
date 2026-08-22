-- Promotion effectiveness
SELECT
    CASE
        WHEN discount_pct > 0 THEN 'Promotional'
        ELSE 'Non-Promotional'
    END AS sales_type,
    COUNT(*) AS transactions,
    SUM(quantity) AS units_sold,
    ROUND(SUM(total_value), 2) AS revenue,
    ROUND(AVG(total_value), 2) AS avg_transaction_value,
    ROUND(AVG(discount_pct), 2) AS avg_discount_pct
FROM fact_sales
GROUP BY sales_type
ORDER BY revenue DESC;
