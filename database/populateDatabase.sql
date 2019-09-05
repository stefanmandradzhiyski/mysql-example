use database

/* Populate countries table */
call sp_insertcountry('Bulgaria');

/* Populate cities table */
call sp_insertcity('Plovdiv');

/* Populate streets table */
call sp_insertstreet('bul. Maritsa');

/* Populate addresses table */
call sp_insertaddress('bul. Maritsa', 162, 'Plovdiv', 'Bulgaria');

/* Populate people table */
call sp_insertperson('Stefan', 'Mandradzhiyski', '9511112106', 'bul. Maritsa', 162, 'Plovdiv', 'Bulgaria');

/* Populate companies table */
call sp_insertcompany('SNMITech', '1234567890123', true, 'bul. Maritsa', 162, 'Plovdiv', 'Bulgaria', '9511112106');

/* Populate products table */
call sp_insertproduct('PS4 Pro', 'The best 4K gaming console', 4.675, '1234567890', 100, 769.897);

/* Create an order (Populate sales and sales details tables) */
call sp_insertsalesdetails('123456789012341', '1234567890123', '1234567890', '1');