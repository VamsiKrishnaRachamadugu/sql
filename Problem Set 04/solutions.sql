select * from Highschooler;
select * from Friend;
select * from Likes;

select distinct id1  from likes;

-- 1.Find the names of all students who are friends with someone named Gabriel. (1 point possible)
select h.name from Highschooler as h join(
select f1.ID1 from Highschooler as h join Friend as f1 on h.ID=f1.ID2
and h.name='Gabriel' )as a on h.ID=a.ID1;

-- 2.For every student who likes someone 2 or more grades younger than themselves, 
-- return that student's name and grade, and the name and grade of the student they like. (1 point possible)

 select h1.name,h1.grade,h2.name,h2.grade from Highschooler h1  join likes l on h1.ID=l.ID1 
 inner join Highschooler h2 on h2.ID=l.ID2 where (h1.grade-h2.grade)>=2;
 
--  3.For every pair of students who both like each other, return the name and grade of both students. 
--  Include each pair only once, with the two names in alphabetical order. (1 point possible)
 select h1.name,h1.grade,h2.name,h2.grade from Highschooler h1  join likes l on h1.ID=l.ID1 
 inner join Highschooler h2 on h2.ID=l.ID2  order by h1.name,h2.name;

-- 4.Find all students who do not appear in the Likes table (as a student who likes or is liked) and 
-- return their names and grades. Sort by grade, then by name within each grade. (1 point possible)
select  h.name,h.grade from Highschooler h left join likes l 
on h.ID=l.ID1 or h.ID=l.ID2 where l.ID1 is null order by h.grade,h.name;

-- 5.For every situation where student A likes student B, but we have no information about whom B likes 
-- (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades. (1 point possible)
 select h1.name,h1.grade,h2.name,h2.grade from Highschooler h1  join likes l on h1.ID=l.ID1 
 inner join Highschooler h2 on h2.ID=l.ID2  ;
 
--  6.Find names and grades of students who only have friends in the same grade. 
--  Return the result sorted by grade, then by name within each grade. (1 point possible)
 select h1.name,h1.grade,h2.name,h2.grade from Highschooler as h1  join likes as l on h1.ID=l.ID1 
 inner join Highschooler as h2 on h2.ID=l.ID2 where h1.grade=h2.grade order by h1.grade,h1.name;

-- 7.For each student A who likes a student B where the two are not friends, find if they have a friend C in common 
-- (who can introduce them!). For all such trios, return the name and grade of A, B, and C. (1 point possible)


-- 8.Find the difference between the number of students in the school and the number of different first names. (1 point possible)
select count(name)-count(distinct name) as unique_name from  Highschooler;

-- 9.Find the name and grade of all students who are liked by more than one other student. (1 point possible)
select h.name,count(l.id2) as likes from Highschooler as h join  likes as l on h.ID=l.ID1 group by l.id2 having count(l.id2)>1;

-- 10.For every situation where student A likes student B, but student B likes a different student C, 
-- return the names and grades of A, B, and C. (1 point possible)
select l.ID1,h.name,l.ID2,h1.name,l1.ID2,h2.name from likes l left join likes l1 
on l.ID2=l1.ID1 left join Highschooler as h on  h.ID=l.ID1 left join  Highschooler as h1 on
  h1.ID=l.ID2 left join Highschooler as h2 on  h2.ID=l1.ID2;

-- 11.Find those students for whom all of their friends are in different grades from themselves. 
-- Return the students' names and grades.(1 point possible)
 select h1.name,h1.grade,h2.name,h2.grade from Highschooler h1  join likes l on h1.ID=l.ID1 
 inner join Highschooler h2 on h2.ID=l.ID2 where h1.grade!=h2.grade;
 
--  12.What is the average number of friends per student? (Your result should be just one number.) (1 point possible)
select floor(avg(c1)) as avg_friends from(select avg(count) as c1 from (
select ID2,count(ID2) as count from Friend group by ID1)as a1 group by ID2)  as a;

-- 13.Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. 
-- Do not count Cassandra, even though technically she is a friend of a friend.
select h.name from Highschooler as h join(select distinct b.id1 from(
select a.ID1,f1.ID1 as 'id2' from(
select f.ID1 from Highschooler h  join Friend as f on h.ID=f.ID2 where h.name='Cassandra') as a
join Highschooler h join Friend as f1 on a.ID1=f1.ID2 
where h.name='Cassandra') as b 
union 
select distinct id2 from(
select a.ID1,f1.ID1 as 'id2' from(
select f.ID1 from Highschooler h  join Friend as f on h.ID=f.ID2 where h.name='Cassandra') as a
join Highschooler h join Friend as f1 on a.ID1=f1.ID2 
where h.name='Cassandra') as b) as c on h.ID=c.ID1;

-- 14.Find the name and grade of the student(s) with the greatest number of friends. (1 point possible)

