-- Which individual products are driving the revenue?
SELECT
    s.sku_id,
    s.sku_name,
    s.category,
    s.subcategory,
    SUM(fs.quantity) AS units_sold,
    ROUND(SUM(fs.total_value), 2) AS revenue
FROM fact_sales fs
JOIN dim_sku s
    ON fs.sku_id = s.sku_id
GROUP BY
    s.sku_id,
    s.sku_name,
    s.category,
    s.subcategory
ORDER BY revenue DESC
LIMIT 10;