/* **********************************************
 * Complete Table Creation
 *      - Includes complete text for various kinds
 *        of constraints: Primary Key, Foreign
 *        Key, Default, Check, and Calculated
 *        Columns
 *      - Includes INSERT statements for data
 *      - Includes Alter Table statements for
 *        Adding columns, constraints, etc.
 * Emergency Service & Product
 * Specification Document 1
 * Version 4.0.0
 ********************************************** */
/*
    Putting stuff between the [slash][asterix] and the
    [asterix][slash] means that this stuff inside is a
    multi-line comment.
    
    [CTRL] + r            -- toggles the "results" pane
    [CTRL] + [SHIFT] + r  -- intellisense - refresh local cache
*/
-- this is a single-line comment (starts with two dashes)
-- CREATE DATABASE [ESP-Db]
USE [ESP-Db] -- this is a statement that tells us to switch to a particular database
-- Notice in the database name above, I had to "wrap" the name in square brackets
-- because the name had a hypen in it. 
-- For our objects (tables, columns, etc), we won't use hypens or spaces, so
-- the brackets are optional...
GO -- this statement helps to "separate" various DDL statements in our script

/* DROP TABLE statements (to "clean up" the database for re-creation) */
-- Tables from Specification Document 3
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PurchaseOrderItems')
    DROP TABLE PurchaseOrderItems
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PurchaseOrders')
    DROP TABLE PurchaseOrders
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Suppliers')
    DROP TABLE Suppliers

-- Tables from Specification Document 2
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'PaymentLogDetails')
    DROP TABLE PaymentLogDetails
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Payments')
    DROP TABLE Payments

-- Tables from Specification Document 2
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'OrderDetails')
    DROP TABLE OrderDetails
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'InventoryItems')
    DROP TABLE InventoryItems
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'CustomerOrders')
    DROP TABLE CustomerOrders
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Customers')
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
    Province        char(2)         
        CONSTRAINT DF_Customers_Province
            DEFAULT ('AB')                    -- Strings are in single quotes
        CONSTRAINT CK_Customers_Province
            CHECK  (Province LIKE 'AB' OR
                    Province LIKE 'BC' OR
                    Province LIKE 'SK' OR
                    Province LIKE 'MB' OR
                    Province LIKE 'QC' OR
                    Province LIKE 'ON' OR
                    Province LIKE 'NT' OR
                    Province LIKE 'NS' OR
                    Province LIKE 'NB' OR
                    Province LIKE 'NL' OR
                    Province LIKE 'YK' OR
                    Province LIKE 'NU' OR
                    Province LIKE 'PE')
                                    NOT NULL,
    PostalCode      char(6)         
        CONSTRAINT CK_Customers_PostalCode
            CHECK (PostalCode LIKE
                    '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
                                    NOT NULL,
    PhoneNumber     char(13)            
        CONSTRAINT CK_Customers_PhoneNumber
            CHECK (PhoneNumber LIKE
                '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
                                        NULL  -- Optional - can be "blank"
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
    Subtotal        money               
        CONSTRAINT CK_CustomerOrders_Subtotal
            CHECK (Subtotal > 0)
                                        NOT NULL,
    GST             money               
        CONSTRAINT CK_CustomerOrders_GST
            CHECK (GST >= 0)
                                        NOT NULL,
    Total           AS Subtotal + GST   -- Compute the Total instead of storing it
)
GO

CREATE TABLE InventoryItems
(
    ItemNumber          varchar(5)
        CONSTRAINT PK_InventoryItems_ItemNumber
        PRIMARY KEY                     NOT NULL,
    ItemDescription     varchar(50)         NULL, -- Allow description to be NULL
    CurrentSalePrice    money           
        CONSTRAINT CK_Item_CurrentSalePrice
            CHECK (CurrentSalePrice > 0)
                                        NOT NULL,
    InStockCount        int             NOT NULL,
    ReorderLevel        int                NOT NULL
)
GO

-- NOTE: Composite Keys are always written up as Table-Level Constraints
CREATE TABLE OrderDetails
(
    OrderNumber         int
        CONSTRAINT FK_OrderDetails_OrderNumber_CustomerOrders_OrderNumber
        FOREIGN KEY REFERENCES
            CustomerOrders(OrderNumber) NOT NULL,
    ItemNumber          varchar(5)
        CONSTRAINT FK_OrderDetails_ItemNumber_InventoryItems_ItemNumber
        FOREIGN KEY REFERENCES
            InventoryItems(ItemNumber)  NOT NULL,
    Quantity            smallint        
        CONSTRAINT DF_OrderDetails_Quantity
            DEFAULT (1)
        CONSTRAINT CK_OrderDetails_Quantity
            CHECK (Quantity > 0)
                                        NOT NULL,
    SellingPrice        money           
        CONSTRAINT CK_OrderDetails_SellingPrice
            CHECK (SellingPrice >= 0)
                                        NOT NULL,
    Amount            AS Quantity * SellingPrice, -- Computed Column
    -- The following is a Table Constraint
    CONSTRAINT PK_OrderDetails_OrderNumber_ItemNumber
    PRIMARY KEY (OrderNumber, ItemNumber)
)


/* **********************************************
 * Specification Document 2 - Design Changes
 *      Perform table changes through ALTER statements
 *      Add additional tables with CREATE statments
 * ******************************************* */
-- Syntax for ALTER TABLE can be found at
--  http://msdn.microsoft.com/en-us/library/ms190273.aspx
-- ALTER TABLE statements allow us to change an existing table without
-- having to drop it or lose information in the table

-- A) Allow Address, City, Province, Postal Code and Phone to be NULL
ALTER TABLE Customers
    ALTER COLUMN [Address] varchar(40) NULL
