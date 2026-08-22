-- Identify the slow-moving inventory value
SELECT
    s.category,
    COUNT(*) AS slow_skus,
    SUM(i.stock_on_hand) AS slow_units,
    ROUND(SUM(i.stock_on_hand * s.cost_price), 2) AS inventory_cost_value
FROM fact_inventory i
JOIN dim_sku s
    ON i.sku_id = s.sku_id
LEFT JOIN recent_sales r
    ON i.sku_id = r.sku_id
WHERE
    COALESCE(r.units_sold_90d, 0) = 0
    OR i.stock_on_hand / (r.units_sold_90d / 3.0) > 6
GROUP BY s.category
ORDER BY inventory_cost_value DESC;
SELECT
    CASE
        WHEN COALESCE(r.units_sold_90d, 0) = 0 THEN 'No Sales'
        WHEN i.stock_on_hand / (r.units_sold_90d / 3.0) < 2 THEN 'Fast'
        WHEN i.stock_on_hand / (r.units_sold_90d / 3.0) <= 6 THEN 'Moderate'
        ELSE 'Slow'
    END AS movement_category,
    COUNT(*) AS sku_count,
    SUM(i.stock_on_hand) AS total_stock
FROM fact_inventory i
LEFT JOIN recent_sales r
    ON i.sku_id = r.sku_id
GROUP BY movement_category
ORDER BY sku_count DESC;