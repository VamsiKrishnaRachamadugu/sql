select * from employee;
select * from dept;

#1)Select the Employee with the top three salaries
select * from(
select e_id,name,salary,dense_rank() over(order by salary desc) as salary_rank from employee)as a where salary_rank<=3;

#2)Select the Employee with the least salary
select * from(
select e_id,name,salary,dense_rank() over(order by salary ) as salary_rank from employee)as a where salary_rank=1;

#3)Select the Employee who does not have a manager in the department table
select e1.e_id,e1.name,e1.dep_id,e2.name as m_name,d.depname from 
employee  e1 left join employee e2 on e1.managerid=e2.e_id left join dept d on e2.dep_id=d.dep_id where e2.name is null;

#4)Select the Employee who is also a Manager
select distinct e2.name from employee e1 inner join employee e2 on e1.managerid=e2.e_id;

#5)Select the Empolyee who is a Manager and has least salary
select * from(
select distinct e2.name,e2.salary,dense_rank() over (order by salary) as salary_rank from employee e1 inner join employee e2 on e1.managerid=e2.e_id) 
as t1 where salary_rank =1;

#6)Select the total number of Employees in Communications departments
select count(e.e_id) from employee as e inner join dept as d  on  e.dep_id=d.dep_id where d.depname='communications';

#7)Select the Employee in Finance Department who has the top salary
select * from (
select e.*,dense_rank() over (order by salary desc) as salary_rank  from employee as e inner join dept as d  on  e.dep_id=d.dep_id where d.depname='finance')
as e where salary_rank=1;

#8)Select the Employee in product depatment who has the least salary
select * from (
select e.*,dense_rank() over (order by salary ) as salary_rank  from employee as e inner join dept as d  on  e.dep_id=d.dep_id where d.depname='product')
as e where salary_rank=1;

#9)Select the count of Empolyees in Health with maximum salary
select count(*) from (
select e.e_id,salary,dense_rank() over (order by salary desc) as salary_rank  from employee as e inner join dept as d  on  e.dep_id=d.dep_id where d.depname='Health')
as e where salary_rank=1;

#10)Select the Employees who report to Natasha Stevens
select e1.e_id,e1.name,e2.name as m_name from employee as e1 inner join employee as e2 on e1.managerid=e2.e_id where e2.name='Natasha Stevens'  ;

#11)Display the Employee name,Employee count,Dep name,Dept manager in the Health department
select name,depname,depmanager from employee as e inner join dept as d on e.dep_id=d.dep_id where depname='Health';

#12)Display the Department id,Employee ids and Manager ids for the Communications department
select d.dep_id,e_id,managerid from employee e inner join dept d on e.dep_id=d.dep_id where d.depname='Communications';

#13)Select the Average Expenses for Each dept with Dept id and Dept name
select e.dep_id,d.depname,avg(salary) from employee e inner join dept d on e.dep_id=d.dep_id  group by e.dep_id;

#14)Select the total expense for the department finance
select sum(salary) as total_expense from employee e inner join dept d on e.dep_id=d.dep_id where d.depname='finance';

#15)Select the department which spends the least with Dept id and Dept manager name
select * from (
select e.dep_id,d.depname,sum(salary) as total_expense,dense_rank() over (order by sum(salary)) as salary_rank from employee e inner join dept d on e.dep_id=d.dep_id group by e.dep_id)
as a where salary_rank =1;

#16)Select the count of Employees in each department
select count(e.e_id)as total_employees,d.depname from employee as e inner join dept as d on e.dep_id=d.dep_id group by e.dep_id;

#17)Select the count of Employees in each department having salary <10000
select count(e.e_id),d.depname from employee as e inner join dept as d on e.dep_id=d.dep_id where salary<10000 group by e.dep_id  ;

#18)Select the total number of Employees in Dept id D04
select count(*)as total_employees from employee where dep_id='D04';

#19)Select all department details of the Department with Maximum Employees
select * from (
select count(e.e_id)as total_employees,d.depname,dense_rank() over (order by count(e.e_id) desc) as employee_rank from employee as e inner join dept as d on e.dep_id=d.dep_id group by e.dep_id)
as t1 where employee_rank=1;

#20)Select the Employees who has Tim Cook as their manager
select e1.e_id,e1.name,e2.name as m_name from employee as e1 inner join employee as e2 on e1.managerid=e2.e_id where e2.name='Tim Cook'  ;
