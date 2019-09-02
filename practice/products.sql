create database orders;
use orders;
CREATE TABLE PRODUCTS
(
       PRODUCT_ID     INTEGER,
       PRODUCT_NAME   VARCHAR(20)
);
CREATE TABLE SALES
(
       SALE_ID        INTEGER,
       PRODUCT_ID     INTEGER,
       YEAR           INTEGER,
       Quantity       INTEGER,
       PRICE          INTEGER
);

INSERT INTO PRODUCTS VALUES ( 100, 'Nokia');
INSERT INTO PRODUCTS VALUES ( 200, 'IPhone');
INSERT INTO PRODUCTS VALUES ( 300, 'Samsung');
INSERT INTO PRODUCTS VALUES ( 400, 'LG');

INSERT INTO SALES VALUES ( 1, 100, 2010, 25, 5000);
INSERT INTO SALES VALUES ( 2, 100, 2011, 16, 5000);
INSERT INTO SALES VALUES ( 3, 100, 2012, 8,  5000);
INSERT INTO SALES VALUES ( 4, 200, 2010, 10, 9000);
INSERT INTO SALES VALUES ( 5, 200, 2011, 15, 9000);
INSERT INTO SALES VALUES ( 6, 200, 2012, 20, 9000);
INSERT INTO SALES VALUES ( 7, 300, 2010, 20, 7000);
INSERT INTO SALES VALUES ( 8, 300, 2011, 18, 7000);
INSERT INTO SALES VALUES ( 9, 300, 2012, 20, 7000);

select year,sum(Quantity) as sales_quantity from sales group by year;

select p.PRODUCT_NAME from PRODUCTS as p left join sales as s
on p.PRODUCT_ID=s.PRODUCT_ID where s.SALE_ID is null;

select p.PRODUCT_NAME,sum(Quantity*PRICE) as Total_sales from sales as s right join 
PRODUCTS as p on p.PRODUCT_ID=s.PRODUCT_ID  group by p.PRODUCT_ID;

select a.PRODUCT_NAME,a.Total_sales from(
select p.PRODUCT_NAME,sum(Quantity) as Total_sales ,dense_rank() over (order by sum(Quantity) desc) as sales_rank 
from sales as s right join 
PRODUCTS as p on p.PRODUCT_ID=s.PRODUCT_ID group by p.PRODUCT_NAME)
as a where  sales_rank=1;


select PRODUCT_ID,PRODUCT_NAME,YEAR,sales_difference from(
select b.PRODUCT_ID,p.PRODUCT_NAME,YEAR,sales_difference,dense_rank() over (partition by YEAR order by sales_difference)
as sales_rank from(
select PRODUCT_ID,YEAR,case when before_year_sales is not null
							then Quantity-before_year_sales
                            end as sales_difference from(
select PRODUCT_ID,YEAR,Quantity,lag(Quantity) over(partition by PRODUCT_ID) as before_year_sales from sales) as a)as b left join products as p
on p.PRODUCT_ID=b.PRODUCT_ID where sales_difference is not null
group by b.PRODUCT_ID,p.PRODUCT_NAME,YEAR) as e where sales_rank=1 ;