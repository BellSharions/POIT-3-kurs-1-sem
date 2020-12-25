GRANT CREATE DATABASE LINK TO SDA;
GRANT CREATE PUBLIC DATABASE LINK TO SDA;

drop database link con1;

--task1
CREATE DATABASE LINK con1
  CONNECT TO SDA
  IDENTIFIED BY "12345"
  USING 'SERVER:1521/sda_pdb';
  
select * from teacher@con1;

begin
  dbms_output.put_line(TEACHERS.GET_NUM_TEACHERS@con1('FIT'));
end;

--task2
CREATE PUBLIC DATABASE LINK con2
  CONNECT TO SDA
  IDENTIFIED BY "12345"   
  USING 'SERVER:1521/sda_pdb';

select * from teacher@con2;

begin
  dbms_output.put_line(TEACHERS.GET_NUM_TEACHERS@con2('FIT'));
end;