use Airport2;

set transaction isolation level read uncommitted;

begin transaction;

select *
from
	flight
where
	flight_id = 10;

commit transaction;


select @@trancount as 'количество транзакций';