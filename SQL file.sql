CREATE DATABASE sales_analysis_project;


SELECT * FROM sales_data;

SELECT 
    COUNT(*) AS total_orders,
    SUM(Amount) AS total_sales,
    AVG(Amount) AS avg_order_value
FROM sales_data;

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

SELECT 
    `ship-city` AS city,
    SUM(Amount) AS total_sales
FROM sales_data
GROUP BY `ship-city`
ORDER BY total_sales DESC;

SELECT 
    `Cust ID`,
    SUM(Amount) AS total_spent
FROM sales_data
GROUP BY `Cust ID`
ORDER BY total_spent DESC
LIMIT 5;

SELECT 
    Category,
    SUM(Amount) AS total_sales
FROM sales_data
GROUP BY Category
ORDER BY total_sales DESC;

SELECT *
FROM sales_data
WHERE Amount IS NULL
   OR `ship-city` IS NULL
   OR `Date` IS NULL;
   
SELECT 
    `Order ID`,
    COUNT(*) AS count
FROM sales_data
GROUP BY `Order ID`
HAVING COUNT(*) > 1;

SELECT 
    Channel,
    SUM(Amount) AS total_sales
FROM sales_data
GROUP BY Channel
ORDER BY total_sales DESC;

SELECT 
    STR_TO_DATE(`Date`, '%d-%m-%Y') AS order_date,
    Amount,
    SUM(Amount) OVER (ORDER BY STR_TO_DATE(`Date`, '%d-%m-%Y')) AS running_total
FROM sales_data;

SELECT 
    `ship-city`,
    SUM(Amount) AS total_sales,
    RANK() OVER (ORDER BY SUM(Amount) DESC) AS city_rank
FROM sales_data
GROUP BY `ship-city`;

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

SELECT 
    year,
    month,
    monthly_sales,
    LAG(monthly_sales) OVER (ORDER BY year, month) AS previous_month,
    monthly_sales - LAG(monthly_sales) OVER (ORDER BY year, month) AS growth
FROM (
    SELECT 
        YEAR(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS year,
        MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y')) AS month,
        SUM(Amount) AS monthly_sales
    FROM sales_data
    GROUP BY 
        YEAR(STR_TO_DATE(`Date`, '%d-%m-%Y')),
        MONTH(STR_TO_DATE(`Date`, '%d-%m-%Y'))
) AS sub;

