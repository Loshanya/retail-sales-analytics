-- Rank stores by revenue
SELECT
    st.store_id,
    st.store_name,
    st.city,
    ROUND(SUM(fs.total_value), 2) AS revenue,
    RANK() OVER (
        ORDER BY SUM(fs.total_value) DESC
    ) AS revenue_rank
FROM fact_sales fs
JOIN dim_store st
    ON fs.store_id = st.store_id
GROUP BY
    st.store_id,
    st.store_name,
    st.city
ORDER BY revenue_rank;