use Airport2;

set transaction isolation level read uncommitted;

begin transaction;

update flight
set
	sold_tickets = 112
where 
	flight_id = 10;

rollback;


select @@trancount as 'количество транзакций';