use databasename

/* Insert company procedure */
create definer=`root`@`localhost` procedure `sp_insertcompany`(
	in in_name varchar(50),
	in in_unique_identifier varchar(13),
	in in_is_dds_registered bool,
	in in_street_name varchar(30),
	in in_street_number int(4),
	in in_city_name varchar(30),
	in in_country_name varchar(30),
	in in_person_ucn varchar(10)
)
begin
	
	declare l_address_id int(10) default 0;
	declare l_person_id int(10) default 0;
	
	declare exit handler for sqlexception, sqlwarning
	begin
		rollback;
	end;
	
	start transaction;
		if not exists (select * from companies where unique_identifier = in_unique_identifier) THEN
		
			call sp_getaddressid(in_street_name, in_street_number, in_city_name, in_country_name, l_address_id);
			select id into l_person_id from people where ucn = in_person_ucn;
		
			if (l_address_id <> 0 and l_person_id <> 0) then
				insert into companies (name, unique_identifier, is_dds_registered, address_id, person_id)
				values (in_name, in_unique_identifier, in_is_dds_registered, l_address_id, l_person_id);
			end if;
		end if;
	commit;

end