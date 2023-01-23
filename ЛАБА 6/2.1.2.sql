
set transaction isolation level read committed;

begin transaction;

update flight
set
	sold_tickets = 113
where 
	flight_id = 10;

rollback;


select @@trancount as 'количество транзакций';