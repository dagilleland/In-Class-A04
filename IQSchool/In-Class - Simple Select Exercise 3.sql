--Simple Select Exercise 3
-- This sample set illustrates the GROUP BY syntax and the use of Aggregate functions with
-- GROUP BY
USE IQSchool
GO

--1. Select the average mark for each course. Display the CourseID and the average mark
SELECT CourseID,
       AVG(Mark) AS 'Average Mark'
FROM   Registration
GROUP BY CourseID
-- The GROUP BY clause should contain a list of all the non-aggregate columns identified in the SELECT clause


--2. How many payments where made for each payment type. Display the Payment typeID and the count
SELECT PaymentTypeID,
       COUNT(*) AS 'Count of Pay Type'
FROM   Payment
GROUP BY PaymentTypeID


--3. Select the average Mark for each studentID. Display the StudentId and their average mark
SELECT StudentID,
       AVG(Mark) AS 'Avg Mark'
FROM   Registration
GROUP BY StudentID

--4. Select the same data as question 3 but only show the studentID's and averages that are > 80
SELECT StudentID,
       AVG(Mark) as 'Average Mark'
FROM   Registration
GROUP BY StudentID
-- The HAVING clause is where we do filtering of Aggregate information
HAVING AVG(Mark) > 80

--5. How many students are from each city? Display the City and the count.
SELECT City,
       COUNT(StudentID) AS 'Student Count'
FROM   Student
GROUP BY City
-- Here's an alternate version
SELECT City,
       COUNT(*) AS 'Student Count'
FROM   Student
GROUP BY City


--6. Which cities have 2 or more students from them? (HINT, remember that fields that we use in the where or having do not need to be selected.....)
SELECT City
--      ,COUNT(StudentID) AS 'Student Count'
FROM   Student
GROUP BY City
HAVING Count(StudentID) >= 2

--7. What is the highest, lowest and average payment amount for each payment type? 
SELECT MAX(Amount) AS 'Highest',
       MIN(Amount) AS 'Lowest',
       AVG(Amount) AS 'Average'
FROM   Payment
GROUP BY PaymentTypeID

--8. How many students are there in each club? Show the clubID and the count
SELECT ClubId,
       COUNT(*) AS 'Student Count'
FROM   Activity
GROUP BY ClubId

--9. Which clubs have 3 or more students in them?
SELECT ClubId
--    ,COUNT(*) AS 'Student Count'
FROM   Activity
GROUP BY ClubId
HAVING COUNT(*) >= 3
