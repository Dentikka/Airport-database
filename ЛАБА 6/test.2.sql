use Airport2;

set transaction isolation level read uncommitted;

begin transaction T2; 

update flight
set
	sold_tickets += 1
where flight_id = 10;

commit;

select @@trancount as 'количество транзакций';