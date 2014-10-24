--Joins Exercise 1
USE IQSchool
GO

--1.	Select Student full names and the course ID's they are registered in.
-- **** Do NOT do it this way, or your instructor will mark it as WRONG  ****
--                                                                *****  
--SELECT  FirstName + ' ' + LastName AS 'Student Name', CourseId
--FROM    Student, Registration
--WHERE   Student.StudentID = Registration.StudentID

-- This one below is correct  :)
SELECT  FirstName + ' ' + LastName AS 'Student Name',
        CourseId
FROM    Student
    INNER JOIN Registration
            ON Student.StudentID = Registration.StudentID
-- We can use aliases for the table names to make our code "cleaner" to read
SELECT  FirstName + ' ' + LastName AS 'Student Name',
        CourseId
FROM    Student S
    INNER JOIN Registration R
            ON S.StudentID = R.StudentID

--1b.	Select Student full names, the course ID, and the course name they are registered in.
--      (Hint, this involves joining together three tables)
SELECT  S.FirstName + ' ' + S.LastName AS 'Student Name',
        C.CourseId,
        C.CourseName
FROM    Student S
    INNER JOIN Registration R
            ON S.StudentID = R.StudentID
    INNER JOIN Course C
            ON R.CourseId = C.CourseId



--2.	Select the Staff full names and the Course ID’s they teach.
--      (Sort by Staff Name, then Course ID to see any duplicates)
SELECT  DISTINCT -- The DISTINCT keyword will remove duplicate rows from the results
        S.FirstName + ' ' + S.LastName AS 'Staff Name',
        R.CourseId
FROM    Staff S
    INNER JOIN Registration R
            ON R.StaffID = S.StaffID
ORDER BY 'Staff Name', R.CourseId


--3.	Select all the Club ID's and the Student full names that are in them

--4.	Select the Student full name, courseID's and marks for studentID 199899200.
SELECT  S.FirstName + ' ' + S.LastName AS 'Student Name',
        R.CourseId,
        R.Mark
FROM    Registration R
    INNER JOIN Student S
            ON S.StudentID = R.StudentID
WHERE   S.StudentID = 199899200


--5.	Select the Student full name, course names and marks for studentID 199899200.

--6.	Select the CourseID, CourseNames, and the Semesters they have been taught in

--7.	What Staff Full Names have taught Networking 1?

--8.	What is the course list for student ID 199912010 in semester 2001S. Select the Students Full Name and the CourseNames

--9. What are the Student Names, courseID's that have Marks >80?

