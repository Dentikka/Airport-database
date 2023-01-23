set dateformat dmy

use Airport;     

drop table if exists route;
drop table if exists flight;
drop table if exists maintenance;
drop table if exists slot;
drop table if exists runway_tariff;
drop table if exists aircraft_service;
drop table if exists parking_service;
drop table if exists parking_equipment;
drop table if exists parking;
drop table if exists airfield_service_equipment;
drop table if exists parking_tariff;
drop table if exists aircraft;
drop table if exists model;
drop table if exists airline;




/*
create table  flight (
	flight_id	integer identity primary key,	 
	date	date, 
	beginning	time,	 
	finishing	time,	 
	slot_id	integer,	 
	aircraft_id	integer,	 
	route_id	integer,	 
	terminal	varchar(50),	 
	gate	integer,	 
	sold_tickets	integer	
 );


 create table slot (
	slot_id	integer identity primary key,
	date	date,	 
	beginning_time	time,	 
	end_time	time,	 
	aircraft_model_id	integer,	 
	airline_id	integer,	 	 
	tariff_id integer
 );


 create table airline (
	airline_id	integer identity primary key,	 
	name	varchar(50)	
 );


 create table model (
	model_id	integer identity primary key, 
	mark	varchar(50),	 
	model	varchar(50),	 
	max_distance	integer,	 
	average_speed	integer,	 
	number_of_seats	integer
);


create table aircraft (
	aircraft_id	integer identity primary key, 
	airline_id	integer,	 
	model_id	integer
);


create table aircraft_service (
	aircraft_service_id integer identity primary key,
	aircraft_id	integer, 
	service_id	integer,	 
	date	date,	 
	start_time	time,	 
	end_time	time,	 
);


create table parking_service (
	service_id	integer identity primary key,	 
	parking_equipment_id	integer,	 
	model_id	integer,	 
	price	integer
);


create table parking_equipment (
	parking_equipment_id	integer identity primary key,	 
	equipment_type_id	integer,	 
	parking_zone_id	integer
);


create table parking (
	zone_id	integer identity primary key, 
	aircraft_id	integer	 ,
	starting_datetime	datetime,	 
	ending_datetime	datetime,	 
	tariff_id	integer
);


create table maintenance (
	slot_id	integer,	 
	type_id	integer
);


create table airfield_service_equipment (
	type_id	integer identity primary key,	 
	name	varchar(50),	 
	quantity	integer,	 	 
	expence_last_month	integer
);


create table parking_tariff (
	tariff_id	integer identity primary key,	 
	name	varchar(50),	 
	starting_date	date,	 
	ending_date	date,	 
	price_per_day	integer,
);


create table runway_tariff (
	tariff_id	integer identity primary key,	 
	name	varchar(50),	 
	starting_date	date,	 
	ending_date	date,	 
	price_per_hour	integer,
);


create table route (
	route_id integer identity primary key,
	name varchar(50),
	distance integer,
	type varchar(50)
);


alter table flight add 
	constraint fk_flight_slot_id foreign key (slot_id)
	references slot (slot_id) 
	on delete cascade
	on update cascade,
	constraint fk_flight_aircraft_id foreign key (aircraft_id)
	references aircraft (aircraft_id) 
	on delete cascade
	on update cascade,
	constraint fk_flight_route_id foreign key (route_id)
	references route (route_id)
	;


alter table maintenance add 
	constraint fk_maintenance_slot_id foreign key (slot_id)
	references slot (slot_id)
	on delete cascade
	on update cascade,
	constraint fk_maintenance_handling_type_id foreign key (type_id)
	references airfield_service_equipment (type_id)
	on delete cascade
	on update cascade;


alter table slot add 
	constraint fk_slot_aircraft_model_id foreign key (aircraft_model_id)
	references model (model_id)
	on delete cascade
	on update cascade,
	constraint fk_slot_airline_id foreign key (airline_id)
	references airline (airline_id)
	on delete cascade
	on update cascade,
	constraint fk_slot_tariff_id foreign key (tariff_id)
	references runway_tariff (tariff_id)
	on delete cascade
	on update cascade;


alter table aircraft_service add 
	constraint fk_aircraft_parking_service_aircraft_id foreign key (aircraft_id)
	references aircraft (aircraft_id)
	on delete cascade
	on update cascade,
	constraint fk_aircraft_parking_service_service_id foreign key (service_id)
	references parking_service (service_id)
	on delete cascade
	on update cascade;


alter table parking_service add 
	constraint fk_parking_service foreign key (parking_equipment_id)
	references  parking_equipment (parking_equipment_id)
	on delete cascade
	on update cascade;


alter table parking_equipment add 
	constraint fk_parking_equipment_equipment_type_id foreign key (equipment_type_id)
	references airfield_service_equipment (type_id)
	on delete cascade
	on update cascade,
	constraint fk_parking_equipment_parking_zone_id foreign key (parking_zone_id)
	references parking (zone_id)
	on delete cascade
	on update cascade;


alter table parking add 
	constraint fk_parking_tariff_id foreign key (tariff_id)
	references parking_tariff (tariff_id)
	on delete cascade
	on update cascade,
	constraint fk_parking_aircraft_id foreign key (aircraft_id)
	references aircraft (aircraft_id)
	on delete no action -- без каскада
	on update no action; -- без каскада


alter table aircraft add 
	constraint fk_aircraft_model_id foreign key (model_id)
	references model (model_id)
	on delete no action -- без каскада
	on update no action  -- без каскада

alter table aircraft add
	constraint fk_aircraft_airline_id foreign key (airline_id)
	references airline (airline_id)
	on delete no action -- без каскада
	on update no action; --  без каскада

	*/

