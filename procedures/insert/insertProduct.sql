use databasename

/* Insert product procedure */
create definer=`root`@`localhost` procedure `sp_insertproduct`(
	in in_name varchar(100),
	in in_short_description varchar(250),
	in in_weight decimal(6,3),
	in in_barcode varchar(13),
	in in_quantity int(6),
	in in_price decimal(6,2)
)
begin
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;
	
	start transaction;
		if not exists (select * from products where barcode = in_barcode) then
			insert into products (name, short_description, weight, barcode, quantity, price)
			values (in_name, in_short_description, in_weight, in_barcode, in_quantity, in_price);
		end if;
	commit;

end