## 🛍️ Retail Sales Analysis 

#📌 Project Overview

This project focuses on analyzing retail sales data using SQL.

The goal is to perform data cleaning and exploratory analysis to derive insights about:

🧑‍🤝‍🧑 Customer behavior

📦 Product category performance

📈 Sales trends over time

## 🗂️ Table Schema
```sql
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
```
# 🧹 Data Cleaning

Removed rows with NULL values in important fields.

Ensured correct row count before and after cleaning.

```sql
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
```
🔎 Exploratory Data Analysis
Here are some key business questions answered in this project:

1️⃣ Total Sales Transactions
```sql
SELECT 
    COUNT(*) AS total_sales 
FROM retail_sales;
```

2️⃣ Unique Customers
```sql
SELECT 
    COUNT(DISTINCT customer_id) AS total_customers 
FROM retail_sales;
```

3️⃣ Sales on Specific Date (2022-11-05)
```sql
SELECT 
    * 
FROM retail_sales 
WHERE sale_date = '2022-11-05';
```

4️⃣ Category-wise Sales Performance
```sql
SELECT 
    category, 
    SUM(total_sale) AS total_sales_by_category,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category;
```

5️⃣ Average Age of Beauty Customers
```sql
SELECT 
    category,
    ROUND(AVG(age),2) AS avg_age
FROM retail_sales
GROUP BY category
HAVING category = 'Beauty';
```

6️⃣ Top 5 Customers by Sales
```sql
SELECT 
    customer_id,
    SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

7️⃣ Best Selling Month Each Year
```sql
SELECT 
    year, 
    month,
    avg_sales
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
```

8️⃣ Shift-wise Orders (Morning, Afternoon, Evening)
```sql
WITH hourly_sale AS (
    SELECT *,
        CASE
            WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
            WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
            ELSE 'Evening'
        END AS shift
    FROM retail_sales
)
SELECT 
    shift, COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;
```

## 📊 Key Insights

✔️ Evening shift recorded more orders compared to Morning & Afternoon.

✔️ Clothing category saw bulk orders in Nov 2022.

✔️ Customers in the Beauty category were younger on average.

✔️ Top 5 customers contributed a large share of revenue.

✔️ Identified best-selling month per year.

## ⚙️ Tech Stack

🗄️ Database: PostgreSQL / MySQL

💻 Language: SQL

🔗 Version Control: Git & GitHub

## 📌 Conclusion

This project demonstrates how SQL can be used to clean, explore, and analyze retail sales data.
It provides insights into customer demographics, sales trends, and product category performance.

