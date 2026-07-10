-- Purchase Frequency Segmentation
SELECT
    customer_id,
    COUNT(order_id) AS total_orders,
    CASE
        WHEN COUNT(order_id) = 1 THEN 'One-Time'
        WHEN COUNT(order_id) BETWEEN 2 AND 5 THEN 'Occasional'
        ELSE 'Loyal'
    END AS customer_segment
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC;


-- Spend Tier Segmentation
SELECT
    c.customer_id,
    c.name,
    ROUND(SUM(oi.quantity * p.price), 2) AS total_spent,
    CASE
        WHEN SUM(oi.quantity * p.price) < 5000 THEN 'Low'
        WHEN SUM(oi.quantity * p.price) < 20000 THEN 'Medium'
        ELSE 'High'
    END AS spend_tier
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;

-- 