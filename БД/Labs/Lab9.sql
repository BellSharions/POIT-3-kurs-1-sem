--task1
grant create session to SDA;
grant create table to SDA;
grant create view to SDA;
grant create any sequence to SDA;
grant select any sequence to SDA;
grant create cluster to SDA;
grant create public synonym to SDA;
grant create synonym to SDA;
grant create materialized view to SDA;
grant drop public synonym to SDA;
alter user SDA quota unlimited on users;

--task2
create sequence SDA.S1
    increment by 10
    start with 1000
    nomaxvalue
    nominvalue
    nocycle
    nocache
    noorder;
    
    select S1.nextval from dual;
    select S1.currval from dual;
    
--task3
create sequence SDA.S2
    increment by 10
    start with 10
    maxvalue 100
    nocycle;
    
    select S2.nextval from dual;
    alter sequence S2 increment by 110;
    drop sequence S2;
    
--task5
create sequence SDA.S3
    increment by -10
    start with 10
    maxvalue 20
    minvalue -100
    nocycle
    order;
    
    select S3.nextval from dual;
    alter sequence S3 increment by -120;
    drop sequence S3;
    
--task6
create sequence SDA.S4
    increment by 1
    start with 1
    maxvalue 10
    cycle
    cache 5
    noorder;
    
    select S4.nextval from dual;
    
--task7
select * from sys.all_sequences where sequence_owner='SDA';

--task8
create table T1 (
    N1 number(20),
    N2 number(20),
    N3 number(20),
    N4 number(20)
    ) storage(buffer_pool keep);
    
    insert into T1(N1,N2,N3,N4) values (S1.currval, S2.currval, S3.currval, S4.currval);
    insert into T1(N1,N2,N3,N4) values (S1.currval, S2.currval, S3.currval, S4.currval);
    insert into T1(N1,N2,N3,N4) values (S1.currval, S2.currval, S3.currval, S4.currval);
    
    select * from T1;

--task9
ALTER USER SDA quota 100m on USERS;
grant unlimited tablespace to SDA;

create cluster SDA.ABC
(
    x number(10),
    v varchar2(12)
)
hashkeys 200;

--task10-12
create table A(XA number(10), VA varchar(12), AA char(10)) cluster SDA.ABC(XA,VA);
create table B(XB number(10), VB varchar(12), BB char(10)) cluster SDA.ABC(XB,VB);
create table C(XC number(10), VC varchar(12), CC char(10)) cluster SDA.ABC(XC,VC);

--task13
select cluster_name, owner from DBA_CLUSTERS;
select * from dba_tables where cluster_name='ABC';

--task14-15
create synonym SS1 for SDA.C;
create public synonym SS2 for SDA.B;
select * from dba_synonyms where table_owner='SDA';

insert into SDA.A values(1, 'A', 'AA');
insert into SDA.B values(2, 'B', 'BB');
insert into SDA.C values(3, 'C', 'CC');
select * from SS1;
select * from SS2;

--task16
create table tableA (
    X number(20) primary key
);
drop table tableA;
create table tableB (
    Y number(20),
    constraint fk_column foreign key (Y) references tableA(X)
);
        
insert into tableA(X) values (1);
insert into tableA(X) values (2);
insert into tableB(Y) values (1);
insert into tableB(Y) values (2);
commit;
    
create view V1 as select tableA.X, tableB.Y from tableA inner join tableB on tableA.X=tableB.Y;
select * from V1;

create synonym SYNON for V1;
select * from SYNON;
--task17
create materialized view MV
    build immediate
    refresh complete
    start with sysdate
    next sysdate + Interval '2' minute
    as
    select tableA.X, tableB.Y from tableA inner join tableB on tableA.X=tableB.Y;

drop materialized view MV;
select * from MV;