drop database sgrb;
create database sgrb;
use sgrb;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS prices_sales;
DROP TABLE IF EXISTS purchases;
DROP TABLE IF EXISTS sales;

DROP TABLE IF EXISTS users_duplicate;
DROP TABLE IF EXISTS clients_duplicate;
DROP TABLE IF EXISTS expenses_duplicate;
DROP TABLE IF EXISTS prices_sales_duplicate;
DROP TABLE IF EXISTS purchases_duplicate;
DROP TABLE IF EXISTS sales_duplicate;

DROP TABLE IF EXISTS users_events;
DROP TABLE IF EXISTS clients_events;
DROP TABLE IF EXISTS expenses_events;
DROP TABLE IF EXISTS prices_sales_events;
DROP TABLE IF EXISTS purchases_events;
DROP TABLE IF EXISTS sales_events;

CREATE TABLE users (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(20) unique NOT NULL,
  firstnames varchar(60) NOT NULL,
  surnames varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  status int(1) NOT NULL,
  roles varchar(60) NOT NULL,
  entrydatetime datetime NOT NULL,
  user_register int(11) NOT NULL,
  password varchar(255) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE clients (
  id int(11) NOT NULL AUTO_INCREMENT,
  clientname varchar(60) NOT NULL,
  client_nr bigint unique NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
) ;
CREATE TABLE expenses (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  price decimal(8,2) NOT NULL,
  observation varchar(255) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
  );
CREATE TABLE prices_sales (
  id int(11) NOT NULL AUTO_INCREMENT,
  product varchar(60) NOT NULL,
  category varchar(100) NULL,
  prod_type varchar(100) NULL,
  quantity varchar(100) NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE sales (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (client_nr) REFERENCES clients (client_nr)
);



CREATE TABLE users_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  firstnames varchar(60) NOT NULL,
  surnames varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  status int(1) NOT NULL,
  roles varchar(60) NOT NULL,
  entrydatetime datetime NOT NULL,
  user_register int(11) NOT NULL,
  password varchar(255) NULL,
  PRIMARY KEY (id)
);
CREATE TABLE clients_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  clientname varchar(60) NOT NULL,
  client_nr bigint unique NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
) ;
CREATE TABLE expenses_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  price decimal(8,2) NOT NULL,
  observation varchar(255) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
  );
CREATE TABLE prices_sales_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  product varchar(60) NOT NULL,
  category varchar(100) NULL,
  prod_type varchar(100) NULL,
  quantity varchar(100) NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE sales_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (client_nr) REFERENCES clients (client_nr)
);



CREATE TABLE users_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  username varchar(20) NOT NULL,
  firstnames varchar(60) NOT NULL,
  surnames varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  status int(1) NOT NULL,
  roles varchar(60) NOT NULL,
  entrydatetime datetime NOT NULL,
  user_register int(11) NOT NULL,
  password varchar(255) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE clients_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  clientname varchar(60) NOT NULL,
  client_nr bigint unique NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
) ;
CREATE TABLE expenses_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  price decimal(8,2) NOT NULL,
  observation varchar(255) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
  );
CREATE TABLE prices_sales_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  product varchar(60) NOT NULL,
  category varchar(100) NULL,
  prod_type varchar(100) NULL,
  quantity varchar(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE sales_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (client_nr) REFERENCES clients (client_nr)
);

INSERT INTO users VALUES (1,'Admin','ADMIN','ADMINISTRATOR','Gestor',1,'a,b,c,d','2021-11-25 13:06:04',1,'Admin123');
INSERT INTO users_duplicate VALUES (1,'Admin','ADMIN','ADMINISTRATOR','Gestor',1,'a,b,c,d','2021-11-25 13:06:04',1,'Admin123');
INSERT INTO users_events VALUES (1,'Admin','ADMIN','ADMINISTRATOR','Gestor',1,'a,b,c,d','2021-11-25 13:06:04',1,'Admin123');

DROP VIEW geral;
CREATE VIEW geral AS 
SELECT 'sales' as tbl,article,quantity,price as entradas,0 as saidas,price as saldo,user_datetime,sector FROM sales where removed = '0'
UNION
SELECT 'purchases' as tbl,article,quantity,0 as entradas,price as saidas,(0 - price) as saldo,user_datetime,sector FROM purchases where removed = '0'
UNION
SELECT 'expenses' as tbl,prod_type,1,0 as entradas,price as saidas,(0 - price) as saldo, user_datetime,sector FROM expenses where removed = '0'
ORDER BY user_datetime DESC;

