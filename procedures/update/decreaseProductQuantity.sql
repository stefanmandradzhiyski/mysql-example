use databasename

/* Decrease product's quantity procedure */
create definer=`root`@`localhost` procedure `sp_decreaseproductquantity`(
	in in_product_barcode varchar(13),
	in in_quantity int (6)
)
begin
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;
	
	start transaction;
		update products set quantity = quantity - in_quantity where barcode = in_product_barcode;
	commit;

end