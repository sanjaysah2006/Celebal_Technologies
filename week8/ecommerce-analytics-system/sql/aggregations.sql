-- Total Revenue Per Customer
SELECT
    c.customer_id,
    c.name,
    ROUND(SUM(oi.quantity * p.price),2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name
ORDER BY total_revenue DESC;

-- Revenue by Product Category
SELECT
    p.category,
    ROUND(SUM(oi.quantity * p.price),2) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id = oi.product_id
GROUP BY p.category
ORDER BY revenue DESC;

-- Monthly Revenue
SELECT
    DATE_FORMAT(o.order_date,'%Y-%m') AS month,
    ROUND(SUM(oi.quantity*p.price),2) AS revenue
FROM orders o
JOIN order_items oi
    ON o.order_id=oi.order_id
JOIN products p
    ON oi.product_id=p.product_id
GROUP BY month
ORDER BY month;

-- Top 10 Products by Quantity Sold
SELECT
    p.product_name,
    SUM(oi.quantity) AS total_quantity
FROM products p
JOIN order_items oi
    ON p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name
ORDER BY total_quantity DESC
LIMIT 10;

-- Top 10 Products by Revenue
SELECT 
    p.product_name,
    ROUND(SUM(oi.quantity*p.price),2) AS revenue
FROM products p
JOIN order_items oi
    ON p.product_id=oi.product_id
GROUP BY p.product_id,p.product_name
ORDER BY revenue DESC
LIMIT 10;

-- Average Order Value Per Customer
WITH order_totals AS
(
SELECT
    o.order_id,
    o.customer_id,
    SUM(oi.quantity*p.price) AS order_value
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
GROUP BY o.order_id,o.customer_id
)

SELECT
customer_id,
ROUND(AVG(order_value),2) AS average_order_value
FROM order_totals
GROUP BY customer_id
ORDER BY average_order_value DESC;

-- Revenue by Order Status
SELECT
    o.status,
    ROUND(SUM(oi.quantity*p.price),2) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
GROUP BY o.status
ORDER BY revenue DESC;

-- Total Orders Per Customer
SELECT
    c.customer_id,
    c.name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
LEFT JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_id,c.name
ORDER BY total_orders DESC;

-- Revenue by Customer City
SELECT
    c.city,
    ROUND(SUM(oi.quantity*p.price),2) AS revenue
FROM customers c
JOIN orders o
ON c.customer_id=o.customer_id
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
GROUP BY c.city
ORDER BY revenue DESC;

-- Total Orders Per Month
SELECT
DATE_FORMAT(order_date,'%Y-%m') AS month,
COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;