GO
ALTER TABLE Customers
    ALTER COLUMN City varchar(35) NULL
GO
ALTER TABLE Customers
    ALTER COLUMN Province char(2) NULL
GO
ALTER TABLE Customers
    ALTER COLUMN PostalCode char(6) NULL
GO
ALTER TABLE Customers
    ALTER COLUMN PhoneNumber char(13) NULL

-- B) Add a check constraint on First and Last name to require at least two letters
/* -- Run these commented out statements to drop constraints, if needed - 
ALTER TABLE Customer
    DROP CONSTRAINT CK_Customers_FirstName
GO
ALTER TABLE Customer
    DROP CONSTRAINT CK_Customers_LastName
GO
*/
-- % is a wildcard for zero or more characters (letter, digit, or other character)
ALTER TABLE Customers
    ADD CONSTRAINT CK_Customers_FirstName
        CHECK (FirstName LIKE '__%') -- ANY 2 characters
GO
ALTER TABLE Customers
    ADD CONSTRAINT CK_Customers_LastName
        CHECK (LastName LIKE '[A-Z][A-Z]%') -- 2 or more Letters
GO

-- C) Add a default constraint on the CustomerOrders.Date to use the current date
-- GETDATE() is a global function in the SQL Server Database
-- GETDATE() will obtain the current date on the database server
ALTER TABLE CustomerOrders
    ADD CONSTRAINT DF_CustomerOrders_Date
        DEFAULT GETDATE() FOR [Date]
GO

-- D) Change the InventoryItems.ItemDescription column to be NOT NULL
-- Create some sample data to demonstrate....
INSERT INTO InventoryItems(ItemNumber, ItemDescription, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('GR35A', NULL, 45.95, 8, 5)
GO

--    1) Put a Default constraint in place (a good practice)
ALTER TABLE InventoryItems
    ADD CONSTRAINT DF_InventoryItems_Description DEFAULT '-no description-' FOR ItemDescription
