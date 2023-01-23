/* Чтобы предотвратить возможность потери данных, необходимо внимательно просмотреть этот скрипт, прежде чем запускать его вне контекста конструктора баз данных.*/
BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.slot
	DROP CONSTRAINT fk_slot_tariff_id
GO
ALTER TABLE dbo.runway_tariff SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.slot
	DROP CONSTRAINT fk_slot_aircraft_model_id
GO
ALTER TABLE dbo.aircraft
	DROP CONSTRAINT fk_aircraft_model_id
GO
ALTER TABLE dbo.model SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_airline
	(
	airline_id bigint NOT NULL IDENTITY (1, 1),
	name varchar(50) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_airline SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_airline ON
GO
IF EXISTS(SELECT * FROM dbo.airline)
	 EXEC('INSERT INTO dbo.Tmp_airline (airline_id, name)
		SELECT CONVERT(bigint, airline_id), name FROM dbo.airline WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_airline OFF
GO
ALTER TABLE dbo.slot
	DROP CONSTRAINT fk_slot_airline_id
GO
ALTER TABLE dbo.aircraft
	DROP CONSTRAINT fk_aircraft_airline_id
GO
DROP TABLE dbo.airline
GO
EXECUTE sp_rename N'dbo.Tmp_airline', N'airline', 'OBJECT' 
GO
ALTER TABLE dbo.airline ADD CONSTRAINT
	PK__airline__A016BF80778B6B20 PRIMARY KEY CLUSTERED 
	(
	airline_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_aircraft
	(
	aircraft_id int NOT NULL IDENTITY (1, 1),
	airline_id bigint NULL,
	model_id int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_aircraft SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_aircraft ON
GO
IF EXISTS(SELECT * FROM dbo.aircraft)
	 EXEC('INSERT INTO dbo.Tmp_aircraft (aircraft_id, airline_id, model_id)
		SELECT aircraft_id, CONVERT(bigint, airline_id), model_id FROM dbo.aircraft WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_aircraft OFF
GO
ALTER TABLE dbo.flight
	DROP CONSTRAINT fk_flight_aircraft_id
GO
ALTER TABLE dbo.aircraft_service
	DROP CONSTRAINT fk_aircraft_parking_service_aircraft_id
GO
ALTER TABLE dbo.parking
	DROP CONSTRAINT fk_parking_aircraft_id
GO
DROP TABLE dbo.aircraft
GO
EXECUTE sp_rename N'dbo.Tmp_aircraft', N'aircraft', 'OBJECT' 
GO
ALTER TABLE dbo.aircraft ADD CONSTRAINT
	PK__aircraft__040153991BA598C2 PRIMARY KEY CLUSTERED 
	(
	aircraft_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.aircraft ADD CONSTRAINT
	fk_aircraft_model_id FOREIGN KEY
	(
	model_id
	) REFERENCES dbo.model
	(
	model_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.aircraft ADD CONSTRAINT
	fk_aircraft_airline_id FOREIGN KEY
	(
	airline_id
	) REFERENCES dbo.airline
	(
	airline_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.parking ADD CONSTRAINT
	fk_parking_aircraft_id FOREIGN KEY
	(
	aircraft_id
	) REFERENCES dbo.aircraft
	(
	aircraft_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
ALTER TABLE dbo.parking SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.aircraft_service ADD CONSTRAINT
	fk_aircraft_parking_service_aircraft_id FOREIGN KEY
	(
	aircraft_id
	) REFERENCES dbo.aircraft
	(
	aircraft_id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.aircraft_service SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
CREATE TABLE dbo.Tmp_slot
	(
	slot_id int NOT NULL IDENTITY (1, 1),
	date date NULL,
	beginning_time time(7) NULL,
	end_time time(7) NULL,
	aircraft_model_id int NULL,
	airline_id bigint NULL,
	tariff_id int NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_slot SET (LOCK_ESCALATION = TABLE)
GO
SET IDENTITY_INSERT dbo.Tmp_slot ON
GO
IF EXISTS(SELECT * FROM dbo.slot)
	 EXEC('INSERT INTO dbo.Tmp_slot (slot_id, date, beginning_time, end_time, aircraft_model_id, airline_id, tariff_id)
		SELECT slot_id, date, beginning_time, end_time, aircraft_model_id, CONVERT(bigint, airline_id), tariff_id FROM dbo.slot WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_slot OFF
GO
ALTER TABLE dbo.flight
	DROP CONSTRAINT fk_flight_slot_id
GO
ALTER TABLE dbo.maintenance
	DROP CONSTRAINT fk_maintenance_slot_id
GO
DROP TABLE dbo.slot
GO
EXECUTE sp_rename N'dbo.Tmp_slot', N'slot', 'OBJECT' 
GO
ALTER TABLE dbo.slot ADD CONSTRAINT
	PK__slot__971A01BBD142736E PRIMARY KEY CLUSTERED 
	(
	slot_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
ALTER TABLE dbo.slot ADD CONSTRAINT
	fk_slot_aircraft_model_id FOREIGN KEY
	(
	aircraft_model_id
	) REFERENCES dbo.model
	(
	model_id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.slot ADD CONSTRAINT
	fk_slot_airline_id FOREIGN KEY
	(
	airline_id
	) REFERENCES dbo.airline
	(
	airline_id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.slot ADD CONSTRAINT
	fk_slot_tariff_id FOREIGN KEY
	(
	tariff_id
	) REFERENCES dbo.runway_tariff
	(
	tariff_id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.maintenance ADD CONSTRAINT
	fk_maintenance_slot_id FOREIGN KEY
	(
	slot_id
	) REFERENCES dbo.slot
	(
	slot_id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.maintenance SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.flight ADD CONSTRAINT
	fk_flight_slot_id FOREIGN KEY
	(
	slot_id
	) REFERENCES dbo.slot
	(
	slot_id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.flight ADD CONSTRAINT
	fk_flight_aircraft_id FOREIGN KEY
	(
	aircraft_id
	) REFERENCES dbo.aircraft
	(
	aircraft_id
	) ON UPDATE  CASCADE 
	 ON DELETE  CASCADE 
	
GO
ALTER TABLE dbo.flight SET (LOCK_ESCALATION = TABLE)
GO
COMMIT
