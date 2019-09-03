select 
Student_name,
City_name,
class,
Classroom_num
from
student  a
inner join
student_details b
on a.Student_Detail_Id=b.Student_Detail_Id 
and b.start_date <= current_date and b.end_date >= current_date
inner join 
city c
on b.City_id=c.City_id
inner join 
class d
on b.Class_id=d.Class_id 
and d.start_date <= current_date and d.end_date >= current_date;


 select  s.Salesman_Name,s.City,s.Monthly_Target,case when c.Purchased_Amount is null then 0
													  else sum(c.Purchased_Amount) end as Amount_purchase_by_Customer
from  Customer as c   right join Salesman as s on c.Salesman_id=s.Salesman_id 
group by s.Salesman_Name,s.City,s.Monthly_Target having Amount_purchase_by_Customer<
(select avg(s.Monthly_Target) as avg_monthly_target from Salesman as s );


SELECT Salesman_Name, City,Monthly_Target,  Amount_purchase_by_Customer FROM(
select 
a.Salesman_Name,
a.City,a.Monthly_Target,
avg(a.Monthly_Target) over (partition by Salesman_Name='1') as avg_monthly_target,
coalesce(SUM(b.Purchased_Amount),0) as Amount_purchase_by_Customer 
from
Salesman a
left join
Customer b
on a.Salesman_id=b.Salesman_id
group by a.Salesman_Name,
a.City,a.Monthly_Target) AS A
WHERE Amount_purchase_by_Customer <= avg_monthly_target
