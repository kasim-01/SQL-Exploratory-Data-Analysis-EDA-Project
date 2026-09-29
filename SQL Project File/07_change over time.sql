--analyze sales performance over time
--Each day sales

select 
order_date,
sum(sales_amount) as total_sales
from gold.fact_sales
where order_date is not null
group by order_date
order by order_date

--each year sales

select 
year(order_date) as order_year,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date)
order by order_year

-- each month sales

select 
month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by month(order_date)
order by order_month

-- sales by each year and its month

select 
year(order_date) as order_year,
month(order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by year(order_date) , month(order_date)
order by order_year,order_month

--      or

select 
datetrunc(month ,order_date) as order_month,
sum(sales_amount) as total_sales,
count(distinct customer_key) as total_customers,
sum(quantity) as total_quantity
from gold.fact_sales
where order_date is not null
group by datetrunc(month ,order_date)
order by datetrunc(month ,order_date)
      