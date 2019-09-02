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
and d.start_date <= current_date and d.end_date >= current_date

