-- Question: How do Jan-Aug 2017 and Jan-Aug 2018 compare (orders, revenue, growth)?
-- Same months in both years, so the comparison is fair (2017 has 12 months, 2018 only 8).
-- Scope and definitions: same as 01_monthly_revenue.sql
WITH yearly AS (
    SELECT
        strftime('%Y', o.order_purchase_timestamp) AS year,
        COUNT(DISTINCT o.order_id)                 AS order_count,
        ROUND(SUM(oi.price), 2)                    AS revenue
    FROM orders AS o
    JOIN order_items AS oi ON o.order_id = oi.order_id
    WHERE o.order_status NOT IN ('canceled', 'unavailable')
      AND strftime('%m', o.order_purchase_timestamp) BETWEEN '01' AND '08'
      AND o.order_purchase_timestamp >= '2017-01-01'
      AND o.order_purchase_timestamp <  '2018-09-01'
    GROUP BY year
)
SELECT
    year,
    order_count,
    revenue,
    ROUND((order_count * 1.0 / LAG(order_count) OVER (ORDER BY year) - 1) * 100, 1) AS order_growth_pct,
    ROUND((revenue * 1.0 / LAG(revenue) OVER (ORDER BY year) - 1) * 100, 1)         AS revenue_growth_pct
FROM yearly
ORDER BY year;