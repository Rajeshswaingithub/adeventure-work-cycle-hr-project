create database project2;
use  project2;
create table salespeople(
snum int primary key,
sname varchar(50) not null,
city varchar(50) not null,
comm decimal(10,2)
);
select * from salespeople;
insert into salespeople values(1001,"peel","city",0.12),
(1002,"serres","san jose",0.13),
(1003,"axelorod","new york",0.10),
(1004,"motika","london",0.11),
(1007,"rafkin","barcelona",0.15);
select * from salespeople;

create  table cust (
cnum int primary key,
cnmae varchar(50) not null,
city varchar(50) not null,
rating int not null,
snum int not null,
foreign key(snum) references salespeople(snum)
);
alter table cust rename column cnmae  to cname;
select * from cust;

insert into cust values(2001,"hoffman","london",100,1001),
(2002,"giovanne","rome",200,1003),
(2003,"liu","san jode",300,1002),
(2004,"grass","berlin",100,1002),
(2006,"clemens","london",300,1007),
(2007,"pereira","rome",100,1004),
(2008,"james","london",200,1007);

select * from cust;

create table orders(
onum int primary key ,
amt decimal(10,2) not null,
odate date not null,
cnum int not null,
snum int not null,
constraint  foreign key (cnum) references project2.cust(cnum),
constraint  foreign key (snum) references project2.salespeople(snum));
desc orders;
select * from orders;

insert into orders values(3001,18.69,'1994-10-03',2008,1007),
(3002,1900.10,'1994-10-03',2007,1004),
(3003,767.19,'1994-10-03',2001,1001),
(3005,5160.45,'1994-10-03',2003,1002),
(3006,1098.16,'1994-10-04',2008,1007),
(3007,75.75,'1994-10-05',2004,1002),
(3008,4723.00,'1994-10-05',2006,1001),
(3009,1713.23,'1994-10-04',2002,1003),
(3010,1309.95,'1994-10-06',2004,1002),
(3011,9891.88,'1994-10-06',2006,1001);
select * from orders;
---------------------
select salespeople.sname ,cust.cname,cust.city
from salespeople,cust
where salespeople.city = cust.city;
------------------------------
select cust.cname,salespeople.sname
from cust,salespeople
where cust.snum =salespeople.snum;
----------------------------------
select orders.onum,cust.cname from orders,cust,salespeople
where salespeople.city <> cust.city
and orders.cnum = cust.cnum
and orders.snum= salespeople.snum;
-----------------------------------------------------------------
select orders.onum,cust.cname from orders,cust 
where orders.cnum=cust.cnum;
----------------------------------
select  a.cname,b.cname,a.rating from cust a,cust b 
where a.rating= b.rating and a.cnum!=b.cnum;
--------------------------------------------
select cname from cust where snum in (select snum from cust group by snum having count(snum)>1);
-----------------------------------------------------
select a.sname,b.sname from salespeople a, salespeople b 
where a.city = b.city; 
--------------------------------------------------------------
select * from orders 
where snum =(select distinct snum from orders where cnum=2008);
---------------------------------------------------------------

select * from orders where amt >
(select avg(amt) from orders where odate = '1994-10-04');
------------------------------------------------------------------
select * from orders where snum in
(select snum from salespeople where city ="london");
---------------------------------------------------------------------
select cnum,cname from cust
 where cnum > (select snum+1000 from salespeople where sname ="serres");
 --------------------------------------------------------------------------
 select count(cname) from cust
 where rating > 
 (select avg(rating) from cust where city ="san jose");
 -------------------------------------------------------------------
 select * from salespeople 
 where snum in (select distinct snum from cust a where exists(
 select * from cust b where b.snum = a.snum and b.cname<>a.cname));
