use Airport2;

set transaction isolation level snapshot;

begin transaction;

update flight
set
	sold_tickets = 116
where 
	flight_id = 10;

commit transaction;


select @@trancount as 'количество транзакций';