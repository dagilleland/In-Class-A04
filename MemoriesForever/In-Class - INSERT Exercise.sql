-- Insert Exercise
USE MemoriesForever
GO

--INSERT EXERCISE
--1. Add the following records into the ItemType Table:

-- ItemTypeID	ItemTypeDescription
-- 1            Camera
-- 2            Lights
-- 3 	        Stand
-- 2            Backdrop
-- 89899985225  Outfit
-- 4A           Other

INSERT INTO itemType (ItemTypeID, ItemTypeDescription)
VALUES               (1,          'Camera')

INSERT INTO itemType (ItemTypeID,ItemTypeDescription)
VALUES (2,'Lights')

INSERT INTO itemType (ItemTypeID,ItemTypeDescription)
VALUES (3,'Stand')

--duplicate primary key value so the following insert fails
INSERT INTO itemType (ItemTypeID,ItemTypeDescription)
VALUES (2,'backdrop')

--ItemTypeId is larger than the int datatype for that field
INSERT INTO itemType (ItemTypeID,ItemTypeDescription)
VALUES (89899985225,'outfit')

--4A is a string and the ItemTypeID is an integer field
INSERT INTO itemType (ItemTypeID,ItemTypeDescription)
VALUES ('4A','Other')
GO


--2. Add the following records into the Item Table:
-- ItemID    ItemDescription    PricePerDay    ItemTypeID
--           Canon G2           25             1
--           100W tungston      18             2
--           Super Flash        25             4
--           Canon EOS20D       30             1
-- 5         HP 630             25             1
--           Light Holdomatic   22             **
            
--**For Light Holdomatic the ItemType is a Stand. Use a subquery in this insert as we only know it is a stand and don’t know the ItemTypeID!

INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES ('Canon G2',25,1)

INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES ('100W tungston',18,2)

--Insert fails because the ItemTypeId (4) does not have a matching parent value in the relationship
INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES ('Super flash',25,4)

INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES ('Canon EOS20D',30,1)

-- Notice as we look at what's inserted so far that the value 3 for ItemID does not appear.
-- This value got "used up" as an identity value when the attempt to insert 'Super flash' failed.
select * from item -- let's take a peek at the data.....


--ItemId is an identity field and as such is populated by the server not the user.
INSERT INTO Item (ItemID, ItemDescription,PricePerDay,ItemTypeID)
VALUES (5,'HP 630',25,1)

-- When we insert a row of data for a table where we need a foreign key,
-- we can use a subquery to get the foreign key value off of some other known
-- value in the related table.
INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES( 'Holdomatic',22,
(Select ItemTypeId from ItemType where ItemTypeDescription = 'Stand'))
-- P.S. - Since we are inserting a single row (the use of the VALUES keyword),
--        we need to make sure that our subquery also returns a single row with
--        a single value


GO
--3.  Add the following records into the StaffType Table:
-- StaffTypeID    StaffTypeDescription
-- 1              Videographer
-- 2              Photographer
-- 1              Mixer
--                Sales
-- 3              Sales

INSERT INTO StaffType (StaffTypeID,StaffTypeDescription)
VALUES (1,'Videographer')


INSERT INTO StaffType (StaffTypeID,StaffTypeDescription)
VALUES (2,'Photographer')


--duplicate primary key value so insert fails
INSERT INTO StaffType (StaffTypeID,StaffTypeDescription)
VALUES (1,'Mixer')

--Did not provide a value for the StaffTypeID field which is a not null field
INSERT INTO StaffType (StaffTypeDescription)
VALUES ('Sales')


INSERT INTO StaffType (StafftypeID,StaffTypeDescription)
VALUES (3, 'Sales')

GO

--4.  Add the following records into the Staff Table:
-- StaffID	StaffFirstName	StaffLastName	Phone	Wage	HireDate	StaffTypeID
-- 1        Joe             Cool            5551223212	23	Jan 1 2007	1
-- 1        Joe             Cool            5551223212	23	Apr 2 2012	1
-- 2        Sue             Photo           5556676612	15	Apr 2 2012	3
-- 3        Jason           Pic             3332342123	***	***	        2
-- ***StaffID 3 will have the same wage as the highest wage of all the staff. HireDate will be the same hire date as Joe Cool. Use subqueries for these fields.

--Check constraint on the table says that the hire date must be greater than or equal to todays date
INSERT INTO Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
VALUES (1, 'Joe','Cool','5551223212',23,'Jan 1 2007',1)

INSERT INTO Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
VALUES (1, 'Joe','Cool','5551223212',23,'Apr 2 2015',1)

INSERT INTO Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
VALUES (2, 'Susan','Photo','5556676612',15,'Apr 2 2015',3)


INSERT INTO Staff (StaffID,
                   StaffFirstName,
                   StaffLastName,
                   Phone,
                   Wage,
                   HireDate,
                   StaffTypeID)
VALUES (3,
       'Jason',
       'Pic',
       '3332342123',
       (SELECT max(Wage) FROM Staff),
       (SELECT Hiredate FROM Staff
        WHERE  StaffFirstName = 'Joe'
          AND  StaffLastName = 'Cool'),
       2)

