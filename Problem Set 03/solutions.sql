select * from Reviewer;
select * from Rating;
select * from Movie;


#1.Find the titles of all movies directed by Steven Spielberg. (1 point possible)
select title from movie where director ='Steven Spielberg';

#2.Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order. (1 point possible)
select distinct year(ratingDate) as movie_year from rating where stars=4 or stars=5 order by year(ratingDate);

#3.Find the titles of all movies that have no ratings. (1 point possible)
select title from movie where mid not in(select mid from rating);

#4.Some reviewers didn't provide a date with their rating. Find the names of all reviewers 
#who have ratings with a NULL value for the date. (1 point possible)
select r.name  from Reviewer as r join rating as r1 on r.rID=r1.rID where ratingDate is null;

#5.Write a query to return the ratings data in a more readable format: reviewer name, movie title, 
#stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars. (1 point possible)
select r.name as reviewer_name,m.title,r1.stars,r1.ratingDate from Movie as m 
join Rating as r1 on m.mID=r1.mID
join Reviewer as r on r1.rID=r.rID order by r.name,m.title,r1.stars;

#6.For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, 
# return the reviewer's name and the title of the movie. (1 point possible)
-- select rID,mID,count(rating_count) from(
-- select rID,mID,stars,ratingDate,row_number() over(partition by rID,mID order by ratingDate,stars) as rating_count from Rating ) 
-- as a group by a.rID,a.mID having count(rating_count)=2;
 SELECT r.name,m.title
   FROM Reviewer as r
   JOIN Rating r1 on r1.rID = r.rID
   JOIN Rating as r2 on r2.rID = r.rID and r2.mID = r1.mID
   JOIN Movie as m on m.mID = r1.mID
   WHERE r2.ratingDate > r1.ratingDate and r2.stars > r1.stars ;


#7.For each movie that has at least one rating, find the highest number of stars that movie received. 
#Return the movie title and number of stars. Sort by movie title. (1 point possible)
-- select m.title,max(stars) as max_stars from(
-- select mID,stars,row_number() over(partition by mID order by stars) as movie_count from Rating) as a join movie as m on a.mID=m.mID   group by a.mID;

select m.title ,max(stars) from movie as m join rating as r on m.mID=r.mID group by r.mID;

#8.For each movie, return the title and the 'rating spread', that is, the difference between highest and 
#lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. (1 point possible)
select m.title ,max(stars)-min(stars) as rating_spread from movie as m join rating as r on m.mID=r.mID group by r.mID;

-- 9.Find the difference between the average rating of movies released before 1980 and 
-- the average rating of movies released after 1980. 
-- (Make sure to calculate the average rating for each movie, then the average of those averages for movies 
-- before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.) (1 point possible)
select a.title,avg(avg_stars) from(
select m.title,m.year,avg(r.stars) as avg_stars from movie as m join rating as r on m.mID=r.mID group by m.title,m.year)
as a where a.year<1980;

select a.title,avg(avg_stars) from(
select m.title,m.year,avg(r.stars) as avg_stars from movie as m join rating as r on m.mID=r.mID group by m.title,m.year)
as a where a.year>1980;

-- 10.Find the names of all reviewers who rated Gone with the Wind. (1 point possible)
select r1.name from Reviewer as r1 join 
Rating as r on r1.rID=r.rID
join movie as m on r.mID=m.mID where m.title ='Gone with the Wind';

-- 11.For any rating where the reviewer is the same as the director of the movie, return the reviewer name, 
-- movie title, and number of stars. (1 point possible)
select r1.name,m.title,r.stars from Reviewer as r1 join 
Rating as r on r1.rID=r.rID
join movie as m on r.mID=m.mID and r1.name=m.director;

-- 12.Return all reviewer names and movie names together in a single list, alphabetized. 
-- (Sorting by the first name of the reviewer and first word in the title is fine; 
-- no need for special processing on last names or removing "The".) (1 point possible)
select r.name,m.title from Movie as m join
Rating as r1 on m.mID=r1.mID
join Reviewer as r on r1.rID=r.rID
order by r.name,m.title ;

-- 13.Find the titles of all movies not reviewed by Chris Jackson. (1 point possible)
select title from movie where title not in(
select distinct m.title from Movie as m join
Rating as r1 on m.mID=r1.mID
join Reviewer as r on r1.rID=r.rID
where r.name='Chris Jackson');


-- 14.For all pairs of reviewers such that both reviewers gave a rating to the same movie, 
-- return the names of both reviewers. Eliminate duplicates, 
-- don't pair reviewers with themselves, and include each pair only once. For each pair, 
-- return the names in the pair in alphabetical order. (1 point possible)
select  distinct rev.name,rev1.name from Rating r1 join Rating r2
on r1.mID=r2.mID and r1.rID!=r2.rID join Reviewer as rev
on  r1.rID=rev.rID join Reviewer as rev1
on  r2.rID=rev1.rID ;

-- 15.For each rating that is the lowest (fewest stars) currently in the database, 
-- return the reviewer name, movie title, and number of stars. (1 point possible)
select rev.name,m.title,min(r.stars) from Reviewer as rev join
Rating as r on rev.rID=r.rID join
movie as m on r.mID=m.mID group by m.title;

-- 16.List movie titles and average ratings, from highest-rated to lowest-rated. 
-- If two or more movies have the same average rating, list them in alphabetical order. (1 point possible)
select m.title, avg(r.stars) as avg_rating from movie as m join
Rating as r on m.mID=r.mID group by m.title order by avg_rating,m.title;

-- 17.Find the names of all reviewers who have contributed three or more ratings.
--  (As an extra challenge, try writing the query without HAVING or without COUNT.) (1 point possible)
select distinct name from(
select rev.name,row_number() over (partition by  rev.name ) as rev_count from Reviewer as rev 
join Rating as r on rev.rID=r.rID) as a
where rev_count>=3;

-- 18.Some directors directed more than one movie. For all such directors, 
-- return the titles of all movies directed by them, along with the director name. 
-- Sort by director name, then movie title. (As an extra challenge, try writing the query both with and without COUNT.) (1 point possible)
select title,director from(
select title,director,row_number() over (partition by director) as mve_count from movie )
as a where a.mve_count>=2;

-- 19.Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
-- (Hint: This query is more difficult to write in SQLite than other systems; 
-- you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.) (1 point possible)






