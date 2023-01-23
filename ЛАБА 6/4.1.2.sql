use Airport2;

set transaction isolation level serializable;

begin transaction;

insert into flight values ('2020-10-21', '23:30:00', '02:00:00', 16, 78, 8, 2, 1, 100);

commit transaction;


select @@trancount as 'количество транзакций';