--task1
declare
  procedure GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE)
  is
    cursor teach is select * from teacher where pulpit = PCODE;
    t teacher%rowtype;
  begin
    open teach;
      fetch teach into t;
      while teach%found
      loop
        dbms_output.put_line(t.teacher_name);
        fetch teach into t;
      end loop;
    close teach;
  end GET_TEACHERS;
begin
  GET_TEACHERS('ISiT');
end;

--task2-3
declare
  function GET_NUM_TEACHERS (PCODE TEACHER.PULPIT%TYPE) RETURN NUMBER
  is
    tcount number(3);
  begin
    select count(*) into tcount from teacher where pulpit = PCODE;
    return tcount;
  end GET_NUM_TEACHERS;
begin
  dbms_output.put_line(GET_NUM_TEACHERS('NEWPULP'));
end;

--task4
begin
  GET_TEACHERS('FIT');
end;

begin
  GET_SUBJECTS('ISiT');
end;

--task5
begin
  dbms_output.put_line(GET_NUM_TEACHERS('XTiT'));
end;

begin
  dbms_output.put_line(GET_NUM_SUBJECTS('NEWPULPIT'));
end;

--task6
create or replace package TEACHERS as
  procedure GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE);
  procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE);
  function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER;
  function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER;
end TEACHERS;

create or replace package body TEACHERS
is
  ----PROCEDURES----
  procedure GET_TEACHERS (FCODE FACULTY.FACULTY%TYPE)
  is
    cursor teach is select t.teacher_name from teacher t inner join pulpit p
          on t.pulpit = p.pulpit inner join faculty f on p.faculty = f.faculty where f.faculty = FCODE;
    t teacher.teacher_name%type;
  begin
    open teach;
      fetch teach into t;
      while teach%found
      loop
        dbms_output.put_line(t);
        fetch teach into t;
      end loop;
    close teach;
  end GET_TEACHERS;
  
  procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE)
  is
    cursor subj is select subject from subject where pulpit = PCODE;
    s subject.subject%type;
  begin
    open subj;
      fetch subj into s;
      while subj%found
      loop
        dbms_output.put_line(s);
        fetch subj into s;
      end loop;
    close subj;
  end GET_SUBJECTS;
  
  ----FUNCTIONS--
  function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY%TYPE) RETURN NUMBER
  is
    tcount number(3);
  begin
    select count(*) into tcount from teacher t inner join pulpit p
          on t.pulpit = p.pulpit inner join faculty f on p.faculty = f.faculty where f.faculty = FCODE;
    return tcount;
  end GET_NUM_TEACHERS;
  
  function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT%TYPE) RETURN NUMBER
  is
    scount number(3);
  begin
    select count(*) into scount from subject where pulpit = PCODE;
    return scount;
  end GET_NUM_SUBJECTS;
  --------------------------
begin
  null;
end TEACHERS;

begin
  TEACHERS.GET_TEACHERS('FIT');
  TEACHERS.GET_SUBJECTS('ISiT');
  dbms_output.put_line(TEACHERS.GET_NUM_TEACHERS('FIT'));
  dbms_output.put_line(TEACHERS.GET_NUM_SUBJECTS('ISiT'));
end;