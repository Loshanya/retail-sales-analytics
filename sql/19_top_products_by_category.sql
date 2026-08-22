-- Top 3 products within each category
WITH product_revenue AS (
    SELECT
        s.category,
        s.sku_id,
        s.sku_name,
        SUM(fs.quantity) AS units_sold,
        SUM(fs.total_value) AS revenue
    FROM fact_sales fs
    JOIN dim_sku s
        ON fs.sku_id = s.sku_id
    GROUP BY
        s.category,
        s.sku_id,
        s.sku_name
),

ranked_products AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_revenue
)

SELECT
    category,
    sku_id,
    sku_name,
    units_sold,
    ROUND(revenue, 2) AS revenue,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY category, product_rank;
