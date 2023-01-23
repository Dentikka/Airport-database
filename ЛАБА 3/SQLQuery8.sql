use a4;


drop table if exists airline;

 create table airline (
	airline_id	integer primary key,	 

 );

 insert into airline values (2);
 insert into airline values(3);

select * from airline;


drop table if exists airline1;


select cast(airline_id as decimal(5, 2)) as airline_id1 into airline1 from airline;

select * from airline1;

