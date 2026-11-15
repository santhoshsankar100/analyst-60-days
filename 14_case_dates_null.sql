## cost class of parts using case & count per class.
select
case
when unit_cost>= 12000 then 'HIGH'
when unit_cost>= 5000 then 'Medium'
else 'LOW'
end as 'Class',
count(*) as no_of_parts
  from parts
  group by class
    order by no_of_parts desc;
    
    ## delivery speed bucket: count per bucket
    select
case
when delivery_days <= 15 then 'FAST'
when delivery_days <= 30 then 'NORMAL'
else 'SLOW'
end as 'SPEED',
count(*) as orders_count
from orders
group by speed
order by orders_count desc;

### abc classifiaction of parts by order spend : count per class;

with part_spend as
(select part_no, sum(spend) as 'Total_spend'
from orders
group by part_no
having Total_spend > 0),
cum as (select part_no, Total_spend, 100* sum(Total_spend) over (order by total_spend desc, part_no)/ sum(total_spend) over () as cum_pct
from part_spend)
select case
when cum_pct <=80 then 'A'
when cum_Pct <=95 then 'B'
else 'C'
end as class,
count(*) as parts
from cum
group by class
order by class;

## order per year and quarter
select year(order_date) as YR, quarter(order_date) as qtr, count(*) as orders
from orders
group by year(order_date) , quarter(order_date)
order by yr, qtr;

## orders delivered more than 20 days beyond lead time
select count(*) as very_late
from orders
where delivery_days - lead_time_days >20;

##null handling : count null lead times, and avg with/without coalesce
select sum(lead_time_days is null) as null_lead,
round(avg(lead_time_days),2)  as avg_skip_null,
round(avg(coalesce(lead_time_days, 0)), 2) as avg_null_as_zero
from orders;

##data quality checks
select(select count(*) from (select part_no from parts group by part_no having  count(*)
>1)d) as duplicate_parts,
(select count(*) from parts where supplier = 'unknown') as unknown_supplier_parts,
(select count(*) from orders where supplier = 'Not Found') as orders_missing_part,
(select count(*) from orders where delivery_date < order_date) as bad_dates;

##delivery status per plant in one row
select plant,
sum(case when delivery_status = 'late delivery' then 1 else 0 end) as late,
sum(case when delivery_status like 'on time%' then 1 else 0 end) as on_time,
sum(case when delivery_status = 'unknown' then 1 else 0 end) as unknown
from orders
group by plant;

##parts with stock below MOQ
select count(*) as below_moq
from parts
where stock_qty < moq;

##orders per weekday
select dayname(order_date) as weekday, count(*) as orders
from orders
group by dayname(order_date)
order by orders desc;