DROP VIEW vpurchases_sales;
CREATE VIEW vpurchases_sales AS 
SELECT 'sales' as tbl,group_factory,article,quantity,price as entradas,0 as saidas,price as saldo,user_datetime,sector FROM sales where removed = '0'
UNION
SELECT 'purchases' as tbl,group_factory,article,quantity,0 as entradas,price as saidas,(0 - price) as saldo,user_datetime,sector FROM purchases where removed = '0';

DROP VIEW vstock;
CREATE VIEW vstock AS 
SELECT 'sales' as tbl,category,group_factory,p_code,barcode,article,price,0 as compras,quantity as vendas,0 as invalid, (0 - quantity) as stock,user_datetime,sector FROM sales 
 where removed = '0'
 UNION
SELECT 'purchases' as tbl,category,group_factory,p_code,barcode,article,price,quantity as compras, 0 as vendas,0 as invalid, quantity as stock,user_datetime,sector FROM purchases 
where removed = '0'
 UNION 
SELECT 'purchases_not_used' as tbl,category,group_factory,p_code,barcode,article,price,0 as compras,0 as vendas, quantity as invalid,(0 - quantity) as stock,user_datetime,sector FROM sales 
 where removed = '0';

drop view vstock2; 
create view vstock2 as  
select category,group_factory,article,price,p_code,barcode,compras,vendas,invalid,stock,user_datetime,sector from vstock
 UNION ALL 
select (select category from prices_sales ps where ps.product = up.article limit 1) as category,up.group_factory as group_factory,
 up.product as article,price,
(select p_code from purchases p where s.article = p.article limit 1) as p_code,
(select barcode from purchases p where s.article = p.article limit 1) as barcode
,0,(0 - up.quantity) as vendas,0 as invalid,
(0 - up.quantity) as stock,s.user_datetime as user_datetime,s.sector as sector from sales s left join used_products up on 
s.article = up.article where up.article is not null and up.removed = '0';


alter table sales add column marked_rmv tinyint(1) default 0 after price;
alter table sales add column removed tinyint(1) default 0 after marked_rmv;


alter table purchases add column marked_rmv tinyint(1) default 0 after price;
alter table purchases add column removed tinyint(1) default 0 after marked_rmv;

alter table expenses add column marked_rmv tinyint(1) default 0 after price;
alter table expenses add column removed tinyint(1) default 0 after marked_rmv;

alter table prices_sales add column marked_rmv tinyint(1) default 0 after price;
alter table prices_sales add column removed tinyint(1) default 0 after marked_rmv;

create table ksts (id int primary key auto_increment, ky varchar(255), prd int(10), datev datetime,sts varchar(200));
------------------------------------------------------------------------------------------------------------------
CREATE TABLE products_purchases (
  id int(11) NOT NULL AUTO_INCREMENT,
  product varchar(60) NOT NULL UNIQUE,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id)
);
CREATE TABLE used_products (
  id int(11) NOT NULL AUTO_INCREMENT,
  article varchar(60) NOT NULL,
  product varchar(60) NOT NULL UNIQUE,
  quantity int(100) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (product) REFERENCES products_purchases (product), 
  FOREIGN KEY (article) REFERENCES price_sales (product) 
);
insert into products_purchases (product,user_datetime,iduser) values ('Batata',now(),1);
insert into products_purchases (product,user_datetime,iduser) values ('Sal',now(),1);

insert into used_products (article,product,quantity,user_datetime,iduser) values ('Amburgue Simples','Batata',2,now(),1);

alter table products_purchases add column marked_rmv tinyint(1) default 0 after product;
alter table products_purchases add column removed tinyint(1) default 0 after marked_rmv;

alter table used_products add column marked_rmv tinyint(1) default 0 after quantity;
alter table used_products add column removed tinyint(1) default 0 after marked_rmv;

-----------------------------------------------------------------------------------------------------
CREATE TABLE clients_requests (
  id int(11) NOT NULL AUTO_INCREMENT,
  place int(10) NOT NULL,
  req_time varchar(40) NOT NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  plc_state int(2),
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE clients_requests_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  place int(10) NOT NULL,
  req_time varchar(40) NOT NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  plc_state int(2),
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE clients_requests_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  place int(10) NOT NULL,
  req_time varchar(40) NOT NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity int(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  plc_state int(2),
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
------------------------------------------------------------------------------
CREATE TABLE ms_requests (
  id int(11) NOT NULL AUTO_INCREMENT,
  msname_us_time varchar(60) unique NOT NULL,
  user_datetime datetime NOT NULL,
  plc_state int(2),
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
) ;

CREATE TABLE ms_requests_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  msname_us_time varchar(60) unique NOT NULL,
  user_datetime datetime NOT NULL,
  plc_state int(2),
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
) ;

CREATE TABLE ms_requests_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  msname_us_time varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  plc_state int(2),
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
) ;


