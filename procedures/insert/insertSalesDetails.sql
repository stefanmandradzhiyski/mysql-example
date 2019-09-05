use databasename

/* Insert sales details and update product quantity procedure */
create definer=`root`@`localhost` procedure `sp_insertsalesdetails`(	
	in in_invoice_number varchar(15),
	in in_unique_identifier varchar(13),
	in in_product_barcode varchar(13),
	in in_product_quantity int(6)
)
begin
	
	declare l_sale_id int(10) default 0;
	declare l_product_id int(10) default 0;
	declare l_product_price decimal(6,2) default 0.00;
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;
	
	start transaction;

		call store.sp_insertsale(in_invoice_number, in_unique_identifier, l_sale_id);

		select id, price into l_product_id, l_product_price from products where barcode = in_product_barcode;
	
		insert into sales_details (sale_id, product_id, product_unit_price, product_quantity) values (l_sale_id, l_product_id, l_product_price, in_product_quantity);
	
		update products set quantity = quantity - in_product_quantity where id = l_product_id;
	
	commit;

end