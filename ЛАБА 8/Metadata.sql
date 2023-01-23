Use Airport2;


--1
select sys.tables.name
from 
sys.tables 
--left join sys.extended_properties on object_id(sys.tables.name) = sys.extended_properties.major_id
where
objectproperty(object_id, 'OwnerId') = 1



--2
select sys.tables.name table_name, sys.columns.name 'column',  sys.columns.is_nullable, sys.types.name 'data_type', sys.columns.max_length 'size'
from
sys.tables join sys.columns on sys.columns.object_id = object_id(sys.tables.name)
join sys.types on sys.types.system_type_id = sys.columns.system_type_id
left join sys.extended_properties on object_id(sys.tables.name) = sys.extended_properties.major_id
where
objectproperty(object_id(sys.tables.name), 'OwnerId') = 1 
and sys.extended_properties.name is null
order by
table_name;


-----
select sys.tables.name table_name, sys.columns.name 'column',  sys.columns.is_nullable, type_name(sys.columns.system_type_id) as data_type, sys.columns.max_length 'size'
from
sys.tables join sys.columns on sys.columns.object_id = object_id(sys.tables.name)
--join sys.types on sys.types.system_type_id = sys.columns.system_type_id

where
objectproperty(object_id(sys.tables.name), 'OwnerId') = 1 

order by
table_name;


--3  

select  sys.objects.name, object_name(sys.objects.parent_object_id) table_name, sys.objects.type 
from 
sys.objects

where 
(sys.objects.type = 'pk' or sys.objects.type = 'f')

and objectproperty(object_id, 'ownerid') = 1;

--4

select sys.foreign_keys.name, tables_1.name as parent_table, tables_2.name as referenced_table 
from 
sys.foreign_keys join sys.tables as tables_1 on sys.foreign_keys.parent_object_id = object_id(tables_1.name) 
join sys.tables as tables_2 on sys.foreign_keys.referenced_object_id = object_id(tables_2.name)
where 
objectproperty(object_id(sys.foreign_keys.name), 'OwnerId') = 1;

--5
select sys.views.name, cast(object_definition(object_id) as xml) as definition 
from 
sys.views
where 
(objectproperty(object_id(sys.views.name), 'OwnerId')) = 1;


--6
use Airport2;
go
create trigger flight_tt
on dbo.flight
for update
as 
select * from flight;

select sys.objects.name as trigger_name, sys.tables.name as table_name
from 
sys.objects  join sys.tables on sys.objects.parent_object_id = object_id(sys.tables.name)
where 
sys.objects.type = 'tr' 
and objectproperty(sys.objects.object_id, 'OwnerId') = 1;

select * from sys.database_principals



select * from sys.views



------ список всех таблиц: если в таблице есть поле с префикосм + подчеркивание + id , €вл€ющеес€ первичнфм ключом.
-- таблица, колонка, €вл€етс€ ли айдентити
select * from sys.objects
where type = 'pk'


select  sys.tables.name table_name, sys.columns.name 'column'  
from
sys.tables join sys.columns on sys.columns.object_id = object_id(sys.tables.name)

select * from information_schema.tables


select * from sys.objects where type = 'u'
select * from sys.schemas

select * from information_schema.key_column_usage
	select * from information_schema.key_column_usage

	select * from information_schema.table_constraints




	select * from sys.tables;



	with t0 as 
(	
select constraint_name, count(constraint_name) as num from 
information_schema.key_column_usage
group by constraint_name
),

	 t1 as(
SELECT t.table_name, k.COLUMN_NAME
FROM 
information_schema.table_constraints t
JOIN information_schema.key_column_usage k
on t.constraint_name = k.constraint_name
join t0 on t.constraint_name = t0.constraint_name
WHERE 
t.constraint_type='PRIMARY KEY'
and k.column_name like '%[_][i][d]' 
and t0.num = 1)

select t1.table_name, t1.column_name, is_identity
from
t1, sys.columns t2
where 
t2.name = t1.column_name
and t2.object_id = object_id(t1.table_name);




select * from sys.foreign_keys

select NAME,
TYPE,
S.object_id
from sys.objects as s
where s.type = 'PK' or s.type = 'F'


/*
sys.objects
sys.schemas
sys.database_principals
sys.tables
sys.foreign_keys
sys.columns
sys.types
*/

