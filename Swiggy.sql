use projects;
SELECT * FROM projects.swiggy;
#interject 1 : Write a query to find top 5 delivery zones by city.
SELECT Area,City,count(ID) AS total_orders
FROM projects.swiggy
GROUP BY Area,City
ORDER BY total_orders DESC
LIMIT 5;
#interject 2: Identify ID who gave low ratings grooup by restuarant
select ID,avg( `Avg ratings`) as Avg_ratings,Restaurant from projects.swiggy group by Restaurant,ID having avg( `Avg ratings`)<=3 ;
#interject 3: Calculate average delivery time by city
select City,Avg( `Delivery time`) as AverageDeliveryTime from projects.swiggy group by city;
#interject 4: Top 3 Restuarants and their total orders grouped by city
select City,Restaurant,total_orders
from( select City, Restaurant, count(ID) as total_orders,
row_number() over(partition by city order by count(ID) desc) as rank_no
from projects.swiggy
group by city,Restaurant
) ranked
where rank_no <=3
order by City,total_orders desc;
#interject 5: BASICS RECOVERANCE
select * from projects.swiggy where `Food type` = ('Biryani,Chinese');
select * from projects.swiggy where `Food Type` is NULL;
select * from projects.swiggy where Price between 300 and 500 ;
select City,Price, 
case
when Price <200 then 'Low'
when Price >=200 and Price <500 then 'High'
else 'Top'
end as pricerange
from projects.swiggy ps
where price is not null
order by Price;
-- subqueries
select City,Price, (select avg(Price) from projects.swiggy) as avgsalary from projects.swiggy;
#interject 6: 2nd highest
select max(Price) from projects.swiggy where Price <(select max(Price) from projects.swiggy); 
#interject 7: Find Duplicates in Records
select Price,count(*) from projects.swiggy group by Price having count(*)>1;
#8:

