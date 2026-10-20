-- Q1: Monthly order count and revenue
-- Scope: 2017-01 to 2018-08 (2016 is sparse, no orders in 2016-11;
--        data is cut off after 2018-08, only one order in 2018-09)
-- Definition: revenue = item price, excluding freight; canceled/unavailable orders excluded
SELECT
    strftime('%Y-%m', o.order_purchase_timestamp)        AS year_month,
    COUNT(DISTINCT o.order_id)                           AS order_count,
    ROUND(SUM(oi.price), 2)                              AS revenue,
    ROUND(SUM(oi.price) / COUNT(DISTINCT o.order_id), 2) AS avg_revenue_per_order
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY year_month
ORDER BY year_month;