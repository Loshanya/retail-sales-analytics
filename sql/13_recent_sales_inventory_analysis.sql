-- Create recent sales summary
CREATE TEMPORARY TABLE recent_sales AS
SELECT
    sku_id,
    SUM(quantity) AS units_sold_90d
FROM fact_sales
WHERE sale_date >= '2025-08-03'
  AND sale_date <= '2025-10-31'
GROUP BY sku_id;
SELECT COUNT(*) AS skus_with_recent_sales
FROM recent_sales;
SELECT
    i.sku_id,
    s.sku_name,
    s.category,
    i.stock_on_hand,
    i.reorder_point,
    i.safety_stock,
    COALESCE(r.units_sold_90d, 0) AS units_sold_90d,

    ROUND(
        COALESCE(r.units_sold_90d, 0) / 3.0,
        2
    ) AS avg_monthly_sales,

    CASE
        WHEN COALESCE(r.units_sold_90d, 0) = 0
            THEN NULL
        ELSE ROUND(
            i.stock_on_hand /
            (r.units_sold_90d / 3.0),
            2
        )
    END AS months_of_inventory

FROM fact_inventory i

JOIN dim_sku s
    ON i.sku_id = s.sku_id

LEFT JOIN recent_sales r
    ON i.sku_id = r.sku_id

ORDER BY months_of_inventory DESC;