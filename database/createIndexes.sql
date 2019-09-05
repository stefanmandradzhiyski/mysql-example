use databasename

/* Create B-Tree index for product name */
create index `products_name_IDX` using BTREE on products (name);

/* Create B-Tree index for invoice number in sale */
create index `sales_invoice_number_IDX` using BTREE on sales (invoice_number);

/* Create Hash index for name in company */
create index `companies_name_IDX` using BTREE on companies (name);