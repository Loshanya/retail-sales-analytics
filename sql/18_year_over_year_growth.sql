-- Year-over-year revenue growth
WITH yearly_revenue AS (
    SELECT
        YEAR(sale_date) AS year,
        SUM(total_value) AS revenue
    FROM fact_sales
    GROUP BY YEAR(sale_date)
)

SELECT
    year,
    ROUND(revenue, 2) AS revenue,
    ROUND(
        LAG(revenue) OVER (ORDER BY year),
        2
    ) AS previous_year_revenue,
    ROUND(
        100 * (
            revenue - LAG(revenue) OVER (ORDER BY year)
        ) / NULLIF(LAG(revenue) OVER (ORDER BY year), 0),
        2
    ) AS yoy_growth_pct
FROM yearly_revenue
ORDER BY year;
