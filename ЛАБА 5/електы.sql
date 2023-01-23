set dateformat ymd;
use Airport2;

drop view departure_timetable;

create view departure_timetable as
select date as date, beginning as departure, route.name as route, airline.name as airline, terminal as terminal, gate as gate
from flight join route on flight.route_id = route.route_id
join aircraft on flight.aircraft_id = aircraft.aircraft_id 
join airline on aircraft.airline_id = airline.airline_id
where route.name like '%AIR';

select * from departure_timetable;