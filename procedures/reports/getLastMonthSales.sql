use databasename

/* Get all sales from a particular company for the past month */
create definer=`root`@`localhost` procedure `sp_getlastmonthsales`(
	IN in_company_name varchar(50)
)
begin
	select s.invoice_number, c.name from companies c
	inner join sales s
	on s.company_id = c.id
	where c.name = in_company_name and month(s.sale_date) = month(current_date() - interval 1 month);
end