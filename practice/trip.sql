create table trip(TRIP_ID varchar(40),TRIP_SOURCE varchar(40),TRIP_DESTINATION varchar(40),TRIP_START_TIME time,TRIP_END_TIME time,TRIP_COST integer,DYNAMIC_FARE varchar(40));
insert into trip values('TP01','CHN','BGL','13:40','15:40',3500,'Y');
insert into trip values('TP02','BGL','MUM','18:20','19:20',6700,'Y');
insert into trip values('TP03','CHN','HYD','9:45','11:10',3000,'Y');
insert into trip values('TP04','HYD','BGL','12:20','13:25',2700,'N');
insert into trip values('TP05','MUM','NDL','23:00','1:25',4500,'Y');
insert into trip values('TP06','BGL','NDL','19:40','22:10',5000,'N');
insert into trip values('TP07','NDL','MUM','16:45','17:50',6000,'Y');
insert into trip values('TP08','MUM','BGL','20:20','23:45',5000,'N');
insert into trip values('TP09','NDL','HYD','11:25','13:45',3000,'N');
insert into trip values('TP10','HYD','CHN','20:30','22:20',4500,'Y');
insert into trip values('TP11','BGL','CHN','23:45','1:05',3900,'Y');

select * from trip where TRIP_ID='TP10'; 
-- 1.Fetch itinerary details from CHN to NDL which are cheaper
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION, Total_Cost as CHEAPER_PRICE from (
select t1.TRIP_SOURCE,t1.TRIP_DESTINATION as 1st_connect,t2.TRIP_DESTINATION as 2nd_connect,t3.TRIP_DESTINATION,
t1.TRIP_COST+t2.TRIP_COST+t3.TRIP_COST AS Total_Cost,dense_rank() over (order by t1.TRIP_COST+t2.TRIP_COST+t3.TRIP_COST) as dr_price
from trip as t1 inner join trip as t2 on
t1.TRIP_DESTINATION=t2.TRIP_SOURCE
 inner join trip as t3 on
t2.TRIP_DESTINATION=t3.TRIP_SOURCE
where t1.TRIP_SOURCE='CHN' AND t3.TRIP_DESTINATION='NDL' )as a where dr_price=1;

-- 2.Fetch itinerary details from CHN to NDL which have less travel time            
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION,min(total_time_taken) as min_total_time_taken from(select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION, ADDTIME(addtime(1st_connect_time,2nd_connect_time),3rd_connect_time) as total_time_taken
,dense_rank() over (order by ADDTIME(addtime(1st_connect_time,2nd_connect_time),3rd_connect_time)) as dr_tiemtaken from(
select t1.TRIP_SOURCE,t1.TRIP_DESTINATION as 1st_connect,t2.TRIP_DESTINATION as 2nd_connect,t3.TRIP_DESTINATION,
case when t1.TRIP_START_TIME>t1.TRIP_END_TIME then timediff('24:00:00',timediff(t1.TRIP_START_TIME,t1.TRIP_END_TIME))
			when t1.TRIP_START_TIME<t1.TRIP_END_TIME then timediff(t1.TRIP_END_TIME,t1.TRIP_START_TIME) end as 1st_connect_time,
            case when t2.TRIP_START_TIME>t2.TRIP_END_TIME then timediff('24:00:00',timediff(t2.TRIP_START_TIME,t2.TRIP_END_TIME))
			when t2.TRIP_START_TIME<t2.TRIP_END_TIME then timediff(t2.TRIP_END_TIME,t2.TRIP_START_TIME)end as 2nd_connect_time,
case when t3.TRIP_START_TIME>t3.TRIP_END_TIME then timediff('24:00:00',timediff(t3.TRIP_START_TIME,t3.TRIP_END_TIME))
			when t3.TRIP_START_TIME<t3.TRIP_END_TIME then timediff(t3.TRIP_END_TIME,t3.TRIP_START_TIME)end as 3rd_connect_time
from trip as t1 inner join trip as t2 on
t1.TRIP_DESTINATION=t2.TRIP_SOURCE
 inner join trip as t3 on
t2.TRIP_DESTINATION=t3.TRIP_SOURCE
where t1.TRIP_SOURCE='CHN' AND t3.TRIP_DESTINATION='NDL') as a) as b where dr_tiemtaken=1 ;

-- 3.Fetch itinerary details from CHN to NDL which have less dynamic pricing(assume current_date = 'Sunday')

