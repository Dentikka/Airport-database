use Airport2;

alter database Airport2
set ALLOW_SNAPSHOT_ISOLATION ON;

set transaction isolation level snapshot;

begin transaction;

select *
from
	flight
where
	flight_id = 10;

commit transaction;


select @@trancount as 'количество транзакций';