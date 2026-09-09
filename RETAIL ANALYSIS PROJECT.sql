use retail_analysis;
show tables;
describe `retail sales`;
SELECT * FROM `retail sales`
LIMIT 10;
SELECT count(*) AS TOTAL_RECORDS
FROM `retail sales`;
select
  min(INVOICE_DATE) AS FIRST_DATE,
  max(INVOICE_DATE) AS LAST_DATE
FROM `retail sales`;
select count(distinct city) AS
Total_citiies
from `retail sales`;
select
     city,
	 count(*) AS total_transactions
from `retail sales`
group by CITY
order by total_transactions desc ;
select
    city,
    round(SUM(REVENUE), 2) AS
Total_Revenue
from `retail sales`
group by city 
order by Total_Revenue desc;
select
    category,
    round(sum(revenue), 2) AS
Total_Revenue
from `retail sales`
group by category
order by Total_Revenue desc;
select
	 Brand,
     round(sum(revenue), 2) AS
Total_Revenue
from `retail sales`
group by Brand
order by Total_revenue desc;

select
   round(sum(revenue -(cost_price * units)), 2) AS
   TOTAL_PROFIT
FROM `retail sales`;

select
   ROUND(sum(revenue), 2) AS
Total_Revenue,
   ROUND(
     SUM(revenue - (cost_price * 
     units)), 2) as Total_Profit,
   ROUND(
        sum(revenue -(cost_price * 
        units))/ sum(revenue) *100,
   2
   )as PROFIT_MARGIN_PROFIT
FROM `retail sales`;
select
   city,
   round(SUM(revenue - (cost_price*
units)), 2) as total_profit
from `retail sales`

select
    category,
    ROUND(SUM(revenue - (cost_price *
units)), 2) as total_profit
from `retail sales`
group by category
order by total_profit desc;

select
    channel,
    round(sum(revenue - (cost_price *
units)), 2) as Total_profit
from `retail sales`
group by channel
order by total_profit desc;

select
   channel,
   round(sum(revenue), 2) as
Total_revenue
from `retail sales`
group by Channel
order by total_revenue desc;
     
select
    channel,
    COUNT(*) AS TOTAL_TRANSACTIONS
FROM `retail sales`
group by channel
order by total_transactions desc;

select
    channel,
    round(sum(revenue) / count(*), 2) as
avg_transaction_value
from `retail sales`
group by channel
order by avg_transaction_value desc;

select INVOICE_DATE
FROM `retail sales`
limit 10;

SELECT
    DATE_FORMAT(
        STR_TO_DATE(Invoice_Date, '%d-%m-%Y %H:%i'),
        '%Y-%m'
    ) AS month,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM `retail sales`
GROUP BY
    DATE_FORMAT(
        STR_TO_DATE(Invoice_Date, '%d-%m-%Y %H:%i'),
        '%Y-%m'
    )
ORDER BY month;

SELECT
    DATE_FORMAT(
        STR_TO_DATE(Invoice_Date, '%d-%m-%Y %H:%i'),
        '%Y-%m'
    ) AS month,
    ROUND(
        SUM(Revenue - (Cost_Price * Units)),
        2
    ) AS Total_Profit
FROM `retail sales`
GROUP BY
    DATE_FORMAT(
        STR_TO_DATE(Invoice_Date, '%d-%m-%Y %H:%i'),
        '%Y-%m'
    )
ORDER BY month;

SELECT
    Payment_Mode,
    COUNT(*) AS Total_Transactions
FROM `retail sales`
GROUP BY Payment_Mode
ORDER BY Total_Transactions DESC
 
SELECT
    Payment_Mode,
    ROUND(SUM(REVENUE), 2) AS Total_Revenue
FROM `retail sales`
GROUP BY Payment_Mode
ORDER BY Total_Revenue DESC;

SELECT
    Store_Format,
    ROUND(SUM(REVENUE), 2) AS Total_Revenue
FROM `retail sales`
GROUP BY Store_Format
ORDER BY Total_Revenue DESC;

