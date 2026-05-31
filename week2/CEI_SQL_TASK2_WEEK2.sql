show databases;
use celebal;
CREATE TABLE customers ( 
    customer_id   INT           PRIMARY KEY, 
    first_name    VARCHAR(50)   NOT NULL, 
    last_name     VARCHAR(50)   NOT NULL, 
    email         VARCHAR(100)  UNIQUE NOT NULL, 
    city          VARCHAR(50)   NOT NULL, 
    state         VARCHAR(50)   NOT NULL, 
    join_date     DATE          NOT NULL, 
    is_premium    BOOLEAN       DEFAULT FALSE 
);

CREATE INDEX idx_customers_city ON customers(city); 
CREATE INDEX idx_customers_state ON customers(state);

CREATE TABLE products ( 
    product_id    INT           PRIMARY KEY, 
    product_name  VARCHAR(100)  NOT NULL, 
    category      VARCHAR(50)   NOT NULL, 
    brand         VARCHAR(50)   NOT NULL, 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    stock_qty     INT           NOT NULL  DEFAULT 0  CHECK (stock_qty >= 0) 
);


CREATE INDEX idx_products_category ON products(category);

CREATE TABLE orders ( 
    order_id      INT           PRIMARY KEY, 
    customer_id   INT           NOT NULL, 
    order_date    DATE          NOT NULL, 
    status        VARCHAR(20)   NOT NULL  DEFAULT 'Pending' 
                  CHECK (status IN ('Pending','Shipped','Delivered','Cancelled')), 
    total_amount  DECIMAL(12,2) NOT NULL  CHECK (total_amount >= 0), 
     
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) 
);

CREATE INDEX idx_orders_date ON orders(order_date); 
CREATE INDEX idx_orders_status ON orders(status);

CREATE TABLE order_items ( 
    item_id       INT           PRIMARY KEY, 
    order_id      INT           NOT NULL, 
    product_id    INT           NOT NULL, 
    quantity      INT           NOT NULL  CHECK (quantity > 0), 
    unit_price    DECIMAL(10,2) NOT NULL  CHECK (unit_price > 0), 
    discount_pct  DECIMAL(5,2)  DEFAULT 0 CHECK (discount_pct BETWEEN 0 AND 100), 
     
    FOREIGN KEY (order_id)   REFERENCES orders(order_id), 
    FOREIGN KEY (product_id) REFERENCES products(product_id) 
); 


-- ========== INSERT: customers ========== 
INSERT INTO customers VALUES 
(101, 'Aarav',  'Sharma', 'aarav.s@email.com',  'Mumbai',    'Maharashtra', '2024-01-15', TRUE), 
(102, 'Priya',  'Patel',  'priya.p@email.com',  'Ahmedabad', 'Gujarat',     '2024-02-20', FALSE), 
(103, 'Rohan',  'Gupta',  'rohan.g@email.com',  'Delhi',     'Delhi',       '2024-03-10', TRUE), 
(104, 'Sneha',  'Reddy',  'sneha.r@email.com',  'Hyderabad', 'Telangana',   '2024-04-05', FALSE), 
(105, 'Vikram', 'Singh',  'vikram.s@email.com', 'Jaipur',    'Rajasthan',   '2024-05-12', TRUE), 
(106, 'Ananya', 'Iyer',   'ananya.i@email.com', 'Chennai',   'Tamil Nadu',  '2024-06-18', FALSE), 
(107, 'Karan',  'Mehta',  'karan.m@email.com',  'Pune',      'Maharashtra', '2024-07-22', TRUE), 
(108, 'Divya',  'Nair',   'divya.n@email.com',  'Kochi',     'Kerala',      '2024-08-30', FALSE); 

-- ========== INSERT: products ========== 
INSERT INTO products VALUES 
(201, 'Wireless Earbuds',     'Electronics', 'BoAt',          1499.00, 250), 
(202, 'Cotton T-Shirt',       'Clothing',    'Levis',         799.00,  500), 
(203, 'Smart Watch',          'Electronics', 'Noise',         2999.00, 150), 
(204, 'Running Shoes',        'Clothing',    'Nike',          4599.00, 120), 
(205, 'Bluetooth Speaker',    'Electronics', 'JBL',           3499.00, 200), 
(206, 'Bedsheet Set',         'Home',        'Spaces',        1299.00, 300), 
(207, 'Laptop Stand',         'Electronics', 'AmazonBasics',  899.00,  180), 
(208, 'Cushion Covers (Set)', 'Home',        'HomeCenter',    599.00,  400); 

