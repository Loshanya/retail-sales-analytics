-- Correct inventory turnover by category
WITH sales_by_sku AS (
    SELECT
        sku_id,
        SUM(quantity) AS units_sold_90d
    FROM fact_sales
    WHERE sale_date BETWEEN '2025-08-03' AND '2025-10-31'
    GROUP BY sku_id
),

inventory_by_sku AS (
    SELECT
        sku_id,
        SUM(stock_on_hand) AS inventory_units
    FROM fact_inventory
    WHERE snapshot_date = '2025-10-31'
    GROUP BY sku_id
)

SELECT
    s.category,
    SUM(COALESCE(sa.units_sold_90d, 0)) AS units_sold_90d,
    SUM(i.inventory_units) AS inventory_units,

    ROUND(
        SUM(COALESCE(sa.units_sold_90d, 0))
        / NULLIF(SUM(i.inventory_units), 0),
        2
    ) AS turnover_90d

FROM dim_sku s

JOIN inventory_by_sku i
    ON s.sku_id = i.sku_id

LEFT JOIN sales_by_sku sa
    ON s.sku_id = sa.sku_id

GROUP BY s.category
ORDER BY turnover_90d DESC;