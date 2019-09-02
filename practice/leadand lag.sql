create database dummy;
use dummy;
drop table employee;
create table employee(id integer,amount integer);
insert into employee values(1,300);
insert into employee values(1,-200);
insert into employee values(2,400);
insert into employee values(2,500);
insert into employee values(3,350);
insert into employee values(4,500);
insert into employee values(null,500);

create table emp(id integer,salary integer);
insert into emp values(null,500);

select * from emp;
select * from employee;


select id,amount,lead(amount) over (partition by id order by amount),
lag(amount) over (partition by id order by amount) from employee;

select * from emp as e  join employee  as e1 on e.id=e1.id;

select * from emp 
union
select amount from employee order by amount  limit 1; 
select amount from employee order by amount desc limit 1;

create table ord(pid integer,o_status varchar(20),oid integer); 
insert into ord values(100,'completed',1);
insert into ord values(200,'pending',2);
insert into ord values(300,'rejected',3);
insert into ord values(400,'completed',1);
insert into ord values(500,'pending',1);
insert into ord values(600,'rejected',2);
insert into ord values(700,'pending',2);
insert into ord values(800,'completed',3);

select oid,total_count  from(
select pid,o_status,oid,case when o_status in('pending','rejected') 
							then o_status
                            else null end as flag ,count(oid) over(partition by oid)as total_count from ord ) as a
group by oid having total_count=count(flag);

select oid from ord group by oid having count(oid)>=2;

select min(pid) from ord where o_status='completed' group by oid;

select oid,count(flag),total_cnt from(
select pid,o_status,oid,(case when o_status ='completed'
							then o_status
                            else null end) as flag ,count(oid) over(partition by oid)as total_cnt from ord ) as a
group by oid having total_cnt=count(flag);

select pid, o_status, oid, lag_id from(
select pid,o_status,oid,lag(o_status) over (partition by oid) as lag_id from ord ) a
where  lag_id ='completed';

select oid,r_status,count(oid) as o_count from(
select oid,(case when o_status='completed'
				then null
                else 'rejected'
               end ) as r_status
               ,(case when o_status in( 'pending','rejected')
				then 1
                else null
               end ) as count from ord ) as a where count is not null group by oid ;

create table Employee  (Emp_id integer,Emp_Name varchar(20),Emp_Sal integer,Dept_id integer);
create table Department(Dept_id	integer,Dept_Name varchar(20)); 
insert into employee values(10,'Vivek',	2000,1);
insert into employee values(20,'Raj',3000,1);
insert into employee values(30,'Vinoth',4000,1);
insert into employee values(40,'Abhishek',5000,2);
insert into employee values(50,'Divya',	6000,2);
insert into employee values(60,'Chitra',7000,3);
 insert into department values(1,'IT');
 insert into department values(2,'Admin');
 insert into department values(4,'Others');
 select * from employee;
 select * from department;
 select d.Dept_id,d.Dept_Name,sum(case when e.Emp_Sal is null
									then 0
                                    
                                    else e.Emp_Sal
                                    
                                    end )as Sum_Emp_SAL from department as d left join employee as e 
on d.Dept_id=e.Dept_id group by e.Dept_id;
 
  select e.Dept_id,case when d.Dept_Name is null
						then 'Others'
                        else d.Dept_Name
                        end, sum(e.Emp_Sal) as Sum_Emp_SAL from employee as e   left join department as d
 on e.Dept_id=d.Dept_id group by e.Dept_id;
 
 select * from employee1 where salary >=2700 and salary <=10000;
 
 create table employee1 (Emp_id integer,Emp_Name varchar(20),Manager_ID integer,salary integer);
 insert into employee1 values(1,'Vivek',8,11000);
insert into employee1 values(2,'Raj',1,2000);
insert into employee1 values(3,'Vinoth',1,3000);
insert into employee1 values(4,'Abhishek',2,5000);
insert into employee1 values(5,'Divya',3,6000);
insert into employee1 values(6,'Chitra',3,2350);
 insert into employee1 values(7,'Devi',3,2500);
 insert into employee1 values(8,'Aarthi',4,2700);
 
select e2.Emp_id  as Manager_ID,e2.Emp_Name as Managaer_Name,sum(e1.salary) as Sum_Emp_Salary 
from employee1 as e1 join employee1 as e2
on e1.Manager_ID=e2.Emp_id group by e2.Emp_id,e2.Emp_Name;
 
--  select Manager_ID,emp_name,sum(salary) over(partition by Manager_ID) as sum from employee1 
--  group by Manager_ID;

select substring(Emp_Name,instr(Emp_Name,'[a-z]')) from employee1;
 
 select * from employee;
select Emp_id,substring(Emp_Name,4) as Emp_Name from employee1;

select Emp_id,substring(Emp_Name,position('h' in Emp_Name)+1) as Emp_Name from employee1;

select Emp_id,Emp_Name,Salary from(
select Emp_id,Emp_Name,Salary,dense_rank() over (order by salary desc) as salary_rank from Employee1 ) as a
where salary_rank=2;

select Emp_id,Emp_Name,Manager_ID,Salary from(
select *,dense_rank() over (order by salary desc) as salary_rank from Employee1 ) as a
where salary_rank<=3;
select * from employee1;


select Emp_Name,salary from employee1 as e1 where 1-1=(select count(distinct e2s.salary )from employee1 as e2 
where e1.salary>e2.salary );

 create table employee2 (Emp_id integer,Emp_Name varchar(20),Dept_name varchar(20),salary integer);
 drop table employee2;
insert into employee2 values(1,'Vivek','IT',2000);
insert into employee2 values(2,'Raj','Admin',3500);
insert into employee2 values(3,'Vinoth','HR',4800);
insert into employee2 values(4,'Abhishek','IT',5700);
insert into employee2 values(5,'Divya','ITES',3000);
insert into employee2 values(6,'Chitra','HR',5800);
 insert into employee2 values(7,'Devi','Admin',3200);
 
select * from Employee2 where Dept_name='IT' and salary>3400 or Dept_name='Admin' and salary>3400 ;

SELECT * from employee where Emp_Name like '%j%';
SELECT * from employee where Emp_Name like '%j%' or Emp_Name like '%n%' or Emp_Name like '%m%';
SELECT * from employee where Emp_Name REGEXP '[jnm]';
SELECT * from employee where Emp_Name REGEXP 'j|n|m';
SELECT * from employee where Emp_Name REGEXP 'bhe';

SELECT * from employee where Emp_Name like '%b%h%e%';

 create table e1 (joining date,salary integer);
 insert into e1 values('2019-01-31',2000);
  insert into e1 values('2019-05-29',2000);
   insert into e1 values('2019-03-31',2000);
    insert into e1 values('2019-04-30',2000);
    insert into e1 values('2018-04-30',2000);
        insert into e1 values('2017-04-30',2000);
        
select  yearly,case when  lag_s is  null
					 then null
                     else ((salary_total-lag_s)/lag_s)*100 
                     end as hike from(
select year(joining) as yearly,salary_total,lag(salary_total) over (order by year(joining)) as lag_s from(
select joining,sum(salary) as salary_total from e1 group by year(joining))
as a) as b; 