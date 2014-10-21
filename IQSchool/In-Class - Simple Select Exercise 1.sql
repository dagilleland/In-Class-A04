--SIMPLE SELECT EXERCISE 1
--USE THE IQSCHOOL DATABASE 
USE IQSchool
GO

--1.  Select all the information from the club table
SELECT  ClubID, ClubName
FROM    Club


--2. Select the FirstNames and LastNames of all the students
SELECT  FirstName, LastName
FROM    Student

--3. Select all the CourseId and CourseName of all the coureses. Use the column aliases of Course ID and Course Name
SELECT CourseId 'Course ID', CourseName 'Course Name'
FROM   Course
-- #3 - an alternate (more wordy) way
SELECT CourseId AS 'Course ID', CourseName AS 'Course Name'
FROM   Course


--4. Select all the course information for courseID 'DMIT101'
SELECT CourseID, CourseName, CourseHours, MaxStudents, CourseCost
FROM   Course
WHERE  CourseID = 'DMIT101'
-- TIP! You can use the sp_help stored procedure to get info on
--      a database table.....
-- sp_help Course -- sp_help gives us info about objects in the database, such as tables

--5. Select the Staff names who have positionID of 3
-- sp_help Staff
SELECT FirstName, LastName
FROM   Staff
WHERE  PositionID = 3

--6. select the CourseNames whose CourseHours are less than 96
SELECT CourseName
FROM   Course
WHERE  CourseHours < 96

--7. Select the studentID's, CourseID and mark where the Mark is between 70 and 80
SELECT StudentID, CourseID, Mark
FROM   Registration
WHERE  Mark BETWEEN 70 AND 80

-- 7.a Select the studentID's where the withdrawal status is null
SELECT StudentID --, CourseId
FROM   Registration
WHERE  WithdrawYN IS NULL

--8. Select the studentID's, CourseID and mark where the Mark is between 70 and 80 and the courseID is DMIT223 or DMIT168
SELECT StudentID, CourseId, Mark
FROM   Registration
WHERE  Mark BETWEEN 70 AND 80
  AND  (CourseId = 'DMIT223' OR CourseId = 'DMIT168')
-- alternate answer to #8
SELECT StudentID, CourseId, Mark
FROM   Registration
WHERE  Mark BETWEEN 70 AND 80
  AND  CourseId IN ('DMIT223', 'DMIT168')


--9. Select the students first and last names who have last names starting with S
SELECT FirstName, LastName
FROM   Student
WHERE  LastName LIKE 'S%'

--10. Select Coursenames whose CourseID  have a 1 as the fifth character
SELECT CourseName
FROM   Course
WHERE  CourseID LIKE '____1%' -- four underscores, 1, %
     --               DMIT158

--11. Select the CourseID's and Coursenames where the CourseName contains the word 'programming'

--12. Select all the ClubNames who start with N or C.

--13. Select Student Names, Street Address and City where the lastName has only 3 letters long.

--14. Select all the StudentID's where the PaymentAmount < 500 OR the PaymentTypeID is 5























