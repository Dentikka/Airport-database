set dateformat ymd;
use Airport2;



-------------------1------------------- ��������� ������, ������� � ������������ ����.
/*
select * from runway_tariff;
select * from parking_tariff;

update runway_tariff
	set price_per_hour = price_per_hour * 1.5
	where starting_date > '2021-01-01';

update parking_tariff
	set price_per_day = price_per_day * 1.5
	where starting_date > '2020-09-01';

select * from runway_tariff;
select * from parking_tariff;
*/


------------------2------------------ �������� ��������, ���������� � �������������� �������, �� ����� 3
/*
select *
	from flight join route on flight.route_id = route.route_id

update flight
	set terminal = 3
	from flight join route on flight.route_id = route.route_id 
	where route.type = '�������������'

select *
	from flight join route on flight.route_id = route.route_id
*/


---------------------3------------------------------�������� ������� �� �������� ������ 4 � 5	
/*
select * from Flight

declare @new_aircraft_id int;
set @new_aircraft_id = (select Flight.aircraft_id from FLight
					where Flight.flight_id=5);

update Flight 
set
Flight.aircraft_id=(select Flight.aircraft_id from FLight
					where Flight.flight_id=4)
from Flight where Flight.flight_id=5;

update Flight 
set
Flight.aircraft_id=@new_aircraft_id
from Flight where Flight.flight_id=4;

select * from Flight
*/


--------------------4--------------------- �������� - ������� �������� ������ �� ����� �� ������ �� ������������� � ��
/*
select * from flight;

update Flight 
set
Flight.aircraft_id= 500
from Flight where Flight.flight_id=4;

select * from Flight
*/