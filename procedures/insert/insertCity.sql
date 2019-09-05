use databasename

/*Insert city procedure */
create definer=`root`@`localhost` procedure `sp_insertcity`(
	in in_city_name varchar(30)
)
begin
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;

	start transaction;
		if not exists (select * from cities where name = in_city_name) then
			insert into cities (name) values (in_city_name);
		end if;
	commit;

end