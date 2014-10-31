--OUTER JOINS EXERCISE 1
--USE THE IQSCHOOL DATABASE 
USE IQSchool
GO

--1. Select All position descriptions and the staff ID's that are in those positions
SELECT PositionDescription, StaffID 
FROM   Position P
    LEFT OUTER JOIN Staff S
        ON P.PositionID = S.PositionID

--2. Select the Position Description and the count of how many staff are in those positions. Return the count for ALL positions.
--HINT: Count can use either count(*) which means records or a field name. Which gives the correct result in this question?
SELECT PositionDescription, 
       Count(StaffID)
FROM   Position P
    LEFT OUTER JOIN Staff S
        ON P.PositionID = S.PositionID
GROUP BY P.PositionID, PositionDescription

-- or -- The following version gives the WRONG results, so just don't use *
SELECT PositionDescription, 
       Count(*)
FROM   Position P
    LEFT OUTER JOIN Staff S
        ON P.PositionID = S.PositionID
GROUP BY P.PositionID, PositionDescription

--3. Select the average mark of ALL the students. Show the student names and averages.
SELECT  FirstName  + ' ' + LastName AS 'Student Name',
        AVG(Mark) AS 'Average'
FROM    Student S
    LEFT OUTER JOIN Registration R
        ON S.StudentID  = Registration.StudentID
GROUP BY S.StudentID , FirstName, LastName

--4. Select the highest and lowest mark for each student. 
SELECT  FirstName  + ' ' + LastName AS 'Student Name',
        MAX(Mark) AS 'Highest',
		MIN(Mark) 'Lowest'
FROM    Student S
    LEFT OUTER JOIN Registration R
        ON S.StudentID  = Registration.StudentID
GROUP BY S.StudentID , FirstName, LastName

--5. How many students are in each club? Display club name and count
SELECT  ClubName,
        COUNT(A.ClubId) AS 'Student Count'
FROM    Club C
    LEFT OUTER JOIN Activity A
        ON C.ClubId = A.ClubId
GROUP BY C.ClubId, ClubName

