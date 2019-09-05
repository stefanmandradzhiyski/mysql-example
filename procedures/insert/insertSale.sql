use databasename

/* Insert sale procedure */
create definer=`root`@`localhost` procedure `sp_insertsale`(
	in in_invoice_number varchar(15),
	in in_unique_identifier varchar(13),
	out out_sale_id int(10)
)
begin
	
	declare l_company_id int(10) default 0;
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;
	
	start transaction;
		if not exists (select * from sales where invoice_number = in_invoice_number) then
			select id into l_company_id from companies where unique_identifier = in_unique_identifier;
			if (l_company_id <> 0) then
				insert into sales (invoice_number, sale_date, company_id) values (in_invoice_number, current_date(), l_company_id);
			end if;
		end if;
	
		select id into out_sale_id from sales where invoice_number = in_invoice_number;
	commit;

end