use dummy;
drop table employee;
show tables;
desc employee;
create table employee(EMP_ID integer,EMP_NAME varchar(20),DESC_ID	integer,PLACE_ID integer,PROJ_ID integer);
create table Designation(DESC_ID integer,DESC_NAME varchar(20),ROLE_TYP varchar(20));
create table Place(PLACE_ID	integer,PLACE_DESC	varchar(20),PLACE_TYP varchar(20));
create table Project(PROJ_ID integer,PROJ_NAME varchar(20));

insert into employee values(1,'Vijaykumar',10,1,3);
insert into employee values(2,'Raja',20,3,4);
insert into employee values(3,'Abhisheksingh',10,4,5);
insert into employee values(4,'Santosh',30,2,1);
insert into employee values(5,'Kribakaran',20,3,2);
insert into employee values(6,'Divya',40,5,3);
insert into employee values(7,'Suganya',10,3,4);
insert into employee values(8,'Shalini',20,2,2);
insert into employee values(9,'Avantika',30,1,5);
insert into employee values(10,'Ajay',50,6,8);
insert into employee values(11,'Tamilselvan',60,7,6);
insert into employee values(12,'Vinodha',70,6,7);
insert into employee values(13,'Karthick',60,5,2);
insert into employee values(14,'Sanjay',70,6,5);
insert into employee values(15,'Meera',60,8,7);

insert into designation values(10,'ASE','DEVELOPER');
insert into designation values(20,'SE','DEVELOPER');
insert into designation values(30,'SSE','DEVELOPER');
insert into designation values(40,'TL','LEAD');
insert into designation values(50,'AM','LEAD');
insert into designation values(100,'SM','MANAGER');

insert into place values(1,'Chennai','Offshore');
insert into place values(2,'Bangalore','Offshore');
insert into place values(3,'Hyderabad','Offshore');
insert into place values(4,'Mexico','Offshore');
insert into place values(5,'Newyork','Onshore');
insert into place values(10,'Canada','Onshore');

insert into project values(1,'Cigna');
insert into project values(2,'ASG');
insert into project values(3,'Pepsi');
insert into project values(4,'Microsoft');
insert into project values(5,'Amazon');
insert into project values(10,'Flipkart');

-- "Fetch EMP_ID,EMP_NAME,DESC_NAME,PLACE_DESC,PROJ_NAME

-- List all the employees from the employee table 
-- EMP_ID
-- EMP_NAME 
-- DESC_NAME ---> If Designation Name is not available then show 'Unknown Designation', If Designation Name  is available but if Role Type is Lead then Show 'TEAM_LEAD'  otherwise populate with out any conversion
-- PLACE_DESC -- >If  Place Description is not avaible then show 'Others' , If  Place Description is available but if Place Type is newyork  then show 'USA'
-- PROJ_NAME --> Designation is not avaible in Department table then show 'Unknown Project'"								
SELECT e.EMP_ID,e.EMP_NAME,CASE WHEN d.DESC_NAME is null
								then 'Unknown Designation' 
                                else d.DESC_NAME  end as DESC_NAME ,
                                CASE WHEN p.PLACE_DESC is null
								then 'Others' 
                                else p.PLACE_DESC   end as PLACE_DESC ,
                                CASE WHEN pr.PROJ_NAME is null
								then 'Unknown Projec' 
                                else pr.PROJ_NAME   end as PROJ_NAME from Employee as e left  join Designation as d 
on e.DESC_ID=d.DESC_ID left join Place as p on e.PLACE_ID=p.PLACE_ID  left join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID;
 
 SELECT e.EMP_ID,e.EMP_NAME,coalesce(d.DESC_NAME, 'Unknown Designation') as DESC_NAME,
                                coalesce( p.PLACE_DESC , 'Others' )  as PLACE_DESC ,
                                coalesce( pr.PROJ_NAME ,'Unknown Projec' ) as PROJ_NAME from Employee as e left  join Designation as d 
on e.DESC_ID=d.DESC_ID left join Place as p on e.PLACE_ID=p.PLACE_ID  left join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID;
 
 -- "Fetch EMP_ID,EMP_NAME,PROJECT_ROLE

