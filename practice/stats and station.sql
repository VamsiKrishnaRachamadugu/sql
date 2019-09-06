create table stats(Stats_ID int,month int,YEAR int,TEMP_FARENHEIT float(50,2),RAIN_INCH float(50,2));

insert into stats values(13,1,2010,57.4,0.31);
insert into stats values(13,5,2010,91.7,5.15);
insert into stats values(13,12,2010,12.6,8.34);
insert into stats values(13,9,2010,100.3,10.34);
insert into stats values(44,9,2010,27.2,3.45);
insert into stats values(44,2,2010,27.3,0.18);
insert into stats values(44,6,2010,74.8,2.11);
insert into stats values(66,3,2010,6.7,2.1);
insert into stats values(66,7,2010,65.8,4.52);

create table station(Station_ID int,CITY varchar(50),STATE varchar(50),LAT_N int,LONG_W int);
insert into station values(13,'Phoenix','AZ',33,112);
insert into station values(44,'Denver','CO',40,105);
insert into station values(66,'Caribou','ME',47,68);

-- 1.Fetch rows which have hottest month per city with highest rainfall
select Station_ID, CITY, STATE, Stats_ID, MONTH, YEAR, TEMP_FARENHEIT, RAIN_INCH from (
select s.Station_ID,s.CITY,s.STATE,st.Stats_ID,st.MONTH,st.YEAR,st.TEMP_FARENHEIT,st.RAIN_INCH,dense_rank() over
 (partition by s.Station_ID order by st.TEMP_FARENHEIT desc,st.RAIN_INCH desc) as dr_temp
from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID) as a where dr_temp=1;


-- 2.Fetch and display rows with Station_ID, City, State, Month, Year and temp(in Celcius), rainfall (in cm)
select s.Station_ID,s.CITY,s.STATE,st.MONTH,st.YEAR,(st.TEMP_FARENHEIT-32)*5/9 as temp_in_celsius,(st.RAIN_INCH*0.3937) as rain_in_cm
from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID;

-- 3.Display all rows for states on all quarters. If a state do not have any quarter information,
--  default Temp in Celcius and rain in cms based on average for the year


-- 4.Which state has coldest month and highest rainfall compared to average per year
select STATE,TEMP_FARENHEIT,RAIN_INCH from(
select s.STATE,st.TEMP_FARENHEIT,st.RAIN_INCH,avg(st.TEMP_FARENHEIT) over(partition by st.YEAR) as temp_avg,
avg(st.RAIN_INCH) over (partition by st.YEAR) as rain_avg
from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID) as t  where TEMP_FARENHEIT<temp_avg and RAIN_INCH>rain_avg;

-- 5.Which city had maximum rainfall below average . Display city, state, rainfall, average information
select CITY, STATE, RAIN_INCH, rain_avg from(
select CITY, STATE, RAIN_INCH, rain_avg,dense_rank() over (order by RAIN_INCH desc) as dr_rain_rank from(
select s.CITY,s.STATE,st.RAIN_INCH,avg(st.RAIN_INCH) over (partition by s.STATE=1) as rain_avg from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID ) as a where RAIN_INCH<rain_avg) as b where dr_rain_rank=1;

-- 6.Which city had second  coldest month when compared to national average
select CITY,TEMP_FARENHEIT from (
select s.CITY,dense_rank() over (order by st.TEMP_FARENHEIT) as dr_rank,st.TEMP_FARENHEIT from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID)as a where dr_rank=2;



-- 8.Report stations which had temperature difference < 5 C  or difference > 20 C in subsequent quarters
select state,temp_diff as temperature_in_c from (
select state,temp_in_c-lag_temp as temp_diff from(
select s.state,(st.TEMP_FARENHEIT-32)*5/9 as temp_in_c,lag((st.TEMP_FARENHEIT-32)*5/9) over(partition by s.state order by st.month) as lag_temp 
from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID) as a) as b where temp_diff<5 or temp_diff>20;

-- 9.Report stations which obsevered temperatures less than 0(in celcius)
select distinct state ,(st.TEMP_FARENHEIT-32)*5/9 as temp_in_celsius
from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID
having temp_in_celsius<0;

-- 10.Display state information and number of times when rainfall is greater than national avergae
select *,count(*) as No_of_times_occured from(
select Station_ID, CITY, STATE, LAT_N, LONG_W from(
select s.*, st.RAIN_INCH,avg(st.RAIN_INCH) over (partition by st.YEAR) as rain_avg from station as s inner join stats as st 
on s.Station_ID=st.Stats_ID ) as a where RAIN_INCH>rain_avg) as a  group by Station_ID, CITY, STATE, LAT_N, LONG_W;