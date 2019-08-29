show tables;
select * from band;
select * from plays_in;
select * from composer;
select * from composition;
select * from has_composed;
select * from concert;
select * from performance;
select * from performer;
select * from musician;
select * from place;

-- 1.Give the organiser's name of the concert in the Assembly Rooms after the first of Feb, 1997. (1 point possible)
select m.m_name from musician as m join concert as c on m.m_no=c.concert_orgniser where c.concert_venue='Assembly Rooms';

-- 2.Find all the performers who played guitar or violin and were born in England. (1 point possible)
select m.m_name from musician as m join performer as p on  m.m_no=p.perf_is 
join place as pl on m.born_in=pl.place_no
where p.instrument='violin' or p.instrument='guitar' and pl.place_town='England';

-- 3.List the names of musicians who have conducted concerts in USA together with the 
-- towns and dates of these concerts. (1 point possible)
select m.m_name from concert as c join place as p on
c.concert_in=p.place_no join musician as m on c.concert_orgniser=m.m_no
where p.place_country='USA';

-- 4.How many concerts have featured at least one composition by Andy Jones? 
-- List concert date, venue and the composition's title. (1 point possible)
select con.con_date,con.concert_venue,c.c_title from concert as con 
join composition as c on con.concert_no=c_in join musician as m on 
 con.concert_orgniser=m.m_no where m.m_name='Andy Jones';
 
 
--  5.List the different instruments played by the musicians and avg number of 
--  musicians who play the instrument. (1 point possible)
select m.m_name,a.instrument,avg(a.count_musician) as avg_musician from musician as m join(
select p.perf_is,p.instrument,count(p.perf_is) as count_musician from  performer as p 
  group by p.instrument) as a on m.m_no=a.perf_is  group by m.m_name,a.instrument;

-- 6.List the names, dates of birth and the instrument played of 
-- living musicians who play a instrument which Theo also plays. (1 point possible)
select   m1.m_name,m1.born,p1.instrument from musician m1 join performer p1 on p1.perf_is = m1.m_no
join (select  p.instrument from performer p join musician  m
on p.perf_is = m.m_no where m.m_name LIKE '%Theo%') as a
on a.instrument=p1.instrument
where m1.died is null;

-- 7.List the name and the number of players for the band whose number of players is greater 
-- than the average number of players in each band. (1 point possible)
select band_name,count(band_id) from band join plays_in on band_no=band_id group by band_name
having count(band_id)>(
select avg(player_count) from(
select band_id,count(player) as player_count from plays_in group by band_id) as a);

-- 8.List the names of musicians who both conduct and compose and live in Britain. (1 point possible)
select distinct m.m_name from musician as m join concert as con join composition as c
on m.m_no=con.concert_orgniser and  m.m_no=c.c_in join place as p 
on m.living_in=p.place_no where p.place_country='England';

-- 9.Show the least commonly played instrument and the number of musicians who play it. (1 point possible)
select a.instrument,count_played from performer as p  join (
select instrument,count(instrument) as count_played,dense_rank() over (order by count(instrument)) as instrument_count from performer group by instrument)
as a on p.instrument=a.instrument where a.instrument_count=1;

-- 10.List the bands that have played music composed by Sue Little; Give the titles of the composition in each case. (1 point possible)
select c.c_title from composer as com join musician as m 
on com.comp_is=m.m_no join composition as c on com.comp_no=c.c_in where m.m_name='Sue Little';

-- 11.List the name and town of birth of any performer born in the same city as James First.(1 point possible)
select   m1.m_name ,p.place_town from musician as m join musician as m1
on m.born_in=m1.born_in join place as p on m.born_in=p.place_no where m.m_name='James First';

-- 12.Create a list showing for EVERY musician born in Britain the number of compositions and
--  the number of instruments played. (1 point possible)
select a.m_name,count(c_no)as composition_count,count(instrument) as instrument_count from composition as c join composer as com on c.c_in =com.comp_no right join(   
select m.m_name,m.m_no from musician as m join place as p 
 on m.born_in=p.place_no where p.place_country='England') as a
on com.comp_is=a.m_no left join performer as per
on  per.perf_is=m_no group by a.m_name;

-- 13.Give the band name, conductor and contact of the bands performing at the most recent concert in the Royal Albert Hall. (1 point possible)
select b.band_name,m.m_name,b.band_contact from band as b join performance as per
on b.band_no=per.gave join concert as c on c.concert_no=per.performed_in join musician as m
on c.concert_orgniser=m.m_no where c.concert_venue ='Royal Albert Hall';

-- 14.Give a list of musicians associated with Glasgow. Include the name of the musician and the nature of the association - 
-- one or more of 'LIVES_IN', 'BORN_IN', 'PERFORMED_IN' AND 'IN_BAND_IN'. (1 point possible)
select m.m_name    from musician as m join place as p
on m.born_in=p.place_no or m.living_in=p.place_no left join concert as con on
con.concert_in=p.place_no left join performance as per1 on con.concert_no=per1.performed_in 
left join band as b on per1.performed =b.band_no  where p.place_town='Glasgow';

-- 15.Jeff Dawn plays in a band with someone who plays in a band with Sue Little. Who is it and what are the bands? (1 point possible)

