select * from pizza_sales

select sum(total_price) as Total_Revenue from pizza_sales  -- Total Revenue

select sum(total_price)/COUNT(distinct order_id)  as Avg_Order_Value from pizza_sales  --Average order Value

select sum(quantity) as Total_Pizza_sold from pizza_sales --Total_Pizza_sold

select COUNT(distinct order_id) as Total_Orders from pizza_sales --Total_orders


select cast(
cast(sum(quantity) as decimal(10,2)) /   --Avg pizza per order
cast(count(distinct order_id) as decimal(10,2))    --casting the integer into 2 decimals
as decimal(10,2))
as Avg_Pizza_per_Order from pizza_sales

---- Daily trands for Total orders---
select DATENAME(dw,order_date) as day_name,  
count(distinct order_id) as Total_orders from pizza_sales 
group by DATENAME(dw,order_date)
/*Saturday	3158
  Wednesday	3024
  Monday	2794
  Sunday	2624
  Friday	3538
  Thursday	3239
  Tuesday	2973 */


--- Monthly trend for Total ordes---
select DATENAME(month,order_date) as month_name,  
count(distinct order_id) as Total_orders from pizza_sales 
group by DATENAME(month,order_date)

/*February	1685
  June	    1773
  August	1841
  April	    1799
  May   	1853
  December	1680
  January	1845
  September	1661
  October	1646
  July	    1935
  November	1792
  March	    1840*/


  -- percentage sales for pizza category
  select pizza_category , sum(total_price) as Total_sales ,
  cast(sum(total_price)*100/(select sum(total_price)  from pizza_sales where month(order_date)=3)  as decimal(10,2))
  as perctage from  pizza_sales
  where month(order_date)=3  -- in  month
  group by pizza_category


  --percentage of sales by pizza size
select pizza_size, cast(sum(total_price) as decimal(10,2) )as Total_sales ,
cast(sum(total_price)*100 /(select sum(total_price) from pizza_sales where DATEPART(quarter,order_date)=2) as decimal(10,2)) as percentage
from pizza_sales
where DATEPART(quarter,order_date)=2
group by pizza_size

-----------
select * from pizza_sales

--Total pizza sold by pizza category--
select  pizza_category,sum(quantity) as Total_pizzas from pizza_sales 
where month(order_date)=1
group by pizza_category
order by Total_pizzas desc


--Top 5 pizza names by revenue

select Top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue  desc

----bottom 5 pizza names by revenue

select Top 5 pizza_name, sum(total_price) as Total_Revenue from pizza_sales
group by pizza_name
order by Total_Revenue  asc

--Top 5 pizza names by quantity

select Top 5 pizza_name, sum(quantity) as Total_quantity from pizza_sales
group by pizza_name
order by Total_quantity  desc

--bottom 5 pizza names by quantity

select Top 5 pizza_name, sum(quantity) as Total_quantity from pizza_sales
group by pizza_name
order by Total_quantity  asc