SET ANSI_PADDING ON

CREATE NONCLUSTERED INDEX [_dta_index_Customers_6_2026542353__K9_K1_K8_2_6] ON [dbo].[Customers]
(
	[Country] ASC,
	[CustomerID] ASC,
	[PostalCode] ASC
)
INCLUDE([CompanyName],[City]) WITH (SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF) ON [PRIMARY]



