-- Classify SKUs by movement
SELECT
    i.sku_id,
    s.sku_name,
    s.category,
    i.stock_on_hand,

    COALESCE(r.units_sold_90d, 0) AS units_sold_90d,

    CASE
        WHEN COALESCE(r.units_sold_90d, 0) = 0
            THEN 'No Sales'
        WHEN i.stock_on_hand / (r.units_sold_90d / 3.0) < 2
            THEN 'Fast'
        WHEN i.stock_on_hand / (r.units_sold_90d / 3.0) <= 6
            THEN 'Moderate'
        ELSE 'Slow'
    END AS movement_category

FROM fact_inventory i

JOIN dim_sku s
    ON i.sku_id = s.sku_id

LEFT JOIN recent_sales r
    ON i.sku_id = r.sku_id

ORDER BY
    CASE
        WHEN COALESCE(r.units_sold_90d, 0) = 0 THEN 1
        WHEN i.stock_on_hand / (r.units_sold_90d / 3.0) > 6 THEN 2
        WHEN i.stock_on_hand / (r.units_sold_90d / 3.0) >= 2 THEN 3
        ELSE 4
    END,
    i.stock_on_hand DESC;