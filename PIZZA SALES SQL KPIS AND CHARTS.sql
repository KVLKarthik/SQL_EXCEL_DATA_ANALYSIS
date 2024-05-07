--PIZZA SALES SQL QUERIES


select * from pizza_sales;


-- Total Revenue KPI
select sum(total_price) as 'Total Revenue'
from pizza_sales

-- AVGrage order value KPI
select sum(total_price)/ count(distinct order_id) as 'AVG order value'
from pizza_sales

-- Total pizza sold KPI
select sum(quantity) 'quantity1' from pizza_sales

-- Total orders KPI
select count(distinct order_id) 'Total orders'
from pizza_sales

-- AVG pizza per order: KPI
select cast(cast(sum(quantity) as decimal(10,2)) / 
cast(count(distinct order_id) as decimal(10,2)) as decimal(10,2))
'AVG pizza per order'
from pizza_sales

--Daily trend
select DATENAME(DW,order_date) 'Day1'
, count(distinct order_id) 'count on each day'
from pizza_sales
group by DATENAME(DW,order_date)

-- Hourly Trend

select DATEPART(HOUR,order_time) ' order hours' ,
count(distinct order_id) 'orders on each hour'
from pizza_sales
group by DATEPART(HOUR,order_time)
order by count(distinct order_id) desc

--percetage of sales by pizza cateory

with cte1 as (
select pizza_category, sum(total_price) as pt
from pizza_sales
group by pizza_category)

,cte2 as(select *,sum(pt) over() pk from cte1)
select pizza_category, (pt/pk)*100 '% of sales by pizza category'
from cte2

-- Percentage of Sales by Pizza Size :

select pizza_size,
cast(sum(total_price) as decimal(10,2)) 'sales by size',
cast(sum(total_price)*100/ (select sum(total_price) from pizza_sales) as decimal(10,2))
'% sales by pizza size'
from pizza_sales
group by pizza_size
order by 
sum(total_price)*100/ (select sum(total_price) from pizza_sales) desc

-- total pizzas sold by pizza category

select pizza_category,sum(quantity)
'total pizzas sold'
from pizza_sales
group by pizza_category

-- top 5 best sellers by total pizzas sold

select top 5 pizza_name,  sum(quantity) 
'best sellers'
from pizza_sales
--where MONTH(order_date) = 1
group by pizza_name
order by sum(quantity) desc


-- Bottom 5 worst sellers by total pizzas sold

select top 5 pizza_name,  sum(quantity) 
'best sellers'
from pizza_sales
--where MONTH(order_date) = 1
group by pizza_name
order by sum(quantity) asc


















