use databasename

/* Get all details about specific product */
create definer=`root`@`localhost` procedure `sp_getproductdetails`(
	in in_product_name varchar(100)
)
begin
	select * from products where name like concat('%', in_product_name, '%');
end