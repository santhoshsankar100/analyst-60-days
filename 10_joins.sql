use supply_chain;
select count(*)
from orders
inner join parts
on orders.part_no = parts.part_no;

select count(*)
from orders
left join parts
on orders.part_no = parts.part_no;

select orders.order_id, orders.part_no
from orders
left join parts
on orders.part_no = parts.part_no
where parts.part_no is null;

select count(distinct orders.part_no)
from orders
left join parts
on orders.part_no = parts.part_no
where parts.part_no is null;

select count(*) as 'no.of parts never ordered'
from parts
left join orders
on orders.part_no = parts.part_no
where orders.order_id is null;

select parts.category, count(parts.part_no)
from parts
left join orders
on orders.part_no = parts.part_no
where orders.order_id is null
group by Category
order by count(parts.part_no) desc;

select parts.part_no, parts.description, count(orders.order_id)
from parts
left join orders
on orders.part_no = parts.part_no
group by parts.part_no, parts.description
order by count(orders.order_id) desc
limit 5;

select parts.category, count(orders.order_id)
from parts
left join orders
on orders.part_no = parts.part_no
group by parts.category
order by count(orders.order_id) desc;

select count(*) as 'orders_on_obsolete', count(distinct orders.part_no) as 'obsolete_parts_ordered'
from orders
inner join parts
on orders.part_no = parts.part_no
where parts.status = 'obsolete';

select parts.supplier, sum(orders.qty)
from orders
inner join parts
on orders.part_no = parts.part_no
group by parts.supplier
order by sum(orders.qty) desc
limit 3;

select count(parts.part_no)
from orders
inner join parts
on orders.part_no = parts.part_no
where orders.DELIVERY_STATUS = 'late Delivery' and
parts.status = 'obsolete';