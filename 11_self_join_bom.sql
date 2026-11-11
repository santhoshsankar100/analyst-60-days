select supersession_part_no, count(*) as "Count"
from parts
group by supersession_part_no
order by count desc
limit 1;

select old.part_no as "old_part", old.unit_cost as "old_cost", old.status,
new.part_no as'Replaced new_part', new.status as 'new_status', new.unit_cost as "new_cost"
from parts old
inner join parts new
on old.supersession_part_no = new.part_no
where old.status = 'obsolete';

select count(*) As "replacement_costlier"
from parts old
inner join parts new
on old.supersession_part_no = new.part_no
where new.unit_cost> old.unit_cost;

select count(*) As 'obsolete_NO Replacement'
from parts old
left join parts new
on old.supersession_part_no = new.part_no
where old.status = 'obsolete' and
new.part_no is null;

select count(distinct a.parent_part)
As 'Top level assemblies'
from bom a
left join bom b
on a.parent_part = b.child_part
where b.child_part is null;

select round(sum(b.qty_per * p.unit_cost),2) as 'bom cost'
from bom b
inner join parts p
on b.child_part = p.part_no
where b.parent_part ='ASM-2001';

select parent_part
from bom
where child_part = 'BRK-51365'
order by parent_part;

select count(*)
as "bom_lines",
count(distinct b.child_part) as "obsolete_parts"
from bom b
inner join parts p
on b.child_part = p.part_no
where p.status = "obsolete";

select count(distinct old.part_no) As "Distinct_old_parts"
from bom b
inner join parts old on b.child_part = old.part_no
where old.status = 'obsolete';

select count(*) 
AS "orders_on_replaceable_obsolete"
from orders o
inner join parts old
on o.part_no = old.part_no
inner join parts new
on old.supersession_part_no = new.part_no;