-- List all the employees from the employee table 
-- EMP_ID
-- EMP_NAME 
-- PROJECT_ROLE ---> If he is a 'DEVELOPER' and working in 'OFFSHORE' then show he is a 'TEAMMEMBER' , If he is a 'DEVELOPER' and working in 
-- 'NEARSHORE' then show he is a 'TEAMLEAD', If he is a 'DEVELOPER' and working in 'ONSHORE'
--  then show he is a 'BA',If he is a 'LEAD' and working in 'ONSHORE' then show he is a 'SCRUMMASTER', 
-- IF he has Some Designation or Working in some place then Show as 'CONTRACTER' Else Show ""SHADOW'


SELECT e.EMP_ID,e.EMP_NAME,CASE WHEN d.ROLE_TYP = 'DEVELOPER' and p.PLACE_TYP ='OFFSHORE'
								then 'TEAMMEMBER'
							 WHEN d.ROLE_TYP = 'DEVELOPER' and p.PLACE_TYP ='NEARSHORE'
								then 'TEAMLEAD'
                             WHEN d.ROLE_TYP = 'DEVELOPER' and p.PLACE_TYP ='ONSHORE'
								then 'BA'
							 WHEN d.ROLE_TYP = 'LEAD' and p.PLACE_TYP ='ONSHORE'
								then 'SCRUMMASTER'
							 WHEN d.ROLE_TYP is  null and p.PLACE_TYP is not null
								then 'CONTRACTER' else 'SHADOW' end as 'PROJECT_ROLE'  from Employee as e left  join Designation as d 
on e.DESC_ID=d.DESC_ID left join Place as p on e.PLACE_ID=p.PLACE_ID  left join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID;
 
-- "Fetch DESC_NAME,PLACE_DESC,PROJ_NAME
-- List how mony employess are working as a DEVELOPER in respective PLACE and PROJECT. Also SHOW rest of count as OTHERS in all the fields and "

select 
CASE WHEN d.ROLE_TYP='DEVELOPER' THEN D.ROLE_TYP ELSE 'OTHERS' END AS DERV_ROLE_TYP,
CASE WHEN d.ROLE_TYP ='DEVELOPER'  THEN p.PLACE_DESC ELSE 'OTHERS' END AS DERV_PLACE_DESC ,
CASE WHEN d.ROLE_TYP='DEVELOPER' THEN pr.PROJ_NAME ELSE 'OTHERS'  END AS DERV_PROJ_DESC,
count(e.emp_id) from Employee as e 
left  join Designation as d 
on e.DESC_ID=d.DESC_ID
left  join Place as p
on e.PLACE_ID=p.PLACE_ID  
left  join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID 
 group by DERV_ROLE_TYP,DERV_PLACE_DESC,DERV_PROJ_DESC ;

-- select d.desc_name,p.PLACE_DESC,pr.PROJ_NAME,e.emp_name,d.ROLE_TYP from Employee as e 
-- left  join Designation as d 
-- on e.DESC_ID=d.DESC_ID  and ROLE_TYP='DEVELOPER' 
-- left  join Place as p
-- on e.PLACE_ID=p.PLACE_ID  
-- left  join Project as pr  on 
--  e.PROJ_ID=pr.PROJ_ID 
--  group by d.ROLE_TYP,p.PLACE_DESC,pr.PROJ_NAME ;            
--             

 
--  "Fetch EMPLOYEE_NAME,DESC_NAME,PLACE_DESC,PROJ_NAME

-- Fetch all the Employee name, Designation , Place and project from respective tables 
-- if there is any null in respective fields then show it as OTHERS in those null Fields:"
SELECT CASE WHEN e.EMP_NAME is null
								then 'Others' 
                                else e.EMP_NAME  end as EMP_NAME,
                                CASE WHEN d.DESC_NAME is null
								then 'Unknown Designation' 
                                else d.DESC_NAME  end as DESC_NAME ,
                                CASE WHEN p.PLACE_DESC is null
								then 'Others' 
                                else p.PLACE_DESC   end as PLACE_DESC ,
                                CASE WHEN pr.PROJ_NAME is null
								then 'Unknown Projec' 
                                else pr.PROJ_NAME   end as PROJ_NAME from Employee as e left  join Designation as d 
