use Airport2;

set transaction isolation level read committed;

begin transaction;

update flight
set
	sold_tickets = 114
where 
	flight_id = 10;

commit transaction;


select @@trancount as 'количество транзакций';