use databasename

/* Insert country procedure */
create definer=`root`@`localhost` procedure `sp_insertcountry`(
	in in_country_name varchar(30)
)
begin
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;

	start transaction;
		if not exists (select * from countries where name = in_country_name) then
			insert into countries (name) values (in_country_name);
		end if;
	commit;

end