alter table clients_requests add column msname_us_time varchar(60) NOT NULL after price;
alter table clients_requests_duplicate add column msname_us_time varchar(60) NOT NULL after price;
alter table clients_requests_events add column msname_us_time varchar(60) NOT NULL after price;


alter table clients_requests add column marked_rmv tinyint(1) default 0 after price;
alter table clients_requests add column removed tinyint(1) default 0 after marked_rmv;
alter table clients_requests_duplicate add column marked_rmv tinyint(1) default 0 after price;
alter table clients_requests_duplicate add column removed tinyint(1) default 0 after marked_rmv;
alter table clients_requests_events add column marked_rmv tinyint(1) default 0 after price;
alter table clients_requests_events add column removed tinyint(1) default 0 after marked_rmv;


--Groupm

alter table products_purchases add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table products_purchases_duplicate add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table products_purchases_events add column groupm varchar(50) NOT NULL default 'NA' after id;

alter table used_products add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table used_products_duplicate add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table used_products_events add column groupm varchar(50) NOT NULL default 'NA' after id;

alter table sales add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table sales_duplicate add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table sales_events add column groupm varchar(50) NOT NULL default 'NA' after id;


alter table purchases_not_used add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table purchases_not_used_duplicate add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table purchases_not_used_events add column groupm varchar(50) NOT NULL default 'NA' after id;

alter table purchases add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table purchases_duplicate add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table purchases_events add column groupm varchar(50) NOT NULL default 'NA' after id;


alter table prices_sales add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table prices_sales_duplicate add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table prices_sales_events add column groupm varchar(50) NOT NULL default 'NA' after id;


CREATE TABLE groups_factories (
  id int(11) NOT NULL AUTO_INCREMENT,
  factory int(10) NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE groups_factories_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  factory int(10) NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE groups_factories_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  factory int(10) NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);

alter table groups_factories modify factory varchar(60) NOT NULL;
alter table groups_factories_duplicate modify factory varchar(60) NOT NULL;
alter table groups_factories_events modify factory varchar(60) NOT NULL;
insert into groups_factories (factory,iduser) values ('CocaCola',1);
insert into groups_factories_duplicate (factory,iduser) values ('CocaCola',1);
insert into groups_factories_events (factory,iduser) values ('CocaCola',1);


