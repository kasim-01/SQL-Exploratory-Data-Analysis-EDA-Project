--segment products into cost ranges and count how many
--products fall into each segment


/*with product_segments as
(select
product_key,
product_name,
cost,
case when cost < 100 then 'below 100'
     when cost between 100 and 500 then '100-500'
     when cost between 500 and 1000 then '500-1000'
     else 'above 1000'
end cost_range
from gold.dim_products)

select 
cost_range,
count(product_key) as total_products
from product_segments
group by cost_range
order by total_products desc*/

/*group customers into three segments based on their spending behavior
   -VIP: customers with atleast 12 months of history and spending more than $5,000.
   -regular: customers with at least 12 months of history but spending $5000 or less.
   -new: customers with a lifespan less than 12 months.

   and find total number of customers by each group */

   WITH customer_spending AS (
    SELECT
        c.customer_key,
        SUM(f.sales_amount) AS total_spending,
        MIN(order_date) AS first_order,
        MAX(order_date) AS last_order,
        DATEDIFF(month, MIN(order_date), MAX(order_date)) AS lifespan
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_customers c
        ON f.customer_key = c.customer_key
    GROUP BY c.customer_key
)
SELECT 
    customer_segment,
    COUNT(customer_key) AS total_customers
FROM (
    SELECT 
        customer_key,
        CASE 
            WHEN lifespan >= 12 AND total_spending > 5000 THEN 'VIP'
            WHEN lifespan >= 12 AND total_spending <= 5000 THEN 'Regular'
            ELSE 'New'
        END AS customer_segment
    FROM customer_spending
) AS segmented_customers
GROUP BY customer_segment
ORDER BY total_customers DESC;