-- ========== INSERT: orders ========== 
INSERT INTO orders VALUES 
(1001, 101, '2024-08-01', 'Delivered',  4498.00), 
(1002, 102, '2024-08-03', 'Delivered',  799.00), 
(1003, 103, '2024-08-05', 'Shipped',    7498.00), 
(1004, 101, '2024-08-10', 'Delivered',  3499.00), 
(1005, 104, '2024-08-12', 'Cancelled',  2999.00), 
(1006, 105, '2024-08-15', 'Delivered',  5898.00), 
(1007, 106, '2024-08-18', 'Pending',    1299.00), 
(1008, 103, '2024-08-20', 'Delivered',  899.00), 
(1009, 107, '2024-08-25', 'Shipped',    6098.00), 
(1010, 108, '2024-08-28', 'Delivered',  1598.00); 

-- ========== INSERT: order_items ========== 
INSERT INTO order_items VALUES 
(5001, 1001, 201, 2, 1499.00, 0), 
(5002, 1001, 207, 1, 899.00,  10), 
(5003, 1002, 202, 1, 799.00,  0), 
(5004, 1003, 203, 1, 2999.00, 0), 
(5005, 1003, 204, 1, 4599.00, 5), 
(5006, 1004, 205, 1, 3499.00, 0), 
(5007, 1005, 203, 1, 2999.00, 0), 
(5008, 1006, 201, 1, 1499.00, 10), 
(5009, 1006, 204, 1, 4599.00, 5), 
(5010, 1007, 206, 1, 1299.00, 0), 
(5011, 1008, 207, 1, 899.00,  0), 
(5012, 1009, 205, 1, 3499.00, 0), 
(5013, 1009, 208, 2, 599.00,  15), 
(5014, 1010, 206, 1, 1299.00, 0), 
(5015, 1010, 208, 1, 599.00,  0); 

-- Section A
-- Q1. Write a query to display all columns and rows from the customer's table. 
select * from customers;

-- Q2. Retrieve only the first_name, last_name, and city of all customers. 
select first_name ,last_name , city from customers;

-- Q3. List all unique categories available in the products table. 
select distinct category from products;

/* Q4. Identify the Primary Key of each table in the schema. 
Explain why a Primary Key must be unique and NOT NULL. */

     -- Primary Key for customers: customer_id 
    DESC customers;
     -- Primary Key for products: product_id
    DESC products;
     -- Primary Key for orders: order_id 
	DESC orders;
     -- Primary Key for order_items: (order_id)
	DESC order_items;

/* A Primary Key is used to uniquely identify each record in a table.
UNIQUE: No two rows can have the same primary key value.
NOT NULL: Every row must contain a value for the primary key.

Without these rules:
duplicate records could exist,
rows could not be identified properly,
relationships between tables would break. */

/* Q5. What constraints are applied to the email column in the customers table? 
     What would happen if you tried to insert a duplicate email? 
Constraints on email column:
email VARCHAR(100) UNIQUE NOT NULL
Constraints used:
UNIQUE
-- No duplicate email addresses are allowed.
NOT NULL
-- Every customer must have an email value. */

INSERT INTO customers
VALUES (
    109,
    'Rahul',
    'Verma',
    'aarav.s@email.com',
    'Lucknow',
    'Uttar Pradesh',
    '2024-09-01',
    FALSE
);

-- Result:
-- Error Code: 1062. Duplicate entry '109' for key 'customers.PRIMARY'	0.000 sec


/* Q6. Try inserting a product with unit_price = -50. 
What happens and which constraint prevents it? 
Write both the INSERT statement and explain the error. */
insert into products value (215,'Wired Earbuds','Electronics','BoAt', -50, 250);
/* result:
Error Code: 1265. Data truncated for column 'unit_price' at row 1    0.000 sec */

-- Section B
-- Q7. Retrieve all orders with status = 'Delivered'. 
select * 
from orders 
where status = 'Delivered';

-- Q8. Find all products in the 'Electronics' category with a unit_price greater than ₹2000. 
select * 
from products 
where category = 'Electronics' and unit_price > 2000;

-- Q9. List all customers who joined in the year 2024 and belong to the state 'Maharashtra'
select * 
from customers 
where join_date >= '2024-01-01' and join_date < '2025-01-01'
	and state = 'Maharashtra';
    
-- Q10. Find all orders placed between '2024-08-10' and '2024-08-25' (inclusive) that are NOT cancelled. 
select * 
from orders 
where order_date 
between '2024-08-10' and '2024-08-25'
and status !='cancelled'; 

