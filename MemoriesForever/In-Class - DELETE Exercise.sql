--DELETE EXERCISE
USE MemoriesForever
GO

-- 1. Delete the Staff with StaffID 8
--    0 rows affected. Deleting records that do not exist does not cause an error
DELETE Staff
WHERE  StaffID = 8

-- 2. Delete StaffTypeId 1
--    cannot Delete the stafftypeId 1 because that value is in the foreign key field for child records (Staff)
Delete StaffType where StaffTypeID = 1

-- 3. Delete all the staff whose wage is less than the average wage of all staff
Delete Staff where Wage < (Select AVG(wage) from Staff)

-- 4. Try and Delete StaffTypeID 1 again. Why did it work this time?
Delete StaffType where StaffTypeID = 1

-- 5. Delete ItemID 5
Delete Item where ItemID = 5

-- 6. Delete all the ItemTypes that do not have any Items
Delete itemType where ItemTypeID not in (select ItemTypeID from item)

-- 7. Delete all the Items
SELECT * FROM Item
DELETE ITEM
