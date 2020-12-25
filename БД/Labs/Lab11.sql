--task1
declare
  fac faculty%rowtype;
begin
  select * into fac from faculty where faculty='FIT';
  dbms_output.put_line(fac.faculty||fac.faculty_name);
end;

--task2-4
declare
  fac faculty%rowtype;
begin
  --select * into fac from faculty;
  --select * into fac from faculty where faculty='sgsg';
  select * into fac from faculty where faculty='FIT';
  dbms_output.put_line('rowcount: '||sql%rowcount);
exception
  when no_data_found then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
  when too_many_rows then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
  when others then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
end;

--task5-10
--select * from auditorium;
--select * from auditorium_type;
begin
  --update auditorium set auditorium = '206-1' where auditorium = '200-1';
  --update auditorium_type set auditorium_type = 'NEW' where auditorium_type = 'LK';
  
  --insert into auditorium values ('64', '35', 90, 'LK');
  
  --delete from auditorium where auditorium = '444-9';
  --delete from auditorium_type where auditorium_type = 'LK';
  
  --rollback;
  if sql%found then dbms_output.put('found, '); end if;
  if sql%isopen then dbms_output.put('opened, '); end if;
  if sql%notfound then dbms_output.put('not found, '); end if;
  dbms_output.put_line('rowcount: '||sql%rowcount);
  commit;
  exception
    when others then dbms_output.put_line('error = '||sqlerrm);
end;

--task11
--select * from teacher;
declare
  cursor cursor_teacher is select teacher, teacher_name, pulpit from teacher;
  m_teacher       teacher.teacher%type;
  m_teacher_name  teacher.teacher_name%type;  
  m_pulpit        teacher.pulpit%type;
begin
  open cursor_teacher;
    dbms_output.put_line('rowcount = '||cursor_teacher%rowcount);
    loop
      fetch cursor_teacher into m_teacher, m_teacher_name, m_pulpit;
      exit when cursor_teacher%notfound;
      dbms_output.put_line(cursor_teacher%rowcount||' '||m_teacher||' '||m_teacher_name||' '||m_pulpit);
    end loop;
    dbms_output.put_line('rowcount = '||cursor_teacher%rowcount);
  close cursor_teacher;
  exception
    when others then dbms_output.put_line('error = '||sqlerrm);
end;

--task12
--select * from subject;
declare
  cursor cursor_subject is select * from subject;
  subj subject%rowtype;
begin
  open cursor_subject;
    dbms_output.put_line('rowcount = '||cursor_subject%rowcount);
    fetch cursor_subject into subj;
    while cursor_subject%found
    loop
      dbms_output.put_line(cursor_subject%rowcount||' '||subj.subject||' '||subj.subject_name||' '||subj.pulpit);
      fetch cursor_subject into subj;
    end loop;
    dbms_output.put_line('rowcount = '||cursor_subject%rowcount);
  close cursor_subject;
  exception
    when others then dbms_output.put_line('error = '||sqlerrm);
end;

--task13
declare
  cursor cur is select pulpit.pulpit, teacher.teacher_name
          from pulpit inner join teacher on pulpit.pulpit=teacher.pulpit;
  rec cur%rowtype;
begin
  for rec in cur
  loop
    dbms_output.put_line(cur%rowcount||' '||rec.teacher_name||' '||rec.pulpit);
  end loop;
  exception
    when others then dbms_output.put_line('error = '||sqlerrm);
end;

--task14
--select * from auditorium;
declare 
  cursor cur(cap1 auditorium.auditorium_capacity%type,cap2 auditorium.auditorium_capacity%type)
      is select auditorium, auditorium_capacity from auditorium
          where auditorium_capacity >=cap1 and auditorium_capacity <= cap2;