/* Q11. Explain what the index idx_orders_date does.
How would it improve the performance of a query that filters orders by order_date?
Write a sample query that would benefit from this index. */

select * 
from orders 
where order_date 
between '2024-08-10' and '2024-08-25';

/* Q12. If you run: SELECT * FROM customers WHERE YEAR(join_date) = 2024;
would the index on join_date be used? Explain why or why not, and rewrite the query to be index-friendly (SARGable).*/ 

select * 
from customers 
where join_date 
between '2024-01-01' and '2024-12-31';

-- Section C

-- Q13. Count the total number of orders in the orders table. 
select 
count(*) as total_order 
from orders;

-- Q14. Find the total revenue (SUM of total_amount) from all 'Delivered' orders. 
select  
    sum(total_amount) as total_revenue 
from orders 
where status ='Delivered';

-- Q15. Calculate the average unit_price of products in each category. 
select 
    category, 
    avg(unit_price) as average 
from products 
group by category;

-- Q16. For each order status, find the count of orders and the total revenue. Sort the result by total revenue in descending order. 
select 
    status , 
    count(*) as order_count , 
    sum(total_amount) as total_revenue 
from orders 
group by status 
order by total_revenue desc;

-- Q17. Find the most expensive (MAX) and cheapest (MIN) product in each category. 
select * from products;
select 
    category , 
    max(unit_price) as expensive , 
    min(unit_price) as cheapest 
from products 
group by category;


-- Q18. List all product categories where the average unit_price is greater than ₹2000. (Hint: Use HAVING clause) 
select 
    category, 
    avg(unit_price) as average_price 
from products 
group by category 
having average_price > 2000;


-- Section D

-- Q19. Write an INNER JOIN query to display each order along with the customer's first_name and last_name. Show: order_id, order_date, first_name, last_name, total_amount.
select 
    o.order_id,
    o.order_date, 
    c.first_name, 
    c.last_name, 
    o.total_amount 
from orders as o 
inner join customers as c;



-- Q20. Using a LEFT JOIN, list ALL customers and their orders (if any). Customers with no orders should still appear with NULL values for order columns. 
select 
    c.customer_id,
    c.first_name, 
    c.last_name, 
    o.order_id,
    o.order_date, 
    o.total_amount 
from customers as c 
left join orders as o 
on c.customer_id = o.customer_id;

-- Q21. Write a query using JOINs across three tables (orders → order_items → products) to show: order_id, product_name, quantity, unit_price, and discount_pct for each order item. 
select 
	o.order_id,
    p.product_name,
    oi.quantity,
    p.unit_price,
    oi.discount_pct 
from orders as o 
join order_items as oi 
on o.order_id = oi.order_id
join products p
on oi.product_id = p.product_id;

/* Q22. Explain the difference between LEFT JOIN and RIGHT JOIN with an example from this schema. When would you use a FULL OUTER JOIN? 
LEFT JOIN

Returns
all rows from the left table
matching rows from the right table
Every customer appears.
Customers without orders show NULL.
Example: */

SELECT c.first_name,
       o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id;



/* RIGHT JOIN
Returns
all rows from the right table
matching rows from the left table
Every order appears.
If an order somehow had no matching customer, customer columns would be NULL.
Example: */

SELECT c.first_name,
       o.order_id
FROM customers c
RIGHT JOIN orders o
ON c.customer_id = o.customer_id;

/*                          LEFT JOIN vs RIGHT JOIN
LEFT JOIN								RIGHT JOIN
Keeps all rows from left table			Keeps all rows from right table
Non-matching right rows become NULL		Non-matching left rows become NULL

When would you use FULL OUTER JOIN?

A FULL OUTER JOIN would show:
all customers,
all orders,
matched and unmatched data together.

-- Example: */

SELECT c.first_name,
       o.order_id
FROM customers c
FULL OUTER JOIN orders o
ON c.customer_id = o.customer_id;


/* Q23. Identify all Foreign Key relationships in the schema.
Explain what would happen if you tried to insert an order with customer_id = 999 (which doesn't exist in customers).

Foreign Keys
Child Table		Foreign Key			Parent Table
orders			customer_id		customers(customer_id)
order_items		order_id		orders(order_id)
order_items		product_id		products(product_id)

What happens if you insert: */
INSERT INTO orders
VALUES (
    1011,
    999,
    '2024-09-01',
    'Pending',
    2500
);

/* where customer_id = 999 does not exist?

Result: The database will reject the insertion and produce an error 
Error Code: 1452. Cannot add or update a child row: a foreign key constraint fails
(`celebal`.`orders`, CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`))	0.016 sec */
