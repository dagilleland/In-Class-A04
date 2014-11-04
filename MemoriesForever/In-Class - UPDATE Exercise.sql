--UPDATE EXERCISE
USE MemoriesForever
GO

-- Background investigation - what's in the tables now?
SELECT * FROM itemtype
SELECT * FROM item

--Question 1
-- Update the following records in the ItemType Table:
-- OLD RECORD                       NEW RECORD
-- ItemTypeID  ItemTypeDescription  ItemTypeID ItemTypeDescription
-- 1           Camera               5          Camera
-- 2           Lights               2          Bright Lights

--Changing the Primary key value causes a related recorded in Item to lose its parent record in ItemType. 
--Updating the primary key value is NEVER recomended.
UPDATE  itemType
   SET  ItemTypeID = 5
 WHERE  ItemTypeID = 1

-- The following, however, is quite acceptable
UPDATE  itemType
   SET  ItemTypeDescription = 'Bright Lights'
 WHERE  ItemTypeID = 2 -- Do NOT forget your WHERE clause

GO

--Question 2
-- Update the following records in the Item Table:
-- a) ItemID 1 is now $30/day and called a Canon G3
-- b) ItemID 4 is now ItemTypeID 5
-- c) ItemID 4 is now the same price as Item Number 1 (use a subquery to find out what the price of item 1 is! Do not hard code the price!)

-- 2a)
UPDATE Item
   SET PricePerDay = 30,
       ItemDescription = 'Canon G3'
 WHERE ItemID = 1

-- 2b)
--There is no ItemTypeId 5. Foreign Key values must have a matching value in the parent table.
UPDATE Item
   SET ItemTypeID = 5 -- This is our Foreign Key value
 WHERE ItemID = 4

-- 2c)
UPDATE Item
   SET PricePerDay = (SELECT PricePerDay
                      FROM   Item
                      WHERE  ItemID = 1) -- This WHERE affects subquery
 WHERE ItemID = 4 -- This WHERE affects the UPDATE
	

GO

--Question 3
-- Update the following records in the Staff Table:
-- SELECT * FROM Staff
-- a) StaffID 1 should have the wage that is equal to the average wage of all the other staff (do not include StaffID’s 1 current wage in the average calculation)
-- b) StaffID 2 got married to StaffID 3! Update StaffID 2  with the following changes:
--    StaffLastName: Pic
--    Wage: Same as StaffID3 (use subquery)
-- c) Update StaffID 12 to have a wage of 80 (note the message displayed)

-- 3a)
UPDATE Staff
   SET Wage = (SELECT AVG(Wage) FROM Staff WHERE StaffID <> 1)
 WHERE StaffID = 1

-- 3b)
UPDATE Staff
   SET StaffLastName = 'Pic',
       Wage = (SELECT Wage FROM Staff WHERE StaffID = 3)
 WHERE StaffID = 2

-- 3c)
-- 0 rows affected because updating a record that does not exist is not an error. 
UPDATE Staff
   SET Wage = 80
 WHERE StaffID = 12
