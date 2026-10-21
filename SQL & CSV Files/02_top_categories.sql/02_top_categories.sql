-- Q2: Top 10 product categories by revenue
-- Setup: two extra tables were imported for this question:
-- products             (from olist_products_dataset.csv)
-- product_translation  (from product_category_name_translation.csv)

SELECT
    -- fall back to the Portuguese name if no translation exists
    COALESCE(t.product_category_name_english, p.product_category_name, 'unknown') AS category,
    COUNT(DISTINCT o.order_id) AS order_count,
    ROUND(SUM(oi.price), 2)    AS revenue
FROM orders AS o
JOIN order_items AS oi ON o.order_id = oi.order_id
JOIN products AS p ON oi.product_id = p.product_id
-- LEFT JOIN: an inner JOIN would silently drop products without a translation
LEFT JOIN product_translation AS t ON p.product_category_name = t.product_category_name
WHERE o.order_status NOT IN ('canceled', 'unavailable')
  AND o.order_purchase_timestamp >= '2017-01-01'
  AND o.order_purchase_timestamp <  '2018-09-01'
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;