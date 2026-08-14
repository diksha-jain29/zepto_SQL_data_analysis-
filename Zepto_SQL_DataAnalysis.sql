DROP TABLE Zepto

CREATE TABLE Zepto(
ID SERIAL PRIMARY KEY,
Category VARCHAR(120),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountPercent NUMERIC(5,2),
availableQuantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
)

SELECT * FROM Zepto 
WHERE name IS NULL
OR
Category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
discountedSellingPrice IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

SELECT DISTINCT Category
FROM Zepto
ORDER BY Category;

SELECT outOfStock, COUNT(ID)
FROM ZEPTO
GROUP BY outOfStock;

SELECT name, COUNT(ID) AS NUM_IDs
FROM Zepto
GROUP BY name
HAVING count(ID)>1
ORDER BY  COUNT(ID) DESC;

--data cleaning 

--price should not be zero
SELECT * FROM Zepto
WHERE mrp=0 OR discountedSellingPrice =0;

DELETE FROM Zepto
WHERE mrp=0 OR discountedSellingPrice=0;

--converting paise to rupees
UPDATE Zepto
SET mrp=mrp/100.00,
discountedSellingPrice= discountedSellingPrice/100.00;

--business insights- answering questions

--1. Finding the top 10 best products based on the selling quantity.
SELECT name, SUM(quantity) FROM Zepto
GROUP BY name
ORDER BY SUM(quantity) DESC
LIMIT 10;

--2.Products with high MRP but out of stock?
SELECT DISTINCT name, mrp,outOfStock
FROM Zepto
WHERE mrp>350 AND outOfStock= TRUE
ORDER BY mrp DESC;

--3. Products where mrp>500 and discount<10%
SELECT DISTINCT name, mrp, discountPercent
FROM Zepto
WHERE mrp>500 AND discountPercent<10
ORDER BY mrp DESC;

--4.total revenue for each category
SELECT Category, SUM(discountedSellingPrice*quantity) AS total_revenue
FROM Zepto
GROUP BY Category
ORDER BY total_revenue DESC;

--5.Grouping the categories like low, medium and bulk
SELECT name,weightInGms,
CASE WHEN weightInGms <= 1500 THEN 'Low'
	WHEN weightInGms <= 5000 THEN 'Medium'
	ELSE 'Bulk'
	END AS weight_category
FROM Zepto;

