select * from location;
select * from gardener;
select * from plant;
select * from planted;
select * from picked;

#1.Write a valid SQL statement that calculates the total weight of all corn cobs that were picked from the garden:
select sum(p.weight) from picked p inner join plant p1 on p.plantid=p1.plantid where p1.name='Corn';

#2.For some reason Erin has change his location for picking the tomato to North. Write the corresponding query.
 update picked as p inner join gardener as g on p.gardenerid=g.gardenerid inner join plant p1 on p1.plantid=p.plantid 
 set locationid =(select locationid from location where name='North') ;

#3. Insert a new column 'Exper' of type Number (30) to the 'gardener' table which stores Experience of the of person. 
#How will you modify this to varchar2(30).
alter table gardener add column exper integer(30);
alter table gardener modify exper varchar(30);
