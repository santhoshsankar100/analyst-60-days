select count(*)
from parts
where unit_cost > (select avg(unit_cost)
from parts);

select count(*) 
as above_category_avg
from parts P
where p.unit_cost > (select avg(p2.unit_cost) from parts p2
where p2.category = p.category);

select count(*) as orders_on_obsolete
from orders
where part_no in (select part_no from parts where status = 'obsolete');

select count(*) as never_ordered
from parts
where part_no not in (select part_no from orders);

select count(*) as frequent_parts
from (select part_no, count(*) as count
from orders
group by part_no
having count(*) > 5)t;

with supplier_spend as (select supplier, sum(spend) as total
from orders
group by supplier)
select supplier, total
from supplier_spend
where total > (select avg(total) from supplier_spend)
order by total desc;

with supplier_spend as (select supplier, sum(spend) as total
from orders
group by supplier),
top3 as (select total from supplier_spend
order by total desc
limit 3)
select sum(total) as top3_spend,
round(100* sum(total)/(select sum(total) from supplier_spend),1) as top3_share_pct
from top3;

with cat_lead as
(select category, round(avg(lead_time_days),2) as avg_lead
from parts
group by category)
select category, avg_lead
from cat_lead
where avg_lead > (select avg(lead_time_days) from parts)
order by avg_lead desc;

with plant_late as (select plant, 100* sum(delivery_status = 'late delivery')/ sum(delivery_status <> 'unknown') as late_pct
from orders
group by plant)
select	plant, round(late_pct,1) as late_pct
from plant_late
where late_pct > (select 100* sum(delivery_status = 'late delivery')/ sum(delivery_status <> 'unknown')
from orders);


with recursive tree as 
(select parent_part, child_part, qty_per, 1 as lvl
from bom
where parent_part = 'ASM-1001'
union all 
select b.parent_part, b.child_part, b.qty_per, t.lvl +1
from bom b
inner join tree t
on b.parent_part = t.child_part)
select lvl, count(*) as 'lines'
from tree
group by lvl;