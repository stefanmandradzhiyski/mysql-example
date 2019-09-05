use databasename

/* Get full details of all purchased products units for a specific invoice number */
create definer=`root`@`localhost` procedure `sp_getsalesdetails`(
	IN in_invoice_number varchar(15)
)
begin
	select 
	s.invoice_number as 'invoice_number', p.name as 'product_name', p.barcode as 'product_barcode', sh.product_unit_price as 'product_price', 
	sh.product_quantity as 'bought_quantity', sum(sh.product_quantity * sh.product_unit_price) as 'total_price'
	from sales s 
	inner join sales_details sd
	on sd.sale_id = s.id
	inner join products p
	on p.id = sd.product_id
	where s.invoice_number = in_invoice_number
	group by p.barcode;
end