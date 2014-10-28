--Joins With Aggregates Exercise 1
USE IQSchool
GO

--1. How many staff are there in each position? SELECT the number and Position Description. Order the results by description.
SELECT  PositionDescription,
        COUNT(*) 'Number of Staff'
FROM Staff 
    INNER JOIN Position
        ON Staff.PositionID = Position.PositionID
GROUP BY PositionDescription
ORDER BY PositionDescription

--2. SELECT the average mark for each course. Display the CourseName and the average mark. Sort the results by average in descending order.
SELECT  CourseName,
        AVG(Mark)'Average mark'
FROM Registration
    INNER JOIN Course
        ON Registration.CourseId = Course.CourseId
GROUP BY CourseName
ORDER BY 'Average mark' DESC

--3. How many payments were made for each payment type. Display the PaymentTypeDescription and the count
    -- TODO: Student Answer Here...

--4. SELECT the average Mark for each student. Display the Student Name and their average mark. Use table aliases in your FROM & JOIN clause.
SELECT  S.FirstName  + ' ' + S.LastName AS 'Student Name',
        AVG(R.Mark)                     AS 'Average'
FROM    Registration R
        INNER JOIN Student S
            ON S.StudentID = R.StudentID
GROUP BY    S.StudentID,
            S.FirstName  + ' ' + S.LastName

--5. SELECT the same data as question 4 but only show the student names and averages that are > 80 (hint: you will need a HAVING clause)
    -- TODO: Student Answer Here....

--6. Display the number of students in each course. Exclude those students that have withdrawn.
SELECT  CourseName,
        COUNT(StudentID) AS 'Number of Students'
FROM    Course
        INNER JOIN Registration
            ON Course.CourseId = Registration.CourseId
WHERE   WithdrawYN IS NULL
   OR   WithdrawYN = 'N'
GROUP BY CourseName

--7.what is the highest, lowest and average payment amount for each payment type Description? 
    -- TODO: Student Answer Here....

--8. How many students are there in each club? Show the clubName and the count
    -- TODO: Student Answer Here....

--9. Which clubs have 3 or more students in them? Display the Club Names.
    -- TODO: Student Answer Here....


















