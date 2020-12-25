--task1
create tablespace TS_SDA
  datafile 'C:\DataBaseLabs\TS_SDA.dbf'
  size 7m
  autoextend on next 5m
  maxsize 20m 
  extent management local;
drop tablespace TS_SDA;

--task2
create temporary tablespace TS_SDA_TEMP
  tempfile 'C:\DataBaseLabs\TS_SDA_TEMP.dbf'
  size 5m
  autoextend on next 3m
  maxsize 30m 
  extent management local;
drop tablespace TS_SDA_TEMP;

--task3
--select file_name, tablespace_name, status, maxbytes, user_bytes from dba_data_files
--union
--select file_name, tablespace_name, status, maxbytes, user_bytes from dba_temp_files;
select * from DICTIONARY;
select * from DBA_TABLESPACES;

--task4
alter session set "_ORACLE_SCRIPT" = true;
create role RL_SDACORE;
grant create session,
      create table,
      create view,
      create procedure,
      drop any table,
      drop any view, 
      create tablespace,
      drop any procedure to RL_SDACORE;

--task5
select * from dba_roles where role  like 'RL%';
select * from dba_sys_privs where grantee = 'RL_SDACORE';

--task6
create profile PF_SDACORE limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30

--task7
select distinct PROFILE from dba_profiles;
select * from dba_profiles where profile = 'PF_SDACORE';
select * from dba_profiles where profile = 'DEFAULT';

--task8
create user SDACORE identified by 12345
default tablespace TS_SDA quota unlimited on TS_SDA
temporary tablespace TS_SDA_TEMP
profile PF_SDACORE
account unlock
password expire

grant RL_SDACORE to SDACORE

--task10
create table SDA_t(x number(3), s varchar2(50));

insert into SDA_t values(1, 'Cat');
insert into SDA_t values(2, 'Dog');
insert into SDA_t values(3, 'Mouse');
commit;

create view FIRSTVIEW as select * from SDA_t;

select * from FIRSTVIEW;

--task11
alter session set "_ORACLE_SCRIPT" = true;

create tablespace SDA_QDATA
datafile 'C:\DataBaseLabs\SDA_QDATA.dbf'
size 10m
offline

alter tablespace SDA_QDATA online;

create user SDA identified by 12345
  default tablespace SDA_QDATA quota 2m on SDA_QDATA
  profile PF_SDACORE
  account unlock  

grant RL_SDACORE to SDA                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        