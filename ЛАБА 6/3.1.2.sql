use Airport2;

set transaction isolation level repeatable read;

begin transaction;

update flight
set
	sold_tickets = 115
where 
	flight_id = 10;

commit transaction;


select @@trancount as 'количество транзакций';