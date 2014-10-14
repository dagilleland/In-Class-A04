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
    ItemDescription     varchar(50)     NOT NULL,
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

-- A) Allow Address, City, Province, Postal Code and Phone to be NULL
ALTER TABLE Customer
    ALTER COLUMN [Address] varchar(50) NULL
GO
ALTER TABLE Customer
    ALTER COLUMN City varchar(40) NULL
GO
ALTER TABLE Customer
    ALTER COLUMN Province varchar(2) NULL
GO
ALTER TABLE Customer
    ALTER COLUMN PostalCode char(7) NULL
GO
ALTER TABLE Customer
    ALTER COLUMN Phone char(13) NULL
GO

-- B) Add a check constraint on First and Last name to require at least two letters
/* -- Run these commented out statements to drop constraints, if needed - 
ALTER TABLE Customer
    DROP CONSTRAINT CK_Customer_FirstName
GO
ALTER TABLE Customer
    DROP CONSTRAINT CK_Customer_LastName
GO
*/
ALTER TABLE Customer
    ADD CONSTRAINT CK_Customer_FirstName
        CHECK (FirstName LIKE '__%') -- ANY 2 characters
GO
ALTER TABLE Customer
    ADD CONSTRAINT CK_Customer_LastName
        CHECK (LastName LIKE '[A-Z][A-Z]%') -- 2 Letters
GO

-- C) Add a default constraint on the Order.[Date] to use the current date
ALTER TABLE [Order]
    ADD CONSTRAINT DF_Order_Date
        DEFAULT GETDATE() FOR [Date]
GO

-- D) Change the Item.Description column to be NOT NULL
--    1) Put a Default constraint in place
ALTER TABLE Item
    ADD CONSTRAINT DF_Item_Description DEFAULT '-no description-' FOR [Description]
GO

--    2) Update existing NULL columns with replacement text
UPDATE  Item
    SET     [Description] = '-missing-'
    WHERE   [Description] IS NULL
GO

--    3) Change the column to be NOT NULL
ALTER TABLE Item
    ALTER COLUMN [Description] varchar(50)  NOT NULL
GO

-- E) Add indexes to the Customer's First and Last Names 
--    as well as to the Item's Description column.
CREATE NONCLUSTERED INDEX IX_Customer_FirstName
    ON  Customer ( FirstName )
GO
CREATE NONCLUSTERED INDEX IX_Customer_LastName
    ON  Customer ( LastName )
GO
--    This index is for two columns AS A GROUP
CREATE NONCLUSTERED INDEX IX_Customer_LastName_FirstName
    ON  Customer ( LastName, FirstName )
GO
--    To Drop an index, use the DROP INDEX statement
DROP INDEX IX_Customer_LastName_FirstName
    ON  Customer
GO

-- F) Add a Unique constraint to the Item's Description column
ALTER TABLE Item
    ADD CONSTRAINT UX_Item_Description
        UNIQUE (Description)
GO

-- G) Add additional tables: PaymentLogDetails, and Payment
 

-- H) Rename Column
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
EXEC sp_help Customer
GO
EXEC sp_help [Order]
GO
EXEC sp_help Item
GO
EXEC sp_help OrderDetail
GO
*/








