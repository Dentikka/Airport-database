use Airport2;

set transaction isolation level repeatable read;

begin transaction;

select *
from
	flight
where
	flight_id = 10;

update flight
set
	sold_tickets = 118
where 
	flight_id = 10;

commit transaction;

select @@trancount as '?????????? ??????????';