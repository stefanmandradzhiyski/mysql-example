use databasename

/* Create specific product archive */
create definer=`snmi`@`localhost` trigger `createarchive` after update on `products` for each row 
begin
	insert into products_archive (name, short_description, weight, barcode, quantity, price)
	values (old.name, old.short_description, old.weight, old.barcode, old.quantity, old.price);
end