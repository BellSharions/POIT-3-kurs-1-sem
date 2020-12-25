--task1
select tablespace_name, contents from DBA_TABLESPACES;

--task2
drop tablespace SDA_QDATA;
create tablespace SDA_QDATA
  datafile 'C:\DataBaseLabs\SDA_QDATA1.dbf'
  size 10m
  offline;
  
alter tablespace SDA_QDATA online;

alter user SDA quota 2m on SDA_QDATA;

create table SDA_T1
(
  id number(15) primary key,
  name varchar(10)
) tablespace SDA_QDATA;

insert into SDA_T1 values(1, 'a');
insert into SDA_T1 values(2, 'b');
insert into SDA_T1 values(3, 'c');

--task3
select segment_name, segment_type from DBA_SEGMENTS where tablespace_name='SDA_QDATA';

select * from user_segments;



--task4
drop table SDA_T1;

select segment_name, segment_type from DBA_SEGMENTS where tablespace_name='SDA_QDATA';

select * from user_recyclebin;

--task5
flashback table SDA_T1 to before drop;

--task6
begin
  for k in 4..10004
  loop
    insert into SDA_T1 values(k, 'tables');
  end loop;
end;
commit;

--task7
select extent_id, blocks, bytes from DBA_EXTENTS where segment_name='SDA_T1';
select extent_id, blocks, bytes from DBA_EXTENTS;

--task8
drop tablespace SDA_QDATA including contents and datafiles;
commit;

--task9
select group#, sequence#, bytes, members, status, first_change# from v$log;

--task10
select * from v$logfile;

--task11
alter system switch logfile;

select group#, sequence#, bytes, members, status, first_change# from v$log;

--time: 8:59:05

--task12
alter database add logfile group 4 'C:\app\Dmitry\oradata\orcl\REDO04.LOG'
  size 50m blocksize 512;

alter database add logfile member 'C:\app\Dmitry\oradata\orcl\REDO041.LOG' to group 4;
alter database add logfile member 'C:\app\Dmitry\oradata\orcl\REDO042.LOG' to group 4;

alter system switch logfile;
select group#, sequence#, bytes, members, status, first_change# from v$log;
select * from v$logfile;

--task13
alter database drop logfile member 'C:\app\Dmitry\oradata\orcl\REDO041.LOG';
alter database drop logfile member 'C:\app\Dmitry\oradata\orcl\REDO042.LOG';

alter database drop logfile group 4;

--task14
select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;
select * from v$log;

--task15

--task16
--sql plus:
--connect /as sysdba;
--shutdown immediate;
--startup mount;
--alter database archivelog;
--alter database open;

select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;
select * from v$log;

--task17
alter system set LOG_ARCHIVE_DEST_1 = 'LOCATION=C:\app\Dmitry\oradata\orcl\archive';

alter system switch logfile;
select * from v$archived_log;

--task18
--sql plus:
--connect /as sysdba;
--shutdown immediate;
--startup mount;
--alter database noarchivelog;
--alter database open;

select name, log_mode from v$database;
select instance_name, archiver, active_state from v$instance;
select * from v$log;

--task19
select name from v$controlfile;

--task20
show parameter control;


--task21
alter database backup controlfile to trace as 'C:\DataBaseLabs\controlFile.txt';
show parameter spfile;
select * from v$parameter;

--task22
create pfile = 'SDA_PFILE.ORA' from spfile;
--C:\app\Dmitry\product\12.1.0\dbhome_3\database\SDA_PFILE.ORA  n   

--task23 
--password C:\app\Dmitry\product\12.1.0\dbhome_3\database\PWDorcl.ora
select * from V$pwfile_users;


--C:\app\Dmitry\product\12.1.0\dbhome_3\srvm\admin parameter

--task24
select * from v$diag_info;

--task25
--C:\app\Dmitry\diag\rdbms\orcl\orcl\alert\log.xml