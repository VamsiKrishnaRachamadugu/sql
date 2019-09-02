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
where mgr_Monthly_Target <= mgr_Amount_purchase_by_Customer