-- Query 1: First Purchase Month (Customer Cohorts)

-- Each customer's cohort is based on the month of their first purchase.
WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_purchase_date
    FROM orders
    GROUP BY customer_id
)

SELECT
    customer_id,
    DATE_FORMAT(first_purchase_date, '%Y-%m') AS cohort_month
FROM first_purchase
ORDER BY cohort_month, customer_id;


-- Cohort Size

-- Number of customers in each cohort.

WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_purchase_date
    FROM orders
    GROUP BY customer_id
)

SELECT
    DATE_FORMAT(first_purchase_date, '%Y-%m') AS cohort_month,
    COUNT(*) AS customers
FROM first_purchase
GROUP BY cohort_month
ORDER BY cohort_month;

-- Cohort Retention

-- This calculates how many customers from each cohort return in later months.

WITH first_purchase AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_purchase_date
    FROM orders
    GROUP BY customer_id
),

customer_orders AS (
    SELECT
        o.customer_id,
        DATE_FORMAT(fp.first_purchase_date,'%Y-%m') AS cohort_month,
        TIMESTAMPDIFF(
            MONTH,
            fp.first_purchase_date,
            o.order_date
        ) AS month_number
    FROM orders o
    JOIN first_purchase fp
        ON o.customer_id = fp.customer_id
)

SELECT
    cohort_month,
    month_number,
    COUNT(DISTINCT customer_id) AS retained_customers
FROM customer_orders
GROUP BY cohort_month, month_number
ORDER BY cohort_month, month_number;

-- Repeat Customers

-- Customers with more than one order.

SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1
ORDER BY total_orders DESC;

-- One-Time Customers
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) = 1;

-- Churned Customers

-- Customers with no orders in the last 180 days.
SELECT
    customer_id,
    MAX(order_date) AS last_order
FROM orders
GROUP BY customer_id
HAVING MAX(order_date) < CURRENT_DATE - 180;

-- Active Customers
-- Customers with orders in the last 180 days.
SELECT
    customer_id,
    MAX(order_date) AS last_order
FROM orders
GROUP BY customer_id
HAVING MAX(order_date) >= CURRENT_DATE - 180;
