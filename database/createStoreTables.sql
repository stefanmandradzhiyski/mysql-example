use databasename

/* Create countries table */
create table if not exists countries (
	id int(10) not null auto_increment,
	name varchar(30) not null,
	constraint countries_pk primary key (id),
	constraint countries_un_name unique key (name)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create cities table */
create table if not exists cities (
	id int(10) not null auto_increment,
	name varchar(30) not null,
	constraint cities_pk primary key (id),
	constraint cities_un_name unique key (name)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create streets table */
create table if not exists streets (
	id int(10) not null auto_increment,
	name varchar(100) not null,
	constraint streets_pk primary key (id),
	constraint streets_un_name unique key (name)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create addresses table */
create table if not exists addresses (
	id int(10) not null auto_increment,
	street_id int(10) not null,
	street_number int(4) not null,
	city_id int(10) not null,
	country_id int(10) not null,
	constraint addresses_pk primary key (id),
	constraint addresses_fk_street foreign key (street_id) references streets(id) on delete restrict on update cascade,
	constraint addresses_fk_city foreign key (city_id) references cities(id) on delete restrict on update cascade,
	constraint addresses_fk_country foreign key (country_id) references countries(id) on delete restrict on update cascade,
	constraint addresses_un_sncc unique key (street_id, street_number, city_id, country_id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create people table */
create table if not exists people (
	id int(10) not null auto_increment,
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	ucn varchar(10) not null,
	address_id int(10) not null,
	constraint people_pk primary key (id),
	constraint people_fk_address foreign key (address_id) references addresses(id) on delete restrict on update cascade,
	constraint people_un_ucn unique key (ucn)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create companies/clients table */
create table if not exists companies (
	id int(10) not null auto_increment,
	name varchar(50) not null,
	unique_identifier varchar(13) not null,
	is_dds_registered bool not null,
	address_id int(10) not null,
	person_id int(10) not null,
	constraint companies_pk primary key (id),
	constraint companies_un_unique_identifier unique key (unique_identifier),
	constraint companies_fk_address foreign key (address_id) references addresses(id) on delete restrict on update cascade,
	constraint companies_fk_person foreign key (person_id) references people(id) on delete restrict on update cascade
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create products table */
create table if not exists products (
	id int(10) not null auto_increment,
	name varchar(100) not null,
	short_description varchar(250) not null,
	weight decimal(6,3) not null,
	barcode varchar(13) not null,
	quantity int(6) not null,
	price decimal(6,2) not null,
	last_updated timestamp not null default current_timestamp on update current_timestamp,
	constraint products_pk primary key (id),
	constraint products_un_barcode unique key (barcode)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create products archive table */
create table if not exists products_archive (
	id int(10) not null auto_increment,
	name varchar(100) null,
	short_description varchar(250) null,
	weight decimal(6,3) null,
	barcode varchar(13) null,
	quantity int(6) null,
	price decimal(6,2) null,
	last_updated timestamp not null default current_timestamp on update current_timestamp,
	constraint products_pk primary key (id)
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create sales table */
create table if not exists sales (
	id int(10) not null auto_increment,
	invoice_number varchar(15) not null,
	sale_date date not null,
	company_id int(10) not null,
	constraint sales_pk primary key (id),
	constraint sales_un_invoice_number unique key (invoice_number),
	constraint sales_fk_company foreign key (company_id) references companies(id) on delete restrict on update cascade
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;

/* Create sales history table */
create table if not exists sales_details (
	sale_id int(10) not null,
	product_id int(10) not null,
	product_unit_price decimal(6,2) not null,
	product_quantity int(6) not null,
	constraint sales_details_fk_sale foreign key (sale_id) references sales(id) on delete restrict on update cascade,
	constraint sales_details_fk_product foreign key (product_id) references products(id) on delete restrict on update cascade
)
engine=innodb
default charset=utf8
collate=utf8_general_ci;
