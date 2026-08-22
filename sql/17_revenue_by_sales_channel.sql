-- Which sales channel — Store, Website, or MobileApp — generates the most revenue?
SELECT
    channel,
    COUNT(*) AS transactions,
    SUM(quantity) AS units_sold,
    ROUND(SUM(total_value), 2) AS revenue,
    ROUND(AVG(total_value), 2) AS avg_transaction_value
FROM fact_sales
GROUP BY channel
ORDER BY revenue DESC;
