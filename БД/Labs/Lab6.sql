--v$boofet_pool

--task1
select sum(value) from v$sga;

--task2
select component, current_size from v$sga_dynamic_components where current_size > 0;

--task3
select component, granule_size from v$sga_dynamic_components where current_size > 0;

--task4
select current_size from v$sga_dynamic_free_memory;

--task5
select component, current_size from v$sga_dynamic_components
  where component='KEEP buffer cache' or component='DEFAULT buffer cache' or component='RECYCLE buffer cache';

--task6
create table SDA_TABLE1(x int) storage(buffer_pool keep);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name='SDA_TABLE1';

--task7
create table SDA_TABLE2(y char(10)) storage(buffer_pool default);
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name='SDA_TABLE2';

--task8
show parameter log_buffer;

--task9
select * from (select pool, name, bytes from v$sgastat where pool='shared pool' order by bytes desc) where rownum <= 10;

--task10
select pool, name, bytes from v$sgastat where pool='large pool' and name='free memory';

--task11
select * from v$session;

--task12
select username, server from v$session;

--task13