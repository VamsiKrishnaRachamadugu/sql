drop database garden_db;
create database garden_db;
use garden_db;
Create table Location (locationid integer primary key, name varchar(30), sunlight double, water double); 
Create table Gardener (gardenerid integer primary key, name varchar(30), age integer); 
Create table Plant (plantid integer primary key, name varchar(30), sunlight double, water double, weight double); 
Create table planted (plantid integer, gardenerid integer, locationid integer, date1 date, seeds integer, foreign key(plantid) references plant(plantid), foreign key(gardenerid) references gardener(gardenerid), foreign key(locationid) references location(locationid)); 
Create table picked (plantid integer, gardenerid integer, locationid integer, date1 date, amount integer, weight double, foreign key(plantid) references plant(plantid), foreign key(gardenerid) references gardener(gardenerid), foreign key(locationid) references location(locationid)); 

/* Set-up for location Table */
Insert into location values(0, 'East', .28, .80); 
Insert into location values(1, 'North', .17, .84); 
Insert into location values(2, 'West', .38, .48); 
Insert into location values(3, 'South', .45, .66); 

/* Set-up for gardener Table */
Insert into gardener values(0, 'Mother', 36); 
Insert into gardener values(1, 'Father', 38); 
Insert into gardener values(2, 'Tim', 15); 
Insert into gardener values(3, 'Erin', 12); 

/* Set-up for plant Table */
Insert into plant values(0, 'Carrot', .26, .82, .08); 
Insert into plant values(1, 'Beet', .44, .80, .04); 
Insert into plant values(2, 'Corn', .44, .76, .26); 
Insert into plant values(3, 'Tomato', .42, .80, .16); 
Insert into plant values(4, 'Radish', .28, .84, .02); 
Insert into plant values(5, 'Lettuce', .29, .85, .03); 

/* Set-up for planted Table */
Insert into planted values(0, 0, 0 , '2012-04-18', 28); 
Insert into planted values(0, 1, 1 , '2012-04-14', 14); 
Insert into planted values(1, 0, 2 , '2012-04-18', 36); 
Insert into planted values(2, 1, 3 , '2012-04-14', 20); 
Insert into planted values(2, 2, 2 , '2012-04-19', 12); 
Insert into planted values(3, 3, 3 , '2012-04-25', 38); 
Insert into planted values(4, 2, 0 , '2012-04-30', 30); 
Insert into planted values(5, 2, 0 , '2012-04-15', 30); 
#Insert into planted values(0, 0, 0 , cast('18-APR-2012' as date.format: "dd-mon-yyyy"), 28); 

/* Set-up for picked Table */
Insert into picked values(0, 2, 0 , '2012-08-18', 28, 2.32); 
Insert into picked values(0, 3, 1 , '2012-08-16', 12, 1.02); 
Insert into picked values(2, 1, 3 , '2012-08-22', 52, 12.96); 
Insert into picked values(2, 2, 2 , '2012-08-28', 18, 4.58); 
Insert into picked values(3, 3, 3 , '2012-08-22', 15, 3.84); 
Insert into picked values(4, 2, 0 , '2012-08-16', 23, 0.52); 