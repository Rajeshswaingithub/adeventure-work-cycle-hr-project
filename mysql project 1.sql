use project;
create table dept (
deptno int primary key,
dname varchar(50) not null,
loc varchar (50) not null
);
desc dept;
select * from dept;
insert into dept values(10,"operations","boston"),
(20,"research","dellas"),
(30,"sales","chicago"),
(40,"accounting","new york");
select * from dept;

create table employee(
empno int primary key,
ename varchar (50) not null,
job varchar(50) default("clerk"),
mgr int ,
hiredate date not null,
sal decimal(10,2) check(sal>0),
comm decimal(10,2),
deptno int ,
foreign key (deptno) references dept(deptno)
);
desc employee;
select * from employee;
insert into employee (empno,ename,job,mgr,hiredate,sal,deptno)values(7369,"smith","clerk",7902,'1890-12-17',800.00,20);
insert into employee (empno,ename,job,mgr,hiredate,sal,comm,deptno)values(7499,"allen","salesman",7698,'1981-02-20',1600.00,300.00,30);
insert into employee (empno,ename,job,mgr,hiredate,sal,comm,deptno)values(7521,"ward","salesman",7698,'1981-02-22',1250.00,500.00,30);
insert into employee (empno,ename,job,mgr,hiredate,sal,deptno)values(7566,"jones","manager",7839,'1981-04-02',2975.00,20);
insert into employee (empno,ename,job,mgr,hiredate,sal,comm,deptno)values(7654,"martin","salesman",7698,'1981-09-28',1250.00,1400.00,30);
insert into employee (empno,ename,job,mgr,hiredate,sal,deptno)values(7698,"blake","manager",7839,'1981-05-01',2850.00,30);
insert into employee (empno,ename,job,mgr,hiredate,sal,deptno)values(7782,"clark","manager",7839,'1981-06-09',2450.00,10),
(7788,"scott","analyst",7566,'1987-04-19',3000.00,20);
insert into employee (empno,ename,job,hiredate,sal,deptno)values(7839,"king","president",'1981-11-17',5000.00,10);
insert into employee (empno,ename,job,mgr,hiredate,sal,comm,deptno)values(7844,"turner","salesman",7689,'1987-09-08',1500.00,0.00,30);
insert into employee (empno,ename,job,mgr,hiredate,sal,deptno)values(7876,"adams","clerk",7788,'1987-05-23',1100.00,20),
(7900,"james","clerk",7698,'1981-12-03',950.00,30),
(7902,"ford","analyst",7566,'1981-12-03',3000.00,20),
(7934,"miller","clerk",7782,'1982-01-23',1300.00,10);

--------------------------------------------
select ename,sal from employee
where sal>1000;
------------------------------------------

select * from employee 
where hiredate<'1981-09-30';

----------------------------------------
select ename from employee
where ename like '_i%';
-------------------------------------------------
select ename,sal,
sal/100*40 as allowances,
sal/100*10 as pf,
sal+sal/100*40-sal/100*10 as netsalary
from employee;
--------------------------------------------------
select ename,job from employee
where mgr is null ;
------------------------------------------------------
select empno, ename ,sal from employee order by sal;
-------------------------------------------------------
select count(job) from employee;
--------------------------------------------------------
select sum(sal) from employee 
group by "salesman";
-----------------------------------------------------
select e.job, d.dname,avg(sal)
from employee e join dept d 
on e.deptno = d.deptno
group by e.job ,d.dname;
-----------------------------------------------------------
select e.ename,e.sal,d.dname from employee e join dept d
on e.deptno=d.deptno;
-----------------------------------------------------
create table jobs_grade(
grade varchar(1),
lowest_sal int,
highest_sal int
);
select * from jobs_grade;
insert into jobs_grade values("a",0,999),
("b",1000,1999),
("c",2000,2999),
("d",3000,3999),
("e",4000,5000);
select * from jobs_grade;
------------------------------------------------------
select e.ename,e.sal,j.grade from 
employee e  join jobs_grade j 
on e.sal between j.lowest_sal and j.highest_sal;
--------------------------------------------------------
select e.ename,m.mgr 
from employee e
join employee m
on e.empno =m.mgr;
----------------------------------------------------------
select ename,sal+comm as total_sal from employee;

----------------------------------------------------
select ename,sal from employee
where mod(empno,2) =1;
-------------------------------------------
select ename,dense_rank sal from employees;


----------------------------------------------------
select ename,sal from employee
order by sal desc limit 3;
-------------------------------------------------------
select e.ename ,d.dname from employee e join dept d
on e.deptno=d.deptno 
where  e.sal in (select max(sal) from employee group by deptno);