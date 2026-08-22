-- Which products have a lot of inventory relative to how quickly they're selling?
SELECT
    s.sku_id,
    s.sku_name,
    s.category,
    i.stock_on_hand,
    i.reorder_point,
    i.safety_stock,
    SUM(fs.quantity) AS total_units_sold,
    ROUND(SUM(fs.total_value), 2) AS total_revenue
FROM fact_inventory i
JOIN dim_sku s
    ON i.sku_id = s.sku_id
LEFT JOIN fact_sales fs
    ON i.sku_id = fs.sku_id
GROUP BY
    s.sku_id,
    s.sku_name,
    s.category,
    i.stock_on_hand,
    i.reorder_point,
    i.safety_stock
ORDER BY total_units_sold ASC;