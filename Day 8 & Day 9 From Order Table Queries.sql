use supply_chain;
select count(order_id) as 'above 300 qty orders From Pune Plant'
from orders
where plant ='pune' and
qty >300;

select count(*) as 'March orders'
from orders
where order_date between '2026-03-01' and '2026-03-31';

select plant, round(sum(spend),0) As 'Total spend', count(*) As 'Total Orders'
from orders
group by plant
order by count(*) desc;

select category,sum(qty)
from orders
group by category
order by sum(qty) desc;

select supplier, sum(spend) As 'Total spend'
from orders
group by supplier
having sum(spend) >100000000
order by sum(spend) desc;

select month(order_date) As 'month',
count(*) as 'total_orders'
from orders
where year(order_date) = 2026
group by month(order_date)
order by month;

select supplier,count(order_id) as 'Late delivery Order Count'
from orders
where DELIVERY_STATUS ='Late Delivery'
group by supplier
order by count(order_id) Desc
limit 5;