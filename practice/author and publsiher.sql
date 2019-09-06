create table author (AUTHOR_ID	varchar(20),AUTHOR_NAME	varchar(20),AUTHOR_COUNTRY	varchar(20),AUTHOR_CITY	varchar(20),PUBLISH_ID varchar(20));
create table publisher(PUBLISH_ID varchar(20),PUBLISH_NAME varchar(40),PUBLISH_CITY varchar(20),PUBLISH_START_DATE date,BRANCHES integer);
truncate table author;
insert into author values('AUT001','William Norton','UK','Cambridge','PB01');
insert into author values('AUT002','C.J.Wilde','USA','San Francisco','PB04');
insert into author values('AUT003','John Betjeman Hunter','RUSSIA','Moscow','PB01');
insert into author values('AUT004','John Betjeman Hunter','CANADA','Toronto','PB03');
insert into author values('AUT005','S.B.Swaminathan','INDIA','Delhi','PB01');
insert into author values('AUT006','Butler Andre  ','UK','London','PB03');
insert into author values('AUT007','E. Howard ','EUROPE','Berlin','PB03');
insert into author values('AUT008','Andrew Jeff','GERMANY','Berlin','PB02');
insert into author values('AUT009','Drek Tailor','Australia','Melbourne','PB01');
insert into author values('AUT010','Mary Coffing','USA','New Jersy','PB04');
insert into publisher values('PB01','Jex Max Publication','Berlin',str_to_date('4/21/1929','%m/%d/%Y'),10);
insert into publisher values('PB02','Summer Night Publication','Canada',str_to_date('8/31/2019','%m/%d/%Y'),25);
insert into publisher values('PB03','Novel Publisher Ltd. ','London',str_to_date('8/10/2018','%m/%d/%Y'),11);
insert into publisher values('PB04','Mark Book Sales','New Jersy',str_to_date('5/24/2008','%m/%d/%Y'),9);

-- 1.Fetch publisher information who have publish_city <> author_city and check if publish_city = author_country 
-- . display the correct publisher_city along with other publisher information based on author_city
select a.AUTHOR_CITY as publisher_city,p.PUBLISH_ID, PUBLISH_NAME,  PUBLISH_START_DATE, BRANCHES from publisher as p inner join author as a 
on  a.PUBLISH_ID=p.PUBLISH_ID and p.PUBLISH_CITY<>a.AUTHOR_CITY
and  p.PUBLISH_CITY=a.AUTHOR_COUNTRY ;

-- 2.Fetch authors_name, author_country, publish_city, publish_start_date, branches who have publications with most number of branches by century
select a.author_name,a.author_country, c.publish_city, c.publish_start_date,c. branches from author as a inner join publisher as p 
on a.PUBLISH_ID=p.PUBLISH_ID inner join (
select p.PUBLISH_ID,p.publish_city,p.publish_start_date,p.branches,
dense_rank() over (partition by substring(year(p.publish_start_date),1,2) 
order by branches desc) as dr_year from publisher as p) as c on c.PUBLISH_ID=p.PUBLISH_ID
where c.dr_year=1;

-- 3.Fetch publisher details who have authors in same city and get corresponding author details who belong to same country
 select distinct p.*,a.* from publisher as p inner join  (
select a.AUTHOR_COUNTRY from author as a inner join publisher as p 
on  a.AUTHOR_CITY=p.PUBLISH_CITY and a.publish_id=p.publish_id
 )as m inner join author as a on
 a.AUTHOR_COUNTRY=m.AUTHOR_COUNTRY and a.publish_id=p.publish_id;
 
--  4.Fetch authors who have incorrect author_country for same author_city. Display correct author_country along with all author_information
select AUTHOR_ID, AUTHOR_NAME,case when AUTHOR_CITY='Berlin' then 'EUROPE'
									end as AUTHOR_COUNTRY, AUTHOR_CITY, PUBLISH_ID from(
select a.* from author as a inner join author as a1
on a.AUTHOR_CITY=a1.AUTHOR_CITY and a.AUTHOR_COUNTRY!=a1.AUTHOR_COUNTRY) as a;

--  5.Fetch authors who do not have publisher from their country
select a.AUTHOR_NAME from author as a left join publisher as p 
on  a.AUTHOR_COUNTRY=p.PUBLISH_CITY or a.AUTHOR_CITY=p.PUBLISH_CITY where p.PUBLISH_CITY is null;

-- 6.Fetch author details if first character of publisher name is same as author_name
select a.AUTHOR_NAME from author as a where a.AUTHOR_NAME like any(select substr(p.PUBLISH_NAME,1,1) from publisher as p)

-- 7.Fetch author details who have more than one initial before their name
select a.AUTHOR_NAME from author as a where a.AUTHOR_NAME like '_._.%';

-- 8.Fetch author details who do not have initial in their name
select a.AUTHOR_NAME from author as a where a.AUTHOR_NAME not like '_.%';
-- 9.Fetch author details who have lower case in author_country
select a.* from author as a where lower(substr(a.author_country,2)) like binary substr(a.author_country,2) ;
--  select a.AUTHOR_NAME from author as a where author_country regexp '[A-Z]+[a-z]';
select a.* from author as a where ascii(lower(substr(a.author_country,2)))=ascii(substr(a.author_country,2)) ;


-- 10.Fetch author information and publisher information who have publisher with recent publish_start_date.
select p.*,a.* from publisher as p inner  join  author as a
on a.PUBLISH_ID=p.PUBLISH_ID inner join(
select max(p.PUBLISH_START_DATE) as max_date from author as a inner join publisher as p 
on a.PUBLISH_ID=p.PUBLISH_ID ) as g
on g.max_date=p.PUBLISH_START_DATE;

-- 11.Fetch count of authors belong to same continent(eg. Berlin -> Europe)