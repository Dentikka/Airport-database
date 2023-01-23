

drop login [test]
go


-- � ����� Microsoft Enterprise Manager ��� ������ ������������ test/test.
create login [test] with password = '1' -- ����� 
go


use Airport2;
go


drop user [test]
go

drop role [test_role]
go

create user [test] for login [test]
go


-- �� ������� ���� ��� ����� ������� ������ ������������ ������������� ����� SELECT, INSERT, UPDATE � ������ ������
grant select, insert, update on object::dbo.Flight to [test]
go

-- �� ������� ���� ��� ����� ������� ������ ������������ ������������� ����� SELECT � UPDATE ������ ��������� ��������.
grant select, update on object::dbo.Route(route_id, [name]) to [test]
go

-- �� ������� ���� ��� ����� ������� ������ ������������ ������������� ������ ����� SELECT.
grant select on object::dbo.Airline to [test]
go

-- � ����� Microsoft Enterprise Manager ��������� ������ ������������ ����� ������� (SELECT) � �������������, ���������� � ������������ ������ �4. 
grant select on object::dbo.Departure_timetable to [test]
go

------------------------------------------------------------------------------------------------------------------------

create role test_role
go

 
grant select, update on object::dbo.Model(model) to [test_role]
go


alter role test_role add member [test]
go




