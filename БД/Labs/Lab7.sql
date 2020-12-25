--task1
select name, description from v$bgprocess where paddr != hextoraw('00') order by name;

--task2
select * from v$process;

select s.username, s.program, s.server, s.osuser, s.process, p.spid, p.program, s.sid, s.serial# from v$session s join v$process p 
  on p.addr=s.paddr where s.username is not null;

--task3
show parameter db_writer_processes;

--task4-5
select * from v$session;

--task6
select * from v$services;

--task7
show parameter DISPATCHER;
alter system set max_dispatchers=10;

--task8

--task9
select username, server from v$session;

--task10
--ORACLE_HOME\NETWORK\ADMIN\listener.ora

--task11
--lsnrctl status, start, stop

--task12                                                                                                                                                                                              