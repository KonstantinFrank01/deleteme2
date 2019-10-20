
-- 1
create or replace function EMPCOUNT (debtno_ in number) 
return number is
ecount number;
begin
    select count(empno) into ecount from emp where deptno = debtno_; 
    return ecount;
end;

select empcount(20) from dual;


-- 2
create or replace procedure empname (emp_no in number, code in number) as
    e_name emp.ename%TYPE;
    e_sal emp.sal%TYPE;
    e_comm emp.comm%TYPE;
begin
    
    select ename into e_name from emp where empno = emp_no;
    select sal into e_sal from emp where empno = emp_no;
    select comm into e_comm from emp where empno = emp_no;
    
    if code = 1 then
        dbms_output.put_line(e_name || ' Gealt: ' || to_char(e_sal + e_comm));
    elsif code = 2 then
        dbms_output.put_line(e_name || ' Gealt: ' || to_char(e_sal));
    end if;

    exception
        when NO_DATA_FOUND then
            dbms_output.put_line('UNBEKANNT Gealt: NULL');
end;    

BEGIN
    empname(99, 2);
END;



-- 3
create or replace procedure sql_comm (emp_no in emp.empno%TYPE) as
    e_sal emp.sal%TYPE;
    e_comm emp.comm%TYPE;
begin
    select sal into e_sal from emp where empno = emp_no;
    select nvl(comm, 0) into e_comm from emp where empno = emp_no;

    dbms_output.put_line('Verhältnis: ' || to_char(e_sal/ e_comm));
    
    exception
        when ZERO_DIVIDE then
            dbms_output.put_line('Keine Provision');
end;

BEGIN
    sql_comm(7369);
END;


-- 4

drop table paints;
create table paints(
    pt_id   number(5) constraint pt_pk primary key,
    pt_name varchar2(30),
    pt_stk_on_hand number(3)
);

insert into paints(pt_id, pt_name, pt_stk_on_hand) values(1, 'Paint 1', 10);
update paints set pt_stk_on_hand = 10 where pt_id = 1;

create or replace procedure sell (paint_id in paints.pt_id%TYPE, qty number) as
    stock paints.pt_stk_on_hand%TYPE;
begin
    select pt_stk_on_hand into stock from paints where pt_id = paint_id;
    
    if qty > stock then
        dbms_output.put_line('insufficient stock');
    else
        update paints set pt_stk_on_hand = stock - qty where pt_id = paint_id;
    end if;
end;

begin
    sell(1,6);
end;