begin
  dbms_output.put_line('capacity < 20:');
  for aum in cur(0,20)
  loop dbms_output.put(aum.auditorium||' '); end loop;
  dbms_output.put_line(chr(10)||'capacity 20-30:');
  for aum in cur(21,30)
  loop dbms_output.put(aum.auditorium||' '); end loop;    
  dbms_output.put_line(chr(10)||'capacity 30-60:');
  for aum in cur(31,60)
  loop dbms_output.put(aum.auditorium||' '); end loop;   
  dbms_output.put_line(chr(10)||'capacity 60-80:');
  for aum in cur(61,80)
  loop dbms_output.put(aum.auditorium||' '); end loop;  
  dbms_output.put_line(chr(10)||'capacity > 80:');
  for aum in cur(81,10000)
  loop dbms_output.put(aum.auditorium||' '); end loop; 
  dbms_output.put_line(chr(10)||'end');
  exception
    when others then dbms_output.put_line('error = '||sqlerrm);
end;

select * from auditorium;
--task15
declare 
  type teacher_name is ref cursor return teacher%rowtype;
  xcurs teacher_name;
  t teacher%rowtype;
begin
  open xcurs for select * from teacher;
    fetch xcurs into t;
    while xcurs%found
    loop
      dbms_output.put_line(t.teacher||t.teacher_name||'   '||t.pulpit);
      fetch xcurs into t;
    end loop;
end;

--task16
declare 
  cursor curs_aut is select auditorium_type,
          cursor (select auditorium from auditorium aum
                  where aut.auditorium_type = aum.auditorium_type)
                from auditorium_type aut;
  curs_aum sys_refcursor;
  aut auditorium_type.auditorium_type%type;
  aum auditorium.auditorium%type;
  txt varchar2(1000);
begin
  open curs_aut;
    fetch curs_aut into aut, curs_aum;
    while(curs_aut%found)
      loop
        txt := rtrim(aut)||':';
        loop
          fetch curs_aum into aum;
          exit when curs_aum%notfound;
          txt := txt||rtrim(aum)||',';
        end loop;
        dbms_output.put_line(txt);
        fetch curs_aut into aut, curs_aum;
      end loop;
  close curs_aut;
end;

--task17
--select * from auditorium;
declare 
  cursor cur(cap1 auditorium.auditorium%type, cap2 auditorium.auditorium%type)
        is select auditorium, auditorium_capacity from auditorium
        where auditorium_capacity >= cap1 and auditorium_capacity <= cap2 for update;
begin
  for res in cur(40, 80)
  loop
    update auditorium set auditorium_capacity = res.auditorium_capacity / 1.1 where current of cur;
  end loop;
end;

--task18
--select * from auditorium;
declare 
  cursor cur(cap1 auditorium.auditorium%type,cap2 auditorium.auditorium%type)
        is select auditorium, auditorium_capacity from auditorium
        where auditorium_capacity >= cap1 and auditorium_capacity <= cap2 for update;
  aum auditorium.auditorium%type;
  cap auditorium.auditorium_capacity%type;
begin
  open cur(0,20);
    fetch cur into aum, cap;
    while(cur%found)
      loop
        delete auditorium where current of cur;
        fetch cur into aum, cap;
      end loop;
  close cur;
end;

--task19
--select * from auditorium;
declare
  cursor cur(capacity auditorium.auditorium%type)
        is select auditorium, auditorium_capacity, rowid
        from auditorium
        where auditorium_capacity >=capacity for update;
  aum auditorium.auditorium%type;
  cap auditorium.auditorium_capacity%type;
begin
  for xxx in cur(80)
  loop
    update auditorium set auditorium_capacity = auditorium_capacity + 1000 where rowid = xxx.rowid;
  end loop;
end;

--task20
declare 
  cursor curs_teacher is select teacher, teacher_name, pulpit from teacher;
  m_teacher teacher.teacher%type;
  m_teacher_name teacher.teacher_name%type;
  m_pulpit teacher.pulpit%type;
  k integer := 1;
begin
  open curs_teacher;
    loop
      fetch curs_teacher into m_teacher, m_teacher_name, m_pulpit;
      exit when curs_teacher%notfound;
      dbms_output.put_line(' '||curs_teacher%rowcount||' '
                          ||m_teacher||' '
                          ||m_teacher_name||' '
                          ||m_pulpit);
      if (k mod 3 = 0) then dbms_output.put_line('-------------------------------------------'); end if;
      k:=k+1;
    end loop;
  close curs_teacher;
  exception
    when others then dbms_output.put_line('error = '||sqlerrm);
end;

-----------------
