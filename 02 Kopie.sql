set serveroutput on;
--1
create or replace function empcount(dp number) return number is 
    x number(10);
Begin
    select count(empno) into x from emp where deptno = dp;
    return x;
End;

Begin
    dbms_output.put_line(empcount(20));
End;

--2
create or replace procedure empname(no number, code number) is
    en varchar2(100);
    em number(20);
    emp_missing exception;
Begin
    
    select ename into en from emp where empno = no;
    
    if code = 1 then
        select nvl(comm, 0) + sal into em from emp where empno = no;
    else 
        if code = 2 then
            select sal into em from emp where empno = no;
        else
            raise emp_missing;
        end if;
    end if;
    
    exception
        when emp_missing or NO_DATA_FOUND then
            dbms_output.put_line('Unbekannt null');
End;

start
    empname(2,1);
end;

--3
create or replace function sal_comm(eno number) return varchar is
    txt varchar2(100) := 'AUTRCH';
    x number(10);
Begin
    select (sal/nvl(comm,0)) into x from emp where empno = eno;
    txt := 'Verhaeltnis: '||to_char(x);
    exception
        when ZERO_DIVIDE then
            txt := 'Keine Provision!';
    
    return txt;
End;

begin
    dbms_output.put_line(sal_comm(7369));
end;
    