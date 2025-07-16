## --RETAIL SALES ANALYSIS-- ##

create database retail_sales_proj;

use retail_Sales_proj;



drop table if exists retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(8),
    age INT,
    category VARCHAR(15),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);



SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL
        OR sale_date IS NULL
        OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantiy IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;
    
    
    
SELECT 
    COUNT(DISTINCT customer_id) AS 'TOTAL_CUSTOMERS'
FROM
    retail_sales;
    
    
    
SELECT DISTINCT category AS 'PRODUCT_TYPES'
FROM retail_sales;

    
    
SELECT 
    transactions_id, sale_date, customer_id, category, quantiy
FROM
    retail_sales
WHERE
    category = 'clothing' AND quantiy > 2
        AND MONTH(sale_date) = '11'
        AND YEAR(sale_date) = '2022'
ORDER BY 2;
    
    
    
SELECT DISTINCT
    category, SUM(quantiy) AS 'TOTAL_QUANTITY'
FROM
    retail_sales
GROUP BY 1;    
    
  
  
SELECT DISTINCT
    category,
    SUM(total_sale) AS 'NET_SALE',
    COUNT(*) AS 'TOTAL_ORDERS'
FROM
    retail_sales
GROUP BY 1;        
    
    
    
SELECT 
    category,
    ROUND(AVG(age), 2) AS 'AVG_AGE_OF_BEAUTY_CUSTOMERS'
FROM
    retail_sales
GROUP BY 1;
    
    
    
SELECT 
    transactions_id, customer_id, total_sale
FROM
    retail_sales
WHERE
    total_sale > 1000;
    

    
SELECT 
    gender,
    category,
    SUM(transactions_id) AS 'TOTAL_TRANSACTIONS'
FROM
    retail_sales
GROUP BY 1 , 2
ORDER BY 1;
    
SELECT * 
FROM 
(    
SELECT 
    YEAR(sale_date) AS 'YEAR',
    MONTHNAME(sale_date) AS 'MONTH',
    ROUND(AVG(total_sale), 2) AS 'TOTAL_SALE',
    RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY ROUND(AVG(total_sale), 2) DESC) AS 'RANKING_BY_ORDER' 
FROM
    retail_sales
GROUP BY 1 , 2
) AS T1
where RANKING_BY_ORDER = 1;
    
    
    
select distinct customer_id as 'CUSTOMER_ID', sum(total_sale) AS 'TOTAL_SALE',
RANK() OVER(order by sum(total_sale) desc) as 'RANK'
from retail_sales
group by 1
limit 5;
    
    
    
SELECT 
    COUNT(DISTINCT customer_id) AS 'Unique Customers', category
FROM
    retail_sales
GROUP BY 2;
    
    
with hourly_sale
as
(
select *,
	case
		when hour(sale_time) < 12 then 'Morning'
        when hour(sale_time) between 12 and 17 then 'Afternoon'
        else 'Evening'
    end as 'Shift'
from retail_Sales
)    
select Shift, count(transactions_id) as 'Total_orders'  
from hourly_Sale
group by 1;    
    
