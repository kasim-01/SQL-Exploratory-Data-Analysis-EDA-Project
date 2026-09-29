--   cumulative analysis --

-- calculate the total sales per month
--and the running total of sales over time 
select
order_date,
total_sales,
sum(total_sales) over(order by order_date) as running_total_sales
from 
(select 
datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month, order_date)) t

--calculate the total sales per month
--and the running total of sales by year 

select
order_date,
total_sales,
sum(total_sales) over(partition by datetrunc(year,order_date) order by order_date) as running_total_sales
from 
(select 
datetrunc(month,order_date) as order_date,
sum(sales_amount) as total_sales
from gold.fact_sales
where order_date is not null
group by datetrunc(month, order_date)) t

