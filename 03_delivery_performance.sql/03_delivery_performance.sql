-- Q3: Average delivery time and late-delivery rate by month
-- Scope: delivered orders only (order_status = 'delivered'), purchased 2017-01 to 2018-08.
--        Canceled, unavailable and in-transit orders are excluded because they have no delivery date.
-- Definitions: delivery time = days from purchase to customer delivery;
--              late = delivered after the estimated delivery date;
--              late rate = late orders / delivered orders
SELECT
    strftime('%Y-%m', order_purchase_timestamp) AS year_month,
    COUNT(*)                                    AS delivered_orders,

    ROUND(AVG(julianday(order_delivered_customer_date)
            - julianday(order_purchase_timestamp)), 1) AS avg_delivery_days,

    -- CASE returns 1 for a late order and 0 otherwise, so SUM() counts the late orders.
    SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
             THEN 1 ELSE 0 END) AS late_orders,

    -- late rate = late orders / all delivered orders; 100.0 forces decimal division
    -- (100 / COUNT(*) alone would be integer division and round down to 0)
    ROUND(100.0 * SUM(CASE WHEN order_delivered_customer_date > order_estimated_delivery_date
                           THEN 1 ELSE 0 END) / COUNT(*), 1) AS late_rate_pct
FROM orders
WHERE order_status = 'delivered'
  -- 8 delivered orders have no delivery date; exclude them, otherwise they would count as "not late"
  AND order_delivered_customer_date IS NOT NULL
  AND order_purchase_timestamp >= '2017-01-01'
  AND order_purchase_timestamp <  '2018-09-01'
GROUP BY year_month
ORDER BY year_month;