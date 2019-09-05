use databasename

/* Insert address procedure */
create definer=`root`@`localhost` procedure `sp_insertaddress`(
	in in_street_name varchar(30),
	in in_street_number int(4),
	in in_city_name varchar(30),
	in in_country_name varchar(30)
)
begin
	
	declare l_street_id int(10) default 0;
	declare l_city_id int(10) default 0;
	declare l_country_id int(10) default 0;
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;
	
	start transaction;
			select id into l_street_id from streets where name = in_street_name;
			select id into l_city_id from cities where name = in_city_name;
			select id into l_country_id from countries where name = in_country_name;
			
			if (l_street_id <> 0 and l_city_id <> 0 and l_country_id <> 0) then
				if not exists (select * from addresses where street_id = l_street_id and street_number = in_street_number and city_id = l_city_id and country_id = l_country_id) then
					insert into addresses (street_id, street_number, city_id, country_id)
					values (l_street_id, in_street_number, l_city_id, l_country_id);
				end if;
			end if;
	commit;

end