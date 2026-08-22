-- Which stores generate the most revenue
SELECT
    st.store_id,
    st.store_name,
    st.city,
    st.store_type,
    COUNT(*) AS transactions,
    SUM(fs.quantity) AS units_sold,
    ROUND(SUM(fs.total_value), 2) AS revenue,
    ROUND(AVG(fs.total_value), 2) AS avg_transaction_value
FROM fact_sales fs
JOIN dim_store st
    ON fs.store_id = st.store_id
GROUP BY
    st.store_id,
    st.store_name,
    st.city,
    st.store_type
ORDER BY revenue DESC;