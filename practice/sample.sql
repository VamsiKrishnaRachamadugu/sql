create database sales;
use sales ;
-- Relationship table
create table relationship(relationship_id varchar(20) primary key,
						  relationship_name varchar(20),
                          relationship_price integer);
-- sales table
create table sales (sales_id varchar(20) primary key,sales_amount integer,sales_discount double,sales_quantity integer);

-- product table
create table product(product_id varchar(20) primary key,product_sales_id integer references sales(sales_id),
						product_name varchar(20),product_relationship_id integer references relationship(relationship_id),
                        product_city varchar(20),product_price varchar(20)
                        );
       
--  user table
create table user(user_id varchar(20) ,user_name varchar(20),user_city varchar(20),
					user_transaction_date date,user_product_id integer references product(product_id),
                    user_sales_id integer references sales(sales_id)
                    ,primary key (user_id,user_transaction_date));
                    
insert into user values('USO1','vamsi','padur','2019-07-02','PRO1','SLO1');
insert into user values('USO2','kadimi','urapakam','2019-07-02','RRO1','SLO2');
insert into user values('USO3','venu','perungalathur','2019-07-10','PRO1','SLO3');


