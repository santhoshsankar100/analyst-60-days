select *
from parts;

select part_no, category,unit_cost,
Row_number()  over (partition by category order by unit_cost desc) as rn
from parts
order by category, rn;

select part_no, unit_cost,
row_number() over (order by unit_cost desc) as rn
from parts
order by rn
limit 5;

with top_supplier as (select supplier, sum(spend) as total_spend
from orders
group by supplier
order by total_spend desc
limit 5)
select supplier,total_spend,
rank() over (order by total_spend desc) as Top_5_suppliers
from top_supplier;

with cat_count as (select category, count(*) as parts
from parts
group by category)
select category, parts, 
rank() over(order by parts desc) as rnk,
dense_rank () over(order by parts desc) as d_rnk
from cat_count;

with ranked as (select category, part_no, unit_cost,
row_number () over(partition by category order by unit_cost desc) as rn
from parts)
select category, part_no, unit_cost
from ranked
where rn = 1
order by unit_cost desc;

with ranked as (select category, part_no, unit_cost,
row_number () over(partition by category order by unit_cost desc) as rn
from parts)
select category, part_no, unit_cost,rn
from ranked
where rn <=2
order by category, rn;

with monthly as (select date_format(order_date, '%Y-%m') as ym, sum(spend) as month_spend
from orders
group by date_format(order_date, '%Y-%m'))
select ym, month_spend, sum(month_spend) over(order by ym) as running_total
from monthly
order by ym;

with monthly as (select date_format(order_date, '%Y-%m') as ym, sum(spend) as month_spend
from orders
group by date_format(order_date, '%Y-%m'))
select ym, month_spend, month_spend - lag(month_spend) over(order by ym) as change_vs_prev
from monthly
order by ym;

with plant_supplier as (select plant, supplier, sum(spend) as total
from orders
group by plant, supplier
),
ranked as(
select plant, supplier, total, 
rank() over (partition by plant order by total desc) as rnk
from plant_supplier)
select plant, supplier, total, rnk
from ranked
where rnk <=2 
order by plant, rnk;

with supplier_spend as (select supplier, sum(spend) as total
from orders
group by supplier)
select supplier, total,
round(100* total/ sum(total) over(), 1) as share_pct
from supplier_spend
order by total desc
limit 5;

with X as (
select part_no, category, lead_time_days,
avg(lead_time_days) over (partition by category) as cat_avg
from parts)
select count(*) as above_cat_avg
from x
where lead_time_days > cat_avg;