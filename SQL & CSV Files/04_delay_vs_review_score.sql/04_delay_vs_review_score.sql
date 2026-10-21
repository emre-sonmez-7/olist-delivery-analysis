-- Q4: Relationship between late delivery and review score
-- Scope: delivered orders only (order_status = 'delivered'), purchased 2017-01 to 2018-08,
--        that have exactly one review
-- Definitions: late = delivered after the estimated delivery date
-- Note: orders with several reviews (~0.6% of all orders) are excluded, see notes.md
WITH single_review_orders AS (
    -- keep only orders with exactly one review, so the JOIN below
    -- cannot count an order twice
    SELECT
        order_id,
        review_score
    FROM order_reviews
    GROUP BY order_id
    HAVING COUNT(*) = 1
)
SELECT
    -- CASE puts every order into one of two groups
    CASE WHEN o.order_delivered_customer_date > o.order_estimated_delivery_date
         THEN 'late' ELSE 'on_time' END AS delivery_status,
    COUNT(*)                            AS order_count,
    ROUND(AVG(s.review_score), 2)       AS avg_review_score
FROM orders AS o
-- inner JOIN: orders without a single-review score are left out
JOIN single_review_orders AS s ON o.order_id = s.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY delivery_status
ORDER BY delivery_status;