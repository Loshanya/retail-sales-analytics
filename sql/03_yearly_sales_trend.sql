-- Is revenue increasing or decreasing over the years?
SELECT
    YEAR(sale_date) AS year,
    COUNT(*) AS transactions,
    SUM(quantity) AS units_sold,
    ROUND(SUM(total_value), 2) AS revenue
FROM fact_sales
GROUP BY YEAR(sale_date)
ORDER BY year;