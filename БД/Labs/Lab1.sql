create table SDA_t(x number(3), s varchar2(50));

insert into SDA_t values(1, 'Cat');
insert into SDA_t values(2, 'Dog');
insert into SDA_t values(3, 'Mouse');
commit;

update SDA_t set x = 11 where s = 'Cat';
update SDA_t set x = 33 where x = 3;
commit;

select * from SDA_t;
select * from SDA_t where x > 3;
select sum(x) from SDA_t;

delete from SDA_t where x = 11;
commit;

alter table SDA_t add constraint x_pk primary key(x);
commit;

create table SDA_t1 (
  x1 number(3), 
  s1 varchar2(50),
  foreign key (x1) references SDA_t(x)
);

insert into SDA_t1 values(2, 'Dima');
commit;

select * from SDA_t inner join SDA_t1 on SDA_t.x = SDA_t1.x1;
select * from SDA_t left outer join SDA_t1 on SDA_t.x = SDA_t1.x1;
select * from SDA_t right outer join SDA_t1 on SDA_t.x = SDA_t1.x1;

drop table SDA_t1;
drop table SDA_t;