select t1.TRIP_SOURCE,t1.TRIP_DESTINATION as 1st_connect,t2.TRIP_DESTINATION as 2nd_connect,t3.TRIP_DESTINATION,
t1.TRIP_COST+t2.TRIP_COST+t3.TRIP_COST AS Total_Cost
from trip as t1 inner join trip as t2 on
t1.TRIP_DESTINATION=t2.TRIP_SOURCE and   t1.TRIP_SOURCE='CHN' and t1.DYNAMIC_FARE='Y'
 inner join trip as t3 on
t2.TRIP_DESTINATION=t3.TRIP_SOURCE
 AND t3.TRIP_DESTINATION='NDL' and t2.DYNAMIC_FARE='Y' and t3.DYNAMIC_FARE='Y';
 
--  4.Fetch itinerary details from CHN to NDL which happens on same day
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION, time_diff from(
select t1.TRIP_SOURCE,t1.TRIP_DESTINATION as 1st_connect,t2.TRIP_DESTINATION as 2nd_connect,t3.TRIP_DESTINATION,
timediff(t3.TRIP_END_TIME,t1.TRIP_START_TIME) as time_diff
from trip as t1 inner join trip as t2 on
t1.TRIP_DESTINATION=t2.TRIP_SOURCE
 inner join trip as t3 on
t2.TRIP_DESTINATION=t3.TRIP_SOURCE
where t1.TRIP_SOURCE='CHN' AND t3.TRIP_DESTINATION='NDL') as a where time_diff>0;


-- 5.Fetch itinerary details from CHN to NDL which have mimum wait time at transit
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION, transit_total_time from(
select t1.TRIP_SOURCE,t1.TRIP_DESTINATION as 1st_connect,t2.TRIP_DESTINATION as 2nd_connect,t3.TRIP_DESTINATION,
addtime(timediff(t2.TRIP_START_TIME,t1.TRIP_END_TIME),timediff(t3.TRIP_START_TIME,t2.TRIP_END_TIME) ) as transit_total_time,
dense_rank() over (order by addtime(timediff(t2.TRIP_START_TIME,t1.TRIP_END_TIME),timediff(t3.TRIP_START_TIME,t2.TRIP_END_TIME) ) ) as dr_transit_time
from trip as t1 inner join trip as t2 on
t1.TRIP_DESTINATION=t2.TRIP_SOURCE
 inner join trip as t3 on
t2.TRIP_DESTINATION=t3.TRIP_SOURCE
where t1.TRIP_SOURCE='CHN' AND t3.TRIP_DESTINATION='NDL' ) as a where  dr_transit_time=1;


-- 6.Fetch return itinerary details from NDL to CHN with mimum transits

select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION  from(
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION,dense_rank() over (order by flag) as dr_flag from(
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION,case when 2nd_connect = 'CHN' then 1
																	when 2nd_connect is not null and TRIP_DESTINATION ='CHN' then 2 end as flag from(
select distinct t1.TRIP_SOURCE,t2.TRIP_SOURCE as 1st_connect,t2.TRIP_DESTINATION as 2nd_connect,case when t2.TRIP_DESTINATION ='CHN' then null
																else t3.TRIP_DESTINATION end as TRIP_DESTINATION
from trip as t1 inner join trip as t2 on
t1.TRIP_DESTINATION=t2.TRIP_SOURCE
 inner join trip as t3 on
t2.TRIP_DESTINATION=t3.TRIP_SOURCE
where (t1.TRIP_SOURCE='NDL' AND t2.TRIP_DESTINATION='CHN' )or
 (t1.TRIP_SOURCE='NDL' AND t3.TRIP_DESTINATION='CHN' )) as a) as b ) as c where dr_flag=1;



-- 7.Fetch itinerary details from CHN to BGL before 11 AM
select t1.TRIP_SOURCE,t2.TRIP_SOURCE,t2.TRIP_DESTINATION  
from trip as t1 inner join trip as t2 on
t1.TRIP_DESTINATION=t2.TRIP_SOURCE and t1.TRIP_START_TIME<'11:00:00'
and t1.TRIP_SOURCE='CHN' AND t2.TRIP_DESTINATION='BGL';


