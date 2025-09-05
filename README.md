🛍️ Retail Sales Analysis (SQL Project)
📌 Project Overview

This project focuses on analyzing retail sales data using SQL. The goal is to perform data cleaning and exploratory analysis to derive meaningful insights such as sales trends, customer behavior, and product category performance.
The dataset contains transactional-level details including date, time, customer demographics, product categories, and sales information.

🗂️ Table Schema

'''sql
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
'''

🧹 Data Cleaning
Removed rows with NULL values in critical fields.
Verified total row count before and after cleaning.

'''sql
DELETE FROM retail_sales
WHERE transactions_id IS NULL
   OR sale_date IS NULL
   OR sale_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
'''

🔎 Exploratory Data Analysis (EDA)
Some of the key business questions answered in this project:

1. Total Sales Transactions

'''sql
SELECT COUNT(*) AS total_sales FROM retail_sales;
'''

3. Unique Customers

'''sql
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
'''


4. Sales on Specific Date (e.g., 2022-11-05)

'''sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
'''

5. Category-wise Sales Performance

'''sql
SELECT category, SUM(total_sale) AS total_sales_by_category, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
'''

6. Average Age of Customers (Beauty Category)

'''sql
SELECT category, ROUND(AVG(age),2) AS avg_age
FROM retail_sales
GROUP BY category
HAVING category = 'Beauty';
'''

8. Top 5 Customers by Sales

'''sql
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
'''

10. Monthly Average Sales & Best Selling Month per Year

'''sql
SELECT year, month, avg_sales
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sales,
        RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date)
                    ORDER BY AVG(total_sale) DESC) AS rank
    FROM retail_sales
    GROUP BY 1,2
) AS t1
WHERE rank = 1;
'''

11. Shift-wise Orders (Morning, Afternoon, Evening)

'''sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
'''

📊 Key Insights
High-value sales transactions identified (>1000 total_sale).
Clothing had significant bulk orders in Nov 2022.
Beauty category customers are on average younger.
Top 5 customers contributed a large share of sales.
Evening shift recorded higher order counts compared to other times.
Found the best-selling month for each year.

⚙️ Tech Stack
Database: PostgreSQL / MySQL
Language: SQL
Version Control: Git & GitHub


🚀 How to Run
Clone this repository:
git clone https://github.com/DhAnAnJaY506/retail-sales-analysis.git
cd retail-sales-analysis

Load the SQL script into your database.
Run queries step by step to explore the dataset.

📌 Conclusion
This project demonstrates how SQL can be used to clean, explore, and analyze retail sales data to uncover customer insights, product performance, and sales patterns. It can be extended further with Power BI / Python visualization for dashboards.