GO
-- demonstrate that the default is in place
INSERT INTO InventoryItems(ItemNumber, CurrentSalePrice, InStockCount, ReorderLevel)
    VALUES('GR47D', 92.45, 3, 3)
GO

--    2) Update existing NULL columns with replacement text
UPDATE  InventoryItems
    SET     ItemDescription = '-missing-'
    WHERE   ItemDescription IS NULL
GO

--    3) Change the column to be NOT NULL
ALTER TABLE InventoryItems
    ALTER COLUMN ItemDescription varchar(50)  NOT NULL
GO

-- E) Add indexes to the Customer's First and Last Names 
--    as well as to the Item's Description column.
-- Indexes improve the performance of the database when retrieving information.
CREATE NONCLUSTERED INDEX IX_Customers_FirstName
    ON  Customers ( FirstName )
GO
CREATE NONCLUSTERED INDEX IX_Customers_LastName
    ON  Customers ( LastName )
GO
--    This index is for two columns AS A GROUP
CREATE NONCLUSTERED INDEX IX_Customers_LastName_FirstName
    ON  Customers ( LastName, FirstName )
GO
--    To Drop an index, use the DROP INDEX statement
DROP INDEX IX_Customers_LastName_FirstName
    ON  Customers
GO

-- F) Add additional tables: PaymentLogDetails, and Payments
CREATE TABLE Payments
(
    PaymentID           int
        CONSTRAINT PK_Payments_PaymentID
            PRIMARY KEY
        IDENTITY(1,1)                   NOT NULL,
    [Date]              datetime        NOT NULL,
    PaymentAmount       money           NOT NULL,
    PaymentType         varchar(7)      
        CONSTRAINT CK_Payments_PaymentType
            CHECK  (PaymentType = 'Cash' OR
                    PaymentType = 'Cheque' OR
                    PaymentType = 'Credit')
                                        NOT NULL
)
GO

CREATE TABLE PaymentLogDetails
(
    OrderNumber         int
        CONSTRAINT FK_PaymentLogDetails_OrderNumber_CustomerOrders_OrderNumber
            FOREIGN KEY REFERENCES
            CustomerOrders(OrderNumber) NOT NULL,
    PaymentID           int
        CONSTRAINT FK_PaymentLogDetails_PaymentID_Payments_PaymentID
            FOREIGN KEY REFERENCES
            Payments(PaymentID)         NOT NULL,
    PaymentNumber       smallint        NOT NULL,
    BalanceOwing        money           NOT NULL,
    DepositBatchNumber  int             NOT NULL,
    -- The following is a Table Constraint
    CONSTRAINT PK_PaymentLogDetails_OrderNumber_PaymentID
    PRIMARY KEY (OrderNumber, PaymentID)
)
GO

/* **********************************************
 * Specification Document 3 - Design Changes
 *      Add additional tables with CREATE statments
 * ******************************************* */
