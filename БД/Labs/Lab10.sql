--task1
begin
  null;
end;

--task2
begin
  dbms_output.put_line('Hello, world');
end;

--task3
declare
  x number(3) := 3;
  y number(3) := 0;
  z number (10,2);
begin
  z:=x/y;
  exception when others
     then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
end;

--task4
declare
  x number(3) := 3;
  y number(3) := 0;
  z number (10,2);
begin
  dbms_output.put_line('x = '||x||', y = '||y);
  begin
   z:=x/y;
   exception when others
      then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
  end;
end;

--task5
--alter system set plsql_warnings = 'ENABLE:INFORMATIONAL';
show parameter plsql_warnings;
select name, value from v$parameter where name = 'plsql_warnings';

--task6
select keyword from v$reserved_words
    where length = 1 and keyword != 'A';

--task7
select keyword from v$reserved_words
    where length > 1 and keyword!='A' order by keyword;
    
--task8
select name,value from v$parameter
    where name like 'plsql%';
    
--task9-17
declare
  c1 number(3) := 25;
  c2 number(3) := 10;
  sum number(10);
  div number(10,2);
  fix number(10,2) := 3.12;
  okr number(4, -1) := 32.12345;
  en number(32, 10)    := 12345E-10;
  bf binary_float := 123456789.12345678911;
  bd binary_double := 123456789.12345678911;
  bl boolean := true;
begin
  sum := c1 + c2;
  div := mod(c1,c2);
  dbms_output.put_line('c1 = '||c1);
  dbms_output.put_line('c2 = '||c2);
  dbms_output.put_line('c1%c2 = '||div);
  dbms_output.put_line('fix = '||fix);
  dbms_output.put_line('okr = '||okr);
  dbms_output.put_line('en = '||en);
  dbms_output.put_line('bf = '||bf);
  dbms_output.put_line('bd = '||bd);
  if bl then dbms_output.put_line('bl = true'); end if;
end;

--task18
declare
  numb constant number(5) := 5;
  vc constant varchar(25) := 'Hello world';
  c constant char(7) := 'Julia';  
begin
  dbms_output.put_line('vc = '||vc);
  dbms_output.put_line('numb = '||numb);
  dbms_output.put_line('c = '||c);
  begin
    numb:=10;
    exception when others
      then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
  end;
end;

--task19-20
declare
  subj subject.subject%type;
  pulp pulpit.pulpit%type;
  fac faculty%rowtype;
begin
  select subject into subj from subject where subject = 'MATH';
  select pulpit into pulp from pulpit where pulpit = 'ISiT';
  select * into fac from faculty where faculty = 'FIT';
  dbms_output.put_line(subj);
  dbms_output.put_line(pulp);
  dbms_output.put_line(rtrim(fac.faculty)||': '||fac.faculty_name);
  exception when others
     then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
end;

--task21-22
declare
  x number(10) := 17;
begin
  if x < 8
    then dbms_output.put_line('x < 8');
  elsif x > 8
     then dbms_output.put_line('x > 8');
  else 
    dbms_output.put_line('x = 8');
  end if;
end;

--task23
declare
  x number(10) := 17;
begin
  case
    when x < 8 then dbms_output.put_line('x < 8');
    when x > 8 then dbms_output.put_line('x > 8');
    else dbms_output.put_line('x = 8');
  end case;
end;

--task24
declare
  x number(10) := 0;
begin
  loop
    x := x + 1;
    dbms_output.put_line('loop = '||x);
  exit when x >= 5;
  end loop;
end;

--task25
declare
  x number(10) := 0;
begin
  while (x < 5)
  loop
    x := x + 1;
    dbms_output.put_line('while = '||x);
  end loop;
end;

--task26
begin
  for k in 1..5
  loop
    dbms_output.put_line('for = '||k);
  end loop;
end;

commit;


---------------
declare
  x number(10) := 100;
begin
  while (x >= 0)
  loop
    x := x - 10;
     dbms_output.put_line(x);
  end loop;
end;