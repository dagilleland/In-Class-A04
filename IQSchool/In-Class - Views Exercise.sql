-- Views Exercise
USE IQSchool
GO

-- 1. Create a view of staff full names called staff_list.
CREATE VIEW staff_list
AS
    SELECT FirstName + ' ' + LastName AS 'StaffName'
    FROM Staff

