alter pluggable database SDA_PDB open;
--task1
select name, open_mode from v$pdbs;

--task2
select * from v$instance;

--task3
select * from product_component_version;

--task4
--create new PDB

--task5
select name, open_mode from v$pdbs;

--task6
create tablespace SDA_PDB_TS
datafile 'C:\DataBaseLabs\SDA_PDB_TS1.dbf'
size 7m
autoextend on next 5m
maxsize 20m
logging
online;
commit;

select TABLESPACE_NAME, BLOCK_SIZE, MAX_SIZE from sys.dba_tablespaces order by tablespace_name;

create temporary tablespace SDA_PDB_TEMP_TS
tempfile 'C:\DataBaseLabs\SDA_PDB_TEMP_TS1.dbf'
size 7m
autoextend on next 3m
maxsize 30m
extent management local;
commit;

alter session set "_ORACLE_SCRIPT"=true;
create role SDA_RL_PDB;

grant create session,
      create table,
      create view,
      create procedure,
      drop any table,
      drop any view, 
      create tablespace,
      drop any procedure to SDA_RL_PDB;
      
alter session set container = cdb$root;
create profile SDA_PDB_PF limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30
  
  create user U1_SDA_PDB identified by 12345
  default tablespace SDA_PDB_TS quota unlimited on SDA_PDB_TS
  temporary tablespace  SDA_PDB_TEMP_TS
  profile SDA_PDB_PF
  account unlock;
  
  grant SDA_RL_PDB to U1_SDA_PDB;
  commit;
  
--task7
create table Person
(
    name char(30),
    age number(3)
    
);
insert into Person values('Dmitry', 19);
insert into Person values('Artem', 20);
commit;
select * from Person;

  
--task8
select * from ALL_USERS;
select * from DBA_TABLESPACES;
select * from DBA_DATA_FILES;
select * from DBA_TEMP_FILES;
select * from DBA_ROLES;
select GRANTEE, PRIVILIGE from DVA_SYS_PRIVS;
select * from DBA_PROFILES;

--task9