-- G) Add additional tables: Suppliers, PurchaseOrders, and PurchaseOrderItems
CREATE TABLE Suppliers
(
    SupplierNumber  int
        CONSTRAINT PK_Suppliers_SupplierNumber
        PRIMARY KEY
        IDENTITY(100, 1)            NOT NULL,
    SupplierName    varchar(65)     NOT NULL,
    [Address]       varchar(40)     NOT NULL,
    City            varchar(35)     NOT NULL,
    Province        char(2)         
        CONSTRAINT CK_Suppliers_Province
            CHECK  (Province LIKE 'AB' OR
                    Province LIKE 'BC' OR
                    Province LIKE 'SK' OR
                    Province LIKE 'MB' OR
                    Province LIKE 'QC' OR
                    Province LIKE 'ON' OR
                    Province LIKE 'NT' OR
                    Province LIKE 'NS' OR
                    Province LIKE 'NB' OR
                    Province LIKE 'NL' OR
                    Province LIKE 'YK' OR
                    Province LIKE 'NU' OR
                    Province LIKE 'PE')
                                    NOT NULL,
    PostalCode      char(6)         
        CONSTRAINT CK_Suppliers_PostalCode
            CHECK (PostalCode LIKE
                    '[A-Z][0-9][A-Z][0-9][A-Z][0-9]')
                                    NOT NULL,
    Phone           char(13)            
        CONSTRAINT CK_Suppliers_Phone
            CHECK (Phone LIKE
                '([0-9][0-9][0-9])[0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
                                    NOT NULL
)
GO

CREATE TABLE PurchaseOrders
(
    PurchaseOrderNumber     int
        CONSTRAINT PK_PurchaseOrders_PurchaseOrderNumber
            PRIMARY KEY
        IDENTITY(1,1)                   NOT NULL,
    SupplierNumber          int
        CONSTRAINT FK_PurchaseOrders_SupplierNumber_Suppliers_SupplierNumber
        FOREIGN KEY REFERENCES
            Suppliers(SupplierNumber)   NOT NULL,
    [Date]                  datetime    NOT NULL,
    Subtotal                money               
        CONSTRAINT CK_PurchaseOrders_Subtotal
            CHECK (Subtotal > 0)
                                        NOT NULL,
    GST                     money               
        CONSTRAINT CK_PurchaseOrders_GST
            CHECK (GST >= 0)
                                        NOT NULL,
    Total           AS Subtotal + GST   -- Compute the Total instead of storing it
)
GO

-- NOTE: Composite Keys are always written up as Table-Level Constraints
CREATE TABLE PurchaseOrderItems
(
    PurchaseOrderNumber     int
        CONSTRAINT FK_PurchaseOrderItems_PurchaseOrderNumber_PurchaseOrders_PurchaseOrderNumber
        FOREIGN KEY REFERENCES
            CustomerOrders(OrderNumber) NOT NULL,
    ItemNumber              varchar(5)
        CONSTRAINT FK_PurchaseOrderItems_ItemNumber_InventoryItems_ItemNumber
        FOREIGN KEY REFERENCES
            InventoryItems(ItemNumber)  NOT NULL,
    SupplierItemNumber      varchar(25)     NULL,
    SupplierDescription     varchar(25)     NULL,
    Quantity                smallint        
        CONSTRAINT DF_PurchaseOrderItems_Quantity
            DEFAULT (1)
        CONSTRAINT CK_PurchaseOrderItems_Quantity
            CHECK (Quantity > 0)
                                        NOT NULL,
    Cost                    money           
        CONSTRAINT CK_PurchaseOrderItems_Cost
            CHECK (Cost >= 0)
                                        NOT NULL,
    Amount                  AS Quantity * Cost  , -- Computed Column
    -- The following is a Table Constraint
    CONSTRAINT PK_PurchaseOrderItems_PurchaseOrderNumber_ItemNumber
    PRIMARY KEY (PurchaseOrderNumber, ItemNumber)
)

-- H) Add a Unique constraint to the Supplier's SupplierName column
-- Unique constraints prevent duplicate values for a given column
ALTER TABLE Suppliers
    ADD CONSTRAINT UX_Suppliers_SupplierName
        UNIQUE (SupplierName)
GO

-- I) Rename Column
--      (not possible in a single ALTER statement in SQL Server,
--       even though it is possible in other RDBMSs, like MySQL and Oracle.)
--      You would have to 
--          1) add a new column,
--          2) copy data from the old column to the new column, and
--          3) delete the old column 

 


/* ***********************************************
 * END OF SCRIPT - END OF SCRIPT - END OF SCRIPT *
 * ********************************************* */
/*
-- The following lines run a "stored procedure" to give information on the named table
-- Select these lines to see details on the tables.
EXEC sp_help Customers
GO
EXEC sp_help CustomerOrders
GO
EXEC sp_help InventoryItems
GO
EXEC sp_help OrderDetails
GO
*/








