ALTER SESSION SET nls_date_format='dd-mm-yyyy';

create table orders
(
	o_id number(3),
	o_name varchar2(30),
  o_date date
);
drop table orders;
select /*xml*/ * from orders;
select * from orders;
delete from orders;