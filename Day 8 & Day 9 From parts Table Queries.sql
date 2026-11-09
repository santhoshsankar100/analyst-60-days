use supply_chain;
select part_no,description,unit_cost
from parts
limit 5;

select category, count(category)
from parts
where category = 'cooling system';

select description,unit_cost
from parts
where unit_cost<500
order by unit_cost asc;

select count(PART_NO)
from parts
WHERE PART_NO LIKE 'FLT-%';

select supplier,count(SUPPLIER)
FROM PARTS
WHERE SUPPLIER IN ('denso','Bosch india','Valeo')
group by supplier;

select count(MOQ)
from parts
where moq between 100 and 200;

select part_no, Supplier
from parts
where category = 'steering'
and status = 'obsolete';

select count(distinct supplier) as 'No.of.Suppliers exist in parts Table'
From parts;

select Supplier,count(Supplier) As 'No.of.parts'
from parts
group by supplier
order by count(supplier) desc;

select category, sum(STOCK_QTY) as 'Total Stock_Qty'
from parts
group by category
order by sum(STOCK_QTY) desc;

select supplier, round(avg(LEAD_TIME_DAYS),2)
from parts
group by supplier
order by avg(LEAD_TIME_DAYS) Desc
limit 3;

select category, count(part_no) as 'no.of.parts'
from parts
group by category
having count(part_no) >45
order by count(part_no) desc;

select category, status, count(*) As 'Obsolete_Part_count'
from parts
where status = 'obsolete'
group by category
having count(*) > 5;