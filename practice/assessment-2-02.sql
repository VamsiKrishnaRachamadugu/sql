select Student_name,
City_name,
class
from
(select 
Student_name,
City_name,
class,
row_number() over (partition by Studen_Id order by b.start_date) as rn
from
student  a
inner join
student_details b
on a.Student_Detail_Id=b.Student_Detail_Id 
inner join 
city c
on b.City_id=c.City_id
inner join 
class d
on b.Class_id=d.Class_id ) tmp
where rn=1





