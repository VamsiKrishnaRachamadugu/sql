insert into project values(1,'Neon Data & Analytics');
insert into project values(2,'ASG Data Warehousing');
insert into project values(3,'Pepsi Data Mart');
insert into project values(4,'Microsoft');
insert into project values(5,'Amazon Cloud Logistics');
insert into project values(10,'Flipkart');

-- 1.Fetch EMP_ID,EMP_NAME,DESC_NAME,PLACE_DESC,EMP_DESC_CNT,EMP_PLACE_CNT
-- EMP_DESC_CNT --- > No Of Employess Each Designation
-- EMP_PLACE_CNT ---> No Of Employess Each Place
-- List All the Employees in The employess
-- If there is null in Place or Designation show as 'OTHERS'
select e.EMP_ID,e.EMP_NAME,coalesce(d.DESC_NAME,'OTHERS')as DESC_NAME,coalesce(p.PLACE_DESC,'OTHERS') as PLACE_DESC,
count(*) over (partition by d.DESC_NAME) as EMP_DESC_CNT,
count(*) over (partition by p.PLACE_DESC) as EMP_PLACE_CNT 
from employee as e left join designation as d on e.DESC_ID=d.DESC_ID left join
place as p on e.place_id=p.PLACE_ID;


-- 2.Fetch EMP_ID,EMP_NAME,DESC_NAME,PLACE_DESC,PROJ_NAME
-- List All the Employees who is working in 'Data' or 'Cloud' project. 
-- Note: Find Respective  keyword in project name
select e.EMP_ID,e.EMP_NAME,coalesce(d.DESC_NAME,'OTHERS') as DESC_NAME,coalesce(p.PLACE_DESC,'OTHERS') as PLACE_DESC,pr.proj_name from 
employee as e left join designation as d on e.DESC_ID=d.DESC_ID 
left join place as p on e.place_id=p.PLACE_ID 
inner join project as pr on e.proj_id=pr.PROJ_ID
and (pr.PROJ_NAME like '%Data%' or pr.PROJ_NAME like '%Cloud%');

-- 3.Fetch EMP_NAME,PLACE_DESC
-- Show only employees working as higest grade in each place, If two employees in same grade use minimum Project_id to pick one, 
--  If two employees in same project use minimum Project_id to pick one,
-- Use DESC_ID, PLACE_ID & PROJECT_ID to define Grades 
select EMP_ID, EMP_NAME, DESC_NAME, PLACE_DESC, proj_name from(
select e.EMP_ID,e.EMP_NAME,d.DESC_NAME,p.PLACE_DESC,pr.proj_name,
row_number() over (partition by p.PLACE_ID order by d.DESC_ID desc,pr.PROJ_ID) as rn_grade from 
employee as e inner join designation as d on e.DESC_ID=d.DESC_ID inner join
place as p on e.place_id=p.PLACE_ID inner join project as pr on e.proj_id=pr.PROJ_ID) as a where rn_grade=1;

-- 4.Fetch Salesman manger Name  & Customer Name 
-- Show Only the Priority Customer based on the Purchased Amount 
select sales_manager_name, Cust_Name from(
select s1.Salesman_Name as sales_manager_name,c.Cust_Name,
row_number() over (partition by s1.Salesman_Name order by c.purchased_amount desc) as rn_amnt
 from Salesman as s inner join Salesman as s1 on s.Sales_Manager_id=s1.Salesman_Id 
inner join Customer as c on s.Salesman_Id=c.Salesman_Id) as a where rn_amnt =1 ;

-- 5.Update the Purchased Monthly target for each sales person based on the Purchase amount 
update Salesman as s
inner join (
select c.Salesman_Id,max(c.purchased_amount) as max 
from customer as c group by c.Salesman_Id)as a on
 s.Salesman_Id=a.Salesman_Id  set monthly_target=a.max ;