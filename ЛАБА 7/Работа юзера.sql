use Airport2;
go


select * from Flight
go
update Flight set sold_tickets = '123' where flight_id = 10
go
insert into flight values ('2020-10-21', '23:30:00', '02:00:00', 16, 78, 8, 2, 1, 100);
go


select name, route_id from Route
go
update Route set name = 'AIR-DOL' where route_id = 17
go


select * from Airline 
go


select * from Departure_timetable
go


update Model set model = '777-300' where model = '777-200'
go


select * from maintenance