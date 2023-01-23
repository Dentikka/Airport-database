Set dateformat ymd;
use Airport2;


-------------------1-----------------удалить рейс номер 17
/*
select * from flight

delete from flight
	where flight_id = 17;

select * from flight;
*/


------------------2------------------удалить из базы самолёт номер 77
/*
select * from aircraft
select * from flight 
	

delete from aircraft 
	where aircraft_id = 77;

select * from aircraft
select * from flight;
*/


------------------3------------------удалить услуги, производящиеся между 7:00 и 11:00 13 октября 
/*
select * from aircraft_service 

declare @desired_date date;
	set @desired_date = '2020-10-13';

declare @desired_start_time time;
	set @desired_start_time = '07:00:00'

declare @desired_end_time time;
	set @desired_end_time = '11:00:00'


delete from aircraft_Service
	where date = @desired_date
	and start_time >= @desired_start_time
	and end_time <= @desired_end_time

select * from aircraft_service 
*/

/*проверка
use air3

drop table if exists table2;
drop table if exists table1;


create table table1 (A int not null primary key, B int)

insert into table1 values(5, 5)
insert into table1 values(6, 5)
insert into table1 values(7, 6)

select * from table1

create table table2  (C int)

alter table table2
 add constraint fk_c_a foreign key (C)
 references table1 (A)
 on delete cascade

 insert into table2 values(6)

 select * from table2

delete from table1
where A > 5

select * from table1
select * from table2
*/




