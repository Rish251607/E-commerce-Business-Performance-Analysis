-- Create Database
CREATE DATABASE superstore_db;                                                                      I 
USE superstore_db;    

-- Create Table (Based on Your Columns)
CREATE TABLE orders (
    Row_ID INT,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales FLOAT,
    Quantity INT,
    Discount FLOAT,
    Profit FLOAT
);

-- Load the data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Superstore.csv'
INTO TABLE orders
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Row_ID, Order_ID, @Order_Date, @Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment,  
     Country, City, State, Postal_Code, Region, Product_ID, Category, Sub_Category, Product_Name, Sales,
     Quantity, Discount, Profit)
SET 
Order_Date = STR_TO_DATE(@Order_Date, '%m/%d/%Y'),
Ship_Date = STR_TO_DATE(@Ship_Date, '%m/%d/%Y');

-- Total Sales
SELECT SUM(Sales) FROM orders;

-- Sales by Category
SELECT Category, SUM(Sales) FROM orders GROUP BY Category;

-- Top Customers
SELECT Customer_Name, SUM(Sales) as total_sales FROM orders GROUP BY Customer_Name ORDER BY total_sales DESC LIMIT 10;

-- Regional Sales
SELECT Region, SUM(Sales) FROM orders GROUP BY Region;

-- Profit by Category (IMPORTANT 🔥)
SELECT Category, SUM(Profit) AS total_profit FROM orders GROUP BY Category ORDER BY total_profit DESC;

-- Monthly Sales Trend
SELECT YEAR(Order_Date) AS year, MONTH(Order_Date) AS month, SUM(Sales) AS total_sales FROM orders GROUP BY year, month ORDER BY year, month;

