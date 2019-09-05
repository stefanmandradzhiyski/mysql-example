use databasename

/* Get details about all last month sold products */
create definer=`root`@`localhost` procedure `sp_getmonthsoldquantity`()
begin
	select p.name as 'product_name', sum(sd.product_quantity) as 'total_sold_quantity', s.sale_date as 'sale_date' from sales_details sd
	inner join products p
	on sd.product_id = p.id
	inner join sales s
	on sd.sale_id = s.id
	where month(s.sale_date) = month(current_date() - interval 1 month)
	group by sd.product_id;
end