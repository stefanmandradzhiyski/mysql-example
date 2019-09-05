use databasename

/* Insert street procedure */
create definer=`root`@`localhost` procedure `sp_insertstreet`(
	in in_street_name varchar(100)
)
begin
	
	declare exit handler for sqlexception, sqlwarning
	begin
	  rollback;
	end;
	
	start transaction;
		if not exists (select * from streets where name = in_street_name) then
			insert into streets(name) values (in_street_name);
		end if;
	commit;

end