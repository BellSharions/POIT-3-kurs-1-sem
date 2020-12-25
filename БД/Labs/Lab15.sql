grant create trigger to SDA;

--task1
create table tabl(
  a int primary key,
  b varchar(30)
);

--task2
declare
  i number(3) := 0;
begin
  while (i < 10)
  loop
    insert into tabl values(i, 'dmitry');
    i := i + 1;
  end loop;
end;
select * from tabl;

--task3-4
create or replace trigger insert_trigger_before before insert on tabl
begin 
  dbms_output.put_line('insert_trigger_before'); 
end;
insert into tabl values (12,'afafaf');
    
create or replace trigger delete_trigger_before before delete on tabl
begin
  dbms_output.put_line('delete_trigger_before');
end;
delete tabl where a=12;
    
create or replace trigger update_trigger_before before update on tabl
begin
  dbms_output.put_line('update_trigger_before');
end;
update tabl set b = 'suraho' where a = 9;

--task5
create or replace trigger insert_foreach_trigger_before before insert on tabl for each row
begin 
  dbms_output.put_line('insert_foreach_trigger_before'); 
end;
insert into tabl values (10,'suraho');
    
create or replace trigger delete_foreach_trigger_before before delete on tabl for each row
begin
  dbms_output.put_line('delete_foreach_trigger_before');
end;
delete tabl where a=10;
    
create or replace trigger update_foreach_trigger_before before update on tabl for each row
begin
  dbms_output.put_line('update_foreach_trigger_before');
end;
update tabl set b = 'suraho' where b = 'dmitry';

--task6
create or replace trigger predicate_trigger before insert or delete or update on tabl
begin
 if inserting then dbms_output.put_line('insert predicate_trigger');
 elsif deleting then dbms_output.put_line('delete predicate_trigger');
 elsif updating then dbms_output.put_line('update predicate_trigger');
 end if;
end;
insert into tabl values (10,'dmitry');

--task7
create or replace trigger insert_trigger_after after insert on tabl
begin 
  dbms_output.put_line('insert_trigger_after'); 
end;
insert into tabl values (11,'dmitry');
    
create or replace trigger delete_trigger_after after delete on tabl
begin
  dbms_output.put_line('delete_trigger_after');
end;
delete tabl where a=11;
    
create or replace trigger update_trigger_after after update on tabl
begin
  dbms_output.put_line('update_trigger_after');
end;
update tabl set b = 'dimka' where a = 10;

--task8
create or replace trigger insert_foreach_trigger_after after insert on tabl for each row
begin 
  dbms_output.put_line('insert_foreach_trigger_after'); 
end;
insert into tabl values (11,'dimoon');
    
create or replace trigger delete_foreach_trigger_after after delete on tabl for each row
begin
  dbms_output.put_line('delete_foreach_trigger_after');
end;
delete tabl where a=11;
    
create or replace trigger update_foreach_trigger_after after update on tabl for each row
begin
  dbms_output.put_line('update_foreach_trigger_after');
end;
update tabl set b = 'dmitry' where b = 'suraho';

--task9
create table AUDITT(
  OperationDate date,
  OperationType varchar2(40),
  TriggerName varchar2(40),
  Data varchar2(40)
);
select * from AUDITT
--task10
drop trigger AUDITT_trigger_before;
create or replace trigger AUDITT_trigger_before before insert or update or delete on tabl for each row
begin
  if inserting then
    dbms_output.put_line('insert AUDITT_trigger_before');
    insert into AUDITT
    values(sysdate, 'insert', 'AUDITS_trigger_before', 'old: '||:old.a||' '||:old.b||', new: '||:new.a||' '||:new.b);
  elsif updating then
    dbms_output.put_line('update AUDITT_trigger_before');
    insert into AUDITT
    values(sysdate, 'update', 'AUDITS_trigger_before', 'old: '||:old.a||' '||:old.b||', new: '||:new.a||' '||:new.b);
  elsif deleting then
    dbms_output.put_line('delete AUDITT_trigger_before');
    insert into AUDITT
    values(sysdate, 'delete', 'AUDITS_trigger_before', 'old: '||:old.a||' '||:old.b||', new: '||:new.a||' '||:new.b);
  end if;
end;

drop trigger AUDITT_trigger_after;
create or replace trigger AUDITT_trigger_after after insert or update or delete on tabl for each row
begin
  if inserting then
    dbms_output.put_line('insert AUDITT_trigger_after');
    insert into AUDITT
    values(sysdate, 'insert', 'AUDITS_trigger_after', 'old: '||:old.a||' '||:old.b||', new: '||:new.a||' '||:new.b);
  elsif updating then
    dbms_output.put_line('update AUDITT_trigger_after');
    insert into AUDITT
    values(sysdate, 'update', 'AUDITS_trigger_after', 'old: '||:old.a||' '||:old.b||', new: '||:new.a||' '||:new.b);
  elsif deleting then
    dbms_output.put_line('delete AUDITT_trigger_after');
    insert into AUDITT
    values(sysdate, 'delete', 'AUDITS_trigger_after', 'old: '||:old.a||' '||:old.b||', new: '||:new.a||' '||:new.b);
  end if;
end;

update tabl set b = 'DIMOOON' where a = 9;
delete from tabl where a = 9;
insert into tabl values('9', 'suraho');
select * from AUDITT;

--task11
insert into tabl values(9, 'suraho');

--task12
drop table tabl;
flashback table tabl to before drop;
select * from user_triggers;

flashback triggers insert_trigger_before to before drop;

drop trigger no_drop_tabl;
create or replace trigger no_drop_tabl before drop on sda.schema
begin
  if dictionary_obj_name = 'TABL' then
    dbms_output.put_line('no_drop_tabl');
    raise_application_error(-20905, 'you cant drop tabl');
  end if;
end;

--task13
drop table AUDITT;
flashback table AUDITT to before drop;
select * from user_triggers;

alter trigger no_drop_tabl enable;

--ALTER TABLE table_name { ENABLE | DISABLE } ALL TRIGGERS;

--task14
create view tablview as select * from tabl;

create or replace trigger instof_trigger instead of insert on tablview
begin
  if inserting then
    dbms_output.put_line('insert instof_trigger');
    insert into tabl VALUES (:new.a, :new.b);
  end if;
end instof_trigger;

insert into tablview values(9, 'SURAHO');
select * from tablview;