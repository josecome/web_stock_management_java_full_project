CREATE TABLE appversion_registration (
  id INT IDENTITY PRIMARY KEY,
  appversion varchar(50)   NULL
);
CREATE TABLE users (
  id INT IDENTITY PRIMARY KEY,
  username varchar(20) NOT NULL,
  firstnames varchar(60) NOT NULL,
  surnames varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  status int NOT NULL,
  roles varchar(60) NOT NULL,
  entrydatetime datetime NOT NULL,
  user_register int NOT NULL,
  password varchar(255) NOT NULL,
  user_updated varchar(60)   NULL,
  date_updated datetime   NULL,
  session_token varchar(100)
);
CREATE TABLE users_duplicate (
  id INT IDENTITY PRIMARY KEY,
  username varchar(20) NOT NULL,
  firstnames varchar(60) NOT NULL,
  surnames varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  status int NOT NULL,
  roles varchar(60) NOT NULL,
  entrydatetime datetime NOT NULL,
  user_register int NOT NULL,
  password varchar(255)   NULL,
  user_updated varchar(60)   NULL,
  date_updated datetime   NULL
);
CREATE TABLE users_events (
  id INT IDENTITY PRIMARY KEY,
  username varchar(20) NOT NULL,
  firstnames varchar(60) NOT NULL,
  surnames varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  status int NOT NULL,
  roles varchar(60) NOT NULL,
  entrydatetime datetime NOT NULL,
  user_register int NOT NULL,
  password varchar(255) NOT NULL
);

