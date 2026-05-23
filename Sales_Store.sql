
use store_sales;
SELECT * FROM Superstore LIMIT 100;

CREATE TABLE superstore_clean AS
SELECT * FROM superstore;

SELECT * FROM superstore_clean LIMIT 5;

SELECT *
FROM superstore_clean
WHERE order_id IS NULL
   OR sales IS NULL
   OR profit IS NULL;
   


ALTER TABLE superstore_clean
RENAME COLUMN `Row ID` TO row_id;

ALTER TABLE superstore_clean
RENAME COLUMN `Order Date` TO order_date;

ALTER TABLE superstore_clean
RENAME COLUMN `Ship Date` TO ship_date;

ALTER TABLE superstore_clean
RENAME COLUMN `Ship Mode` TO ship_mode;

ALTER TABLE superstore_clean
RENAME COLUMN `Customer ID` TO customer_id;

ALTER TABLE superstore_clean
RENAME COLUMN `Customer Name` TO customer_name;

ALTER TABLE superstore_clean
RENAME COLUMN `Postal Code` TO postal_code;

ALTER TABLE superstore_clean
RENAME COLUMN `Product ID` TO product_id;

ALTER TABLE superstore_clean
RENAME COLUMN `Sub-Category` TO sub_category;

ALTER TABLE superstore_clean
RENAME COLUMN `Product Name` TO product_name;
   
   
SELECT *
FROM superstore_clean
WHERE order_id IS NULL
   OR sales IS NULL
   OR profit IS NULL;
   
   SELECT
    order_id,
    product_name,
    COUNT(*) AS duplicate_count
FROM superstore_clean
GROUP BY order_id, product_name
HAVING COUNT(*) > 1;

DELETE t1
FROM superstore_clean t1
JOIN superstore_clean t2
ON t1.row_id > t2.row_id
AND t1.order_id = t2.order_id
AND t1.product_name = t2.product_name
AND t1.sales = t2.sales
AND t1.quantity = t2.quantity;

SELECT
    order_id,
    product_name,
    sales,
    quantity,
    COUNT(*) AS duplicate_count
FROM superstore_clean
GROUP BY
    order_id,
    product_name,
    sales,
    quantity
HAVING COUNT(*) > 1;


SET SQL_SAFE_UPDATES = 0;
DELETE t1
FROM superstore_clean t1
JOIN superstore_clean t2
ON t1.row_id > t2.row_id
AND t1.order_id = t2.order_id
AND t1.product_name = t2.product_name
AND t1.sales = t2.sales
AND t1.quantity = t2.quantity;

UPDATE superstore_clean
SET
    customer_name = TRIM(customer_name),
    city = TRIM(city),
    state = TRIM(state),
    product_name = TRIM(product_name);
    
SELECT ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean;

SELECT ROUND(SUM(profit),2) AS total_profit
FROM superstore_clean;

SELECT COUNT(DISTINCT order_id) AS total_orders
FROM superstore_clean;

SELECT
    region,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean
GROUP BY region
ORDER BY total_sales DESC;

SELECT
    category,
    ROUND(SUM(sales),2) AS sales,
    ROUND(SUM(profit),2) AS profit
FROM superstore_clean
GROUP BY category
ORDER BY sales DESC;

SELECT
    product_name,
    ROUND(SUM(sales),2) AS total_sales
FROM superstore_clean
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

SELECT
    YEAR(order_date) AS year,
    MONTHNAME(order_date) AS month,
    ROUND(SUM(sales),2) AS monthly_sales
FROM superstore_clean
GROUP BY year, month
ORDER BY year;

SELECT
    product_name,
    ROUND(SUM(profit),2) AS total_profit
FROM superstore_clean
GROUP BY product_name
HAVING total_profit < 0
ORDER BY total_profit;

