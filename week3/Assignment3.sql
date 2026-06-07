-- Assignment3.sql
-- SQL script for Superstore customer sales analysis.

-- Create normalized tables from the raw Superstore dataset.
CREATE TABLE IF NOT EXISTS customers (
    Customer_ID VARCHAR(20) PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS orders (
    Row_ID INT PRIMARY KEY,
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(20),
    FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
);

CREATE TABLE IF NOT EXISTS products (
    Product_ID VARCHAR(20) PRIMARY KEY,
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(200),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(5,2),
    Profit DECIMAL(10,2)
);

-- Insert data using SELECT DISTINCT to avoid duplicates.
INSERT IGNORE INTO customers (Customer_ID, Customer_Name, Segment, Country, City, State, Postal_Code, Region)
SELECT DISTINCT `Customer ID`, `Customer Name`, Segment, Country, City, State, `Postal Code`, Region
FROM superstore_raw;

INSERT IGNORE INTO orders (Row_ID, Order_ID, Order_Date, Ship_Date, Ship_Mode, Customer_ID)
SELECT DISTINCT `Row ID`, `Order ID`, `Order Date`, `Ship Date`, `Ship Mode`, `Customer ID`
FROM superstore_raw;

INSERT IGNORE INTO products (Product_ID, Category, Sub_Category, Product_Name, Sales, Quantity, Discount, Profit)
SELECT DISTINCT `Product ID`, Category, `Sub-Category`, `Product Name`, Sales, Quantity, Discount, Profit
FROM superstore_raw;

-- Subquery: customers above average total sales.
WITH totals AS (
  SELECT `Customer ID` AS cid, SUM(Sales) AS total_sales
  FROM superstore_raw
  GROUP BY `Customer ID`
)
SELECT cid AS `Customer ID`, total_sales
FROM totals
WHERE total_sales > (SELECT AVG(total_sales) FROM totals)
LIMIT 10;

-- Highest order per customer using aggregation + join.
WITH max_sales_per_customer AS (
  SELECT `Customer ID`, MAX(Sales) AS MaxSales
  FROM superstore_raw
  GROUP BY `Customer ID`
)
SELECT s.*
FROM superstore_raw AS s
JOIN max_sales_per_customer AS m
  ON s.`Customer ID` = m.`Customer ID`
 AND s.Sales = m.MaxSales;

-- CTE for total sales per customer.
WITH customer_totals AS (
  SELECT `Customer ID`, `Customer Name`, SUM(Sales) AS TotalSales, COUNT(DISTINCT `Order ID`) AS OrderCount
  FROM superstore_raw
  GROUP BY `Customer ID`, `Customer Name`
)
SELECT *
FROM customer_totals
ORDER BY TotalSales DESC
LIMIT 10;

-- Window function: rank customers by total sales.
SELECT `Customer ID`, `Customer Name`, TotalSales,
       DENSE_RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
FROM (
  SELECT `Customer ID`, `Customer Name`, SUM(Sales) AS TotalSales
  FROM superstore_raw
  GROUP BY `Customer ID`, `Customer Name`
) t
ORDER BY TotalSales DESC
LIMIT 10;

-- Window function: row numbers for orders per customer.
SELECT `Order ID`, `Customer ID`, `Order Date`, Sales,
       ROW_NUMBER() OVER (PARTITION BY `Customer ID` ORDER BY `Order Date` ASC, `Order ID`) AS OrderRowNumber
FROM superstore_raw
ORDER BY `Customer ID`, OrderRowNumber
LIMIT 20;

-- Top 3 customers by total sales.
SELECT `Customer ID`, `Customer Name`, TotalSales, SalesRank
FROM (
  SELECT `Customer ID`, `Customer Name`, TotalSales,
         DENSE_RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
  FROM (
    SELECT `Customer ID`, `Customer Name`, SUM(Sales) AS TotalSales
    FROM superstore_raw
    GROUP BY `Customer ID`, `Customer Name`
  ) t
) s
WHERE SalesRank <= 3
ORDER BY TotalSales DESC;

-- Final combined JOIN + CTE + Window Function result.
WITH customer_cte AS (
  SELECT `Customer ID` AS cid, `Customer Name` AS cname, SUM(Sales) AS TotalSales, COUNT(DISTINCT `Order ID`) AS OrdersCount, MAX(Sales) AS HighestOrderValue
  FROM superstore_raw
  GROUP BY `Customer ID`, `Customer Name`
),
ranked AS (
  SELECT cid, cname, TotalSales, OrdersCount, HighestOrderValue, DENSE_RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank, AVG(TotalSales) OVER () AS AvgTotalSales
  FROM customer_cte
)
SELECT cu.Customer_Name AS `Customer Name`, r.TotalSales AS `Total Sales`, r.SalesRank AS `Rank`
FROM customers cu
JOIN ranked r ON cu.Customer_ID = r.cid
ORDER BY r.TotalSales DESC
LIMIT 10;