/*

insert into airline values ( 'јэрофлот');
insert into airline values ( '”ральскиие авиалинии');
insert into airline values ( 'ѕобеда');
insert into airline values ( 'S7');
insert into airline values ( 'Red Wings');
insert into airline values ( 'Nordwind');
insert into airline values ( '–услайн');


insert into model values ( 'boeing', '737-400', 4000, 800, 159);
insert into model values ( 'boeing', '737-800', 5500, 830, 200);
insert into model values ( 'boeing', '747-100', 7200, 850, 490);
insert into model values ( 'boeing', '777-200', 6000, 800, 350);
insert into model values ( 'boeing', '787-100', 11000, 850, 490);
insert into model values ( 'airbus', 'A310', 4000, 800, 279);
insert into model values ( 'boeing', 'A320', 6000, 800, 289);
insert into model values ( 'boeing', 'A350', 10000, 800, 310);
insert into model values ( '“уполев', '“у-204', 4000, 800, 159);
insert into model values ( '—ухой', '—уперджет-100', 3000, 830, 98);


insert into aircraft values ( 1, 1);
insert into aircraft values ( 1, 1);
insert into aircraft values ( 1, 1);
insert into aircraft values ( 1, 2);
insert into aircraft values ( 1, 2);
insert into aircraft values ( 1, 2);
insert into aircraft values ( 1, 2);
insert into aircraft values ( 1, 2);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 3);
insert into aircraft values ( 1, 4);
insert into aircraft values ( 1, 4);
insert into aircraft values ( 1, 4);
insert into aircraft values ( 1, 4);
insert into aircraft values ( 1, 4);
insert into aircraft values ( 1, 4);
insert into aircraft values ( 1, 4);
insert into aircraft values ( 1, 5);
insert into aircraft values ( 1, 5);
insert into aircraft values ( 1, 5);
insert into aircraft values ( 1, 5);
insert into aircraft values ( 1, 5);
insert into aircraft values ( 1, 5);
insert into aircraft values ( 1, 6);
insert into aircraft values ( 1, 6);
insert into aircraft values ( 1, 6);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 1, 8);
insert into aircraft values ( 1, 8);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 9);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 1, 10);
insert into aircraft values ( 2, 1);
insert into aircraft values ( 2, 1);
insert into aircraft values ( 2, 1);
insert into aircraft values ( 2, 7);
insert into aircraft values ( 2, 7);
insert into aircraft values ( 2, 7);
insert into aircraft values ( 2, 7);
insert into aircraft values ( 2, 7);
insert into aircraft values ( 2, 7);
insert into aircraft values ( 2, 9);
insert into aircraft values ( 2, 9);
insert into aircraft values ( 2, 9);
insert into aircraft values ( 3, 4);
insert into aircraft values ( 3, 4);
insert into aircraft values ( 3, 4);
insert into aircraft values ( 3, 4);
insert into aircraft values ( 3, 4);
insert into aircraft values ( 4, 1);
insert into aircraft values ( 4, 1);
insert into aircraft values ( 4, 1);
insert into aircraft values ( 4, 1);
insert into aircraft values ( 4, 1);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 7);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 4, 8);
insert into aircraft values ( 5, 1);
insert into aircraft values ( 5, 1);
insert into aircraft values ( 5, 1);
insert into aircraft values ( 5, 1);
insert into aircraft values ( 5, 7);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 1, 7);
insert into aircraft values ( 6, 1);
insert into aircraft values ( 6, 1);
insert into aircraft values ( 6, 1);
insert into aircraft values ( 6, 1);
insert into aircraft values ( 6, 7);
insert into aircraft values ( 6, 7);
insert into aircraft values ( 6, 7);
insert into aircraft values ( 6, 7);
insert into aircraft values ( 7, 1);
insert into aircraft values ( 7, 1);
insert into aircraft values ( 7, 1);
insert into aircraft values ( 7, 7);
insert into aircraft values ( 7, 7);
insert into aircraft values ( 7, 7); 


insert into runway_tariff values ( 'ночной осень 2020', '2020-09-01', '2020-11-30', 100000);
insert into runway_tariff values ( 'дневной осень 2020', '2020-09-01', '2020-11-30', 100000);
insert into runway_tariff values ( 'ночной осень 2021', '2020-09-01', '2020-11-30', 100000);
insert into runway_tariff values ( 'дневной осень 2021', '2020-09-01', '2020-11-30', 100000);
insert into runway_tariff values ( 'ночной весна 2021', '2020-09-01', '2020-11-30', 300000);
insert into runway_tariff values ( 'дневной весна 2021', '2020-09-01', '2020-11-30', 200000);


insert into  slot values ( '2020-10-04', '00:00:00', '05:59:00', 1, 2, 1);
insert into  slot values ( '2020-10-04', '06:00:00', '11:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-04', '12:00:00', '17:59:00', 1, 4, 2);
insert into  slot values ( '2020-10-04', '18:00:00', '23:59:00', 2, 6, 1);
insert into  slot values ( '2020-10-05', '00:00:00', '05:59:00', 6, 3, 1);
insert into  slot values ( '2020-10-05', '06:00:00', '11:59:00', 5, 4, 2);
insert into  slot values ( '2020-10-05', '12:00:00', '17:59:00', 4, 5, 2);
insert into  slot values ( '2020-10-05', '18:00:00', '23:59:00', 3, 2, 1);
insert into  slot values ( '2020-10-06', '00:00:00', '05:59:00', 3, 1, 1);
insert into  slot values ( '2020-10-06', '06:00:00', '11:59:00', 4, 1, 2);
insert into  slot values ( '2020-10-06', '12:00:00', '17:59:00', 4, 1, 2);
insert into  slot values ( '2020-10-06', '18:00:00', '23:59:00', 4, 3, 1);
insert into  slot values ( '2020-10-07', '00:00:00', '05:59:00', 1, 2, 1);
insert into  slot values ( '2020-10-07', '06:00:00', '11:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-07', '12:00:00', '17:59:00', 4, 1, 2);
insert into  slot values ( '2020-10-07', '18:00:00', '23:59:00', 4, 3, 1);
insert into  slot values ( '2020-10-08', '00:00:00', '05:59:00', 1, 2, 1);
insert into  slot values ( '2020-10-08', '06:00:00', '11:59:00', 8, 3, 2);
insert into  slot values ( '2020-10-08', '12:00:00', '17:59:00', 9, 1, 2);
insert into  slot values ( '2020-10-08', '18:00:00', '23:59:00', 10, 1, 1);
insert into  slot values ( '2020-10-09', '00:00:00', '05:59:00', 1, 1, 1);
insert into  slot values ( '2020-10-09', '06:00:00', '11:59:00', 4, 1, 2);
insert into  slot values ( '2020-10-09', '12:00:00', '17:59:00', 6, 1, 2);
insert into  slot values ( '2020-10-09', '18:00:00', '23:59:00', 7, 1, 1);
insert into  slot values ( '2020-10-10', '00:00:00', '05:59:00', 8, 1, 1);
insert into  slot values ( '2020-10-10', '06:00:00', '11:59:00', 8, 1, 2);
insert into  slot values ( '2020-10-10', '12:00:00', '17:59:00', 4, 1, 2);
insert into  slot values ( '2020-10-10', '18:00:00', '23:59:00', 2, 1, 1);
insert into  slot values ( '2020-10-11', '00:00:00', '05:59:00', 3, 1, 1);
insert into  slot values ( '2020-10-11', '06:00:00', '11:59:00', 4, 3, 2);
insert into  slot values ( '2020-10-11', '12:00:00', '17:59:00', 3, 1, 2);
insert into  slot values ( '2020-10-11', '18:00:00', '23:59:00', 3, 1, 1);
insert into  slot values ( '2020-10-12', '00:00:00', '05:59:00', 4, 1, 1);
insert into  slot values ( '2020-10-12', '06:00:00', '11:59:00', 3, 1, 2);
insert into  slot values ( '2020-10-12', '12:00:00', '17:59:00', 3, 1, 2);
insert into  slot values ( '2020-10-12', '18:00:00', '23:59:00', 4, 1, 1);
insert into  slot values ( '2020-10-13', '00:00:00', '05:59:00', 5, 3, 1);
insert into  slot values ( '2020-10-13', '06:00:00', '11:59:00', 6, 3, 2);
insert into  slot values ( '2020-10-13', '12:00:00', '17:59:00', 5, 2, 2);
insert into  slot values ( '2020-10-13', '18:00:00', '23:59:00', 4, 2, 1);
insert into  slot values ( '2020-10-14', '00:00:00', '05:59:00', 3, 2, 1);
insert into  slot values ( '2020-10-14', '06:00:00', '11:59:00', 4, 4, 2);
insert into  slot values ( '2020-10-14', '12:00:00', '17:59:00', 4, 4, 2);
insert into  slot values ( '2020-10-14', '18:00:00', '23:59:00', 2, 4, 1);
insert into  slot values ( '2020-10-15', '00:00:00', '05:59:00', 2, 4, 1);
insert into  slot values ( '2020-10-15', '06:00:00', '11:59:00', 2, 4, 2);
insert into  slot values ( '2020-10-15', '12:00:00', '17:59:00', 2, 4, 2);
insert into  slot values ( '2020-10-15', '18:00:00', '23:59:00', 3, 4, 1);
insert into  slot values ( '2020-10-16', '00:00:00', '05:59:00', 3, 1, 1);
insert into  slot values ( '2020-10-16', '06:00:00', '11:59:00', 3, 1, 2);
insert into  slot values ( '2020-10-16', '12:00:00', '17:59:00', 4, 1, 2);
insert into  slot values ( '2020-10-16', '18:00:00', '23:59:00', 1, 1, 1);
insert into  slot values ( '2020-10-17', '00:00:00', '05:59:00', 1, 1, 1);
insert into  slot values ( '2020-10-17', '06:00:00', '11:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-17', '12:00:00', '17:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-17', '18:00:00', '23:59:00', 1, 4, 1);
insert into  slot values ( '2020-10-18', '00:00:00', '05:59:00', 1, 4, 1);
insert into  slot values ( '2020-10-18', '06:00:00', '11:59:00', 1, 4, 2);
insert into  slot values ( '2020-10-18', '12:00:00', '17:59:00', 1, 4, 2);
insert into  slot values ( '2020-10-18', '18:00:00', '23:59:00', 1, 4, 1);
insert into  slot values ( '2020-10-19', '00:00:00', '05:59:00', 1, 1, 1);
insert into  slot values ( '2020-10-19', '06:00:00', '11:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-19', '12:00:00', '17:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-19', '18:00:00', '23:59:00', 1, 1, 1);
insert into  slot values ( '2020-10-20', '00:00:00', '05:59:00', 1, 4, 1);
insert into  slot values ( '2020-10-20', '06:00:00', '11:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-20', '12:00:00', '17:59:00', 1, 1, 2);
insert into  slot values ( '2020-10-20', '18:00:00', '23:59:00', 1, 1, 1);


insert into airfield_service_equipment values ( 'т€гач', 30, 300000);
insert into airfield_service_equipment values ( 'погрузчик', 30, 300000);
insert into airfield_service_equipment values ( 'трап', 30, 200000);
insert into airfield_service_equipment values ( 'снегоуборочна€ машина', 20, 50000);
insert into airfield_service_equipment values ( 'машина сопровождени€', 10, 50000);
insert into airfield_service_equipment values ( 'автобус', 30, 300000);
insert into airfield_service_equipment values ( 'очиститиель корпуса', 30, 210000);
insert into airfield_service_equipment values ( 'заправчна€ станци€', 10, 300000);
insert into airfield_service_equipment values ( 'комплект дл€ уборки салона', 30, 300000);
insert into airfield_service_equipment values ( 'комплект дл€ прочистки турбин', 30, 210000);
insert into airfield_service_equipment values ( 'комплект прочистки двигател€', 30, 200000);
insert into airfield_service_equipment values ( 'комплекты дл€ устранени€ мелких неисправностей', 30, 200000);
insert into airfield_service_equipment values ( 'пажаротушителные станции', 30, 50000);
insert into airfield_service_equipment values ( 'Ћокаторы', 30, 30000);
insert into airfield_service_equipment values ( 'метеостанции', 2, 40000);



insert into parking_tariff values( 'окт€брь 2020', '2020-10-01', '2020-10-31', 200000);
insert into parking_tariff values( 'но€брь 2020', '2020-10-01', '2020-10-31', 200000);
insert into parking_tariff values( 'декабрь 2020', '2020-10-01', '2020-10-31', 200000);
insert into parking_tariff values( '€нварь 2021', '2020-10-01', '2020-10-31', 200000);
insert into parking_tariff values( 'февраль 2021', '2020-10-01', '2020-10-31', 200000);






insert into maintenance values (1, 1);
insert into maintenance values (1, 2);
insert into maintenance values (1, 9);
insert into maintenance values (2, 1);
insert into maintenance values (2, 2);
insert into maintenance values (2, 9);
insert into maintenance values (3, 1);
insert into maintenance values (3, 2);
insert into maintenance values (3, 9);
insert into maintenance values (4, 1);
insert into maintenance values (5, 2);
insert into maintenance values (6, 2);
insert into maintenance values (7, 2);
insert into maintenance values (8, 2);
insert into maintenance values (9, 2);
insert into maintenance values (10,2);
insert into maintenance values (11, 2);
insert into maintenance values (12, 2);
insert into maintenance values (13, 2);
insert into maintenance values (14, 2);
insert into maintenance values (15, 2);
insert into maintenance values (16, 2);
insert into maintenance values (8, 9);
insert into maintenance values (9, 9);
insert into maintenance values (10, 9);
insert into maintenance values (11, 9);
insert into maintenance values (12, 9);
insert into maintenance values (13, 9);
insert into maintenance values (14, 9);
insert into maintenance values (15, 9);
insert into maintenance values (16, 9);
insert into maintenance values (17, 2);
insert into maintenance values (18, 2);
insert into maintenance values (19, 2);
insert into maintenance values (20, 2);
insert into maintenance values (21, 2);
insert into maintenance values (22, 2);
insert into maintenance values (23, 2);
insert into maintenance values (24, 2);
insert into maintenance values (25, 2);
insert into maintenance values (36, 2);
insert into maintenance values (37, 2);
insert into maintenance values (38, 2);
insert into maintenance values (39, 2);
insert into maintenance values (30, 2);
insert into maintenance values (31, 2);
insert into maintenance values (32, 2);
insert into maintenance values (33, 2);
insert into maintenance values (34, 2);
insert into maintenance values (35, 2);
insert into maintenance values (36, 2);
insert into maintenance values (37, 2);
insert into maintenance values (38, 2);
insert into maintenance values (39, 2);
insert into maintenance values (40, 2);
insert into maintenance values (41, 2);
insert into maintenance values (42, 2);
insert into maintenance values (43, 2);
insert into maintenance values (44, 2);
insert into maintenance values (45, 2);
insert into maintenance values (46, 2);
insert into maintenance values (47, 2);
insert into maintenance values (48, 2);
insert into maintenance values (49, 2);
insert into maintenance values (50, 2); 
insert into maintenance values (18, 9);
insert into maintenance values (19, 9);
insert into maintenance values (20, 9);
insert into maintenance values (21, 9);
insert into maintenance values (22, 9);
insert into maintenance values (23, 9);
insert into maintenance values (24, 9);
insert into maintenance values (25, 9);
insert into maintenance values (36, 9);
insert into maintenance values (37, 9);
insert into maintenance values (38, 9);
insert into maintenance values (39, 9);
insert into maintenance values (30, 9);
insert into maintenance values (31, 9);
insert into maintenance values (32, 9);
insert into maintenance values (33, 9);
insert into maintenance values (34, 9);
insert into maintenance values (35, 9);
insert into maintenance values (36, 9);
insert into maintenance values (37, 9);
insert into maintenance values (38, 9);
insert into maintenance values (39, 9);
insert into maintenance values (40, 9);
insert into maintenance values (41, 9);
insert into maintenance values (42, 9);
insert into maintenance values (43, 9);
insert into maintenance values (44, 9);
insert into maintenance values (45, 9);
insert into maintenance values (46, 9);
insert into maintenance values (47, 9);
insert into maintenance values (48, 9);
insert into maintenance values (49, 9);
insert into maintenance values (50, 9); 
insert into maintenance values (51, 9);
insert into maintenance values (52, 9);
insert into maintenance values (53, 2);
insert into maintenance values (54, 2);
insert into maintenance values (55, 2);
insert into maintenance values (56, 2);
insert into maintenance values (57, 2);
insert into maintenance values (58, 2);
insert into maintenance values (59, 2);
insert into maintenance values (60, 2);
insert into maintenance values (61, 2);
insert into maintenance values (62, 2);
insert into maintenance values (63, 2);
insert into maintenance values (64, 2);
insert into maintenance values (65, 2);
insert into maintenance values (66, 2);
insert into maintenance values (67, 2);
insert into maintenance values (68, 2);
insert into maintenance values (53, 9);
insert into maintenance values (54, 9);
insert into maintenance values (55, 9);
insert into maintenance values (56, 9);
insert into maintenance values (57, 9);
insert into maintenance values (58, 9);
insert into maintenance values (59, 9);
insert into maintenance values (60, 9);
insert into maintenance values (61, 9);
insert into maintenance values (62, 9);
insert into maintenance values (63, 9);
insert into maintenance values (64, 9);
insert into maintenance values (65, 9);
insert into maintenance values (66, 9);
insert into maintenance values (67, 9);
insert into maintenance values (68, 9);
insert into maintenance values (53, 10);
insert into maintenance values (54, 10);
insert into maintenance values (55, 10);
insert into maintenance values (56, 10);
insert into maintenance values (57, 10);
insert into maintenance values (58, 10);
insert into maintenance values (59, 10);
insert into maintenance values (60, 10);
insert into maintenance values (61, 10);
insert into maintenance values (62, 10);
insert into maintenance values (63, 10);
insert into maintenance values (64, 10);
insert into maintenance values (65, 10);
insert into maintenance values (66, 10);
insert into maintenance values (67, 10);
insert into maintenance values (68, 10);
insert into maintenance values (53, 10);
insert into maintenance values (54, 10);
insert into maintenance values (55, 10);
insert into maintenance values (56, 10);
insert into maintenance values (57, 10);
insert into maintenance values (58, 10);
insert into maintenance values (59, 10);
insert into maintenance values (60, 10);
insert into maintenance values (61, 10);
insert into maintenance values (62, 10);
insert into maintenance values (63, 10);
insert into maintenance values (64, 10);
insert into maintenance values (65, 10);
insert into maintenance values (66, 10);
insert into maintenance values (67, 10);
insert into maintenance values (68, 10);
insert into maintenance values (53, 10);
insert into maintenance values (54, 10);
insert into maintenance values (55, 10);
insert into maintenance values (56, 10);
insert into maintenance values (57, 10);
insert into maintenance values (58, 10);
insert into maintenance values (59, 10);
insert into maintenance values (60, 10);
insert into maintenance values (61, 10);
insert into maintenance values (62, 10);
insert into maintenance values (63, 10);
insert into maintenance values (64, 10);
insert into maintenance values (65, 10);
insert into maintenance values (66, 10);
insert into maintenance values (67, 10);
insert into maintenance values (68, 10);
insert into maintenance values (53, 10);
insert into maintenance values (54, 10);
insert into maintenance values (55, 10);
insert into maintenance values (56, 10);
insert into maintenance values (57, 10);
insert into maintenance values (58, 10);
insert into maintenance values (59, 10);
insert into maintenance values (60, 10);
insert into maintenance values (61, 10);
insert into maintenance values (62, 10);
insert into maintenance values (63, 10);
insert into maintenance values (64, 10);
insert into maintenance values (65, 10);
insert into maintenance values (66, 10);
insert into maintenance values (67, 10);
insert into maintenance values (68, 10);
insert into maintenance values (8, 10);
insert into maintenance values (9, 10);
insert into maintenance values (10, 10);
insert into maintenance values (11, 10);
insert into maintenance values (12, 10);
insert into maintenance values (13, 10);
insert into maintenance values (14, 10);
insert into maintenance values (15, 10);
insert into maintenance values (16, 10);



insert into parking values (10, '2020-10-05 18:00:00', '2020-10-06 06:00:00', 1)
insert into parking values (11, '2020-10-05 18:00:00', '2020-10-06 12:00:00', 1);
insert into parking values (12, '2020-10-05 19:00:00', '2020-10-06 12:00:00', 1);
insert into parking values (13, '2020-10-05 20:00:00', '2020-10-06 12:00:00', 1);
insert into parking values (14, '2020-10-06 03:00:00', '2020-10-06 18:00:00', 1);
insert into parking values (15, '2020-10-06 06:00:00', '2020-10-06 18:00:00', 1);
insert into parking values (20, '2020-10-06 08:00:00', '2020-10-06 19:00:00', 1);
insert into parking values (19, '2020-10-06 09:00:00', '2020-10-06 19:00:00', 1);
insert into parking values (21, '2020-10-06 12:00:00', '2020-10-06 21:00:00', 1);
insert into parking values (22, '2020-10-06 16:00:00', '2020-10-06 23:00:00', 1);
insert into parking values (23, '2020-10-06 18:00:00', '2020-10-06 23:00:00', 1);
insert into parking values (24, '2020-10-06 19:00:00', '2020-10-06 23:00:00', 1);
insert into parking values (73, '2020-10-06 20:00:00', '2020-10-07 01:00:00', 1);
insert into parking values (74, '2020-10-06 21:00:00', '2020-10-07 02:00:00', 1);
insert into parking values (75, '2020-10-06 22:00:00', '2020-10-07 03:00:00', 1);



insert into parking_equipment values ( 6, 1);
insert into parking_equipment values ( 7, 1);
insert into parking_equipment values ( 12, 1);
insert into parking_equipment values ( 6, 2);
insert into parking_equipment values ( 7, 2);
insert into parking_equipment values ( 12, 2);
insert into parking_equipment values ( 6, 3);
insert into parking_equipment values ( 7, 3);
insert into parking_equipment values ( 12, 3);
insert into parking_equipment values ( 6, 4);
insert into parking_equipment values ( 7, 4);
insert into parking_equipment values ( 12, 4);
insert into parking_equipment values ( 6, 5);
insert into parking_equipment values ( 7, 5);
insert into parking_equipment values ( 12, 6);
insert into parking_equipment values ( 6, 7);
insert into parking_equipment values ( 7, 7);
insert into parking_equipment values ( 12, 7);
insert into parking_equipment values ( 6, 8);
insert into parking_equipment values ( 7, 8);
insert into parking_equipment values ( 12, 8);
insert into parking_equipment values ( 6, 9);
insert into parking_equipment values ( 7, 9);
insert into parking_equipment values ( 12, 9);
insert into parking_equipment values ( 6, 10);
insert into parking_equipment values ( 7, 10);
insert into parking_equipment values ( 12, 10);
insert into parking_equipment values ( 6, 11);
insert into parking_equipment values ( 7, 11);
insert into parking_equipment values ( 12, 11);
insert into parking_equipment values ( 6, 12);
insert into parking_equipment values ( 7, 12);
insert into parking_equipment values ( 12, 12);
insert into parking_equipment values ( 6, 13);
insert into parking_equipment values ( 7, 13);
insert into parking_equipment values ( 12, 13);
insert into parking_equipment values ( 6, 14);
insert into parking_equipment values ( 7, 14);
insert into parking_equipment values ( 12, 14);
insert into parking_equipment values ( 6, 15);
insert into parking_equipment values ( 7, 15);
insert into parking_equipment values ( 12, 15);
insert into parking_equipment values ( 8, 1);
insert into parking_equipment values ( 9, 1);
insert into parking_equipment values ( 10, 1);
insert into parking_equipment values ( 11, 1);
insert into parking_equipment values ( 8, 2);
insert into parking_equipment values ( 9, 2);
insert into parking_equipment values ( 11, 2);
insert into parking_equipment values ( 8, 3);
insert into parking_equipment values ( 9, 3);
insert into parking_equipment values ( 11, 3);
insert into parking_equipment values ( 8, 4);
insert into parking_equipment values ( 9, 4);
insert into parking_equipment values ( 11, 4);
insert into parking_equipment values ( 8, 5);
insert into parking_equipment values ( 9, 5);


insert into parking_service values (1, 1, 50000);
insert into parking_service values (1, 2, 60000);
insert into parking_service values (1, 3, 65000);
insert into parking_service values (1, 4, 70000);
insert into parking_service values (1, 5, 80000);
insert into parking_service values (1, 6, 50000);
insert into parking_service values (1, 7, 60000);
insert into parking_service values (1, 8, 65000);
insert into parking_service values (1, 9, 50000);
insert into parking_service values (1, 10, 45000);
insert into parking_service values (2, 1, 50000);
insert into parking_service values (2, 2, 60000);
insert into parking_service values (2, 3, 65000);
insert into parking_service values (2, 4, 70000);
insert into parking_service values (2, 5, 80000);
insert into parking_service values (2, 6, 50000);
insert into parking_service values (2, 7, 60000);
insert into parking_service values (2, 8, 65000);
insert into parking_service values (2, 9, 50000);
insert into parking_service values (2, 10, 45000);
insert into parking_service values (3, 1, 40000);
insert into parking_service values (3, 2, 50000);
insert into parking_service values (3, 3, 55000);
insert into parking_service values (3, 4, 60000);
insert into parking_service values (3, 5, 70000);
insert into parking_service values (3, 6, 60000);
insert into parking_service values (3, 7, 70000);
insert into parking_service values (3, 8, 75000);
insert into parking_service values (3, 9, 40000);
insert into parking_service values (3, 10, 35000);
insert into parking_service values (4, 1, 30000);
insert into parking_service values (4, 2, 40000);
insert into parking_service values (4, 3, 45000);
insert into parking_service values (4, 4, 50000);
insert into parking_service values (4, 5, 60000);
insert into parking_service values (4, 6, 30000);
insert into parking_service values (4, 7, 40000);
insert into parking_service values (4, 8, 45000);
insert into parking_service values (4, 9, 30000);
insert into parking_service values (4, 10, 25000);
insert into parking_service values (5, 1, 30000);
insert into parking_service values (5, 2, 40000);
insert into parking_service values (5, 3, 45000);
insert into parking_service values (5, 4, 50000);
insert into parking_service values (5, 5, 60000);
insert into parking_service values (5, 6, 30000);
insert into parking_service values (5, 7, 40000);
insert into parking_service values (5, 8, 45000);
insert into parking_service values (5, 9, 30000);
insert into parking_service values (5, 10, 25000);
insert into parking_service values (6, 1, 50000);
insert into parking_service values (6, 2, 60000);
insert into parking_service values (6, 3, 65000);
insert into parking_service values (6, 4, 70000);
insert into parking_service values (6, 5, 80000);
insert into parking_service values (6, 6, 50000);
insert into parking_service values (6, 7, 60000);
insert into parking_service values (6, 8, 65000);
insert into parking_service values (6, 9, 50000);
insert into parking_service values (6, 10, 45000);
insert into parking_service values (7, 1, 50000);
insert into parking_service values (7, 2, 60000);
insert into parking_service values (7, 3, 65000);
insert into parking_service values (7, 4, 70000);
insert into parking_service values (7, 5, 80000);
insert into parking_service values (7, 6, 50000);
insert into parking_service values (7, 7, 60000);
insert into parking_service values (7, 8, 65000);
insert into parking_service values (7, 9, 50000);
insert into parking_service values (7, 10, 45000);
insert into parking_service values (8, 1, 50000);
insert into parking_service values (8, 2, 60000);
insert into parking_service values (8, 3, 65000);
insert into parking_service values (8, 4, 70000);
insert into parking_service values (8, 5, 80000);
insert into parking_service values (8, 6, 50000);
insert into parking_service values (8, 7, 60000);
insert into parking_service values (8, 8, 65000);
insert into parking_service values (8, 9, 50000);
insert into parking_service values (8, 10, 45000);
insert into parking_service values (9, 1, 50000);
insert into parking_service values (9, 2, 60000);
insert into parking_service values (9, 3, 65000);
insert into parking_service values (9, 4, 70000);
insert into parking_service values (9, 5, 80000);
insert into parking_service values (9, 6, 50000);
insert into parking_service values (9, 7, 60000);
insert into parking_service values (9, 8, 65000);
insert into parking_service values (9, 9, 50000);
insert into parking_service values (9, 10, 45000);
insert into parking_service values (10, 1, 40000);
insert into parking_service values (10, 2, 50000);
insert into parking_service values (10, 3, 55000);
insert into parking_service values (10, 4, 60000);
insert into parking_service values (10, 5, 70000);
insert into parking_service values (10, 6, 60000);
insert into parking_service values (10, 7, 70000);
insert into parking_service values (10, 8, 75000);
insert into parking_service values (10, 9, 40000);
insert into parking_service values (10, 10, 35000);
insert into parking_service values (1, 1, 40000);
insert into parking_service values (11, 2, 50000);
insert into parking_service values (11, 3, 55000);
insert into parking_service values (11, 4, 60000);
insert into parking_service values (11, 5, 70000);
insert into parking_service values (11, 6, 60000);
insert into parking_service values (11, 7, 70000);
insert into parking_service values (11, 8, 75000);
insert into parking_service values (11, 9, 40000);
insert into parking_service values (11, 10, 35000);
insert into parking_service values (12, 1, 30000);
insert into parking_service values (12, 2, 40000);
insert into parking_service values (12, 3, 45000);
insert into parking_service values (12, 4, 50000);
insert into parking_service values (12, 5, 60000);
insert into parking_service values (12, 6, 30000);
insert into parking_service values (12, 7, 40000);
insert into parking_service values (12, 8, 45000);
insert into parking_service values (12, 9, 30000);
insert into parking_service values (12, 10, 25000); 


insert into aircraft_service values( 10, 103, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 10, 113, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 11, 103, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 11, 113, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 12, 103, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 12, 113, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 13, 103, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 13, 113, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 14, 103, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 14, 113, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 15, 103, '2020-10-06', '03:00:00', '04:00:00');
insert into aircraft_service values( 15, 113, '2020-10-06', '07:00:00', '08:00:00');
insert into aircraft_service values( 19, 103, '2020-10-06', '07:00:00', '08:00:00');
insert into aircraft_service values( 19, 113, '2020-10-06', '10:00:00', '11:00:00');
insert into aircraft_service values( 20, 103, '2020-10-06', '10:00:00', '11:00:00');
insert into aircraft_service values( 20, 113, '2020-10-06', '10:00:00', '11:00:00');
insert into aircraft_service values( 21, 103, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 21, 103, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 22, 103, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 22, 113, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 23, 113, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 23, 113, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 24, 103, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 24, 113, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 73, 103, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 73, 113, '2020-10-06', '20:00:00', '21:00:00');
insert into aircraft_service values( 74, 103, '2020-10-06', '23:00:00', '23:50:00');
insert into aircraft_service values( 74, 113, '2020-10-06', '23:00:00', '23:50:00');
insert into aircraft_service values( 75, 103, '2020-10-06', '23:00:00', '23:50:00');
insert into aircraft_service values( 75, 113, '2020-10-06', '23:00:00', '23:50:00');


insert into route values ('SVO-AIR', 600, 'внутренний');
insert into route values ('DDE-AIR', 600, 'внутренний');
insert into route values ('VKO-AIR', 600, 'внутренний');
insert into route values ('PLK-AIR', 900, 'внутренний');
insert into route values ('EKB-AIR', 2000, 'внутренний');
insert into route values ('VOZ-AIR', 600, 'внутренний');
insert into route values ('NSB-AIR', 5000, 'внутренний');
insert into route values ('SHI-AIR', 1500, 'внутренний');
insert into route values ('SIP-AIR', 1600, 'внутренний');
insert into route values ('MIN-AIR', 1500, 'международный');
insert into route values ('KIV-AIR', 1500, 'международный');
insert into route values ('-NUR-AIR', 5000, 'международный');
insert into route values ('AIR-SVO', 600, 'внутренний');
insert into route values ('AIR-DDE', 600, 'внутренний');
insert into route values ('AIR-VKO', 600, 'внутренний');
insert into route values ('AIR-PLK', 900, 'внутренний');
insert into route values ('AIR-EKB', 2000, 'внутренний');
insert into route values ('AIR-VOZ', 600, 'внутренний');
insert into route values ('AIR-NSB', 5000, 'внутренний');
insert into route values ('AIR-SHI', 1500, 'внутренний');
insert into route values ('AIR-SIP', 1600, 'внутренний');
insert into route values ('AIR-MIN', 1500, 'международный');
insert into route values ('AIR-KIV', 1500, 'международный');
insert into route values ('AIR-NUR', 5000, 'международный');





insert into flight values ('2020-10-06', '00:00:00', '01:00:00', 9, 10, 1, 1, 1, 100);
insert into flight values ('2020-10-06', '02:00:00', '02:00:00', 9, 11, 13, 1, 2, 99);
insert into flight values ('2020-10-06', '07:00:00', '01:00:00', 10, 21, 3, 2, 1, 87);
insert into flight values ('2020-10-06', '14:00:00', '01:00:00', 11, 22, 14, 2, 2, 77);
insert into flight values ('2020-10-06', '17:00:00', '01:00:00', 11, 23, 5, 1, 1, 120);
insert into flight values ('2020-10-06', '19:00:00', '01:00:00', 12, 73, 12, 1, 2, 110);
insert into flight values ('2020-10-06', '21:00:00', '01:00:00', 12, 74, 23, 2, 1, 100);
insert into flight values ('2020-10-06', '22:00:00', '01:00:00', 12, 75, 10, 2, 2, 111);
insert into flight values ('2020-10-06', '00:00:00', '01:00:00', 13, 61, 1, 1, 1, 111);
insert into flight values ('2020-10-06', '02:00:00', '02:00:00', 13, 62, 14, 1, 2, 109);
insert into flight values ('2020-10-06', '07:00:00', '01:00:00', 14, 1, 2, 2, 1, 101);
insert into flight values ('2020-10-06', '14:00:00', '01:00:00', 15, 2, 7, 2, 2, 80);
insert into flight values ('2020-10-06', '17:00:00', '01:00:00', 15, 3, 15, 1, 1, 88);
insert into flight values ('2020-10-06', '19:00:00', '01:00:00', 16, 73, 8, 2, 1, 96);
insert into flight values ('2020-10-06', '21:00:00', '01:00:00', 16, 74, 15, 2, 2, 89);
insert into flight values ('2020-10-06', '22:00:00', '01:00:00', 16, 75, 21, 1, 1, 101);

*/
