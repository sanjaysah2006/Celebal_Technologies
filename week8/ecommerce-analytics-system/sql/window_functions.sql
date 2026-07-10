-- Customer Rankings by Lifetime Value
SELECT
    c.customer_id,
    c.name,
    ROUND(SUM(oi.quantity * p.price),2) AS lifetime_value,
    RANK() OVER(
        ORDER BY SUM(oi.quantity * p.price) DESC
    ) AS customer_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name;

-- Customer Rankings by Lifetime Value (Dense Rank)
SELECT
    c.customer_id,
    c.name,
    ROUND(SUM(oi.quantity * p.price),2) AS lifetime_value,
    DENSE_RANK() OVER(
        ORDER BY SUM(oi.quantity * p.price) DESC
    ) AS dense_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.name;

-- Monthly Sales with Running Total
WITH monthly_sales AS
(
SELECT
    DATE_FORMAT(o.order_date,'%Y-%m') AS month,
    SUM(oi.quantity*p.price) AS revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
GROUP BY month
)

SELECT
month,
ROUND(revenue,2) AS revenue,
ROUND(
SUM(revenue)
OVER(
ORDER BY month
),2) AS running_total
FROM monthly_sales;

-- Monthly Sales with Moving Average
WITH monthly_sales AS
(
SELECT
DATE_FORMAT(order_date,'%Y-%m') AS month,
SUM(oi.quantity*p.price) revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
GROUP BY month
)

SELECT
month,
ROUND(revenue,2),
ROUND(
AVG(revenue)
OVER(
ORDER BY month
ROWS BETWEEN 2 PRECEDING
AND CURRENT ROW
),2) moving_average
FROM monthly_sales;


-- Monthly Sales with Previous Month Comparison
WITH monthly_sales AS
(
SELECT
DATE_FORMAT(order_date,'%Y-%m') month,
SUM(oi.quantity*p.price) revenue
FROM orders o
JOIN order_items oi
ON o.order_id=oi.order_id
JOIN products p
ON oi.product_id=p.product_id
GROUP BY month
)

SELECT
month,
ROUND(revenue,2),

ROUND(
LAG(revenue)
OVER(
ORDER BY month
),2) previous_month,

ROUND(
(revenue-
LAG(revenue)
OVER(ORDER BY month))
/
LAG(revenue)
OVER(ORDER BY month)
*100
,2) growth_percent

FROM monthly_sales;


-- Order Sequencing by Customer
SELECT
customer_id,
order_id,
order_date,

ROW_NUMBER()
OVER(
PARTITION BY customer_id
ORDER BY order_date
) AS order_sequence

FROM orders;