SELECT
    Payment_Mode,
    ROUND(SUM(REVENUE - (Cost_Price * 
Units)), 2) AS Total_Profit
FROM `retail sales`
GROUP BY Payment_Mode
ORDER BY Total_Profit DESC;

SELECT
    Category,
    SUM(Units) AS Total_Units_Sold
FROM `retail sales`
GROUP BY Category
ORDER BY Total_Units_Sold DESC;

SELECT
    Category,
    SUM(Units) AS Total_Units_Sold,
    ROUND(sum(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Revenue - (Cost_Price *
Units)),  2 ) AS Total_Profit
FROM `retail sales`
GROUP BY Category
ORDER BY Total_Units_Sold DESC;

SELECT
    Brand,
    SUM(Units) AS Total_Units_Sold,
    ROUND(sum(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Revenue - (Cost_Price *
Units)),  2 ) AS Total_Profit
FROM `retail sales`
GROUP BY Brand
ORDER BY Total_Units_Sold DESC;

SELECT
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Revenue - (Cost_Price * Units)), 2) AS Total_Profit,
    ROUND(
         SUM(Revenue - (Cost_Price *
	Units)) / SUM(Revenue) * 100,
            2
	    ) as Profit_Margin_Percent
FROM `retail sales`
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;

SELECT
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Revenue - (Cost_Price * Units)), 2) AS Total_Profit,
    ROUND(
         SUM(Revenue - (Cost_Price *
	Units)) / SUM(Revenue) * 100,
            2
	    ) as Profit_Margin_Percent
FROM `retail sales`
GROUP BY Category
having sum(Revenue) > 500000
ORDER BY Profit_Margin_Percent DESC;

SELECT
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM `retail sales`
GROUP BY Category
ORDER BY Total_Revenue DESC
LIMIT 5;

SELECT
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue
FROM `retail sales`
GROUP BY Category
HAVING SUM(Revenue) > (
    SELECT AVG(category_revenue)
    FROM (
        SELECT SUM(Revenue) AS category_revenue
        FROM `retail sales`
        GROUP BY Category
    ) AS category_summary
)
ORDER BY Total_Revenue DESC;

WITH category_sales AS (
    SELECT
        Category,
        SUM(Revenue) AS Total_Revenue
    FROM `retail sales`
    GROUP BY Category
)
SELECT
    Category,
    ROUND(Total_Revenue, 2) AS Total_Revenue
FROM category_sales
WHERE Total_Revenue > (
    SELECT AVG(Total_Revenue)
    FROM category_sales
)
ORDER BY Total_Revenue DESC;

SELECT
    CASE
        WHEN Revenue >= 500 THEN 'High Value'
        WHEN Revenue >= 200 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS Transaction_Category,
    COUNT(*) AS Total_Transactions
FROM `retail sales`
GROUP BY Transaction_Category
ORDER BY Total_Transactions DESC;

SELECT
    City,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    RANK() OVER (ORDER BY SUM(Revenue) DESC) AS Revenue_Rank
FROM `retail sales`
GROUP BY City
ORDER BY Revenue_Rank;

SELECT
    City,
    Category,
    ROUND(SUM(Revenue), 2) AS Total_Revenue,
    ROUND(SUM(Revenue - (Cost_Price * Units)), 2) AS Total_Profit
FROM `retail sales`
GROUP BY City, Category
ORDER BY Total_Revenue DESC
LIMIT 10;

SELECT
    COUNT(*) AS Total_Rows,
    SUM(CASE WHEN Revenue IS NULL THEN 1 ELSE 0 END) AS Missing_Revenue,
    SUM(CASE WHEN Units IS NULL THEN 1 ELSE 0 END) AS Missing_Units,
    SUM(CASE WHEN Cost_Price IS NULL THEN 1 ELSE 0 END) AS Missing_Cost_Price,
    SUM(CASE WHEN Revenue < 0 THEN 1 ELSE 0 END) AS Negative_Revenue,
    SUM(CASE WHEN Units <= 0 THEN 1 ELSE 0 END) AS Invalid_Units
FROM `retail sales`;