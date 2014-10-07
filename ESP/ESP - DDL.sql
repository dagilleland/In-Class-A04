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
		CONSTRAINT PK_Customers_CustomerNumber
        PRIMARY KEY
        IDENTITY(100, 1)            NOT NULL, -- NOT NULL when data is Required
    FirstName       varchar(50)     NOT NULL,
    LastName        varchar(60)     NOT NULL,
    [Address]       varchar(40)     NOT NULL,
    City            varchar(35)     NOT NULL,
    Province        char(2)         NOT NULL,
    PostalCode      char(6)         NOT NULL,
    PhoneNumber     char(13)		    NULL  -- Optional - can be "blank"
)
GO

CREATE TABLE CustomerOrders
(
    OrderNumber     int
        CONSTRAINT PK_CustomerOrders_OrderNumber
			PRIMARY KEY
        IDENTITY(200,1)                 NOT NULL,
    CustomerNumber  int
        CONSTRAINT FK_CustomerOrders_CustomerNumber_Customers_CustomerNumber
		FOREIGN KEY REFERENCES
            Customers(CustomerNumber)   NOT NULL,
    [Date]          datetime            NOT NULL,
    Subtotal        money               NOT NULL,
    GST             money               NOT NULL,
    Total           money				NOT NULL
)
GO

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5)
        CONSTRAINT PK_InventoryItems_ItemNumber
		PRIMARY KEY                     NOT NULL,
    ItemDescription     varchar(50)     NOT NULL,
    CurrentSalePrice    money           NOT NULL,
    InStockCount        int             NOT NULL,
    ReorderLevel        int				NOT NULL
)
GO

-- NOTE: Composite Keys are always written up as Table-Level Constraints
CREATE TABLE OrderDetails
(
    OrderNumber         int
        FOREIGN KEY REFERENCES
            CustomerOrders(OrderNumber) NOT NULL,
    ItemNumber          varchar(5)
        FOREIGN KEY REFERENCES
            InventoryItems(ItemNumber)  NOT NULL,
    Quantity            smallint        NOT NULL,
    SellingPrice        money           NOT NULL,
    Amount              money           NOT NULL,
    -- The following is a Table Constraint
    PRIMARY KEY (OrderNumber, ItemNumber)
)