on e.DESC_ID=d.DESC_ID left join Place as p on e.PLACE_ID=p.PLACE_ID  left join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID;

create table Customer (Customer_id	integer,Cust_Name varchar(20),City varchar(20),Priority_num integer,Salesman_id	integer,Purchased_Amount integer);
create table Salesman(Salesman_Id integer,Salesman_Name varchar(20),City varchar(20),Sales_Manager_id integer,Monthly_Target integer);
select * from customer ;
delete from customer where Customer_id =10;
insert into Customer values(10,'James','Chennai',1,1,10000);
insert into Customer values(20,'Ricky','Chennai',1,3,8000);
insert into Customer values(30,'Ramu','Bangalore',1,2,8000);
insert into Customer values(40,'Jyothi','Hyderabad',2,3,9000);
insert into Customer values(50,'Amaran','Chennai',1,4,3000);
insert into Customer values(60,'Akilan','Hyderabad',2,3,6000);
insert into Customer values(70,'Arun','Chennai',2,5,5000);
insert into Customer values(80,'Dinesh','Mumbai',2,4,6000);

truncate table Salesman;
insert into Salesman values(1,'John','Chennai',2,10000);
insert into Salesman values(2,'Abraham','Bangalore',4,21000);
insert into Salesman values(3,'Raju','Hyderabad',4,21000);
insert into Salesman values(4,'Srinath','Mumbai',5,9000);
insert into Salesman values(5,'Vijay','Chennai',6,4000);
insert into Salesman values(6,'Balaji','Hyderabad',6,15000);

-- Fetch Salesman_Name, Cust_Name, Customer_city,Salesman_City
-- Show only the customer and salesman whole belong to the different City 
select s.Salesman_Name, c.Cust_Name, c.city as Customer_city,s.city as Salesman_City
 from  Customer as c   inner join Salesman as s on c.Salesman_id=s.Salesman_id
where  c.city!=s.City;

select s.Salesman_Name, c.Cust_Name, c.city as Customer_city,s.city as Salesman_City
 from  Customer as c   inner join Salesman as s on c.Salesman_id=s.Salesman_id
where  c.city<>s.City;
-- Fetch Salesman_Name, City, Monthly_target, Amount_purchase_by_Customer 
-- Show only the Sales Man who achieved the monthly Target
--  Sum of Amount_purchase_by_Customer -- Amount purchased by corresponding customer
select  s.Salesman_Name,s.City,s.Monthly_Target,sum(Purchased_Amount) as Amount_purchase_by_Customer
from  Customer as c   inner join Salesman as s on c.Salesman_id=s.Salesman_id
group by s.Salesman_Name,s.City,s.Monthly_Target having Amount_purchase_by_Customer>=s.Monthly_Target;

-- Fetch Cust_Name, City,Priority_num,Purchased_amount
-- Show only the customer information who is top two  purchased more in their respective priority
-- Sum of Amount_purchase_by_Customer -- Amount purchased by corresponding customer
select Cust_Name, City,Priority_num,Purchased_amount from(
 select Cust_Name, City,Priority_num,Purchased_amount,row_number() over (partition by Priority_num order by Purchased_amount desc) as rn_amount from customer) as a
 where rn_amount<=3;
 

 
--  Fetch Salesman_Name, City, Amount_purchase_by_Customer 
-- Show only the Sales Man who  Amount_purchase_by_Customer is less than the avg monthly target of all sales person
--  Sum of Amount_purchase_by_Customer -- Amount purchased by corresponding customer
 select  s.Salesman_Name,s.City,s.Monthly_Target,case when c.Purchased_Amount is null then 0
													  else sum(c.Purchased_Amount) end as Amount_purchase_by_Customer
