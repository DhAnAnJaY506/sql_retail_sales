CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);
-- Data Cleaning

SELECT *
FROM retail_sales
LIMIT 10;

SELECT COUNT(*)
FROM retail_sales;

DELETE FROM retail_sales
WHERE transaCtions_id IS NULL
OR
 sale_date IS NULL
OR
 sale_time IS NULL
OR
 customer_id IS NULL
OR
 gender IS NULL
OR 
 age IS NULL
OR
 category IS NULL
OR 
 quantity IS NULL
OR
 price_per_unit IS NULL
OR
cogs IS NULL
OR 
 total_sale IS NULL;
 
-- Data Explorations

 -- how many sales we have?
SELECT
COUNT(*) AS total_Sales
FROM retail_sales;

-- how many unique customers we have?
SELECT
COUNT(DISTINCT(customer_id)) AS total_Sales
FROM retail_sales

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:	
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * 
FROM retail_sales
WHERE category = 'Clothing'
AND
quantity >= 4
AND
TO_CHAR(sale_date,'YYYY-MM') = '2022-11';

-- Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT
	category,
	SUM(total_sale) AS total_sales_by_category,
	COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;

--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT
	category,
	ROUND(AVG(age),2) as avg_age
FROM retail_sales
GROUP BY 1
HAVING category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT
	category,
	gender,
	COUNT(*) AS tran_count
FROM retail_sales
GROUP BY 1,2
ORDER BY 1 ;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT
	year,
	month,
	avg_sales
FROM
(
SELECT
	EXTRACT(YEAR FROM sale_date)  AS year,
	EXTRACT(MONTH FROM sale_date) AS MONTH,
	AVG(total_Sale) AS avg_sales,
	RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY (AVG(total_Sale))) AS RANK
FROM retail_sales
GROUP BY 1,2
) AS T1
WHERE RANK = 1;

--*Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT 
	category,
	COUNT(DISTINCT(customer_id)) AS unq_customers
FROM retail_sales
GROUP BY 1
ORDER BY 2;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;

---------------------------------------------End of Project---------------------------------------------------------