-- 8.Fetch return itinerary details from NDL to CHN which happens on same day or which has less travel time
select TRIP_SOURCE, 1st_connect,  case when TRIP_DESTINATION  is null then 2nd_connect
													else TRIP_DESTINATION   end as TRIP_DESTINATION 
													from(
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION,dense_rank() over (order by total_time_taken) as dr_flag,same_day_flag from(
select TRIP_SOURCE, 1st_connect, 2nd_connect, TRIP_DESTINATION,case when 3rd_connect_time is not null then
                                                                addtime(addtime(1st_connect_time,2nd_connect_time),3rd_connect_time) 
                                                                else  addtime(1st_connect_time,2nd_connect_time) end as total_time_taken,
                                                                case when time_diff>0 then 1
                                                                else 2 end as same_day_flag from(
select distinct t1.TRIP_SOURCE,t2.TRIP_SOURCE as 1st_connect,t2.TRIP_DESTINATION as 2nd_connect,
																case when t2.TRIP_DESTINATION ='CHN' then null
																else t3.TRIP_DESTINATION end as TRIP_DESTINATION,
                                                        case when t1.TRIP_START_TIME>t1.TRIP_END_TIME then timediff('24:00:00',timediff(t1.TRIP_START_TIME,t1.TRIP_END_TIME))
															 when t1.TRIP_START_TIME<t1.TRIP_END_TIME then timediff(t1.TRIP_END_TIME,t1.TRIP_START_TIME) end as 1st_connect_time,
														case when t2.TRIP_START_TIME>t2.TRIP_END_TIME then timediff('24:00:00',timediff(t2.TRIP_START_TIME,t2.TRIP_END_TIME))
															when t2.TRIP_START_TIME<t2.TRIP_END_TIME then timediff(t2.TRIP_END_TIME,t2.TRIP_START_TIME)end as 2nd_connect_time,
														case when t2.TRIP_DESTINATION ='CHN' and  t3.TRIP_DESTINATION is not null then null
															when t3.TRIP_START_TIME>t3.TRIP_END_TIME then timediff('24:00:00',timediff(t3.TRIP_START_TIME,t3.TRIP_END_TIME))
															when t3.TRIP_START_TIME<t3.TRIP_END_TIME then timediff(t3.TRIP_END_TIME,t3.TRIP_START_TIME)
															else null end as 3rd_connect_time,
														case when t2.TRIP_DESTINATION ='CHN' then  timediff(t2.TRIP_END_TIME,t1.TRIP_START_TIME)
															else  timediff(t3.TRIP_END_TIME,t1.TRIP_START_TIME)  end as time_diff

													from trip as t1 inner join trip as t2 on
													t1.TRIP_DESTINATION=t2.TRIP_SOURCE
													 inner join trip as t3 on
													t2.TRIP_DESTINATION=t3.TRIP_SOURCE
													where (t1.TRIP_SOURCE='NDL' AND t2.TRIP_DESTINATION='CHN' )or
													 (t1.TRIP_SOURCE='NDL' AND t3.TRIP_DESTINATION='CHN' )
                                                     ) as a
) as b ) as c where dr_flag=1 or same_day_flag=1;

-- 9.Fetch trip details which have less travel time
select TRIP_ID, TRIP_SOURCE, TRIP_DESTINATION, TRIP_START_TIME, TRIP_END_TIME, TRIP_COST, DYNAMIC_FARE,travel_time from(
select *,dense_rank() over (order by travel_time) as time_taken_order from(
select t1.*, case when t1.TRIP_START_TIME>t1.TRIP_END_TIME then timediff('24:00:00',timediff(t1.TRIP_START_TIME,t1.TRIP_END_TIME))
			when t1.TRIP_START_TIME<t1.TRIP_END_TIME then timediff(t1.TRIP_END_TIME,t1.TRIP_START_TIME) end as travel_time from
            trip as t1 ) as a) as b where time_taken_order=1;
            
-- 10.Fetch trip details which have high travel time and no dynamic pricing
select TRIP_ID, TRIP_SOURCE, TRIP_DESTINATION, TRIP_START_TIME, TRIP_END_TIME, TRIP_COST, DYNAMIC_FARE,travel_time from(
select *,dense_rank() over (order by travel_time desc) as time_taken_order from(
select t1.*, case when t1.TRIP_START_TIME>t1.TRIP_END_TIME then timediff('24:00:00',timediff(t1.TRIP_START_TIME,t1.TRIP_END_TIME))
			when t1.TRIP_START_TIME<t1.TRIP_END_TIME then timediff(t1.TRIP_END_TIME,t1.TRIP_START_TIME) end as travel_time from
            trip as t1  where DYNAMIC_FARE='N') as a) as b where time_taken_order=1;
            