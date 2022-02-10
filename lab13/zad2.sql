WITH cte AS (
SELECT  Ship_mode as shipmode, Region, SUM(Shipping_cost) as shipcost
FROM sample
GROUP BY Ship_mode, Region
)
SELECT shipmode, Region, row_number() over(ORDER BY shipcost DESC) as row_number, DENSE_RANK() over(ORDER BY shipcost DESC) as denserankbyshipcost, shipcost, SUM(shipcost) over(PARTITION BY region ORDER BY region) as shipcostbyregion
FROM cte
ORDER BY row_number;