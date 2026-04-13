-- create and use database
CREATE DATABASE sales_project;
USE sales_project;

-- view sample data
SELECT * FROM superstore LIMIT 10;

-- total revenue
SELECT SUM(Sales) AS total_revenue
FROM superstore;

-- sales by region
SELECT Region, SUM(Sales) AS revenue
FROM superstore
GROUP BY Region
ORDER BY revenue DESC;

-- top 5 customers by sales
SELECT `Customer Name`, SUM(Sales) AS total_spent
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_spent DESC
LIMIT 5;

-- sales by category
SELECT Category, SUM(Sales) AS revenue
FROM superstore
GROUP BY Category;

-- orders with second class shipping
SELECT *
FROM superstore
WHERE `Ship Mode` = 'Second Class';

-- yearly sales trend
SELECT YEAR(`Order Date`) AS year, SUM(Sales) AS revenue
FROM superstore
GROUP BY YEAR(`Order Date`)
ORDER BY year;

-- top customer
SELECT `Customer Name`, SUM(Sales) AS total_sales
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 1;

-- top region
SELECT Region, SUM(Sales) AS total_sales
FROM superstore
GROUP BY Region
ORDER BY total_sales DESC
LIMIT 1;

-- year with highest sales
SELECT YEAR(`Order Date`) AS year, SUM(Sales) AS total_sales
FROM superstore
GROUP BY YEAR(`Order Date`)
ORDER BY total_sales DESC
LIMIT 1;

-- top profit category
SELECT Category, SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_profit DESC
LIMIT 1;

-- loss making category
SELECT Category, SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_profit ASC
LIMIT 1;

-- top selling city
SELECT City, SUM(Sales) AS total_sales
FROM superstore
GROUP BY City
ORDER BY total_sales DESC
LIMIT 1;

-- top customer by profit
SELECT `Customer Name`, SUM(Profit) AS total_profit
FROM superstore
GROUP BY `Customer Name`
ORDER BY total_profit DESC
LIMIT 1;

-- yearly profit trend
SELECT YEAR(`Order Date`) AS year, SUM(Profit) AS total_profit
FROM superstore
GROUP BY YEAR(`Order Date`)
ORDER BY year;

-- discount impact analysis
SELECT Discount, SUM(Profit) AS total_profit, SUM(Sales) AS total_sales
FROM superstore
GROUP BY Discount
ORDER BY Discount;

-- category with high sales threshold
SELECT Category, SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category
HAVING SUM(Sales) > 100000
ORDER BY total_sales DESC;

-- customer segmentation
SELECT `Customer Name`, Sales,
CASE
    WHEN Sales > 1000 THEN 'High Value'
    WHEN Sales > 500 THEN 'Medium Value'
    ELSE 'Low Value'
END AS customer_segment
FROM superstore;

-- profit analysis by category
SELECT Category, SUM(Profit) AS total_profit
FROM superstore
GROUP BY Category
ORDER BY total_profit DESC;

-- above average sales
SELECT *
FROM superstore
WHERE Sales > (SELECT AVG(Sales) FROM superstore);

-- rank customers by sales
SELECT
    `Customer Name`,
    SUM(Sales) AS total_sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS sales_rank
FROM superstore
GROUP BY `Customer Name`;

-- dense rank customers by sales
SELECT
    `Customer Name`,
    SUM(Sales) AS total_sales,
    DENSE_RANK() OVER (ORDER BY SUM(Sales) DESC) AS dense_rank
FROM superstore
GROUP BY `Customer Name`;

-- running total sales
SELECT
    `Order Date`,
    Sales,
    SUM(Sales) OVER (ORDER BY `Order Date`) AS running_total_sales
FROM superstore;

-- monthly sales trend
SELECT
    DATE_FORMAT(`Order Date`, '%Y-%m') AS month,
    SUM(Sales) AS monthly_sales
FROM superstore
GROUP BY DATE_FORMAT(`Order Date`, '%Y-%m')
ORDER BY month;

-- customer rank within region
SELECT
    Region,
    `Customer Name`,
    SUM(Sales) AS total_sales,
    RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales) DESC) AS region_rank
FROM superstore
GROUP BY Region, `Customer Name`;

-- sales category classification
SELECT
    CASE
        WHEN Sales > 1000 THEN 'High Value'
        WHEN Sales > 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS sales_category,
    COUNT(*) AS total_orders
FROM superstore
GROUP BY sales_category;

