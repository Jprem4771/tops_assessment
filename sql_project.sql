CREATE DATABASE SQL_PROJECT;
use SQL_PROJECT;
create table DEPARTMENT (
    Dept_no int not null  primary key default 0,
    D_name varchar(14) default null,
    Loc varchar(13) default null
);
select * from DEPARTMENT;

create table  EMP (
    Emp_no int not null primary key default 0,
    E_name varchar(10) default null,
    Job varchar(9) default null,
    Mgr int default null,
    Hiredate date default null,
    Sal decimal(7,2) default null,
    Com decimal(7,2) default null,
    Dept_no int default null,
    foreign key(Dept_no) references DEPARTMENT(Dept_no)
);
select * from EMP;

INSERT INTO DEPARTMENT (Dept_no, d_name, loc) VALUES 
(1, 'ACCOUNTING', 'NEW YORK'),
(2, 'RESEARCH', 'LA'),
(3, 'SALES', 'CHICAGO'),
(4, 'OPERATIONS', 'BOSTON');

INSERT INTO EMP (Emp_no, E_name, Job, Mgr, Hiredate, Sal, com, Dept_no) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-11-27', 21800.0, NULL, 2),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 21600.0, 300.00, 3),
(7521, 'WARD', 'SALESMAN', 7698, '1981-12-22', 12250.0, 500.00, 3),
(7566, 'JONES', 'MANAGER', 7839, '1981-06-22', 29750.0, NULL, 2),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 12500.0, 1400.00, 3),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-08-21', 28500.0, NULL, 3),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 24500.0, NULL, 1),
(7788, 'SCOTT', 'ANALYST', 7566, '1988-09-01', 30100.0, NULL, 2),
(7839, 'KING', 'PRESIDENT', NULL, '1989-01-17', 50100.0, NULL, 1),
(7844, 'TURNER', 'SALESMAN', 7698, '1991-08-19', 11500.0, 0.00, 3),
(7876, 'ADAMS', 'CLERK', 7788, '1997-07-13', 21100.0, NULL, 2),
(7900, 'JAMES', 'CLERK', 7698, '1986-03-12', 11950.0, NULL, 3),
(7902, 'FORD', 'ANALYST', 7566, '1983-06-12', 30000.0, NULL, 2),
(7934, 'MILLER', 'CLERK', 7782, '1981-01-23', 13000.0, NULL, 1);

-- Q.1 Select unique job from EMP table.
select distinct job from EMP;


-- Q.2 List the details of the emps in asc order of the Dptnos and desc of Jobs? 
select * from EMP order by Dept_no asc, job desc  ;

-- Q.3 Display all the unique job groups in the descending order? 
select distinct job from EMP order by job desc;

-- Q.4 List the emps who joined before 1981. 
select * from EMP where hiredate<"1981-01-01";

-- Q.5 List the Empno, Ename, Sal, Daily sal of all emps in the asc order of Annsal. 
select Emp_no, E_name, sal,(sal/30) as Daily_sal, (sal*12) as Annual_sal from EMP order by Annual_sal asc;

-- Q.6 List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369. 
select Emp_no, E_name, sal, DATEDIFF(CURDATE(), hiredate)from EMP as EXP where mgr=7369;

-- Q.7 Display all the details of the emps who’s Comm Is more than their Sal?
select * from EMP where com > sal;

-- Q.8 List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order.
select * from EMP where job="CLERK" or job= "ANALYST" order by E_name;

-- Q.9 List the emps Who Annual sal ranging from 22000 and 45000.
select * from EMP where sal between 22000 and 45000; 

-- Q.10 List the Enames those are starting with ‘S’ and with five characters. 

select E_name from EMP where E_name like "S____";

-- Q.11 List the emps whose Empno not starting with digit78.
select * from EMP where Emp_no not like  "78%";

-- Q.12 List all the Clerks of Deptno 2. 
select * from EMP where job="Clerk" and Dept_no="2";

-- Q.13 List the Emps who are senior to their own MGRS.
select emp.Emp_no,emp.E_name,emp.Mgr,emp.Hiredate as HireDate_Emp,Manager.Mgr,Manager.E_name as manager_name,Manager.Hiredate as Hiredate_manager from emp
join emp as Manager 
on emp.Emp_no=Manager.Mgr
where emp.Hiredate < Manager.Hiredate;


-- Q.14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10.
select * from EMP where Dept_no=2 and job in(select distinct job from EMP where Dept_no=1);

-- Q.15 List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal.
select * from EMP where sal in (select sal from EMP where  E_name in ("SMITH","FORD")) order by sal desc;

-- Q.16 List the emps whose jobs same as SMITH or ALLEN.
select * from EMP where job in(select job from EMP where E_name in ("SMITH","ALLEN"));

-- Q.17 Any jobs of deptno 10 those that are not found in deptno 20. 
select distinct job from EMP where Dept_no =1 and job not in(select distinct job from EMP where Dept_no=20);

-- Q.18 Find the highest sal of EMP table. 
select max(sal) from EMP;

-- Q.19 Find details of highest paid employee.
select * from EMP where sal in(select max(sal) from EMP);

-- Q.20 Find the total sal given to the MGR.
select sum(sal) from EMP where job="MANAGER";

-- Q.21 List the emps whose names contains ‘A’. 
select * from EMP where E_name like "%A%";

-- Q.22 Find all the emps who earn the minimum Salary for each job wise in ascending order.
select Emp_no, E_name, job, dept_no, sal from EMP e1 where sal = (select min(sal) from  EMP e2 where e1.job = e2.job)order by job asc, sal asc;

-- Q.23 List the emps whose sal greater than Blake’s sal.
select * from EMP where sal>(select sal from EMP where E_name="Blake");

-- Q.24. Create view v1 to select ename, job, dname, loc whose deptno are same
create view v1 as
select e.E_name, e.job, d.D_name, d.loc from EMP e
join DEPARTMENT d on e.dept_no=d.dept_no;


-- Q.26 Add column Pin with bigint data type in table student
CREATE TABLE STUDENT (
    Rno INT NOT NULL PRIMARY KEY DEFAULT 0,
    Sname VARCHAR(14) DEFAULT NULL,
    City VARCHAR(20) DEFAULT NULL,
    State VARCHAR(20) DEFAULT NULL
);

alter table STUDENT add column Pin bigint;

-- Q.27.Modify the student table to change the sname length from 14 to 40. Create trigger to insert data in emp_log table whenever any update of sal in EMP table. You can set action as ‘New Salary’.

alter table STUDENT modify  Sname varchar(40);

CREATE TABLE EMP_LOG (
    Emp_id INT NOT NULL,
    Log_date DATE DEFAULT NULL,
    New_salary INT DEFAULT NULL,
    Action VARCHAR(20) DEFAULT NULL
);

delimiter //
create trigger New_salary 
after update on emp
for each row 
Begin
if old.Sal <> New.Sal then
insert into emp_log(Emp_id,Log_Date,New_salary,Action) values(old.Emp_no,Now(),new.Sal,'New_Salary');
End if ; 

End //
delimiter ;
