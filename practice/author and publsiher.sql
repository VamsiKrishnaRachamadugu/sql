create table author (AUTHOR_ID	varchar(20),AUTHOR_NAME	varchar(20),AUTHOR_COUNTRY	varchar(20),AUTHOR_CITY	varchar(20),PUBLISH_ID varchar(20));
create table publisher(PUBLISH_ID varchar(20),PUBLISH_NAME varchar(40),PUBLISH_CITY varchar(20),PUBLISH_START_DATE date,BRANCHES integer);
truncate table author;
insert into author values('AUT001','William Norton','UK','Cambridge','PB01');
insert into author values('AUT002','C. J. Wilde','USA','San Francisco','PB04');
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


