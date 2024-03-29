create database music_db;
use music_db;

create table musician(m_no int primary key, m_name varchar(20), born varchar(10), died varchar(20),born_in int,living_in int);

create table place(place_no int primary key, place_town varchar(20), place_country varchar(20)); 

create table performer(perf_no int primary key, perf_is int, instrument varchar(20), perf_type varchar(20));
create table composer(comp_no int primary key, comp_is int, comp_type varchar(20)); 
create table band(band_no int primary key, band_name varchar(20), band_home int, band_type varchar(20), b_date varchar(20), band_contact varchar(20));

create table plays_in(player int, band_id int);
create table composition(c_no int primary key, comp_date varchar(20), c_title varchar(30), c_in int);
create table has_composed(cmpr_no int, cmpn_no int); 

create table concert(concert_no int primary key, concert_venue varchar(20), concert_in int, con_date varchar(20),concert_orgniser int);
create table performance(pfrmnc_no int primary key, gave int, performed int, conducted_by int, performed_in int); 

insert into musician(m_no,m_name,born,born_in,living_in) values(1,'Fred Bloggs','02/01/48',1,2); 
insert into musician(m_no,m_name,born,born_in,living_in) values(2,'John Smith','03/03/50',3,4 ); 
insert into musician(m_no,m_name,born,born_in,living_in) values(3,'Helen Smyth','08/08/48',4,5 ); 
insert into musician values(4,'Harriet Smithson','09/05/1909','20/09/1980',5,6); 
insert into musician(m_no,m_name,born,born_in,living_in) values(5,'James First','10/06/65',7,7); 
insert into musician(m_no,m_name,born,born_in,living_in) values(6,'Theo Mengel','12/08/48',7,1); 
insert into musician(m_no,m_name,born,born_in,living_in) values(7,'Sue Little','21/02/45',8,9); 
insert into musician(m_no,m_name,born,born_in,living_in) values(8,'Harry Forte','28/02/51',1,8); 
insert into musician(m_no,m_name,born,born_in,living_in) values(9,'Phil Hot','30/06/42',2,7); 
insert into musician(m_no,m_name,born,born_in,living_in) values(10,'Jeff Dawn','12/12/45',3,6); 
insert into musician(m_no,m_name,born,born_in,living_in) values(11,'Rose Spring','25/05/48',4,5); 
insert into musician(m_no,m_name,born,born_in,living_in) values(12,'Davis Heavan','03/10/75 ',5,4); 
insert into musician(m_no,m_name,born,born_in,living_in) values(13,'Lovely Time','28/12/48',6,3); 
insert into musician values(14,'Alan Fluff','15/01/35','15/05/97',7,2); 
insert into musician(m_no,m_name,born,born_in,living_in) values(15,'Tony Smythe','02/04/32',8,1); 
insert into musician(m_no,m_name,born,born_in,living_in) values(16,'James Quick','08/08/1924',9,2); 
insert into musician(m_no,m_name,born,born_in,living_in) values(17,'Freda Miles','04/07/1920',9,3); 
insert into musician(m_no,m_name,born,born_in,living_in) values(18,'Elsie James','06/05/47',8,5); 
insert into musician(m_no,m_name,born,born_in,living_in) values(19,'Andy Jones','08/10/58',7,6); 
insert into musician values(20,'Louise Simpson','10/01/48','11/02/98',6,6); 
insert into musician(m_no,m_name,born,born_in,living_in) values( 21,'James Steeple','10/01/47',5,6); 
insert into musician(m_no,m_name,born,born_in,living_in) values(22,'Steven Chaytors','11/03/56',6,7); 
  
insert into place values(1,'Manchester','England');
insert into place values(2,'Edinburgh','Scotland');
insert into place values(3,'Salzburg','Austria');
insert into place values(4,'New York','USA');
insert into place values(5,'Birmingham','England');
insert into place values(6,'Glasgow','Scotland');
insert into place values(7,'London','England');
insert into place values(8,'Chicago','USA');
insert into place values(9,'Amsterdam','Netherlands');

insert into performer values(1,2,'violin','classical');
insert into performer values(2,4,'viola','classical');
insert into performer values(3,6,'banjo','jazz');
insert into performer values(4,8,'violin','classical');
insert into performer values(5,12,'guitar','jazz');
insert into performer values(6,14,'violin','classical');
insert into performer values(7,16,'trumpet','jazz');
insert into performer values(8,18,'viola','classical');
insert into performer values(9,20,'bass','jazz');
insert into performer values(10,2,'flute','jazz');
insert into performer values(11,20,'cornet','jazz');
insert into performer values(12,6,'violin','jazz');
insert into performer values(13,8,'drums','jazz');
insert into performer values(14,10,'violin','classical');
insert into performer values(15,12,'cello','classical');
insert into performer values(16,14,'viola','classical');
insert into performer values(17,16,'flute','jazz');
insert into performer values(18,18,'guitar','not known');
insert into performer values(19,20,'trombone','jazz');
insert into performer values(20,3,'horn','jazz');
insert into performer values(21,5,'violin','jazz');
insert into performer values(22,7,'cello','classical');
insert into performer values(23,2,'bass','jazz');
insert into performer values(24,4,'violin','jazz');
insert into performer values(25,6,'drums','classical');
insert into performer values(26,8,'clarinet','jazz');
insert into performer values(27,10,'bass','jazz');
insert into performer values(28,12,'viola','classical');
insert into performer values(29,18,'cello','classical');

insert into composer values(1,1,'jazz');
insert into composer values(2,3,'classical');
insert into composer values(3,5,'jazz');
insert into composer values(4,7,'classical');
insert into composer values(5,9,'jazz');
insert into composer values(6,11,'rock');
insert into composer values(7,13,'classical');
insert into composer values(8,15,'jazz');
insert into composer values(9,17,'classical');
insert into composer values(10,19,'jazz');
insert into composer values(11,10,'rock');
insert into composer values(12,8,'jazz');

