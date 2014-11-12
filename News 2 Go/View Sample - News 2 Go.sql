USE [lab2-2014]
GO

CREATE VIEW DropSiteDeliverOrders
AS
    SELECT  DS.DropSiteId AS 'Drop Site ID',
            DS.DropSiteName AS 'Drop Site Name',
            DS.DropSiteAddress AS 'Drop Site Address',
            R.RouteID AS 'Route ID',
            R.RouteName AS 'Route Name',
            C.CarrierID AS 'Carrier ID',
            C.CarrierFirstName + ' ' + C.CarrierLastName AS 'Carrier Name',
            C.Phone AS 'Carrier Phone'
    FROM    DropSite DS
        INNER JOIN [Route] R ON DS.DropSiteId = R.DropSiteID
        INNER JOIN Carrier C ON R.CarrierId = C.CarrierID

-- Select the Drop Site Delivery Orders for Drop Site #20

SELECT [Drop Site ID]
      ,[Drop Site Name]
      ,[Drop Site Address]
      ,[Route ID]
      ,[Route Name]
      ,[Carrier ID]
      ,[Carrier Name]
      ,[Carrier Phone]
  FROM [dbo].[DropSiteDeliverOrders]
  WHERE [Drop Site ID] = 20
GO

