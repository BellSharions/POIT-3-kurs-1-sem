ALTER SESSION SET nls_date_format='dd-mm-yyyy hh24:mi:ss';
grant select on dba_jobs_running to SDA;

ALTER SYSTEM SET JOB_QUEUE_PROCESSES = 9;
select * from v$parameter where name like 'job%';
select * from dba_jobs_running;
select * from v$lock where SID = 27;

create table teacher_for_job
(
  teacher varchar(20),
  teacher_name varchar(20),
  pulpit varchar(10),
  birthday date,
  salary number(10)
);

create table job_status (
  status   nvarchar2(50),
  datetime date default sysdate
);

declare
  cursor tcursor is select * from teacher_for_job;
  teach teacher_for_job%rowtype;
  begin
    for n in tcursor
    loop
      insert into teacher (teacher, teacher_name, pulpit, birthday, salary) values (n.teacher, n.teacher_name, n.pulpit, n.birthday, n.salary); 
    end loop;
    delete from teacher_for_job;
    commit;
end;

create or replace procedure teacherpdocedure is
  begin
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then insert into job_status (status) values ('FAIL');
end teacherpdocedure;

select * from teacher_for_job; 
select * from teacher;
select * from job_status;

delete from job_status;

begin
  teacherpdocedure();
end;

--------------JOB------------------
declare job_number user_jobs.job%type;
begin
  dbms_job.submit(job_number, 
  'declare
    a number(3):= 0;
  BEGIN
  while (a < 30)
  loop
    dbms_lock.sleep(10);
    a := a + 1;
  end loop;
  teacherpdocedure(); 
  END;', sysdate, 'sysdate + 30/86400');
  commit;
  dbms_output.put_line(job_number);
end;

select * from user_jobs;

begin
  dbms_job.run(103);
end;

begin
  dbms_job.broken(103, false, null);
end;


begin
  dbms_job.remove(161);
end;

begin
  dbms_job.isubmit(1, 'BEGIN teacherpdocedure(); END;', sysdate, 'sysdate + 60/86400');
end;

-------------SHELDURE------------------
begin
dbms_scheduler.create_schedule(
  schedule_name => 'Sch_1',
  start_date => sysdate,
  repeat_interval => 'FREQ=MINUTELY',
  comments => 'Sch_1 MINUTELY start now'
);
end;

select * from user_scheduler_schedules;

begin
dbms_scheduler.create_program(
  program_name => 'Pr_1',
  program_type => 'STORED_PROCEDURE',
  program_action => 'teacherpdocedure',
  number_of_arguments => 0,
  enabled => true,
  comments => 'teacherpdocedure'
);
end;

select * from  user_scheduler_programs;

begin
dbms_scheduler.create_job(
  job_name => 'J_1',
  program_name => 'Pr_1',
  schedule_name => 'Sch_1',
  enabled => true
);
end;

select * from user_scheduler_jobs;

select * from teacher_for_job; 
select * from teacher;
select * from job_status;

delete from job_status;

begin
  DBMS_SCHEDULER.ENABLE('J_1');
end;

begin
  DBMS_SCHEDULER.RUN_JOB('J_1');
end;

begin
  DBMS_SCHEDULER.STOP_JOB('J_1');
end;

begin
  DBMS_SCHEDULER.DROP_JOB( JOB_NAME => 'J_1');
end;