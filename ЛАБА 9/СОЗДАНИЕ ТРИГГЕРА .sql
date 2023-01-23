-----Длина перелета не должна превышать максимальную дальность полёта для данного самолёта-----
use Airport2;
go

CREATE OR ALTER TRIGGER Flight_max_dist_slot_ins 
ON Flight
AFTER INSERT
AS
IF EXISTS (
	SELECT flight.flight_id
	FROM route INNER JOIN flight ON flight.route_id=route.route_id
				INNER JOIN slot ON flight.slot_id=slot.slot_id
				INNER JOIN model ON slot.aircraft_model_id=model.model_id
				INNER JOIN inserted ON flight.flight_id=inserted.flight_id  
 WHERE distance>max_distance)

 BEGIN
RAISERROR ('Расстояние не должно превышать максимальную дальность полёта для данного самолёта', 11, 1);
DELETE FROM FLIGHT WHERE flight_id in 
	(SELECT flight.flight_id
	FROM route INNER JOIN flight ON flight.route_id=route.route_id
				INNER JOIN slot ON flight.slot_id=slot.slot_id
				INNER JOIN model ON slot.aircraft_model_id=model.model_id
				INNER JOIN inserted ON flight.flight_id=inserted.flight_id  
 WHERE distance>max_distance) ;



END

go

CREATE OR ALTER TRIGGER Flight_max_dist_slot_upd 
ON Flight
AFTER UPDATE
AS
IF EXISTS (
	SELECT flight.flight_id
	FROM route INNER JOIN flight ON flight.route_id=route.route_id
				INNER JOIN slot ON flight.slot_id=slot.slot_id
				INNER JOIN model ON slot.aircraft_model_id=model.model_id
				INNER JOIN inserted ON flight.flight_id=inserted.flight_id  
 WHERE distance>max_distance)

 BEGIN
RAISERROR ('Расстояние не должно превышать максимальную дальность полёта для данного самолёта', 11, 1);

UPDATE Flight
set date = deleted.date,
beginning = deleted.beginning,
duration = deleted.duration,
slot_id = deleted.slot_id,
aircraft_id = deleted.aircraft_id,
route_id = deleted.route_id,
terminal = deleted.terminal,
gate = deleted.gate,
sold_tickets = deleted.sold_tickets
from deleted
WHERE
flight.flight_id = deleted.flight_id AND
flight.flight_id in 
	(SELECT flight.flight_id
	FROM route INNER JOIN flight ON flight.route_id=route.route_id
				INNER JOIN slot ON flight.slot_id=slot.slot_id
				INNER JOIN model ON slot.aircraft_model_id=model.model_id
				INNER JOIN inserted ON flight.flight_id=inserted.flight_id  
 WHERE distance>max_distance) ;

END

go





