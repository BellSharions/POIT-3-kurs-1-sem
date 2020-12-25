--alter session set nls_date_format = 'DD-MM-YYYY';

--task1
alter table teacher add BIRTHDAY date;
alter table teacher add SALARY number(38);
select * from teacher;

--task2
select teacher_name from TEACHER;
    select regexp_substr(teacher_name,'(\S+)',1, 1)||' '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 2),1, 1)||'. '||
      substr(regexp_substr(teacher_name,'(\S+)',1, 3),1, 1)||'. '
    from teacher;
    
--task3
select * from teacher where TO_CHAR((birthday), 'd') = 2;

--task4
create view birth as select * from teacher where TO_CHAR(sysdate,'mm')+1 = TO_CHAR(birthday, 'mm');
select * from birth;

--task5
create view nmonth as select to_char(birthday, 'Month') month, count(*) count
        from teacher group by to_char(birthday, 'Month');
select * from nmonth;

--task6
declare
  cursor birth is select * from teacher
        where MOD((TO_CHAR(sysdate,'yyyy') - TO_CHAR(birthday, 'yyyy')+1), 10)=0;
begin
  for res in birth
  loop
     dbms_output.put_line(res.teacher||res.teacher_name||' '||res.pulpit||' '||res.birthday||' '||res.salary);
  end loop;
end;



--task7
declare 
  cursor avgPulpit is select pulpit, floor(avg(salary)) from teacher group by pulpit;
  pulp teacher.pulpit%type;
  sal teacher.salary%type;
begin
  open avgPulpit;
  fetch avgPulpit into pulp, sal;
  while avgPulpit%found
  loop
    dbms_output.put_line(pulp||sal);
    fetch avgPulpit into pulp, sal;
  end loop;
 close avgPulpit;
end;

declare
  cursor avgFaculty is select f.faculty, floor(avg(salary)) from teacher t inner join pulpit p on t.pulpit = p.pulpit inner join faculty f on p.faculty = f.faculty group by f.faculty;
  fac teacher.pulpit%type;
  sal teacher.salary%type;
begin
  open avgFaculty;
  fetch avgFaculty into fac, sal;
  while avgFaculty%found
  loop
    dbms_output.put_line(fac||sal);
    fetch avgFaculty into fac, sal;
  end loop;
 close avgFaculty;
end;

declare
  cursor curs is select salary from teacher;
  numb number(10);
  sal teacher.salary%type;
  summ number(10) := 0;
begin
  execute immediate 'select count(*) from faculty' into numb;
  open curs;
    fetch curs into sal;
    while curs%found
    loop
      summ := summ + sal;
      fetch curs into sal;
    end loop;
  close curs;
  dbms_output.put_line(summ / numb);
end;

--task8
declare
  rec1 teacher%rowtype;
  type address is record
    (
      address1 varchar2(100),
      address2 varchar2(100),
      address3 varchar2(100)
    );
  type person is record
    (
      code teacher.teacher%type,
      name teacher.teacher_name%type,
      homeaddress address
    );
  rec2 person;
  rec3 person;
begin
  rec2.code := 'DMTR';
  rec2.name := 'Dmitry Suraho';
  rec2.homeaddress.address1 := 'Belarus';
  rec2.homeaddress.address2 := 'Borisov, Minsk region';
  rec2.homeaddress.address3 := 'b-r Grechko';
  rec3 := rec2;
  dbms_output.put_line(rec3.code);
  dbms_output.put_line(rec3.name);
  dbms_output.put_line(rec3.homeaddress.address1);
  dbms_output.put_line(rec3.homeaddress.address2);
  dbms_output.put_line(rec3.homeaddress.address3);
  exception
    when others then dbms_output.put_line('error = '||sqlerrm);
end;

select GET_NUM_TEACHERS(faculty), faculty from faculty order by faculty

----------------------------------

select teacher_name from teacher;
select teacher_name from teacher where regexp_like(teacher_name, '^[A-Z]+E{1,}[^W]');
select auditorium from auditorium;
select auditorium from auditorium where regexp_like(auditorium_name, '^[1-4][0-3][0-9]-[1-4]$'); -- dont work $
declare
  oldname varchar(20) := 'dikmmmmma';
  newname varchar(20);
  substr varchar(20);
  countin number(3);
begin
--  newname := regexp_replace(oldname, 'ikm*', 'orog');
--  substr := regexp_substr(oldname, 'm+');
--  countin := regexp_count(oldname, 'm+');
--  dbms_output.put_line(oldname||' => '||newname);
--  dbms_output.put_line(substr||' in '||oldname||', count: '||countin);
  
end;
declare
begin
 if(regexp_like('12345', '5$')) then dbms_output.put_line('true'); else dbms_output.put_line('false'); end if;
end;
