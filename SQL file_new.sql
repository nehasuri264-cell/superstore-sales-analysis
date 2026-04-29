CREATE DATABASE sales_analysis_project;

-- ================================================
-- SUPER STORE SALES ANALYSIS -- SQL PROJECT
-- Tool: MySQL | Dataset: E-commerce Sales Data
-- Author: Neha Suri
-- ================================================


-- ------------------------------------------------
-- 1. VIEW FULL DATASET
-- ------------------------------------------------
SELECT * FROM sales_data;

-- ------------------------------------------------
-- 2. OVERALL BUSINESS SUMMARY
--    Total orders, revenue, and average order value
-- ------------------------------------------------
SELECT 
    COUNT(*) AS total_orders,
    SUM(Amount) AS total_sales,
    AVG(Amount) AS avg_order_value
FROM sales_data;


-- ------------------------------------------------
-- 3. MONTHLY SALES TREND
--    Revenue breakdown by year and month
-- ------------------------------------------------
SELECT 
    YEAR(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS year,
    MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS month,
    SUM(Amount) AS monthly_sales
FROM sales_data
GROUP BY 
    YEAR(STR_TO_DATE(`Date`, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y'))
ORDER BY 
    YEAR(STR_TO_DATE(`Date`, '%d-%m-%Y')),
    MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y'));


-- ------------------------------------------------
-- 4. SALES BY CITY
--    Identify top performing cities by revenue
-- ------------------------------------------------
SELECT 
    `ship-city` AS city,
    SUM(Amount) AS total_sales
FROM sales_data
GROUP BY `ship-city`
ORDER BY total_sales DESC;


-- ------------------------------------------------
-- 5. TOP 5 CUSTOMERS BY REVENUE
--    High-value customer identification
-- ------------------------------------------------
SELECT 
    `Cust ID`,
    SUM(Amount) AS total_spent
FROM sales_data
GROUP BY `Cust ID`
ORDER BY total_spent DESC
LIMIT 5;


-- ------------------------------------------------
-- 6. SALES BY PRODUCT CATEGORY
--    Which categories drive the most revenue
-- ------------------------------------------------
SELECT 
    Category,
    SUM(Amount) AS total_sales
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;


-- ------------------------------------------------
-- 7. DATA QUALITY CHECK -- NULL VALUES
--    Identify missing data across key columns
-- ------------------------------------------------
SELECT *
FROM sales_data
WHERE Amount IS NULL
   OR `ship-city` IS NULL
   OR `Date` IS NULL;


-- ------------------------------------------------
-- 8. DATA QUALITY CHECK -- DUPLICATE ORDERS
--    Detect duplicate Order IDs in the dataset
-- ------------------------------------------------
SELECT 
    `Order ID`,
    COUNT(*) AS count
FROM sales_data
GROUP BY `Order ID`
HAVING COUNT(*) > 1;


-- ------------------------------------------------
-- 9. SALES BY CHANNEL
--    Revenue contribution per sales channel
-- ------------------------------------------------
SELECT 
    Channel,
    SUM(Amount) AS total_sales
FROM sales_data
GROUP BY Channel
ORDER BY total_sales DESC;


-- ------------------------------------------------
-- 10. RUNNING TOTAL OF SALES OVER TIME
--     Cumulative revenue trend using window function
-- ------------------------------------------------
SELECT 
    STR_TO_DATE(`Date`, '%d-%m-%Y') AS order_date,
    Amount,
    SUM(Amount) OVER (ORDER BY STR_TO_DATE(`Date`, '%d-%m-%Y')) AS running_total
FROM sales_data;


-- ------------------------------------------------
-- 11. CITY RANKING BY SALES
--     Rank all cities by total revenue using RANK()
-- ------------------------------------------------
SELECT 
    `ship-city`,
    SUM(Amount) AS total_sales,
    RANK() OVER (ORDER BY SUM(Amount) DESC) AS city_rank
FROM sales_data
GROUP BY `ship-city`;


-- ------------------------------------------------
-- 12. CUSTOMER REVENUE CONTRIBUTION (%)
--     Each customer's share of total revenue
--     Uses nested aggregate window function
-- ------------------------------------------------
SELECT 
    `Cust ID`,
    SUM(Amount) AS total_spent,
    ROUND(
        SUM(Amount) * 100 / SUM(SUM(Amount)) OVER (), 
        2
    ) AS contribution_percent
FROM sales_data
GROUP BY `Cust ID`
ORDER BY total_spent DESC;


-- ------------------------------------------------
-- 13. CATEGORY REVENUE CONTRIBUTION (%)
--     Percentage share of each product category
-- ------------------------------------------------
SELECT 
    Category,
    SUM(Amount) AS total_sales,
    ROUND(
        SUM(Amount) * 100 / SUM(SUM(Amount)) OVER (), 
        2
    ) AS percentage_share
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;


-- ------------------------------------------------
-- 14. MONTH-OVER-MONTH SALES GROWTH
--     Uses CTE + LAG() window function to calculate
--     monthly growth vs previous month
-- ------------------------------------------------
WITH monthly_sales AS (
    SELECT 
        YEAR(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS year,
        MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS month,
        SUM(Amount) AS monthly_sales
    FROM sales_data
    GROUP BY 
        YEAR(STR_TO_DATE(`Date`, '%d-%m-%Y')),
        MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y'))
)
SELECT 
    year,
    month,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY year, month) AS previous_month_sales,
    monthly_sales - LAG(monthly_sales) OVER (ORDER BY year, month) AS growth
FROM monthly_sales;