insert into band (band_no, band_name , band_home, band_type, b_date, band_contact) values(1,'ROP',5,'classical','30/01/2001',11);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(2,'AASO',6,'classical',10);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(3,'The J Bs',8,'jazz',12);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(4,'BBSO',9,'classical',21);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(5,'The left Overs',2,'jazz',8);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(6,'Somebody Loves this',1,'jazz',6);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(7,'Oh well',4,'classical',3);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(8,'Swinging strings',4,'classical',7);
insert into band (band_no, band_name , band_home, band_type, band_contact)  values(9,'The Rest',9,'jazz',16);

insert into plays_in values(1,1);
insert into plays_in values(1,7);
insert into plays_in values(3,1);
insert into plays_in values(4,1);
insert into plays_in values(4,7);
insert into plays_in values(5,1);
insert into plays_in values(6,1);
insert into plays_in values(6,7);
insert into plays_in values(7,1);
insert into plays_in values(8,1);
insert into plays_in values(8,7);
insert into plays_in values(10,2);
insert into plays_in values(12,2);
insert into plays_in values(13,2);
insert into plays_in values(14,2);
insert into plays_in values(14,8);
insert into plays_in values(15,2);
insert into plays_in values(15,8);
insert into plays_in values(17,2);
insert into plays_in values(18,2);
insert into plays_in values(19,3);
insert into plays_in values(20,3);
insert into plays_in values(21,4);
insert into plays_in values(22,4);
insert into plays_in values(23,4);
insert into plays_in values(25,5);
insert into plays_in values(26,6);
insert into plays_in values(27,6);
insert into plays_in values(28,7);
insert into plays_in values(28,8);
insert into plays_in values(29,7);

insert into composition values(1,'17/06/75','Opus 1',1); 
insert into composition values(2,'21/07/76','Here Goes',2);
insert into composition values(3,'14/12/81','Valiant Knight',3);
insert into composition values(4,'12/01/82','Little Piece',4);
insert into composition values(5,'13/03/85','Simple Song',5);
insert into composition values(6,'14/04/86','Little Swing Song',6);
insert into composition values(7,'13/05/87','Fast Journey',7);
insert into composition values(8,'14/02/76','Simple Love Song',8);
insert into composition values(9,'21/01/82','Complex Rythms',9);
insert into composition values(10,'23/02/85','Drumming Rythms',9);
insert into composition values(11,'18/03/78','Fast Drumming',8);
insert into composition values(12,'13/08/84','Slow Song',7);
insert into composition values(13,'14/09/68','Blue Roses',6);
insert into composition values(14,'15/11/83','Velvet Rain',5);
insert into composition values(15,'16/05/82','Cold Wind',4);
insert into composition values(16,'18/06/83','After the Wind Blows',3);
insert into composition (c_no,c_title,c_in) values(17,'A Simple Piece',2);
insert into composition values(18,'12/01/85','Long Rythms',1);
insert into composition values(19,'12/02/88','Eastern Wind',1);
insert into composition (c_no,c_title,c_in) values(20,'Slow Symphony Blowing',2);
insert into composition values(21,'12/07/90','A Last Song',6);

insert into has_composed values(1,1);
insert into has_composed values(1,8);
insert into has_composed values(2,11);
insert into has_composed values(3,2);
insert into has_composed values(3,13);
insert into has_composed values(3,14);
insert into has_composed values(3,18);
insert into has_composed values(4,12);
insert into has_composed values(4,20);
insert into has_composed values(5,3);
insert into has_composed values(5,13);
insert into has_composed values(5,14);
insert into has_composed values(6,15);
insert into has_composed values(6,21);
insert into has_composed values(7,4);
insert into has_composed values(7,9);
insert into has_composed values(8,16);
insert into has_composed values(9,5);
insert into has_composed values(9,10);
insert into has_composed values(10,17);
insert into has_composed values(11,6);
insert into has_composed values(12,7);
insert into has_composed values(12,19);

insert into concert values(1,'Bridgewater Hall',1,'1995-01-06',21); 
insert into concert values(2,'Bridgewater Hall',1,'1996-05-08',3); 
insert into concert values(3,'Usher Hall',2,'1995-06-03',3); 
insert into concert values(4,'Assembly Rooms',2,'1997-09-20',21); 
insert into concert values(5,'Festspiel Haus',3,'1995-02-21',8); 
insert into concert values(6,'Royal Albert Hall',7,'1993-04-12',8); 
insert into concert values(7,'Concertgebouw',9,'1993-01-14',8); 
insert into concert values(8,'Metropolitan',4,'1997-01-15',21); 

insert into performance values(1,1,1,21,1); 
insert into performance values(2,1,3,21,1);
insert into performance values(3,1,5,21,1);
insert into performance values(4,1,2,1,2);
insert into performance values(5,2,4,21,2); 
insert into performance values(6,2,6,21,2);
insert into performance values(7,4,19,9,3);
insert into performance values(8,4,20,10,3);
insert into performance values(9,5,12,10,4);
insert into performance values(10,5,13,11,4);
insert into performance values(11,3,5,13,5);
insert into performance values(12,3,6,13,5);
insert into performance values(13,3,7,13,5);
insert into performance values(14,6,20,14,6);
insert into performance values(15,8,12,15,7);
insert into performance values(16,9,16,21,8);
insert into performance values(17,9,17,21,8);
insert into performance values(18,9,18,21,8);
insert into performance values(19,9,19,21,8);
insert into performance values(20,4,12,10,3);