from  Customer as c   right join Salesman as s on c.Salesman_id=s.Salesman_id 
group by s.Salesman_Name,s.City,s.Monthly_Target having Amount_purchase_by_Customer<(select avg(s.Monthly_Target) as avg_monthly_target from Salesman as s );


--  select s.Salesman_Name,s1.Salesman_Name as Sales_Manager_Name ,s1.Monthly_target,sum(c.Purchased_Amount)  as Amount_purchase_by_Customer
--  from Salesman as s inner join Salesman as s1 on s.Sales_Manager_id=s1.Salesman_id inner join Customer as c on 
--  c.Salesman_id=s.Salesman_id 
-- group by s.Salesman_id having s1.Monthly_target<Amount_purchase_by_Customer;//
-- Fetch  Sales_Manager_Name, Salesman_Name,Manager Monthly_target,  Amount_purchase_by_Customer 
--  Show only the Sales Man who's manager is achieved the monthly Target based on his reportees purchase detail
--  Sum of Amount_purchase_by_Customer -- Amount purchased by customer which is sold by it reportees
select emp_salesman_name,mgr_salesman_name,mgr_Monthly_Target,emp_Amount_purchase_by_Customer
from
(select distinct
mgr.salesman_id as mgr_salesman_id,
mgr.salesman_name as mgr_salesman_name,
emp.salesman_name as emp_salesman_name,
mgr.Monthly_Target as mgr_Monthly_Target,
sum(c.Purchased_Amount) over (partition by mgr.salesman_id) as mgr_Amount_purchase_by_Customer ,
sum(c.Purchased_Amount) over (partition by emp.salesman_id) as emp_Amount_purchase_by_Customer 
from
salesman emp
inner join 
Salesman mgr
on emp.Sales_Manager_id = mgr.salesman_id 
inner join 
customer c
on c.salesman_id=emp.salesman_id  ) tmp
where mgr_Monthly_Target <= mgr_Amount_purchase_by_Customer;

