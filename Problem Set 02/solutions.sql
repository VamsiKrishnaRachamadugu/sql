select * from gardener;
select * from picked;
select * from plant;
select * from location;
select * from planted ;

#1.Write a valid SQL statement that calculates the total weight of all corn cobs that were picked from the garden:
select sum(p.weight) from picked p inner join plant p1 on p.plantid=p1.plantid where p1.name='Corn';

#2.For some reason Erin has change his location for picking the tomato to North. Write the corresponding query.
 update picked as p inner join gardener as g on p.gardenerid=g.gardenerid inner join plant p1 on p1.plantid=p.plantid 
 set locationid =(select locationid from location where name='North') ;

#3. Insert a new column 'Exper' of type Number (30) to the 'gardener' table which stores Experience of the of person. 
#How will you modify this to varchar2(30).
alter table gardener add column exper integer(30);
alter table gardener modify exper varchar(30);

#4.Write a query to find the plant name which required seeds less than 20 which plant on 14-APR
select p1.name from plant as p1 inner join planted p2 on p1.plantid=p2.plantid where p2.seeds<20 and month(date1)='04' and day(date1)='14';

#5.List the amount of sunlight and water to all plants with names that start with letter 'c' or letter 'r'.
select name,sunlight,water from plant where name like 'c%' or 'r%';

#6.Write a valid SQL statement that displays the plant name and the total amount of seed required for each plant that were plant in the 
#garden. The output should be in descending order of plant name.
select p.name,p1.seeds from plant as p inner join planted p1 on p.plantid=p1.plantid order by p1.seeds desc;

#7.Write a valid SQL statement that calculates the average number of items produced per seed planted for 
#each plant type:( (Average Number of Items = Total Amount Picked / Total Seeds Planted.)
select a.plantid,avg(a.tot_amt /a.total_seeds) from(
select p1.plantid,sum(p1.seeds) as total_seeds ,sum(p2.amount) as tot_amt from planted p1 
left join picked p2 on p1.plantid=p2.plantid group by plantid)as a group by a.plantid ;

#8.Write a valid SQL statement that would produce a result set like the following:
select g.name ,p.name ,p1.date1,p2.amount from gardener as g 
inner join plant as  p
inner join planted as p1 on g.gardenerid=p1.gardenerid and p.plantid=p1.plantid
inner join picked as p2 on g.gardenerid=p2.gardenerid and p1.plantid=p2.plantid
where g.name='Tim';

#9.Find out persons who picked from the same location as he/she planted.
select  distinct g.name  from gardener as g inner join planted as p1 on g.gardenerid=p1.gardenerid
inner join picked as p2 on g.gardenerid=p2.gardenerid and p1.locationid=p2.locationid and p1.plantid=p2.plantid;

#10.Create a view that lists all the plant names picked from all locations except ’West’ in the month of August.
create view plant_name_view as
select distinct p.name from plant as p join  picked as pi on p.plantid=pi.plantid 
inner join location l on pi.locationid=l.locationid where l.name!='West'
and month(pi.date1)=8;
select * from plant_name_view ;