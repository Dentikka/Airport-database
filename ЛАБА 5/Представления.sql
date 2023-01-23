set dateformat ymd;
use Airport2;



------- 1 ------ расписаине отправлений

drop view if exists departure_timetable;
go

create view departure_timetable as
select 
	date, 
	beginning as departure, 
	route.name as route, 
	airline.name as airline, 
	terminal, 
	gate,
	type
from 
	flight 
	join route on flight.route_id = route.route_id
	join aircraft on flight.aircraft_id = aircraft.aircraft_id 
	join airline on aircraft.airline_id = airline.airline_id
where 
	route.name like '%AIR';
go

select * from departure_timetable;


-------- 2 ------- Марка самолета, количество рейсов в этом месяц, среднее время полета, среднее расстояние.

drop view if exists aircraft_flight_statistics;
go

create view aircraft_flight_statistics as
select 
	mark, 
	model,  
	count(flight_id) as number_of_flights, 
	avg(datepart(hh, duration)*60 + datepart(mi, duration)) as average_flight_duration,
	avg(distance) as average_distance 
from
	aircraft 
	join model on aircraft.model_id = model.model_id
	join flight on aircraft.aircraft_id = flight.aircraft_id
	join  route on flight.route_id = route.route_id
group by 
	mark, 
	model; 
go

select * from aircraft_flight_statistics;



------- 3 ------ Номер самолёта, марка и модель, расписание рейсов (для нашего аэропорта), количество свободных мест на рейсах

drop view if exists aircraft_timetable ;
go

create view aircraft_timetable as
select
	aircraft.aircraft_id as aircraft_number,
	mark,
	model,
	date, 
	beginning, 
	route.name as route,
	(number_of_seats - sold_tickets) as availible_tickets
from
	aircraft
	join flight on aircraft.aircraft_id = flight.aircraft_id
	join route on flight.route_id = route.route_id
	join model on aircraft.model_id = model.model_id;
go

select * from aircraft_timetable;




-------- 4 -------- расписание услуг, окзаываемых самолётам на парковочных зонах

drop view if exists aircraft_services;
go

create view aircraft_services as
select
	date,
	start_time,
	end_time,
	aircraft_id as serviced_aircraft_number,
	name,
	price
from
	aircraft_service
	join parking_service on aircraft_service.service_id = parking_service.service_id
	join parking_equipment on parking_equipment.parking_equipment_id = parking_service.parking_equipment_id
	join airfield_service_equipment on parking_equipment.equipment_type_id = airfield_service_equipment.type_id
go

select * from aircraft_services;






------- Селекты -------------------

---------- 1 ---------------- Для каждого направления показать ближайший рейс за следующие два дня, оставшееся до него время 

with dep_tt as
	(select 
		route,
		distance,
		departure_timetable.type,
		departure,
		datediff(hour, cast(getdate() as time), departure)
		+ (datediff(day, getdate(), date) * 24)
		as datediff
	from 
		departure_timetable
		join route on route.name = departure_timetable.route
	where
		datediff(hour, cast(getdate() as time), departure)
		+ (datediff(day, getdate(), date) * 24) > 0),

dep_min_dd as
	(select 
		route, 
		min(datediff) as min_datediff
	from
		dep_tt
	group by
		route)

select 
	dep_tt.route, 
	distance, type, 
	departure,
	'осталось ' + cast(datediff as varchar) + ' часов' as time_left
from
	dep_tt
	join dep_min_dd on dep_tt.route = dep_min_dd.route
where
	datediff = min_datediff

		
 
 ----------- 2 --------- выбрать услуги, которые окзавыются самолётам вместимостью свыше 350 мест.
 
 select
	aircraft_services.date, 
	aircraft_services.start_time, 
	aircraft_services.end_time, 
	name,
	mark,
	model,
	number_of_seats,
	price
from 
	aircraft_services, 
	aircraft,
	model
where
	aircraft_services.serviced_aircraft_number = aircraft.aircraft_id
	and aircraft.model_id = model.model_id
	and number_of_seats > 350;
*/

-------- 3 -------- выбрать рейсы, на котрых летают самолёты Аэрофлота.
/*
select  
	aircraft_number,
	mark,
	model,
	date, 
	beginning, 
	route,
	availible_tickets
from
	aircraft_timetable,
	aircraft,
	airline
where
	aircraft_timetable.aircraft_number = aircraft.aircraft_id
	and aircraft.airline_id = airline.airline_id
	and airline.name = 'Аэрофлот'
*/

--------- 4 --------- Посчитать доход с каждой авиакомпании от слотов, на которых работают самолёты, летающие в среднем не далее, чем на 1500 км
/*
select 
	airline.name as airline,
	sum(price_per_hour * datediff(hh, beginning_time, end_time)) as income
from 
	aircraft_flight_statistics, 
	model,
	slot,
	airline,
	runway_tariff
where 
	aircraft_flight_statistics.mark = model.mark
	and aircraft_flight_statistics.model = model.model
	and slot.aircraft_model_id = model.model_id
	and slot.airline_id = airline.airline_id
	and slot.tariff_id = runway_tariff.tariff_id
	and average_distance < 1500
group by
	airline.name
*/