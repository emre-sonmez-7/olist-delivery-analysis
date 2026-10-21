-- Question: Which month has the highest revenue, and how much?
-- Answer: 2017-11 with 1,003,862.14 (7,421 orders)

SELECT *
FROM (
    SELECT
        strftime('%Y-%m', o.order_purchase_timestamp) AS year_month,
        COUNT(DISTINCT o.order_id)                    AS order_count,
        ROUND(SUM(oi.price), 2)                       AS revenue
    FROM orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
      AND o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp <  '2018-09-01'
    GROUP BY year_month
)
ORDER BY revenue DESC
LIMIT 3;