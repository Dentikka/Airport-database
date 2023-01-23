set dateformat ymd;
use Airport2;


-------------Из задания--------------
-------------------1-----------------Количество рейсов, средняя продолжительность полёта, среднее расстояние для boeing 777-200
/*
select mark, model,  count(flight_id) as number_of_flights, 
	avg(datepart(hh, duration)*60 + datepart(mi, duration)) as average_flight_duration,
	avg(distance) as average_diastance from
	((aircraft join model on aircraft.model_id = model.model_id) 
	join flight on aircraft.aircraft_id = flight.aircraft_id)
	join  route on flight.route_id = route.route_id
		where mark = 'boeing' and model.model = '777-200'
		group by mark, model;
*/

--------------------2----------------------Самые частые марки на внутренних рейсах
/*
select top 1 with ties mark, count(flight_id) as number_of_flights from 
	((aircraft join flight on aircraft.aircraft_id = flight.aircraft_id)
	join model on aircraft.model_id = model.model_id)
	join route on flight.route_id = route.route_id
		group by mark, route.type
		having route.type = 'внутренний'
		order by number_of_flights desc;
*/
		

--------------------3-----------------Маршрут, по которому значится наибольшее количество рейсов с заполняяемостью не менее 20%
/*
with
	t1 as (select flight_id, route.route_id as route_id, route.name as name, sold_tickets, number_of_seats  from 
	((route join flight on route.route_id = flight.route_id)
	join aircraft on flight.aircraft_id = aircraft.aircraft_id)
	join model on aircraft.model_id = model.model_id
	where sold_tickets >= 0.2*number_of_seats)
	select top 1 with ties t1.name as name, count(flight_id) as number_of_flights from
		route join t1 on t1.route_id = route.route_id
			group by t1.route_id, t1.name
			order by number_of_flights desc;
*/			   
  




--------------------4-----------------------наличие совбобдных мест на рейc номер 
/*
select t1.flight_id,
	case
	when t1.total_tickets - t1.sold_tickets > 0
	then 'сводных мест  ' + cast(t1.total_tickets - t1.sold_tickets as varchar(10)) 
	else 'свободные места отсутствуют' 
	end
	as availible_tickets
	from 
	(select flight_id, number_of_seats as total_tickets, sold_tickets from
	(flight join aircraft on flight.aircraft_id = aircraft.aircraft_id)
	join model on aircraft.model_id = model.model_id
	where flight_id = 14) as t1
*/

-------------------Собственные выборки-------------------
-----------------5---------------- количество парковочных мест, занятое каждой авиакомпанией 13 октября в 03:00
/*
declare @desired_datetime  datetime;
set @desired_datetime = '2020-10-13 03:00:00'

select airline.name, count(zone_id) as nuber_f_zones from
	(parking join aircraft on parking.aircraft_id = aircraft.aircraft_id)
	join airline on aircraft.airline_id = airline.airline_id
		where  
		starting_datetime <= @desired_datetime
		and ending_datetime >= @desired_datetime 
		group by airline.name
*/


------------------6----------------------количество свободных единиц техники на 13 августа 03:00
/*
declare @desired_date  date;
set @desired_date = '2020-10-13';
declare @desired_time time;
set @desired_time = '03:00:00';
		
with t1 as		
	( 
	select airfield_service_equipment.type_id, name, quantity, aircraft_service.aircraft_Service_id, isnull(date, @desired_date) as date, isnull(start_time, @desired_time) as start_time, isnull(end_time, @desired_time) as end_time from airfield_service_equipment 
		left join (aircraft_Service join parking_service on aircraft_service.service_id = parking_Service.service_id ) 
		on airfield_service_equipment.type_id = parking_service.parking_equipment_id
	)
		select t1.name, quantity,  (quantity - count(isnull(aircraft_service_id, 0))) as availible_quantity from t1
		where date = @desired_date
		and start_time <= @desired_time
		and end_time >= @desired_time
		group by type_id, name, quantity;
*/


-------------------7-------------------Общий доход от услуг, оказанных каждой авиакомпании на парковке
/*
with
t1 as (
	select airline.airline_id, airline.name, isnull(sum(price), 0) as income from
		((aircraft_service join parking_service on aircraft_Service.service_id = parking_service.service_id)
		join aircraft on aircraft.aircraft_id = aircraft_service.aircraft_id )
		right join airline on aircraft.airline_id = airline.airline_id
		group by airline.airline_id, airline.name),

t2 as (
	select airline.airline_id, airline.name, isnull(sum(price_per_day*cast(datediff(hh, starting_datetime, ending_datetime) as int)/24), 0) as income from
		((parking join parking_tariff on parking.tariff_id = parking_tariff.tariff_id)
		join aircraft on aircraft.aircraft_id = parking.aircraft_id )
		right join airline on aircraft.airline_id = airline.airline_id
		group by airline.airline_id, airline.name)
select t1.name as airline_name, cast(cast((t1.income + t2.income) as decimal(18, 2)) as money) as total_income from
	t1 join t2 on t1.airline_id = t2.airline_id
*/



/*
declare @table as table(A float)

insert into @table(A) values(5)
insert into @table(A) values(6)
insert into @table(A) values(5)
insert into @table(A) values(8)
insert into @table(A) values(-0.1)
insert into @table(A) values(-2)




declare @s int
select @s = (SELECT COUNT (A) FROM @table WHERE A=0)
select product =
	CASE
		WHEN @s > 0 THEN 0
		WHEN ((SELECT COUNT (A) FROM @table WHERE A<0)/2)*2  < (SELECT COUNT (A) FROM @table WHERE A<0) THEN -1.0*EXP(sum(LOG(
			case
				when @s > 0 THEN 1
				else module
			end)))
		ELSE EXP(sum(LOG(
			case
				when @s > 0 THEN 1
				else module
			end)))
	END
FROM (SELECT ABS(A) AS module FROM @table) as t1
*/


