-- Rank stores within each city
SELECT
    st.city,
    st.store_id,
    st.store_name,
    ROUND(SUM(fs.total_value), 2) AS revenue,
    RANK() OVER (
        PARTITION BY st.city
        ORDER BY SUM(fs.total_value) DESC
    ) AS city_rank
FROM fact_sales fs
JOIN dim_store st
    ON fs.store_id = st.store_id
GROUP BY
    st.city,
    st.store_id,
    st.store_name
ORDER BY
    st.city,
    city_rank;