

drop login [test]
go


-- В среде Microsoft Enterprise Manager был создан пользователь test/test.
create login [test] with password = '1' -- логин 
go


use Airport2;
go


drop user [test]
go

drop role [test_role]
go

create user [test] for login [test]
go


-- по крайней мере для одной таблицы новому пользователю присваиваются права SELECT, INSERT, UPDATE в полном объеме
grant select, insert, update on object::dbo.Flight to [test]
go

-- по крайней мере для одной таблицы новому пользователю присваиваются права SELECT и UPDATE только избранных столбцов.
grant select, update on object::dbo.Route(route_id, [name]) to [test]
go

-- по крайней мере для одной таблицы новому пользователю присваивается только право SELECT.
grant select on object::dbo.Airline to [test]
go

-- В среде Microsoft Enterprise Manager присвоить новому пользователю право доступа (SELECT) к представлению, созданному в лабораторной работе №4. 
grant select on object::dbo.Departure_timetable to [test]
go

------------------------------------------------------------------------------------------------------------------------

create role test_role
go

 
grant select, update on object::dbo.Model(model) to [test_role]
go


alter role test_role add member [test]
go




