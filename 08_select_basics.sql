use supply_chain;
select count(*)from parts;
select count(*)from orders;
select *from orders limit 5;
select *from parts limit 10;
select part_no, category, supplier, unit_cost from parts;
select	count(*) from parts where status='active';
select part_no, description, unit_cost from parts order by unit_cost desc limit 5;
select count(*) from parts where category in ('brake','engine');
select count(*) from parts where lead_time_days between 10 and 20;
select count(*) from parts where supplier like 'b%';
select part_no,supplier,lead_time_days,status from parts where status = 'obsolete' AND lead_time_days > 30;
select distinct category from parts order by category;
select count(*) from orders where qty>400 and order_date >= 2026-01-01;
select count(distinct category) as category_count from parts;
select round(100*sum(delivery_status = 'late delivery')/sum(delivery_status<>'Unknown'), 1) As late_pct from orders;
select *from orders;
/* 
Expected Answers:
1. count - 480
2.count - 850
3. limit first 5 'BRK-74477' From Orders sheet
4. limit first 10 'ENG-13278' From parts sheet
5. specific columns showing from parts sheet
6. 411
7. showing listed top parts 'BDY-81611', 'Side Mirror - Premium', '18487.31'
8. 110
9. 98
10. 56
11.'ENG-63627', 'Varroc Engineering', '90', 'Obsolete', all listed 
12. Listed Unique Catagories; lead time -days>30
13. 108
14. category count - 10
15. 26.8
16. all elements from order sheet
*/

