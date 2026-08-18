-- Create the database
CREATE DATABASE IF NOT EXISTS salesDataWalmart;

-- Select database as schema
USE salesDataWalmart;

CREATE TABLE IF NOT EXISTS sales (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY, 
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_mathod VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4) NOT NULL,
    rating FLOAT(2,1)
);

-- ---------------------------------------------------------------------------------------------
--  ----------------------------- Feature Engeneering ------------------------------------------
-- Create a new column time_of_day
SELECT
	time,
    (CASE
		WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
        WHEN `time` BETWEEN "12:00:01" AND "16:00:00" THEN "Afternoon"
        ELSE "Evening"
	END
    ) AS time_of_date
FROM sales;

-- Add the new column to the sales table
ALTER TABLE sales ADD COLUMN time_of_date VARCHAR(30);

-- Update the column by adding the data
UPDATE sales
SET time_of_date = (
	CASE
			WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
			WHEN `time` BETWEEN "12:00:01" AND "16:00:00" THEN "Afternoon"
			ELSE "Evening"
		END
);


-- Create a new column day_name
SELECT 
	date,
    DAYNAME(date) as day_name
FROM sales;

-- Add the new column (day_name) to the sales table
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

-- Update the column by adding the data
UPDATE sales 
SET day_name = DAYNAME(date);

-- Create a new column month_name
SELECT 
	date,
    MONTHNAME(date)
FROM sales;

-- Add the new column(manth_name) to the sales table
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

-- Update the column by adding the data
UPDATE sales
SET month_name =  MONTHNAME(date);
-- -------------------------------------------------------------------------------------

-- -------------------------------------------------------------------------------------
-- ------------------------------------ Generic ----------------------------------------
--  How many unique cities does the data have?
SELECT
	DISTINCT(city)
FROM sales;

-- In which city is each branch?
SELECT
	DISTINCT(branch)
FROM sales;

SELECT
	DISTINCT city, branch
FROM sales;
-- ---------------------------------------------------------------------------------
-- -------------------------- Products----------------------------------------------
-- How many unique product lines does the data have?
SELECT 
	COUNT(DISTINCT product_line)
FROM sales;

-- What is the most common payment method?
SELECT
	payment_mathod,
	COUNT(payment_mathod) as count
FROM sales
GROUP BY payment_mathod
ORDER BY count DESC;

-- What is the most selling product line?
SELECT
	product_line,
	COUNT(product_line) as count
FROM sales
GROUP BY product_line
ORDER BY count DESC;

-- What is the total revenue by month?
SELECT
	month_name as month,
	SUM(total) as total_revenue
FROM sales
GROUP BY month_name
ORDER BY total_revenue DESC;

-- What month had the largest COGS? 
SELECT
	month_name as month,
	SUM(cogs) as total_cogs
FROM sales
GROUP BY month_name
ORDER BY total_cogs DESC;

-- What product line had the largest revenue?
SELECT
	product_line,
	SUM(total) as total_revenue
FROM sales
GROUP BY product_line
ORDER BY total_revenue DESC;

-- What is the city with the largest revenue?
SELECT
	city,
	SUM(total) as total_revenue
FROM sales
GROUP BY city
ORDER BY total_revenue DESC;

-- What product line had the largest VAT?
SELECT
	product_line,
	SUM(VAT) as total_vat
FROM sales
GROUP BY product_line
ORDER BY total_vat DESC;

-- Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
SELECT 
	total,
    (CASE 
		WHEN total > (SELECT AVG(total) FROM sales) THEN "Good"
        ELSE "Bad"
        END
	) AS classification
FROM sales;

ALTER TABLE sales ADD COLUMN classification VARCHAR(8);

UPDATE sales
JOIN (
    SELECT AVG(total) AS avg_total
    FROM sales
) AS avg_sales
SET sales.classification = 
    CASE 
        WHEN sales.total > avg_sales.avg_total THEN "Good"
        ELSE "Bad"
    END;

-- Which branch sold more products than average product sold?
SELECT
	branch,
    SUM(quantity)
FROM sales
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales);

-- What is the most common product line by gender?
SELECT
	gender,
    product_line,
    COUNT(gender) as total_gender
FROM sales
GROUP BY gender, product_line
ORDER BY total_gender DESC;

-- What is the average rating of each product line?
SELECT
	product_line,
    ROUND(AVG(rating),2) as AVG_rating
FROM sales
GROUP BY product_line;
-- ----------------------------------------------------------------------------
-- ---------------------------- Sales -----------------------------------------
-- Number of sales made in each time of the day per weekday
SELECT 
	time_of_date,
    COUNT(*) AS total_sale
FROM sales
GROUP BY time_of_date;

-- Which of the customer types brings the most revenue?
SELECT
	customer_type,
    SUM(total) AS total_revenue
FROM sales
GROUP BY customer_type
ORDER BY total_revenue DESC;

-- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT 
	city,
    AVG(VAT) as avg_vat
FROM sales
GROUP BY city
ORDER BY avg_vat DESC;

-- Which customer type pays the most in VAT?
SELECT
	customer_type,
    AVG(VAT) as avg_vat
FROM sales
GROUP BY customer_type
ORDER BY avg_vat DESC;

-- ------------------------------------------------------------------------------------------
-- ---------------------------------- Customer ----------------------------------------------
-- How many unique customer types does the data have?
SELECT
	DISTINCT customer_type
FROM sales;

-- How many unique payment methods does the data have?
SELECT
	DISTINCT payment_mathod
FROM sales;

-- What is the most common customer type?
SELECT 
	customer_type,
    COUNT(*) AS quantity_customer_type
FROM sales
GROUP BY customer_type
ORDER BY quantity_customer_type DESC;

-- Which customer type buys the most?
SELECT
	customer_type,
    COUNT(total) AS count_total
FROM sales
GROUP BY customer_type
ORDER BY count_total DESC;

-- What is the gender of most of the customers?
SELECT
	gender,
    COUNT(*) AS quantity_customer
FROM sales
GROUP BY gender
ORDER BY quantity_customer DESC;

-- What is the gender distribution per branch?
SELECT
	gender,
    COUNT(*) AS quantity_customer_a
FROM sales
WHERE branch = "A"
GROUP BY gender
ORDER BY quantity_customer_a DESC;

SELECT
	gender,
    COUNT(*) AS quantity_customer_b
FROM sales
WHERE branch = "B"
GROUP BY gender
ORDER BY quantity_customer_b DESC;

SELECT
	gender,
    COUNT(*) AS quantity_customer_c
FROM sales
WHERE branch = "C"
GROUP BY gender
ORDER BY quantity_customer_c DESC;

-- Which time of the day do customers give most ratings?
SELECT
	time_of_date,
    AVG(rating) AS avg_rating
FROM sales
GROUP BY time_of_date
ORDER BY avg_rating DESC;

-- Which time of the day do customers give most ratings per branch?
SELECT
	time_of_date,
    AVG(rating) AS avg_rating
FROM sales
WHERE branch = "C"
GROUP BY time_of_date
ORDER BY avg_rating DESC;

-- Which day of the week has the best avg ratings?
SELECT 
	day_name,
    AVG(rating) as avg_rating
FROM sales
GROUP BY day_name
ORDER BY avg_rating DESC;

-- Which day of the week has the best average ratings per branch?
SELECT 
	day_name,
    AVG(rating) as avg_rating
FROM sales
WHERE branch = "A"
GROUP BY day_name
ORDER BY avg_rating DESC;