CREATE TABLE categories (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  category varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE clients (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  clientname varchar(60) NOT NULL,
  client_nr BIGINT NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE clients_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  clientname varchar(60) NOT NULL,
  client_nr BIGINT NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE clients_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  clientname varchar(60) NOT NULL,
  client_nr BIGINT NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE clients_requests (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50) NULL,
  msname_us_time varchar(60) NOT NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  lastqnty varchar(50)   NULL,
  marked_rmv INT,
  removed INT,
  iduser INT NOT NULL, 
  user_datetime datetime NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE clients_requests_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50) NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  lastqnty varchar(50)   NULL,
  marked_rmv INT,
  removed INT,
  msname_us_time varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE clients_requests_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50) NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  lastqnty varchar(50)   NULL,
  marked_rmv INT,
  removed INT,
  msname_us_time varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE deposits (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50)   NULL,
  clientname varchar(60) NOT NULL,
  residenty varchar(100)   NULL,
  id_number varchar(100)   NULL,
  phone varchar(100)   NULL,
  observation varchar(255)   NULL,
  last_doposit_date datetime   ,
  total_payment decimal(8,2) NOT NULL,
  total_used decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE deposits_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50)   NULL,
  clientname varchar(60) NOT NULL,
  residenty varchar(100)   NULL,
  id_number varchar(100)   NULL,
  phone varchar(100)   NULL,
  observation varchar(255)   NULL,
  last_doposit_date datetime   ,
  total_payment decimal(8,2) NOT NULL,
  total_used decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE deposits_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50)   NULL,
  clientname varchar(60) NOT NULL,
  residenty varchar(100)   NULL,
  id_number varchar(100)   NULL,
  phone varchar(100)   NULL,
  observation varchar(255)   NULL,
  last_doposit_date datetime   ,
  total_payment decimal(8,2) NOT NULL,
  total_used decimal(8,2) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE depositslist (
  id INT IDENTITY PRIMARY KEY,
  payment decimal(8,2) NOT NULL,
  deposit_id INT NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  withdrawals decimal(8,2) NOT NULL,
  withdrawals_purpose varchar(100),  
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (deposit_id) REFERENCES deposits (id)
);
CREATE TABLE depositslist_duplicate (
  id INT IDENTITY PRIMARY KEY,
  payment decimal(8,2) NOT NULL,
  deposit_id INT NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  withdrawals decimal(8,2) NOT NULL,
  withdrawals_purpose varchar(100) NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (deposit_id) REFERENCES deposits (id)
);
CREATE TABLE depositslist_events (
  id INT IDENTITY PRIMARY KEY,
  payment decimal(8,2) NOT NULL,
  deposit_id INT NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  withdrawals decimal(8,2) NOT NULL,
  withdrawals_purpose varchar(100) NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (deposit_id) REFERENCES deposits (id)
);
CREATE TABLE expenses (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  prod_type varchar(60) NOT NULL,
  price decimal(8,2) NOT NULL,
  marked_rmv INT,
  removed INT,
  observation varchar(255) NOT NULL,
  expense_date date   NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE expenses_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  prod_type varchar(60) NOT NULL,
  price decimal(8,2) NOT NULL,
  marked_rmv INT,
  removed INT,
  observation varchar(255) NOT NULL,
  expense_date date   NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE expenses_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  prod_type varchar(60) NOT NULL,
  price decimal(8,2) NOT NULL,
  marked_rmv INT,
  removed INT,
  observation varchar(255) NOT NULL,
  expense_date date   NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,  
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE groups_factories (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  factory varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  marked_rmv INT,
  removed INT,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE groups_factories_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  factory varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  marked_rmv INT,
  removed INT,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE groups_factories_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  factory varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  marked_rmv INT,
  removed INT,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ksts (
  id INT IDENTITY PRIMARY KEY,
  ky varchar(255)   NULL,
  prd int NULL,
  datev datetime   NULL,
  sts varchar(200)   NULL,
  cnmc VARCHAR(1000000),
  cnmc2 VARCHAR(1000000),
  cnmc3 VARCHAR(1000000),
  cnmc4 VARCHAR(1000000),
  lastu datetime NULL,
  user_system_id varchar(255),
  user_system_status INT,
  user_system_subscr VARCHAR(1000000),
  user_system_subscr_day VARCHAR(1000000),
  user_system_rdys VARCHAR(1000000),
  user_system_subscr_e VARCHAR(100),
  user_system_subscr_day_e VARCHAR(100),
  user_system_rdys_e VARCHAR(100)
);
CREATE TABLE language (
  id INT IDENTITY PRIMARY KEY,
  code varchar(60) NOT NULL,
  english varchar(100) NOT NULL,
  portuguese varchar(100) NOT NULL,
  french varchar(100) NOT NULL,
  spanish varchar(100) NOT NULL
);
CREATE TABLE ms (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  total INT   NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  total INT   NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  total INT   NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_requests (
  id INT IDENTITY PRIMARY KEY,
  cliente varchar(50),
  sector varchar(50) NOT NULL,
  msname_us_time varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  plc_state int   NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_requests_duplicate (
  id INT IDENTITY PRIMARY KEY,
  cliente varchar(50) NOT NULL,
  sector varchar(50) NOT NULL,
  msname_us_time varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  plc_state int  NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_requests_events (
  id INT IDENTITY PRIMARY KEY,
  cliente varchar(50) NOT NULL,
  sector varchar(50) NOT NULL,
  msname_us_time varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  plc_state int NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_states (
  id INT IDENTITY PRIMARY KEY,
  cliente varchar(50) NOT NULL,
  sector varchar(50) NOT NULL,
  msname_us_time varchar(60) NOT NULL,
  id_by_sector INT NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_states_duplicate (
  id INT IDENTITY PRIMARY KEY,
  cliente varchar(50) NOT NULL,
  sector varchar(50) NOT NULL,
  msname_us_time varchar(60) NOT NULL,
  id_by_sector INT NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE ms_states_events (
  id INT IDENTITY PRIMARY KEY,
  cliente varchar(50) NOT NULL,
  sector varchar(50) NOT NULL,
  msname_us_time varchar(60) NOT NULL,
  id_by_sector INT NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE organization (
  id INT IDENTITY PRIMARY KEY,
  org_name varchar(50) NOT NULL,
  org_logo VARCHAR(1000000),
  org_location varchar(50) NOT NULL,
  org_name_rprt INT,
  org_logo_rprt INT,
  org_location_rprt INT,
  lnk_download varchar(50) NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE organization_duplicate (
  id INT IDENTITY PRIMARY KEY,
  org_name varchar(50) NOT NULL,
  org_logo VARCHAR(1000000),
  org_location varchar(50) NOT NULL,
  org_name_rprt INT,
  org_logo_rprt INT,
  org_location_rprt INT,
  lnk_download varchar(50) NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE organization_events (
  id INT IDENTITY PRIMARY KEY,
  org_name varchar(50) NOT NULL,
  org_logo VARCHAR(1000000),
  org_location varchar(50) NOT NULL,
  org_name_rprt INT,
  org_logo_rprt INT,
  lnk_download varchar(50) NULL,
  org_location_rprt int,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE prefered_language (
  id INT IDENTITY PRIMARY KEY,
  language varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE product_type (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  prod_type varchar(60) NOT NULL,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL
);
CREATE TABLE products_purchases (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  product varchar(60) NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL
);
CREATE TABLE products_purchases_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  product varchar(60) NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL
);
CREATE TABLE products_purchases_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  product varchar(60) NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL
);
ALTER TABLE products_purchases add UNIQUE (product);
CREATE TABLE prices_sales (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  product varchar(60) NOT NULL,
  category varchar(100)   NULL,
  prod_type varchar(100)   NULL,
  quantity varchar(100)   NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  descount INT,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE prices_sales_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  product varchar(60) NOT NULL,
  category varchar(100)   NULL,
  prod_type varchar(100)   NULL,
  quantity varchar(100)   NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  descount INT,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE prices_sales_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  product varchar(60) NOT NULL,
  category varchar(100)   NULL,
  prod_type varchar(100)   NULL,
  quantity varchar(100) NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  descount INT,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT   NULL,
  price decimal(8,2) NOT NULL,
  price_other decimal(8,2) NOT NULL,
  comp_prz datetime   NULL,
  price_cntry varchar(3) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NULL,
  quant_saled INT,
  lot_art varchar(50),
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  price_other decimal(8,2) NOT NULL,
  comp_prz datetime   NULL,
  price_cntry varchar(3) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NULL,
  quant_saled INT,
  lot_art varchar(50),
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  price_other decimal(8,2) NOT NULL,
  comp_prz datetime   NULL,
  price_cntry varchar(3) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NULL,
  quant_saled INT,
  lot_art varchar(50),
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
ALTER TABLE purchases ALTER COLUMN quant_saled SET DEFAULT 0;
ALTER TABLE purchases_duplicate ALTER COLUMN quant_saled SET DEFAULT 0;
ALTER TABLE purchases_events ALTER COLUMN quant_saled SET DEFAULT 0;
CREATE TABLE purchases_not_used (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT   NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases_not_used_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
CREATE TABLE purchases_not_used_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  barcode varchar(50) NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id)
);
ALTER TABLE clients add UNIQUE (client_nr);
CREATE TABLE sales (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  tax_p decimal(8,2)   NULL,
  tax decimal(8,2)   NULL,
  barcode varchar(50) NOT NULL,
  enrolled_client  varchar(50),
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  aloc_stock int,
  aloc_stck_used int,
  aloc_stock_obs varchar(200)   NULL,
  aloc_stck_used_user_rg INT   NULL,
  iduser INT NOT NULL,
  FOREIGN KEY (iduser) REFERENCES users (id),
  FOREIGN KEY (client_nr) REFERENCES clients (client_nr)
);
CREATE TABLE sales_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  tax_p decimal(8,2)   NULL,
  tax decimal(8,2)   NULL,
  barcode varchar(50) NOT NULL,
  enrolled_client  varchar(50),
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  aloc_stock int,
  aloc_stck_used int,
  aloc_stock_obs varchar(200)   NULL,
  aloc_stck_used_user_rg INT   NULL,
  iduser INT NOT NULL
);
CREATE TABLE sales_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  prod_type varchar(60) NOT NULL,
  category varchar(60) NOT NULL,
  article varchar(60) NOT NULL,
  quantity INT NOT NULL,
  price decimal(8,2) NOT NULL,
  p_code varchar(50) NOT NULL,
  tax_p decimal(8,2)   NULL,
  tax decimal(8,2)   NULL,
  barcode varchar(50) NOT NULL,
  enrolled_client  varchar(50),
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  client_nr bigint NOT NULL,
  aloc_stock int,
  aloc_stck_used int,
  aloc_stock_obs varchar(200)   NULL,
  aloc_stck_used_user_rg INT   NULL,
  iduser INT NOT NULL
);
CREATE TABLE used_products (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  article varchar(60) NOT NULL,
  product varchar(60) NOT NULL,
  quantity INT NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL
);
CREATE TABLE used_products_duplicate (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  article varchar(60) NOT NULL,
  product varchar(60) NOT NULL,
  quantity INT NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL
);
CREATE TABLE used_products_events (
  id INT IDENTITY PRIMARY KEY,
  sector varchar(50) NOT NULL,
  group_factory varchar(50)   NULL,
  article varchar(60) NOT NULL,
  product varchar(60) NOT NULL,
  quantity INT NOT NULL,
  marked_rmv INT,
  removed INT,
  user_datetime datetime NOT NULL,
  iduser INT NOT NULL
);
CREATE TABLE server_contacts (
  id INT IDENTITY PRIMARY KEY,
  last_server_contact_date datetime NOT NULL
);
CREATE VIEW geral AS 
      select 'sales' AS tbl,sales.article AS article,sales.quantity AS quantity,sales.price AS entradas,0 AS saidas,sales.price AS saldo,sales.user_datetime AS user_datetime,sales.sector AS sector from sales where (sales.removed = '0') 
union select 'purchases' AS tbl,purchases.article AS article,purchases.quantity AS quantity,0 AS entradas,purchases.price AS saidas,(0 - purchases.price) AS saldo,purchases.user_datetime AS user_datetime,purchases.sector AS sector from purchases where (purchases.removed = '0') 
union select 'expenses' AS tbl,expenses.prod_type AS prod_type,1 AS quantity,0 AS entradas,expenses.price AS saidas,(0 - expenses.price) AS saldo,expenses.user_datetime AS user_datetime,expenses.sector AS sector from expenses where (expenses.removed = '0') order by user_datetime desc;
CREATE VIEW purchases_ordered_by_id_desc AS select purchases.id AS id,purchases.article AS article,purchases.price AS price,purchases.quantity AS quantity,purchases.sector AS sector from purchases where (purchases.removed = 0) order by purchases.id desc;
CREATE VIEW purchases_last_prices AS select distinct purchases_ordered_by_id_desc.article AS article,cast((purchases_ordered_by_id_desc.price / purchases_ordered_by_id_desc.quantity) as decimal(8,2)) AS cost,purchases_ordered_by_id_desc.sector AS sector from purchases_ordered_by_id_desc;
CREATE VIEW vexpenses AS select expenses.id AS id,expenses.sector AS sector,expenses.prod_type AS prod_type,expenses.price AS price,expenses.marked_rmv AS marked_rmv,expenses.removed AS removed,expenses.observation AS observation,expenses.user_datetime AS user_datetime,expenses.iduser AS iduser from expenses where (expenses.removed = 0);
CREATE VIEW vpurchases AS select purchases.id AS id,purchases.group_factory AS grupo,purchases.p_code AS p_code,purchases.barcode AS barcode,purchases.prod_type AS prod_type,purchases.category AS category,purchases.article AS article,purchases.quantity AS quantity,purchases.price AS price,purchases.price_other AS price_other,purchases.price_cntry AS price_cntry,CAST(purchases.comp_prz AS DATE) AS comp_prz,purchases.user_datetime AS user_datetime,purchases.sector AS sector,purchases.group_factory AS group_factory,((purchases.quantity * prices_sales.price) - purchases.price) AS profit,purchases.marked_rmv AS marked_rmv,purchases.removed AS removed from purchases left join prices_sales on purchases.article = prices_sales.product where purchases.removed = 0;
CREATE VIEW vpurchases_sales AS select 'sales' AS tbl,sales.group_factory AS group_factory,sales.article AS article,sales.quantity AS quantity,sales.price AS entradas,0 AS saidas,sales.price AS saldo,sales.user_datetime AS user_datetime,sales.sector AS sector from sales where (sales.removed = '0') union select 'purchases' AS tbl,purchases.group_factory AS group_factory,purchases.article AS article,purchases.quantity AS quantity,0 AS entradas,purchases.price AS saidas,(0 - purchases.price) AS saldo,purchases.user_datetime AS user_datetime,purchases.sector AS sector from purchases where (purchases.removed = '0');
CREATE VIEW vsales AS select sales.id AS id,sales.sector AS sector,sales.group_factory AS group_factory,sales.prod_type AS prod_type,sales.category AS category,sales.article AS article,sales.quantity AS quantity,sales.price AS price,sales.p_code AS p_code,sales.tax_p AS tax_p,sales.tax AS tax,sales.barcode AS barcode,sales.marked_rmv AS marked_rmv,sales.removed AS removed,sales.user_datetime AS user_datetime,sales.client_nr AS client_nr,sales.iduser AS iduser from sales where (sales.removed = 0);
CREATE VIEW vstock AS select 'sales' AS tbl,sales.group_factory AS group_factory,sales.p_code AS p_code,sales.barcode AS barcode,sales.article AS article,0 AS compras,sales.quantity AS vendas,0 AS invalid,(0 - sales.quantity) AS stock,sales.user_datetime AS user_datetime,sales.sector AS sector from sales where (sales.removed = '0') union select 'purchases' AS tbl,purchases.group_factory AS group_factory,purchases.p_code AS p_code,purchases.barcode AS barcode,purchases.article AS article,purchases.quantity AS compras,0 AS vendas,0 AS invalid,purchases.quantity AS stock,purchases.user_datetime AS user_datetime,purchases.sector AS sector from purchases where (purchases.removed = '0') union select 'purchases_not_used' AS tbl,purchases_not_used.group_factory AS group_factory,purchases_not_used.p_code AS p_code,purchases_not_used.barcode AS barcode,purchases_not_used.article AS article,0 AS compras,0 AS vendas,purchases_not_used.quantity AS invalid,(0 - purchases_not_used.quantity) AS stock,purchases_not_used.user_datetime AS user_datetime,purchases_not_used.sector AS sector from purchases_not_used where (purchases_not_used.removed = '0');
CREATE VIEW vstock2 AS select vstock.group_factory AS group_factory,vstock.article AS article,vstock.p_code AS p_code,vstock.barcode AS barcode,vstock.compras AS compras,vstock.vendas AS vendas,vstock.invalid AS invalid,vstock.stock AS stock,vstock.user_datetime AS user_datetime,vstock.sector AS sector from vstock 
union all select used_products.group_factory AS group_factory,used_products.product AS article,(select p.p_code from purchases p where (s.article = p.article) limit 1) AS p_code,(select p.barcode from purchases p where (s.article = p.article) limit 1) AS barcode,0 AS compras,(0 - used_products.quantity) AS vendas,0 AS invalid,(0 - used_products.quantity) AS stock,s.user_datetime AS user_datetime,s.sector AS sector from sales s left join used_products on s.article = used_products.article where used_products.article is not null and used_products.removed = '0';
INSERT INTO users VALUES (1,'Admin','ADMIN','ADMINISTRATOR','Gestor',1,'cibagumprmbwdnkjqyveshuzoa','2021-11-25 13:06:04',1,'zzzz27qetajjd3esmayfq1xsja2kibnx7nc6jadslq853go0xxu5y17yl8it5w5621csq330p01sp04','Admin','2022-02-18 03:39:13','a');
INSERT INTO users_duplicate VALUES (1,'Admin','ADMIN','ADMINISTRATOR','Gestor',1,'a,b,c,d','2021-11-25 13:06:04',1,'_',NULL,NULL);
INSERT INTO users_events VALUES (1,'Admin','ADMIN','ADMINISTRATOR','Gestor',1,'a,b,c,d','2021-11-25 13:06:04',1,'_');
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (1,'','Ferragens','empty',1,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (2,'','Ferragens','empty',2,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (3,'','Ferragens','empty',3,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (4,'','Ferragens','empty',4,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (5,'','Ferragens','empty',5,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (6,'','Ferragens','empty',6,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (7,'','Ferragens','empty',7,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (8,'','Ferragens','empty',8,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (9,'','Ferragens','empty',9,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (10,'','Ferragens','empty',10,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (11,'','Ferragens','empty',11,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (12,'','Ferragens','empty',12,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (13,'','Ferragens','empty',13,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (14,'','Ferragens','empty',14,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (15,'','Ferragens','empty',15,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (16,'','Ferragens','empty',16,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (17,'','Ferragens','empty',17,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (18,'','Ferragens','empty',18,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (19,'','Ferragens','empty',19,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (20,'','Ferragens','empty',20,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (21,'','Ferragens','empty',21,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (22,'','Ferragens','empty',22,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (23,'','Ferragens','empty',23,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (24,'','Ferragens','empty',24,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (25,'','Ferragens','empty',25,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (26,'','Ferragens','empty',26,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (27,'','Ferragens','empty',27,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (28,'','Ferragens','empty',28,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (29,'','Ferragens','empty',29,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (30,'','Ferragens','empty',30,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (31,'','Ferragens','empty',31,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (32,'','Ferragens','empty',32,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (33,'','Ferragens','empty',33,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (34,'','Ferragens','empty',34,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (35,'','Ferragens','empty',35,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (36,'','Ferragens','empty',36,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (37,'','Ferragens','empty',37,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (38,'','Ferragens','empty',38,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (39,'','Ferragens','empty',39,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (40,'','Ferragens','empty',40,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (41,'','Ferragens','empty',41,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (42,'','Ferragens','empty',42,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (43,'','Ferragens','empty',43,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (44,'','Ferragens','empty',44,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (45,'','Ferragens','empty',45,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (46,'','Ferragens','empty',46,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (47,'','Ferragens','empty',47,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (48,'','Ferragens','empty',48,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (49,'','Ferragens','empty',49,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (50,'','Ferragens','empty',50,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (64,'','Farmacia','empty',1,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (65,'','Farmacia','empty',2,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (66,'','Farmacia','empty',3,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (67,'','Farmacia','empty',4,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (68,'','Farmacia','empty',5,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (69,'','Farmacia','empty',6,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (70,'','Farmacia','empty',7,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (71,'','Farmacia','empty',8,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (72,'','Farmacia','empty',9,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (73,'','Farmacia','empty',10,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (74,'','Farmacia','empty',11,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (75,'','Farmacia','empty',12,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (76,'','Farmacia','empty',13,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (77,'','Farmacia','empty',14,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (78,'','Farmacia','empty',15,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (79,'','Farmacia','empty',16,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (80,'','Farmacia','empty',17,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (81,'','Farmacia','empty',18,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (82,'','Farmacia','empty',19,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (83,'','Farmacia','empty',20,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (84,'','Farmacia','empty',21,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (85,'','Farmacia','empty',22,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (86,'','Farmacia','empty',23,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (87,'','Farmacia','empty',24,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (88,'','Farmacia','empty',25,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (89,'','Farmacia','empty',26,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (90,'','Farmacia','empty',27,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (91,'','Farmacia','empty',28,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (92,'','Farmacia','empty',29,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (93,'','Farmacia','empty',30,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (94,'','Farmacia','empty',31,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (95,'','Farmacia','empty',32,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (96,'','Farmacia','empty',33,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (97,'','Farmacia','empty',34,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (98,'','Farmacia','empty',35,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (99,'','Farmacia','empty',36,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (100,'','Farmacia','empty',37,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (101,'','Farmacia','empty',38,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (102,'','Farmacia','empty',39,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (103,'','Farmacia','empty',40,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (104,'','Farmacia','empty',41,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (105,'','Farmacia','empty',42,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (106,'','Farmacia','empty',43,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (107,'','Farmacia','empty',44,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (108,'','Farmacia','empty',45,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (109,'','Farmacia','empty',46,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (110,'','Farmacia','empty',47,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (111,'','Farmacia','empty',48,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (112,'','Farmacia','empty',49,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (113,'','Farmacia','empty',50,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (127,'','Venda de Pecas','empty',1,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (128,'','Venda de Pecas','empty',2,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (129,'','Venda de Pecas','empty',3,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (130,'','Venda de Pecas','empty',4,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (131,'','Venda de Pecas','empty',5,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (132,'','Venda de Pecas','empty',6,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (133,'','Venda de Pecas','empty',7,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (134,'','Venda de Pecas','empty',8,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (135,'','Venda de Pecas','empty',9,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (136,'','Venda de Pecas','empty',10,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (137,'','Venda de Pecas','empty',11,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (138,'','Venda de Pecas','empty',12,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (139,'','Venda de Pecas','empty',13,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (140,'','Venda de Pecas','empty',14,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (141,'','Venda de Pecas','empty',15,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (142,'','Venda de Pecas','empty',16,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (143,'','Venda de Pecas','empty',17,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (144,'','Venda de Pecas','empty',18,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (145,'','Venda de Pecas','empty',19,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (146,'','Venda de Pecas','empty',20,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (147,'','Venda de Pecas','empty',21,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (148,'','Venda de Pecas','empty',22,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (149,'','Venda de Pecas','empty',23,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (150,'','Venda de Pecas','empty',24,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (151,'','Venda de Pecas','empty',25,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (152,'','Venda de Pecas','empty',26,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (153,'','Venda de Pecas','empty',27,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (154,'','Venda de Pecas','empty',28,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (155,'','Venda de Pecas','empty',29,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (156,'','Venda de Pecas','empty',30,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (157,'','Venda de Pecas','empty',31,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (158,'','Venda de Pecas','empty',32,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (159,'','Venda de Pecas','empty',33,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (160,'','Venda de Pecas','empty',34,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (161,'','Venda de Pecas','empty',35,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (162,'','Venda de Pecas','empty',36,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (163,'','Venda de Pecas','empty',37,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (164,'','Venda de Pecas','empty',38,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (165,'','Venda de Pecas','empty',39,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (166,'','Venda de Pecas','empty',40,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (167,'','Venda de Pecas','empty',41,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (168,'','Venda de Pecas','empty',42,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (169,'','Venda de Pecas','empty',43,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (170,'','Venda de Pecas','empty',44,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (171,'','Venda de Pecas','empty',45,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (172,'','Venda de Pecas','empty',46,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (173,'','Venda de Pecas','empty',47,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (174,'','Venda de Pecas','empty',48,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (175,'','Venda de Pecas','empty',49,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (176,'','Venda de Pecas','empty',50,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (190,'','Mercearia','empty',1,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (191,'','Mercearia','empty',2,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (192,'','Mercearia','empty',3,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (193,'','Mercearia','empty',4,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (194,'','Mercearia','empty',5,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (195,'','Mercearia','empty',6,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (196,'','Mercearia','empty',7,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (197,'','Mercearia','empty',8,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (198,'','Mercearia','empty',9,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (199,'','Mercearia','empty',10,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (200,'','Mercearia','empty',11,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (201,'','Mercearia','empty',12,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (202,'','Mercearia','empty',13,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (203,'','Mercearia','empty',14,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (204,'','Mercearia','empty',15,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (205,'','Mercearia','empty',16,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (206,'','Mercearia','empty',17,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (207,'','Mercearia','empty',18,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (208,'','Mercearia','empty',19,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (209,'','Mercearia','empty',20,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (210,'','Mercearia','empty',21,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (211,'','Mercearia','empty',22,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (212,'','Mercearia','empty',23,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (213,'','Mercearia','empty',24,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (214,'','Mercearia','empty',25,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (215,'','Mercearia','empty',26,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (216,'','Mercearia','empty',27,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (217,'','Mercearia','empty',28,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (218,'','Mercearia','empty',29,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (219,'','Mercearia','empty',30,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (220,'','Mercearia','empty',31,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (221,'','Mercearia','empty',32,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (222,'','Mercearia','empty',33,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (223,'','Mercearia','empty',34,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (224,'','Mercearia','empty',35,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (225,'','Mercearia','empty',36,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (226,'','Mercearia','empty',37,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (227,'','Mercearia','empty',38,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (228,'','Mercearia','empty',39,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (229,'','Mercearia','empty',40,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (230,'','Mercearia','empty',41,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (231,'','Mercearia','empty',42,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (232,'','Mercearia','empty',43,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (233,'','Mercearia','empty',44,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (234,'','Mercearia','empty',45,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (235,'','Mercearia','empty',46,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (236,'','Mercearia','empty',47,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (237,'','Mercearia','empty',48,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (238,'','Mercearia','empty',49,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (239,'','Mercearia','empty',50,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (253,'','Bar','empty',1,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (254,'','Bar','empty',2,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (255,'','Bar','empty',3,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (256,'','Bar','empty',4,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (257,'','Bar','empty',5,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (258,'','Bar','empty',6,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (259,'','Bar','empty',7,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (260,'','Bar','empty',8,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (261,'','Bar','empty',9,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (262,'','Bar','empty',10,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (263,'','Bar','empty',11,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (264,'','Bar','empty',12,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (265,'','Bar','empty',13,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (266,'','Bar','empty',14,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (267,'','Bar','empty',15,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (268,'','Bar','empty',16,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (269,'','Bar','empty',17,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (270,'','Bar','empty',18,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (271,'','Bar','empty',19,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (272,'','Bar','empty',20,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (273,'','Bar','empty',21,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (274,'','Bar','empty',22,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (275,'','Bar','empty',23,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (276,'','Bar','empty',24,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (277,'','Bar','empty',25,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (278,'','Bar','empty',26,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (279,'','Bar','empty',27,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (280,'','Bar','empty',28,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (281,'','Bar','empty',29,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (282,'','Bar','empty',30,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (283,'','Bar','empty',31,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (284,'','Bar','empty',32,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (285,'','Bar','empty',33,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (286,'','Bar','empty',34,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (287,'','Bar','empty',35,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (288,'','Bar','empty',36,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (289,'','Bar','empty',37,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (290,'','Bar','empty',38,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (291,'','Bar','empty',39,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (292,'','Bar','empty',40,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (293,'','Bar','empty',41,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (294,'','Bar','empty',42,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (295,'','Bar','empty',43,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (296,'','Bar','empty',44,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (297,'','Bar','empty',45,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (298,'','Bar','empty',46,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (299,'','Bar','empty',47,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (300,'','Bar','empty',48,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (301,'','Bar','empty',49,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (302,'','Bar','empty',50,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (303,'','Restaurant','empty',1,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (304,'','Restaurant','empty',2,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (305,'','Restaurant','empty',3,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (306,'','Restaurant','empty',4,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (307,'','Restaurant','empty',5,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (308,'','Restaurant','empty',6,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (309,'','Restaurant','empty',7,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (310,'','Restaurant','empty',8,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (311,'','Restaurant','empty',9,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (312,'','Restaurant','empty',10,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (313,'','Restaurant','empty',11,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (314,'','Restaurant','empty',12,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (315,'','Restaurant','empty',13,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (316,'','Restaurant','empty',14,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (317,'','Restaurant','empty',15,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (318,'','Restaurant','empty',16,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (319,'','Restaurant','empty',17,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (320,'','Restaurant','empty',18,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (321,'','Restaurant','empty',19,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (322,'','Restaurant','empty',20,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (323,'','Restaurant','empty',21,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (324,'','Restaurant','empty',22,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (325,'','Restaurant','empty',23,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (326,'','Restaurant','empty',24,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (327,'','Restaurant','empty',25,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (328,'','Restaurant','empty',26,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (329,'','Restaurant','empty',27,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (330,'','Restaurant','empty',28,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (331,'','Restaurant','empty',29,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (332,'','Restaurant','empty',30,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (333,'','Restaurant','empty',31,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (334,'','Restaurant','empty',32,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (335,'','Restaurant','empty',33,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (336,'','Restaurant','empty',34,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (337,'','Restaurant','empty',35,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (338,'','Restaurant','empty',36,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (339,'','Restaurant','empty',37,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (340,'','Restaurant','empty',38,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (341,'','Restaurant','empty',39,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (342,'','Restaurant','empty',40,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (343,'','Restaurant','empty',41,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (344,'','Restaurant','empty',42,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (345,'','Restaurant','empty',43,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (346,'','Restaurant','empty',44,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (347,'','Restaurant','empty',45,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (348,'','Restaurant','empty',46,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (349,'','Restaurant','empty',47,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (350,'','Restaurant','empty',48,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (351,'','Restaurant','empty',49,1);
INSERT INTO ms_states (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (352,'','Restaurant','empty',50,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (1,'','Ferragens','empty',1,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (2,'','Ferragens','empty',2,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (3,'','Ferragens','empty',3,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (4,'','Ferragens','empty',4,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (5,'','Ferragens','empty',5,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (6,'','Ferragens','empty',6,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (7,'','Ferragens','empty',7,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (8,'','Ferragens','empty',8,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (9,'','Ferragens','empty',9,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (10,'','Ferragens','empty',10,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (11,'','Ferragens','empty',11,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (12,'','Ferragens','empty',12,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (13,'','Ferragens','empty',13,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (14,'','Ferragens','empty',14,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (15,'','Ferragens','empty',15,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (16,'','Ferragens','empty',16,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (17,'','Ferragens','empty',17,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (18,'','Ferragens','empty',18,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (19,'','Ferragens','empty',19,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (20,'','Ferragens','empty',20,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (21,'','Ferragens','empty',21,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (22,'','Ferragens','empty',22,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (23,'','Ferragens','empty',23,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (24,'','Ferragens','empty',24,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (25,'','Ferragens','empty',25,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (26,'','Ferragens','empty',26,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (27,'','Ferragens','empty',27,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (28,'','Ferragens','empty',28,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (29,'','Ferragens','empty',29,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (30,'','Ferragens','empty',30,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (31,'','Ferragens','empty',31,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (32,'','Ferragens','empty',32,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (33,'','Ferragens','empty',33,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (34,'','Ferragens','empty',34,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (35,'','Ferragens','empty',35,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (36,'','Ferragens','empty',36,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (37,'','Ferragens','empty',37,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (38,'','Ferragens','empty',38,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (39,'','Ferragens','empty',39,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (40,'','Ferragens','empty',40,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (41,'','Ferragens','empty',41,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (42,'','Ferragens','empty',42,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (43,'','Ferragens','empty',43,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (44,'','Ferragens','empty',44,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (45,'','Ferragens','empty',45,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (46,'','Ferragens','empty',46,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (47,'','Ferragens','empty',47,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (48,'','Ferragens','empty',48,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (49,'','Ferragens','empty',49,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (50,'','Ferragens','empty',50,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (64,'','Farmacia','empty',1,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (65,'','Farmacia','empty',2,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (66,'','Farmacia','empty',3,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (67,'','Farmacia','empty',4,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (68,'','Farmacia','empty',5,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (69,'','Farmacia','empty',6,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (70,'','Farmacia','empty',7,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (71,'','Farmacia','empty',8,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (72,'','Farmacia','empty',9,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (73,'','Farmacia','empty',10,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (74,'','Farmacia','empty',11,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (75,'','Farmacia','empty',12,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (76,'','Farmacia','empty',13,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (77,'','Farmacia','empty',14,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (78,'','Farmacia','empty',15,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (79,'','Farmacia','empty',16,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (80,'','Farmacia','empty',17,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (81,'','Farmacia','empty',18,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (82,'','Farmacia','empty',19,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (83,'','Farmacia','empty',20,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (84,'','Farmacia','empty',21,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (85,'','Farmacia','empty',22,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (86,'','Farmacia','empty',23,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (87,'','Farmacia','empty',24,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (88,'','Farmacia','empty',25,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (89,'','Farmacia','empty',26,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (90,'','Farmacia','empty',27,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (91,'','Farmacia','empty',28,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (92,'','Farmacia','empty',29,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (93,'','Farmacia','empty',30,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (94,'','Farmacia','empty',31,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (95,'','Farmacia','empty',32,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (96,'','Farmacia','empty',33,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (97,'','Farmacia','empty',34,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (98,'','Farmacia','empty',35,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (99,'','Farmacia','empty',36,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (100,'','Farmacia','empty',37,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (101,'','Farmacia','empty',38,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (102,'','Farmacia','empty',39,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (103,'','Farmacia','empty',40,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (104,'','Farmacia','empty',41,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (105,'','Farmacia','empty',42,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (106,'','Farmacia','empty',43,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (107,'','Farmacia','empty',44,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (108,'','Farmacia','empty',45,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (109,'','Farmacia','empty',46,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (110,'','Farmacia','empty',47,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (111,'','Farmacia','empty',48,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (112,'','Farmacia','empty',49,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (113,'','Farmacia','empty',50,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (127,'','Venda de Pecas','empty',1,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (128,'','Venda de Pecas','empty',2,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (129,'','Venda de Pecas','empty',3,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (130,'','Venda de Pecas','empty',4,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (131,'','Venda de Pecas','empty',5,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (132,'','Venda de Pecas','empty',6,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (133,'','Venda de Pecas','empty',7,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (134,'','Venda de Pecas','empty',8,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (135,'','Venda de Pecas','empty',9,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (136,'','Venda de Pecas','empty',10,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (137,'','Venda de Pecas','empty',11,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (138,'','Venda de Pecas','empty',12,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (139,'','Venda de Pecas','empty',13,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (140,'','Venda de Pecas','empty',14,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (141,'','Venda de Pecas','empty',15,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (142,'','Venda de Pecas','empty',16,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (143,'','Venda de Pecas','empty',17,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (144,'','Venda de Pecas','empty',18,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (145,'','Venda de Pecas','empty',19,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (146,'','Venda de Pecas','empty',20,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (147,'','Venda de Pecas','empty',21,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (148,'','Venda de Pecas','empty',22,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (149,'','Venda de Pecas','empty',23,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (150,'','Venda de Pecas','empty',24,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (151,'','Venda de Pecas','empty',25,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (152,'','Venda de Pecas','empty',26,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (153,'','Venda de Pecas','empty',27,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (154,'','Venda de Pecas','empty',28,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (155,'','Venda de Pecas','empty',29,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (156,'','Venda de Pecas','empty',30,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (157,'','Venda de Pecas','empty',31,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (158,'','Venda de Pecas','empty',32,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (159,'','Venda de Pecas','empty',33,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (160,'','Venda de Pecas','empty',34,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (161,'','Venda de Pecas','empty',35,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (162,'','Venda de Pecas','empty',36,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (163,'','Venda de Pecas','empty',37,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (164,'','Venda de Pecas','empty',38,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (165,'','Venda de Pecas','empty',39,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (166,'','Venda de Pecas','empty',40,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (167,'','Venda de Pecas','empty',41,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (168,'','Venda de Pecas','empty',42,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (169,'','Venda de Pecas','empty',43,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (170,'','Venda de Pecas','empty',44,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (171,'','Venda de Pecas','empty',45,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (172,'','Venda de Pecas','empty',46,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (173,'','Venda de Pecas','empty',47,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (174,'','Venda de Pecas','empty',48,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (175,'','Venda de Pecas','empty',49,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (176,'','Venda de Pecas','empty',50,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (190,'','Mercearia','empty',1,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (191,'','Mercearia','empty',2,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (192,'','Mercearia','empty',3,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (193,'','Mercearia','empty',4,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (194,'','Mercearia','empty',5,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (195,'','Mercearia','empty',6,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (196,'','Mercearia','empty',7,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (197,'','Mercearia','empty',8,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (198,'','Mercearia','empty',9,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (199,'','Mercearia','empty',10,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (200,'','Mercearia','empty',11,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (201,'','Mercearia','empty',12,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (202,'','Mercearia','empty',13,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (203,'','Mercearia','empty',14,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (204,'','Mercearia','empty',15,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (205,'','Mercearia','empty',16,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (206,'','Mercearia','empty',17,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (207,'','Mercearia','empty',18,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (208,'','Mercearia','empty',19,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (209,'','Mercearia','empty',20,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (210,'','Mercearia','empty',21,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (211,'','Mercearia','empty',22,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (212,'','Mercearia','empty',23,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (213,'','Mercearia','empty',24,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (214,'','Mercearia','empty',25,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (215,'','Mercearia','empty',26,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (216,'','Mercearia','empty',27,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (217,'','Mercearia','empty',28,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (218,'','Mercearia','empty',29,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (219,'','Mercearia','empty',30,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (220,'','Mercearia','empty',31,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (221,'','Mercearia','empty',32,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (222,'','Mercearia','empty',33,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (223,'','Mercearia','empty',34,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (224,'','Mercearia','empty',35,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (225,'','Mercearia','empty',36,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (226,'','Mercearia','empty',37,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (227,'','Mercearia','empty',38,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (228,'','Mercearia','empty',39,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (229,'','Mercearia','empty',40,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (230,'','Mercearia','empty',41,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (231,'','Mercearia','empty',42,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (232,'','Mercearia','empty',43,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (233,'','Mercearia','empty',44,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (234,'','Mercearia','empty',45,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (235,'','Mercearia','empty',46,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (236,'','Mercearia','empty',47,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (237,'','Mercearia','empty',48,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (238,'','Mercearia','empty',49,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (239,'','Mercearia','empty',50,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (253,'','Bar','empty',1,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (254,'','Bar','empty',2,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (255,'','Bar','empty',3,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (256,'','Bar','empty',4,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (257,'','Bar','empty',5,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (258,'','Bar','empty',6,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (259,'','Bar','empty',7,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (260,'','Bar','empty',8,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (261,'','Bar','empty',9,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (262,'','Bar','empty',10,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (263,'','Bar','empty',11,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (264,'','Bar','empty',12,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (265,'','Bar','empty',13,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (266,'','Bar','empty',14,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (267,'','Bar','empty',15,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (268,'','Bar','empty',16,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (269,'','Bar','empty',17,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (270,'','Bar','empty',18,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (271,'','Bar','empty',19,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (272,'','Bar','empty',20,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (273,'','Bar','empty',21,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (274,'','Bar','empty',22,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (275,'','Bar','empty',23,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (276,'','Bar','empty',24,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (277,'','Bar','empty',25,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (278,'','Bar','empty',26,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (279,'','Bar','empty',27,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (280,'','Bar','empty',28,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (281,'','Bar','empty',29,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (282,'','Bar','empty',30,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (283,'','Bar','empty',31,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (284,'','Bar','empty',32,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (285,'','Bar','empty',33,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (286,'','Bar','empty',34,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (287,'','Bar','empty',35,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (288,'','Bar','empty',36,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (289,'','Bar','empty',37,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (290,'','Bar','empty',38,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (291,'','Bar','empty',39,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (292,'','Bar','empty',40,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (293,'','Bar','empty',41,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (294,'','Bar','empty',42,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (295,'','Bar','empty',43,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (296,'','Bar','empty',44,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (297,'','Bar','empty',45,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (298,'','Bar','empty',46,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (299,'','Bar','empty',47,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (300,'','Bar','empty',48,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (301,'','Bar','empty',49,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (302,'','Bar','empty',50,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (303,'','Restaurant','empty',1,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (304,'','Restaurant','empty',2,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (305,'','Restaurant','empty',3,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (306,'','Restaurant','empty',4,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (307,'','Restaurant','empty',5,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (308,'','Restaurant','empty',6,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (309,'','Restaurant','empty',7,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (310,'','Restaurant','empty',8,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (311,'','Restaurant','empty',9,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (312,'','Restaurant','empty',10,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (313,'','Restaurant','empty',11,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (314,'','Restaurant','empty',12,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (315,'','Restaurant','empty',13,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (316,'','Restaurant','empty',14,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (317,'','Restaurant','empty',15,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (318,'','Restaurant','empty',16,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (319,'','Restaurant','empty',17,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (320,'','Restaurant','empty',18,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (321,'','Restaurant','empty',19,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (322,'','Restaurant','empty',20,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (323,'','Restaurant','empty',21,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (324,'','Restaurant','empty',22,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (325,'','Restaurant','empty',23,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (326,'','Restaurant','empty',24,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (327,'','Restaurant','empty',25,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (328,'','Restaurant','empty',26,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (329,'','Restaurant','empty',27,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (330,'','Restaurant','empty',28,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (331,'','Restaurant','empty',29,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (332,'','Restaurant','empty',30,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (333,'','Restaurant','empty',31,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (334,'','Restaurant','empty',32,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (335,'','Restaurant','empty',33,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (336,'','Restaurant','empty',34,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (337,'','Restaurant','empty',35,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (338,'','Restaurant','empty',36,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (339,'','Restaurant','empty',37,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (340,'','Restaurant','empty',38,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (341,'','Restaurant','empty',39,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (342,'','Restaurant','empty',40,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (343,'','Restaurant','empty',41,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (344,'','Restaurant','empty',42,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (345,'','Restaurant','empty',43,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (346,'','Restaurant','empty',44,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (347,'','Restaurant','empty',45,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (348,'','Restaurant','empty',46,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (349,'','Restaurant','empty',47,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (350,'','Restaurant','empty',48,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (351,'','Restaurant','empty',49,1);
INSERT INTO ms_states_duplicate (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (352,'','Restaurant','empty',50,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (1,'','Ferragens','empty',1,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (2,'','Ferragens','empty',2,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (3,'','Ferragens','empty',3,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (4,'','Ferragens','empty',4,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (5,'','Ferragens','empty',5,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (6,'','Ferragens','empty',6,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (7,'','Ferragens','empty',7,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (8,'','Ferragens','empty',8,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (9,'','Ferragens','empty',9,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (10,'','Ferragens','empty',10,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (11,'','Ferragens','empty',11,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (12,'','Ferragens','empty',12,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (13,'','Ferragens','empty',13,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (14,'','Ferragens','empty',14,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (15,'','Ferragens','empty',15,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (16,'','Ferragens','empty',16,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (17,'','Ferragens','empty',17,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (18,'','Ferragens','empty',18,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (19,'','Ferragens','empty',19,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (20,'','Ferragens','empty',20,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (21,'','Ferragens','empty',21,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (22,'','Ferragens','empty',22,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (23,'','Ferragens','empty',23,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (24,'','Ferragens','empty',24,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (25,'','Ferragens','empty',25,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (26,'','Ferragens','empty',26,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (27,'','Ferragens','empty',27,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (28,'','Ferragens','empty',28,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (29,'','Ferragens','empty',29,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (30,'','Ferragens','empty',30,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (31,'','Ferragens','empty',31,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (32,'','Ferragens','empty',32,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (33,'','Ferragens','empty',33,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (34,'','Ferragens','empty',34,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (35,'','Ferragens','empty',35,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (36,'','Ferragens','empty',36,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (37,'','Ferragens','empty',37,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (38,'','Ferragens','empty',38,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (39,'','Ferragens','empty',39,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (40,'','Ferragens','empty',40,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (41,'','Ferragens','empty',41,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (42,'','Ferragens','empty',42,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (43,'','Ferragens','empty',43,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (44,'','Ferragens','empty',44,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (45,'','Ferragens','empty',45,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (46,'','Ferragens','empty',46,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (47,'','Ferragens','empty',47,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (48,'','Ferragens','empty',48,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (49,'','Ferragens','empty',49,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (50,'','Ferragens','empty',50,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (64,'','Farmacia','empty',1,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (65,'','Farmacia','empty',2,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (66,'','Farmacia','empty',3,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (67,'','Farmacia','empty',4,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (68,'','Farmacia','empty',5,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (69,'','Farmacia','empty',6,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (70,'','Farmacia','empty',7,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (71,'','Farmacia','empty',8,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (72,'','Farmacia','empty',9,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (73,'','Farmacia','empty',10,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (74,'','Farmacia','empty',11,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (75,'','Farmacia','empty',12,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (76,'','Farmacia','empty',13,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (77,'','Farmacia','empty',14,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (78,'','Farmacia','empty',15,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (79,'','Farmacia','empty',16,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (80,'','Farmacia','empty',17,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (81,'','Farmacia','empty',18,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (82,'','Farmacia','empty',19,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (83,'','Farmacia','empty',20,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (84,'','Farmacia','empty',21,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (85,'','Farmacia','empty',22,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (86,'','Farmacia','empty',23,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (87,'','Farmacia','empty',24,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (88,'','Farmacia','empty',25,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (89,'','Farmacia','empty',26,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (90,'','Farmacia','empty',27,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (91,'','Farmacia','empty',28,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (92,'','Farmacia','empty',29,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (93,'','Farmacia','empty',30,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (94,'','Farmacia','empty',31,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (95,'','Farmacia','empty',32,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (96,'','Farmacia','empty',33,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (97,'','Farmacia','empty',34,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (98,'','Farmacia','empty',35,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (99,'','Farmacia','empty',36,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (100,'','Farmacia','empty',37,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (101,'','Farmacia','empty',38,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (102,'','Farmacia','empty',39,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (103,'','Farmacia','empty',40,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (104,'','Farmacia','empty',41,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (105,'','Farmacia','empty',42,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (106,'','Farmacia','empty',43,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (107,'','Farmacia','empty',44,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (108,'','Farmacia','empty',45,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (109,'','Farmacia','empty',46,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (110,'','Farmacia','empty',47,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (111,'','Farmacia','empty',48,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (112,'','Farmacia','empty',49,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (113,'','Farmacia','empty',50,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (127,'','Venda de Pecas','empty',1,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (128,'','Venda de Pecas','empty',2,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (129,'','Venda de Pecas','empty',3,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (130,'','Venda de Pecas','empty',4,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (131,'','Venda de Pecas','empty',5,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (132,'','Venda de Pecas','empty',6,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (133,'','Venda de Pecas','empty',7,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (134,'','Venda de Pecas','empty',8,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (135,'','Venda de Pecas','empty',9,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (136,'','Venda de Pecas','empty',10,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (137,'','Venda de Pecas','empty',11,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (138,'','Venda de Pecas','empty',12,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (139,'','Venda de Pecas','empty',13,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (140,'','Venda de Pecas','empty',14,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (141,'','Venda de Pecas','empty',15,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (142,'','Venda de Pecas','empty',16,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (143,'','Venda de Pecas','empty',17,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (144,'','Venda de Pecas','empty',18,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (145,'','Venda de Pecas','empty',19,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (146,'','Venda de Pecas','empty',20,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (147,'','Venda de Pecas','empty',21,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (148,'','Venda de Pecas','empty',22,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (149,'','Venda de Pecas','empty',23,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (150,'','Venda de Pecas','empty',24,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (151,'','Venda de Pecas','empty',25,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (152,'','Venda de Pecas','empty',26,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (153,'','Venda de Pecas','empty',27,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (154,'','Venda de Pecas','empty',28,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (155,'','Venda de Pecas','empty',29,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (156,'','Venda de Pecas','empty',30,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (157,'','Venda de Pecas','empty',31,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (158,'','Venda de Pecas','empty',32,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (159,'','Venda de Pecas','empty',33,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (160,'','Venda de Pecas','empty',34,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (161,'','Venda de Pecas','empty',35,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (162,'','Venda de Pecas','empty',36,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (163,'','Venda de Pecas','empty',37,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (164,'','Venda de Pecas','empty',38,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (165,'','Venda de Pecas','empty',39,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (166,'','Venda de Pecas','empty',40,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (167,'','Venda de Pecas','empty',41,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (168,'','Venda de Pecas','empty',42,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (169,'','Venda de Pecas','empty',43,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (170,'','Venda de Pecas','empty',44,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (171,'','Venda de Pecas','empty',45,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (172,'','Venda de Pecas','empty',46,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (173,'','Venda de Pecas','empty',47,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (174,'','Venda de Pecas','empty',48,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (175,'','Venda de Pecas','empty',49,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (176,'','Venda de Pecas','empty',50,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (190,'','Mercearia','empty',1,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (191,'','Mercearia','empty',2,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (192,'','Mercearia','empty',3,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (193,'','Mercearia','empty',4,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (194,'','Mercearia','empty',5,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (195,'','Mercearia','empty',6,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (196,'','Mercearia','empty',7,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (197,'','Mercearia','empty',8,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (198,'','Mercearia','empty',9,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (199,'','Mercearia','empty',10,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (200,'','Mercearia','empty',11,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (201,'','Mercearia','empty',12,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (202,'','Mercearia','empty',13,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (203,'','Mercearia','empty',14,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (204,'','Mercearia','empty',15,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (205,'','Mercearia','empty',16,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (206,'','Mercearia','empty',17,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (207,'','Mercearia','empty',18,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (208,'','Mercearia','empty',19,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (209,'','Mercearia','empty',20,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (210,'','Mercearia','empty',21,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (211,'','Mercearia','empty',22,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (212,'','Mercearia','empty',23,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (213,'','Mercearia','empty',24,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (214,'','Mercearia','empty',25,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (215,'','Mercearia','empty',26,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (216,'','Mercearia','empty',27,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (217,'','Mercearia','empty',28,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (218,'','Mercearia','empty',29,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (219,'','Mercearia','empty',30,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (220,'','Mercearia','empty',31,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (221,'','Mercearia','empty',32,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (222,'','Mercearia','empty',33,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (223,'','Mercearia','empty',34,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (224,'','Mercearia','empty',35,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (225,'','Mercearia','empty',36,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (226,'','Mercearia','empty',37,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (227,'','Mercearia','empty',38,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (228,'','Mercearia','empty',39,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (229,'','Mercearia','empty',40,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (230,'','Mercearia','empty',41,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (231,'','Mercearia','empty',42,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (232,'','Mercearia','empty',43,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (233,'','Mercearia','empty',44,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (234,'','Mercearia','empty',45,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (235,'','Mercearia','empty',46,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (236,'','Mercearia','empty',47,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (237,'','Mercearia','empty',48,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (238,'','Mercearia','empty',49,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (239,'','Mercearia','empty',50,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (253,'','Bar','empty',1,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (254,'','Bar','empty',2,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (255,'','Bar','empty',3,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (256,'','Bar','empty',4,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (257,'','Bar','empty',5,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (258,'','Bar','empty',6,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (259,'','Bar','empty',7,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (260,'','Bar','empty',8,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (261,'','Bar','empty',9,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (262,'','Bar','empty',10,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (263,'','Bar','empty',11,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (264,'','Bar','empty',12,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (265,'','Bar','empty',13,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (266,'','Bar','empty',14,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (267,'','Bar','empty',15,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (268,'','Bar','empty',16,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (269,'','Bar','empty',17,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (270,'','Bar','empty',18,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (271,'','Bar','empty',19,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (272,'','Bar','empty',20,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (273,'','Bar','empty',21,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (274,'','Bar','empty',22,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (275,'','Bar','empty',23,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (276,'','Bar','empty',24,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (277,'','Bar','empty',25,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (278,'','Bar','empty',26,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (279,'','Bar','empty',27,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (280,'','Bar','empty',28,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (281,'','Bar','empty',29,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (282,'','Bar','empty',30,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (283,'','Bar','empty',31,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (284,'','Bar','empty',32,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (285,'','Bar','empty',33,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (286,'','Bar','empty',34,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (287,'','Bar','empty',35,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (288,'','Bar','empty',36,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (289,'','Bar','empty',37,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (290,'','Bar','empty',38,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (291,'','Bar','empty',39,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (292,'','Bar','empty',40,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (293,'','Bar','empty',41,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (294,'','Bar','empty',42,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (295,'','Bar','empty',43,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (296,'','Bar','empty',44,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (297,'','Bar','empty',45,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (298,'','Bar','empty',46,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (299,'','Bar','empty',47,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (300,'','Bar','empty',48,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (301,'','Bar','empty',49,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (302,'','Bar','empty',50,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (303,'','Restaurant','empty',1,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (304,'','Restaurant','empty',2,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (305,'','Restaurant','empty',3,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (306,'','Restaurant','empty',4,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (307,'','Restaurant','empty',5,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (308,'','Restaurant','empty',6,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (309,'','Restaurant','empty',7,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (310,'','Restaurant','empty',8,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (311,'','Restaurant','empty',9,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (312,'','Restaurant','empty',10,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (313,'','Restaurant','empty',11,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (314,'','Restaurant','empty',12,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (315,'','Restaurant','empty',13,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (316,'','Restaurant','empty',14,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (317,'','Restaurant','empty',15,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (318,'','Restaurant','empty',16,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (319,'','Restaurant','empty',17,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (320,'','Restaurant','empty',18,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (321,'','Restaurant','empty',19,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (322,'','Restaurant','empty',20,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (323,'','Restaurant','empty',21,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (324,'','Restaurant','empty',22,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (325,'','Restaurant','empty',23,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (326,'','Restaurant','empty',24,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (327,'','Restaurant','empty',25,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (328,'','Restaurant','empty',26,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (329,'','Restaurant','empty',27,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (330,'','Restaurant','empty',28,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (331,'','Restaurant','empty',29,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (332,'','Restaurant','empty',30,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (333,'','Restaurant','empty',31,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (334,'','Restaurant','empty',32,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (335,'','Restaurant','empty',33,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (336,'','Restaurant','empty',34,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (337,'','Restaurant','empty',35,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (338,'','Restaurant','empty',36,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (339,'','Restaurant','empty',37,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (340,'','Restaurant','empty',38,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (341,'','Restaurant','empty',39,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (342,'','Restaurant','empty',40,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (343,'','Restaurant','empty',41,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (344,'','Restaurant','empty',42,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (345,'','Restaurant','empty',43,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (346,'','Restaurant','empty',44,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (347,'','Restaurant','empty',45,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (348,'','Restaurant','empty',46,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (349,'','Restaurant','empty',47,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (350,'','Restaurant','empty',48,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (351,'','Restaurant','empty',49,1);
INSERT INTO ms_states_events (id,cliente,sector,msname_us_time,id_by_sector,iduser) VALUES (352,'','Restaurant','empty',50,1);
insert into organization (id,org_name,org_logo,org_location,org_name_rprt,org_logo_rprt,org_location_rprt,lnk_download,user_datetime,iduser)  values (0,'AAAA','data:image/bmpbase64,Qk26YQAAAAAAADYAAAAoAAAAaQAAAE8AAAABABgAAAAAAIRhAAAAAAAAAAAAAAAAAAAAAAAAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AB3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtR3mtQAd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUd5rUAHea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1Hea1AA==','BBBB','0','0','0','localhost',CURRENT_DATE,1);
insert into prefered_language (language,user_datetime,iduser) VALUES ('Default',CURRENT_DATE,1);
CREATE INDEX index_client_nr ON clients (client_nr);
CREATE INDEX indx1  ON  prices_sales (sector);
CREATE INDEX indx2  ON  sales (sector);
CREATE INDEX indx3  ON  purchases (sector);
CREATE INDEX indx4  ON  expenses (sector);
CREATE INDEX indx5  ON  clients (sector);
CREATE INDEX indx6  ON  clients_requests (sector);
CREATE INDEX indx7  ON  deposits (sector);
CREATE INDEX indx8  ON  groups_factories (sector);
CREATE INDEX indx9  ON  ms (sector);
CREATE INDEX indx10  ON  product_type (sector);
CREATE INDEX indx11  ON  products_purchases (sector);
CREATE INDEX indx12  ON  prices_sales (sector);
CREATE INDEX indx13  ON  purchases_not_used (sector);
CREATE INDEX indx14  ON  prices_sales (user_datetime);
CREATE INDEX indx15 ON  sales (user_datetime);
CREATE INDEX indx16  ON  purchases (user_datetime);
CREATE INDEX indx17  ON  expenses (user_datetime);
CREATE INDEX indx18  ON  clients (user_datetime);
CREATE INDEX indx19  ON  clients_requests (user_datetime);
CREATE INDEX indx20  ON  deposits (user_datetime);
CREATE INDEX indx21  ON  groups_factories (user_datetime);
CREATE INDEX indx22  ON  ms (user_datetime);
CREATE INDEX indx23  ON  product_type (user_datetime);
CREATE INDEX indx24  ON  products_purchases (user_datetime);
CREATE INDEX indx25  ON  prices_sales (user_datetime);
CREATE INDEX indx26  ON  purchases_not_used (user_datetime);
CREATE INDEX indx27  ON  prices_sales (iduser);
CREATE INDEX indx28  ON  sales (iduser);
CREATE INDEX indx29  ON  purchases (iduser);
CREATE INDEX indx30  ON  expenses (iduser);
CREATE INDEX indx31  ON  clients (iduser);
CREATE INDEX indx32  ON  clients_requests (iduser);
CREATE INDEX indx33  ON  deposits (iduser);
CREATE INDEX indx34  ON  groups_factories (iduser);
CREATE INDEX indx35  ON  ms (iduser);
CREATE INDEX indx36  ON  product_type (iduser);
CREATE INDEX indx37  ON  products_purchases (iduser);
CREATE INDEX indx38  ON  prices_sales (iduser);
CREATE INDEX indx39  ON  purchases_not_used (iduser);
CREATE INDEX indx40  ON  prices_sales (removed);
CREATE INDEX indx41  ON  sales (removed);
CREATE INDEX indx42  ON  purchases (removed);
CREATE INDEX indx43  ON  expenses (removed);
CREATE INDEX indx47  ON  groups_factories (removed);
CREATE INDEX indx50  ON  products_purchases (removed);
CREATE INDEX indx51  ON  prices_sales (removed);                    
CREATE INDEX indx53  ON  prices_sales (product);
CREATE INDEX indx54  ON  sales (article);
CREATE INDEX indx55  ON  purchases (article);
CREATE INDEX indx56  ON  prices_sales (p_code);
CREATE INDEX indx57  ON  sales (p_code);
CREATE INDEX indx58  ON  purchases (p_code);
CREATE INDEX indx59  ON  prices_sales (barcode);
CREATE INDEX indx60  ON  sales (barcode);
CREATE INDEX indx61  ON  purchases (barcode);
CREATE INDEX indx62  ON  prices_sales (group_factory);
CREATE INDEX indx63  ON  sales (group_factory);
CREATE INDEX indx64  ON  purchases (group_factory);
CREATE INDEX indx52  ON  purchases_not_used (removed);












