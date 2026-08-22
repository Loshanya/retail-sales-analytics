SELECT
    s.category,
    COUNT(*) AS transactions,
    SUM(fs.quantity) AS units_sold,
    ROUND(SUM(fs.total_value), 2) AS revenue,
    ROUND(
        100 * SUM(fs.total_value) /
        SUM(SUM(fs.total_value)) OVER (),
        2
    ) AS revenue_share_pct
FROM fact_sales fs
JOIN dim_sku s
    ON fs.sku_id = s.sku_id
GROUP BY s.category
ORDER BY revenue DESC;