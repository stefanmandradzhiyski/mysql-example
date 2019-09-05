use databasename

/* Insert person procedure */
create definer=`root`@`localhost` procedure `sp_insertperson`(
	in in_first_name varchar(30),
	in in_last_name varchar(30),
	in in_ucn varchar(13),
	in in_street_name varchar(30),
	in in_street_number int(4),
	in in_city_name varchar(30),
	in in_country_name varchar(30)
)
begin
	
	declare l_address_id int(10) default 0;
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;
	
	start transaction;
		if not exists (select * from people where ucn = in_ucn) THEN
		
			call sp_getaddressid(in_street_name, in_street_number, in_city_name, in_country_name, l_address_id);
			
			if (l_address_id <> 0) then
				insert into people (first_name, last_name, ucn, address_id)
				values (in_first_name, in_last_name, in_ucn, l_address_id);
			end if;
		end if;
	commit;

end