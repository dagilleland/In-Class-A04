-- In SQL, a single-line comment begins with two dashes
/* Multiline comments work just like in C#
   The comment begins with a slash and asterix,
   and ends with an asterix and slash
*/
USE [ESP-Db] -- this is a statement that tells us to switch to a particular database
-- Notice in the database name above, I had to "wrap" the name in square brackets
-- because the name had a hypen in it. 
-- For our objects (tables, columns, etc), we won't use hypens or spaces, so
-- the brackets are optional...
GO -- this statement helps to "separate" various DDL statements in our script

/* DROP TABLE statements (to "clean up" the database for re-creation) */
DROP TABLE OrderDetails
DROP TABLE InventoryItems
DROP TABLE CustomerOrders
DROP TABLE Customers
GO

-- To create a database table, we use the CREATE TABLE statement.
CREATE TABLE Customers
(
    CustomerNumber  int
        PRIMARY KEY
        IDENTITY(100, 1)            ,
    FirstName       varchar(50)     ,
    LastName        varchar(60)     ,
    [Address]       varchar(40)     ,
    City            varchar(35)     ,
    Province        char(2)         ,
    PostalCode      char(6)         ,
    PhoneNumber     char(13)
)
GO

CREATE TABLE CustomerOrders
(
    OrderNumber     int
        PRIMARY KEY
        IDENTITY(200,1)                 ,
    CustomerNumber  int
        FOREIGN KEY REFERENCES
            Customers(CustomerNumber)   ,
    [Date]          datetime            ,
    Subtotal        money               ,
    GST             money               ,
    Total           money           
)
GO

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5)
        PRIMARY KEY                     ,
    ItemDescription     varchar(50)     ,
    CurrentSalePrice    money           ,
    InStockCount        int             ,
    ReorderLevel        int
)
GO

-- NOTE: Composite Keys are always written up as Table-Level Constraints
CREATE TABLE OrderDetails
(
    OrderNumber         int
        FOREIGN KEY REFERENCES
            CustomerOrders(OrderNumber) ,
    ItemNumber          varchar(5)
        FOREIGN KEY REFERENCES
            InventoryItems(ItemNumber)  ,
    Quantity            smallint        ,
    SellingPrice        money           ,
    Amount              money           ,
    -- The following is a Table Constraint
    PRIMARY KEY (OrderNumber, ItemNumber)
)
