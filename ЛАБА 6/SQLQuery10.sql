begin tran work
create table #a (a int)
begin tran
insert #a values (1)
save tran work
insert #a values (0)
rollback tran work
insert #a values (2)
commit
select * from #a
print @@trancount