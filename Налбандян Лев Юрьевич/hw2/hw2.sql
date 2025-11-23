
--№1

select distinct brand from product p where p.standard_cost > 1500 and p.product_id in (
	select product_id from order_items oi join orders o on oi.order_id = o.order_id group by product_id having sum(quantity) >= 1000
);

--№2

select DATE_TRUNC('day',order_date::date), count(*) as orders_number,  count(distinct customer_id) as customer_number  from orders where order_status = 'Approved' and order_date between '2017-04-01' and '2017-04-09' group by DATE_TRUNC('day',order_date::date) order by DATE_TRUNC('day',order_date::date) 

--№3

select distinct job_title from customer where job_industry_category = 'IT' and job_title like 'Senior%'
union all
select distinct job_title from customer where job_industry_category = 'Financial Services' and job_title like 'Lead%'

--№4

WITH fin_order_ids AS (
select order_id from orders o join customer c on o.customer_id = c.customer_id where job_industry_category = 'Financial Services'
), fin_brands as (
select distinct brand from order_items oi join product p on oi.product_id = p.product_id where oi.order_id in (select order_id fin_order_ids) 
), it_order_ids AS (
select order_id from orders o join customer c on o.customer_id = c.customer_id where job_industry_category = 'IT'
), it_brands as (
select distinct brand from order_items oi join product p on oi.product_id = p.product_id where oi.order_id in (select order_id it_order_ids) 
)
select brand from fin_brands where brand not in (select brand from it_brands)

--№6

select customer_id, first_name , last_name from customer where customer_id not in (
select distinct customer_id from orders where order_status='Approved' and 
online_order = true and
EXTRACT(YEAR FROM order_date::date) >= EXTRACT(YEAR FROM now()::date)) and
wealth_segment <> 'Mass Customer' and 
owns_car = 'Yes';

--№7

with top_five_list_price_in_road as(
select product_id from product p where p.product_line = 'Road' order by p.list_price desc limit 5
),
customers_with_top_two_products AS (
    select o.customer_id,
           COUNT(DISTINCT oi.product_id) AS num_unique_products
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id IN (SELECT product_id FROM top_five_list_price_in_road)
    GROUP BY o.customer_id
    HAVING COUNT(DISTINCT oi.product_id) = 2
)
select c.customer_id, c.first_name, c.last_name from customer c where c.customer_id in (select customer_id from customers_with_top_two_products) and c.job_industry_category like 'IT%'


