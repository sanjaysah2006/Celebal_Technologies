CREATE DATABASE superstore_db;
USE superstore_db;

CREATE TABLE superstore (
    row_id INT,
    order_id VARCHAR(20),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country VARCHAR(50),
    city VARCHAR(100),
    state VARCHAR(100),
    postal_code VARCHAR(20),
    region VARCHAR(50),
    product_id VARCHAR(30),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name TEXT,
    sales DECIMAL(10,4),
    quantity INT,
    discount DECIMAL(10,4),
    profit DECIMAL(10,4)
)
CHARACTER SET latin1;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv'
INTO TABLE superstore
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;



UPDATE superstore
SET order_date = STR_TO_DATE(order_date, '%m/%d/%Y'),
    ship_date  = STR_TO_DATE(ship_date, '%m/%d/%Y')
    WHERE row_id IS NOT NULL;

describe superstore;

SELECT * FROM superstore LIMIT 10;

SELECT COUNT(*) FROM superstore;

SELECT *
FROM superstore
WHERE region = 'East';

SELECT *
FROM superstore
WHERE sales > 500;

SELECT *
FROM superstore
WHERE category = 'Technology';


SELECT *
FROM superstore
WHERE order_date BETWEEN '2016-01-01' AND '2017-12-31';


SELECT region, sum(sales) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

SELECT category, SUM(sales) AS total_sales
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

SELECT segment, AVG(profit) AS avg_profit
FROM superstore
GROUP BY segment;

SELECT sub_category, SUM(quantity) AS total_qty
FROM superstore
GROUP BY sub_category
ORDER BY total_qty DESC;

SELECT product_name, SUM(sales) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT customer_name, SUM(sales) AS total_spent
FROM superstore
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;

SELECT product_name, SUM(profit) AS total_profit
FROM superstore
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 10;

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(sales) AS monthly_sales
FROM superstore
GROUP BY month
ORDER BY monthly_sales DESC;

SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(profit) AS monthly_profit
FROM superstore
GROUP BY month
ORDER BY monthly_profit DESC;

SELECT order_id, product_id, COUNT(*) AS cnt
FROM superstore
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;


SELECT *
FROM superstore
WHERE order_id IS NULL
   OR customer_id IS NULL
   OR sales IS NULL;
   
   
SELECT *
FROM superstore
WHERE sales < 0 OR profit < 0;