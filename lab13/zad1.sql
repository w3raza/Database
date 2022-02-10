WITH cte AS(SELECT Product_name, Customer_name, COUNT(*) AS count, SUM(sales) AS sum
from sample 
GROUP BY Product_name, Customer_name
HAVING COUNT(sales) > 1
UNION
SELECT product_name, null, COUNT(sales) AS count, SUM(sales) AS sum
FROM sample GROUP BY product_name
HAVING COUNT(sales) > 20
UNION
SELECT null, customer_name, COUNT(sales) AS count, SUM(sales) AS sum
FROM sample GROUP BY customer_name
HAVING COUNT(sales) > 30
)
SELECT * FROM cte ORDER BY  Product_name, Customer_name;