create table Student(Studen_Id	integer,Student_name	varchar(20),Student_Detail_id integer);
create table Student_details(Student_Detail_Id integer,City_id integer,	Class_id integer,Start_date date,End_date date);
-- insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(1,1,2,'1/4/2018','03-31-2019');
-- Date_Format(`Req_Date`,'%d/%m/%Y')
truncate table Student_details;
insert into Student values(1,'Ajay',1);
insert into Student values(2,'Ramesh',2);
insert into Student values(3,'Shriram',3);
insert into Student values(4,'Gopi',4);
insert into Student values(5,'Kalai',5);
insert into Student values(6,'Vinoth',6);
select * from Student_details;
select * from City;
select * from Class;
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(1,1,2,STR_TO_DATE('01/04/2018', '%d/%m/%Y'),STR_TO_DATE('03-31-2019', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(1,1,3,STR_TO_DATE('01/04/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(2,2,1,STR_TO_DATE('01/04/2018', '%d/%m/%Y'),STR_TO_DATE('03-31-2019', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(2,3,2,STR_TO_DATE('01/04/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(3,2,1,STR_TO_DATE('01/04/2017', '%d/%m/%Y'),STR_TO_DATE('03-31-2018', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(3,3,2,STR_TO_DATE('01/04/2018', '%d/%m/%Y'),STR_TO_DATE('03-31-2019', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(3,1,3,STR_TO_DATE('01/04/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(4,2,1,STR_TO_DATE('01/04/2018', '%d/%m/%Y'),STR_TO_DATE('03-31-2019', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(4,3,2,STR_TO_DATE('01/04/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(5,1,2,STR_TO_DATE('01/04/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));
insert into Student_details(Student_Detail_Id,City_id,Class_id,Start_date,End_date) values(6,2,3,STR_TO_DATE('01/04/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));

create table City(City_Id integer,city_name varchar(20));
insert into city values(1,'Chennai');
insert into city values(2,'Bangalore');
insert into city values(3,'Mumbai');

create table Class(Class_Id	integer,Class varchar(20),Classroom_num integer,Start_date date,End_date date);
insert into Class values(1,'10th',256,STR_TO_DATE('1/4/2017', '%d/%m/%Y'),STR_TO_DATE('10-31-2018', '%m-%d-%Y'));
insert into Class values(1,'10th',257,STR_TO_DATE('1/11/2018', '%d/%m/%Y'),STR_TO_DATE('09-30-2019', '%m-%d-%Y'));
insert into Class values(1,'10th',258,STR_TO_DATE('1/10/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));
insert into Class values(2,'11th',301,STR_TO_DATE('1/4/2017', '%d/%m/%Y'),STR_TO_DATE('03-31-2018', '%m-%d-%Y'));
insert into Class values(2,'11th',310,STR_TO_DATE('1/4/2018', '%d/%m/%Y'),STR_TO_DATE('10-31-2019', '%m-%d-%Y'));
insert into Class values(2,'11th',320,STR_TO_DATE('1/11/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));
insert into Class values(3,'12th',356,STR_TO_DATE('1/4/2017', '%d/%m/%Y'),STR_TO_DATE('10-31-2018', '%m-%d-%Y'));
insert into Class values(3,'12th',360,STR_TO_DATE('1/11/2018', '%d/%m/%Y'),STR_TO_DATE('09-30-2019', '%m-%d-%Y'));
insert into Class values(3,'12th',371,STR_TO_DATE('1/10/2019', '%d/%m/%Y'),STR_TO_DATE('12-31-9999', '%m-%d-%Y'));

-- Fetch All Student_name,City_name,Class_Name
-- Show only the initial information of all the student in respective Field
select Student_name,city_name,Class from(
select s.Student_name,c.city_name,cl.Class,row_number() over (partition by s.Student_name order by sd.Start_date) as rn_student_date from Student as s 
inner join Student_details as sd on
s.Student_Detail_id=sd.Student_Detail_id inner join City as c on sd.City_Id=c.City_Id
inner join Class as cl on sd.Class_Id=cl.Class_Id)as a where rn_student_date=1;


-- Fetch All Student_name,City_name,Class_Name,Classroom_num
-- Show only the information of all the student where he stands as of today'S date
select Student_name,City_name,class,Classroom_num from student  a inner join
student_details b
on a.Student_Detail_Id=b.Student_Detail_Id 
and b.start_date <= current_date and b.end_date >= current_date
inner join  city c on b.City_id=c.City_id
inner join class d on b.Class_id=d.Class_id 
and d.start_date <= current_date and d.end_date >= current_date;



-- Fetch All Student_name,City_name
-- Show only the information of all the student who studied in Chennai or Classroom Number (301,310,320)
select distinct s.Student_name from Student as s 
inner join Student_details as sd on
s.Student_Detail_id=sd.Student_Detail_id inner join City as c on sd.City_Id=c.City_Id
inner join Class as cl on sd.Class_Id=cl.Class_Id where c.city_name='Chennai' or cl.Classroom_num in(301,310,320);

select substr(Student_name,instr(Student_name,'a',2)) from Student;


select 
CASE WHEN d.ROLE_TYP='DEVELOPER' THEN D.ROLE_TYP ELSE 'OTHERS' END AS DERV_ROLE_TYP,
CASE WHEN d.ROLE_TYP ='DEVELOPER'  THEN p.PLACE_DESC ELSE 'OTHERS' END AS DERV_PLACE_DESC ,
CASE WHEN d.ROLE_TYP='DEVELOPER' THEN pr.PROJ_NAME ELSE 'OTHERS'  END AS DERV_PROJ_DESC,
count(e.emp_id) from Employee as e 
left  join Designation as d 
on e.DESC_ID=d.DESC_ID and d.ROLE_TYP='DEVELOPER'
left  join Place as p
on e.PLACE_ID=p.PLACE_ID  
left  join Project as pr  on 
 e.PROJ_ID=pr.PROJ_ID 
 group by DERV_ROLE_TYP,DERV_PLACE_DESC,DERV_PROJ_DESC ;

 
 
 select  
COALESCE(E.EMP_NAME,'OTHERS') AS DERV_EMP_NAME,
COALESCE(D.DESC_NAME,'OTHERS') AS DERV_DESC_NAME,
COALESCE(p.PLACE_DESC,'OTHERS') AS DERV_PLACE_DESC ,
COALESCE(pr.PROJ_NAME,'OTHERS')  AS DERV_PROJ_DESC
from Employee as e 
full outer join Designation d on e.DESC_ID=d.DESC_ID
full outer join Place p on e.PLACE_ID=p.PLACE_ID  
full outer join Project pr on e.PROJ_ID=pr.PROJ_ID


INSTR -- Postiion

SUBSTR -- strin

Abhisheksingh

13 

11

Select instr(emp_name,'s',2)
13

12
10

substr(emp_name,instr(emp_name,'s',2),length(emp_name)-1)

substr(field_name, start length,end length) -String

instr(field_name, charater set, postion) postion number


LIKe

LIKE (START%

START
@

LIKE all ('%A%','%b%','%b%')

LIKE any ('%A%','%R%','%U%')

SUBSTR(EMP_NAME,3,


select EMP_NAME from employee where EMP_NAME like all ('%A%','%A%')

select 







select 
a.Salesman_Name,
a.City,a.Monthly_Target,
sum(b.Purchased_Amount) as Amount_purchase_by_Customer 
from
Salesman a
left join
Customer b
on a.Salesman_id=b.Salesman_id
group by a.Salesman_Name,
a.City,a.Monthly_Target
having a.Monthly_Target <= Amount_purchase_by_Customer 




select 
(select 
a.Salesman_Name,
a.City,
avg(a.Monthly_Target) over (partition by 1) as avg_monthly_target,
sum(b.Purchased_Amount) as Amount_purchase_by_Customer 
from
Salesman a
left join
Customer b
on a.Salesman_id=b.Salesman_id
group by a.Salesman_Name,
a.City,a.Monthly_Target
having Amount_purchase_by_Customer >= avg_monthly_target



having a.Monthly_Target <= Amount_purchase_by_Customer 


select mgr_dtl.mgr_salesman_name,mgr_dtl.emp_salesman_name,
mgr_dtl.mgr_Monthly_Target,c.Amount_purchase_by_Customer
from
(select 
mgr.salesman_id as mgr_salesman_id,
mgr.salesman_name as mgr_salesman_name,
emp.salesman_name as emp_salesman_name,
mgr.Monthly_Target as mgr_Monthly_Target
from
salesman emp
inner join 
Salesman mgr
on emp.Sales_Manager_id = mgr.salesman_id   ) mgr_dtl 


left join 



(select 
mgr.salesman_id as mgr_salesman_id,
sum(c.Purchased_Amount) as Amount_purchase_by_Customer 
from
salesman emp
inner join 
Salesman mgr
on emp.Sales_Manager_id = mgr.salesman_id
inner join customer c
on
c.salesman_id=emp.salesman_id 
group by mgr.salesman_id) c 
on mgr_dtl.mgr_salesman_id=c.mgr_salesman_id
where mgr_dtl.mgr_Monthly_Target <= Amount_purchase_by_Customer 









group by mgr_dtl.mgr_salesman_name,mgr_dtl.emp_salesman_name,mgr_dtl.mgr_Monthly_Target

select mgr_dtl.mgr_salesman_name,mgr_dtl.emp_salesman_name,
mgr_dtl.mgr_Monthly_Target,c.Amount_purchase_by_Customer
from
(

select distinct
mgr.salesman_id as mgr_salesman_id,
mgr.salesman_name as mgr_salesman_name,
emp.salesman_name as emp_salesman_name,
mgr.Monthly_Target as mgr_Monthly_Target,
sum(c.Purchased_Amount) over (partition by mgr.salesman_id) as mgr_Amount_purchase_by_Customer ,
sum(c.Purchased_Amount) over (partition by emp.salesman_id) as emp_Amount_purchase_by_Customer 
from
salesman emp
inner join 
Salesman mgr
on emp.Sales_Manager_id = mgr.salesman_id 
inner join 
customer c
on c.salesman_id=emp.salesman_id 










 
