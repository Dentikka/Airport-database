use Airport2;

set transaction isolation level serializable;

begin transaction;

select *
from
	flight
where
	date >= '2020-10-21'
	and beginning >= '02:00:00'

commit transaction;


select @@trancount as 'количество транзакций';