CREATE TABLE ms_states (
   id int(11) NOT NULL AUTO_INCREMENT,
   msname_us_time varchar(60) NOT NULL,
   iduser int(11) NOT NULL,
   PRIMARY KEY (id),
   KEY iduser (iduser),
   FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE ms_states_duplicate (
   id int(11) NOT NULL AUTO_INCREMENT,
   msname_us_time varchar(60) NOT NULL,
   iduser int(11) NOT NULL,
   PRIMARY KEY (id),
   KEY iduser (iduser),
   FOREIGN KEY (iduser) REFERENCES users (id)
);

CREATE TABLE ms_states_events (
   id int(11) NOT NULL AUTO_INCREMENT,
   msname_us_time varchar(60) NOT NULL,
   iduser int(11) NOT NULL,
   PRIMARY KEY (id),
   KEY iduser (iduser),
   FOREIGN KEY (iduser) REFERENCES users (id)
);

insert into ms_states (msname_us_time,iduser) values ('empty',1);
insert into ms_states_duplicate (msname_us_time,iduser) values ('empty',1);
insert into ms_states_events (msname_us_time,iduser) values ('empty',1);


 

alter table clients_requests add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table clients_requests_duplicate add column groupm varchar(50) NOT NULL default 'NA' after id;
alter table clients_requests_events add column groupm varchar(50) NOT NULL default 'NA' after id;

CREATE TABLE ms (
   id int(11) NOT NULL AUTO_INCREMENT,
   ms_total int(11) NOT NULL,
   iduser int(11) NOT NULL,
   PRIMARY KEY (id),
   KEY iduser (iduser),
   FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_duplicate (
   id int(11) NOT NULL AUTO_INCREMENT,
   ms_total int(11) NOT NULL,
   iduser int(11) NOT NULL,
   PRIMARY KEY (id),
   KEY iduser (iduser),
   FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_events (
   id int(11) NOT NULL AUTO_INCREMENT,
   ms_total int(11) NOT NULL,
   iduser int(11) NOT NULL,
   PRIMARY KEY (id),
   KEY iduser (iduser),
   FOREIGN KEY (iduser) REFERENCES users (id)
);
insert into ms (ms_total,iduser) values (9,1);
insert into ms_duplicate (ms_total,iduser) values (9,1);
insert into ms_events (ms_total,iduser) values (9,1);

-------------------------------------------------------------------------------------------------------
alter table purchases add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table purchases_duplicate add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table purchases_events add column barcode varchar(50) NOT NULL default 'NA' after price;

alter table prices_sales add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table prices_sales_duplicate add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table prices_sales_events add column barcode varchar(50) NOT NULL default 'NA' after price;

alter table sales add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table sales_duplicate add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table sales_events add column barcode varchar(50) NOT NULL default 'NA' after price;

alter table purchases_not_used add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table purchases_not_used_duplicate add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table purchases_not_used_events add column barcode varchar(50) NOT NULL default 'NA' after price;
-----------------------------------------------------------------------------------------------------------
alter table sales add column tax decimal(8,2) NULL after price;
alter table sales_duplicate add column tax decimal(8,2) NULL after price;
alter table sales_events add column tax decimal(8,2) NULL after price;

alter table sales add column tax_p decimal(8,2) NULL after price;
alter table sales_duplicate add column tax_p decimal(8,2) NULL after price;
alter table sales_events add column tax_p decimal(8,2) NULL after price;


alter table groups_factories add column marked_rmv tinyint(1) default 0 after factory;
alter table groups_factories add column removed tinyint(1) default 0 after marked_rmv;
alter table groups_factories_duplicate add column marked_rmv tinyint(1) default 0 after factory;
alter table groups_factories_duplicate add column removed tinyint(1) default 0 after marked_rmv;
alter table groups_factories_events add column marked_rmv tinyint(1) default 0 after factory;
alter table groups_factories_events add column removed tinyint(1) default 0 after marked_rmv;

alter table ms change column ms_total total int(11);
alter table ms_duplicate change column ms_total total int(11);
alter table ms_events change column ms_total total int(11);
------------------------------------------------------------------------------------------------
alter table purchases add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table purchases_duplicate add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table purchases_events add column p_code varchar(50) NOT NULL default 'NA' after price;

alter table prices_sales add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table prices_sales_duplicate add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table prices_sales_events add column p_code varchar(50) NOT NULL default 'NA' after price;

alter table sales add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table sales_duplicate add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table sales_events add column p_code varchar(50) NOT NULL default 'NA' after price;

alter table purchases_not_used add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table purchases_not_used_duplicate add column p_code varchar(50) NOT NULL default 'NA' after price;
alter table purchases_not_used_events add column p_code varchar(50) NOT NULL default 'NA' after price;

alter table purchases add column comp_prz datetime NULL after price_other;
alter table purchases_duplicate add column comp_prz datetime NULL after price_other;
alter table purchases_events add column comp_prz datetime NULL after price_other;
--------------------------------------------------------------------------------------------------------------------
alter table clients_requests change groupm group_factory varchar(50);
alter table clients_requests_duplicate change groupm group_factory varchar(50);
alter table clients_requests_events change groupm group_factory varchar(50);

alter table products_purchases  change groupm group_factory varchar(50);
alter table products_purchases_duplicate change groupm group_factory varchar(50);
alter table products_purchases_events change groupm group_factory varchar(50);

alter table used_products change groupm group_factory varchar(50);
alter table used_products_duplicate change groupm group_factory varchar(50);
alter table used_products_events change groupm group_factory varchar(50);

alter table sales change groupm group_factory varchar(50);
alter table sales_duplicate change groupm group_factory varchar(50);
alter table sales_events  change groupm group_factory varchar(50);

alter table purchases_not_used change groupm group_factory varchar(50);
alter table purchases_not_used_duplicate change groupm group_factory varchar(50);
alter table purchases_not_used_events change groupm group_factory varchar(50);

alter table purchases  change groupm group_factory varchar(50);
alter table purchases_duplicate change groupm group_factory varchar(50);
alter table purchases_events change groupm group_factory varchar(50);

alter table prices_sales change groupm group_factory varchar(50);
alter table prices_sales_duplicate change groupm group_factory varchar(50);
alter table prices_sales_events change groupm group_factory varchar(50);


alter table clients_requests add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table clients_requests add column p_code varchar(50) NOT NULL default 'NA' after price;

alter table clients_requests_duplicate add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table clients_requests_duplicate add column p_code varchar(50) NOT NULL default 'NA' after price;

alter table clients_requests_events add column barcode varchar(50) NOT NULL default 'NA' after price;
alter table clients_requests_events add column p_code varchar(50) NOT NULL default 'NA' after price;



alter table purchases add column price_cntry varchar(3) NOT NULL default 'NA' after price;
alter table purchases add column price_other decimal(8,2) NOT NULL default '0.00' after price; 
alter table purchases_duplicate add column price_cntry varchar(3) NOT NULL default 'NA' after price;
alter table purchases_duplicate add column price_other decimal(8,2) NOT NULL default '0.00' after price; 
alter table purchases_events add column price_cntry varchar(3) NOT NULL default 'NA' after price;
alter table purchases_events add column price_other decimal(8,2) NOT NULL default '0.00' after price; 


alter table ms_states add column cliente varchar(50) NOT NULL after id;
alter table ms_states_duplicate add column cliente varchar(50) NOT NULL after id;
alter table ms_states_events add column cliente varchar(50) NOT NULL after id;

CREATE TABLE appversion_registration (
   id int(11) NOT NULL AUTO_INCREMENT,
   appversion varchar(50) NULL,
   PRIMARY KEY (id)
);


--------------------------------------------------------------------------------
--04022022
--------------------------------------------------------------------------------
CREATE VIEW prices_sales_lst as select 
 distinct product,id,sector,group_factory,category,prod_type,quantity,price,p_code,barcode,marked_rmv,removed,user_datetime,iduser 
 FROM prices_sales order by id desc;



--------------------------------------------------------------------------------
DROP TABLE organization;
CREATE TABLE organization (
    id int(11) NOT NULL AUTO_INCREMENT,
    org_name varchar(50) NOT NULL,
    org_logo TEXT,
    org_location varchar(50) NOT NULL,
    org_name_rprt TINYINT(1) Default 0,
    org_logo_rprt TINYINT(1) Default 0,
    org_location_rprt TINYINT(1) Default 0, 
    user_datetime datetime NOT NULL,
    iduser int(11) NOT NULL,
    PRIMARY KEY (id),
    KEY iduser (iduser),
    FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE organization_duplicate (
    id int(11) NOT NULL AUTO_INCREMENT,
    org_name varchar(50) NOT NULL,
    org_logo TEXT,
    org_location varchar(50) NOT NULL,
    org_name_rprt TINYINT(1) Default 0,
    org_logo_rprt TINYINT(1) Default 0,
    org_location_rprt TINYINT(1) Default 0, 
    user_datetime datetime NOT NULL,
    iduser int(11) NOT NULL,
    PRIMARY KEY (id),
    KEY iduser (iduser),
    FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE organization_events (
    id int(11) NOT NULL AUTO_INCREMENT,
    org_name varchar(50) NOT NULL,
    org_logo TEXT,
    org_location varchar(50) NOT NULL,
    org_name_rprt TINYINT(1) Default 0,
    org_logo_rprt TINYINT(1) Default 0,
    org_location_rprt TINYINT(1) Default 0, 
    user_datetime datetime NOT NULL,
    iduser int(11) NOT NULL,
    PRIMARY KEY (id),
    KEY iduser (iduser),
    FOREIGN KEY (iduser) REFERENCES users (id)
);
--------------------------------------------------------------------------------
CREATE TABLE deposits (
  id int(11) NOT NULL AUTO_INCREMENT,
  clientname varchar(60) NOT NULL,
  residenty varchar(100) NULL,
  id_number varchar(100) NULL,
  phone varchar(100) NULL,
  observation varchar(255) NULL,
  last_doposit_date varchar(100) NULL, 
  last_doposit_value varchar(100) NULL, 
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE deposits_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  clientname varchar(60) NOT NULL,
  residenty varchar(100) NULL,
  id_number varchar(100) NULL,
  phone varchar(100) NULL,
  observation varchar(255) NULL,
  last_doposit_date varchar(100) NULL, 
  last_doposit_value varchar(100) NULL, 
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE deposits_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  clientname varchar(60) NOT NULL,
  residenty varchar(100) NULL,
  id_number varchar(100) NULL,
  phone varchar(100) NULL,
  observation varchar(255) NULL,
  last_doposit_date varchar(100) NULL, 
  last_doposit_value varchar(100) NULL, 
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
--------------------------------------------------------------------------------
CREATE TABLE depositslist (
  id int(11) NOT NULL AUTO_INCREMENT,
  dsptvalue decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE depositslist_duplicate (
  id int(11) NOT NULL AUTO_INCREMENT,
  dsptvalue decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE depositslist_events (
  id int(11) NOT NULL AUTO_INCREMENT,
  dsptvalue decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser int(11) NOT NULL,
  PRIMARY KEY (id),
  KEY iduser (iduser),
  FOREIGN KEY (iduser) REFERENCES users (id)
);




