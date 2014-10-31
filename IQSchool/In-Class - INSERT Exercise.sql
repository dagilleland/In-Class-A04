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

INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES ('Super flash',25,4)
--Insert fails because the ItemTypeId (4) does not have a matching parent value in the relationship
INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES ('Canon EOS20D',30,1)
select * from item
INSERT INTO Item (ItemID, ItemDescription,PricePerDay,ItemTypeID)
VALUES (5,'HP 630',25,1)
--ItemId is an identity field and as such is populated by the server not the user.

INSERT INTO Item (ItemDescription,PricePerDay,ItemTypeID)
VALUES( 'Holdomatic',22,
(Select ItemTypeId from ItemType where ItemTypeDescription = 'Stand'))


GO
--3.  Add the following records into the StaffType Table:

INSERT INTO StaffType (StaffTypeID,StaffTypeDescription)
VALUES (1,'Videographer')


INSERT INTO StaffType (StaffTypeID,StaffTypeDescription)
VALUES (2,'Photographer')


INSERT INTO StaffType (StaffTypeID,StaffTypeDescription)
VALUES (1,'Mixer')
--duplicate primary key value so insert fails

INSERT INTO StaffType (StaffTypeDescription)
VALUES ('Sales')
--Did not provide a value for the StaffTypeID field which is a not null field


INSERT INTO StaffType (StafftypeID,StaffTypeDescription)
VALUES (3, 'Sales')

--4.  Add the following records into the Staff Table:
GO
INSERT INTO Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
VALUES (1, 'Joe','Cool','5551223212',23,'Jan 1 2007',1)
--Check constraint on the table says that the hire date must be greater than or equal to todays date

INSERT INTO Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
VALUES (1, 'Joe','Cool','5551223212',23,'Apr 2 2014',1)

INSERT INTO Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
VALUES (2, 'Susan','Photo','5556676612',15,'Apr 2 2014',3)


INSERT INTO Staff (StaffID,StaffFirstName,StaffLastName,Phone,Wage,HireDate,StaffTypeID)
VALUES (3, 'Jason','Pic','3332342123',
(Select max(wage) from Staff),(Select Hiredate from Staff where StaffFirstName = 'Joe' and StaffLastName ='Cool'),2)
