SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [_dta_index_Customers_6_2026542353__K9_K1_2_3_4_5_6_7_8_10_11] ON [dbo].[Customers]
(
	[Country] ASC,
	[CustomerID] ASC
)
INCLUDE([CompanyName],[ContactName],[ContactTitle],[Address],[City],[Region],[PostalCode],[Phone],[Fax]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [_dta_index_Orders_6_2042542410__K14_K3_K2_1_4_5_6_7_8_9_10_11_12_13] ON [dbo].[Orders]
(
	[ShipCountry] ASC,
	[EmployeeID] ASC,
	[CustomerID] ASC
)
INCLUDE([OrderID],[OrderDate],[RequiredDate],[ShippedDate],[ShipVia],[Freight],[ShipName],[ShipAddress],[ShipCity],[ShipRegion],[ShipPostalCode]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [_dta_index_Orders_6_2042542410__K2_K14_K3_1_4_5_6_7_8_9_10_11_12_13] ON [dbo].[Orders]
(
	[CustomerID] ASC,
	[ShipCountry] ASC,
	[EmployeeID] ASC
)
INCLUDE([OrderID],[OrderDate],[RequiredDate],[ShippedDate],[ShipVia],[Freight],[ShipName],[ShipAddress],[ShipCity],[ShipRegion],[ShipPostalCode]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]
GO

DROP INDEX CUSTOMERS.[_dta_index_Customers_6_2026542353__K9_K1_2_3_4_5_6_7_8_10_11];
DROP INDEX ORDERS.[_dta_index_Orders_6_2042542410__K14_K3_K2_1_4_5_6_7_8_9_10_11_12_13];
DROP INDEX ORDERS.[_dta_index_Orders_6_2042542410__K2_K14_K3_1_4_5_6_7_8_9_10_11_12_13]

SELECT * FROM SYS.INDEXES 
WHERE OBJECT_ID IN (SELECT OBJECT_ID FROM SYS.TABLES)