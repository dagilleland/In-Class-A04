-- Date and String Function Exercise
-- This sample set illustrates the funtions for manipulating Date and String data
USE IQSchool
GO

----- Date Manipulation  -------
/* Key DateTime functions
    - DATENAME() - used to get a part of a date/time
    - DATEDIFF() - used to compare two dates and get the time interval between them
    - MONTH() - used to get the month number of a date
    - YEAR() - used to get the year portion of a date
 */
--1. Select the staff names and the name of the month they were hired
SELECT FirstName + ' '+ LastName AS 'Staff',
       DATENAME(month, DateHired) AS 'Hire Month' 
FROM   Staff
--1b. Select the staff names and the year they were hired (sort from longest hired to most recently hired
SELECT FirstName + ' '+ LastName AS 'Staff',
       DATENAME(year, DateHired) AS 'Hire Month' 
FROM   Staff
ORDER BY 'Hire Month'


--2. How many days did Tess Agonor work for the school?
--   DATEDIFF will subtract the first date from the second date
--   i.e.:  DateReleased - DateHired
--   DATEDIFF(DatePart, StartDate, EndDate)
--            EndDate - StartDate (in DatePart time units)
SELECT DATEDIFF(day,DateHired, DateReleased) AS 'Days worked'
FROM   Staff
WHERE  FirstName = 'Tess' 
  AND  LastName ='Agonor'

--3. How Many Students where born in each month? Display the Month Name and the Number of Students.
SELECT DATENAME(month,Birthdate) AS 'Month',
       COUNT (*) AS 'Student Count'
FROM   Student 
GROUP BY DATENAME(month, Birthdate)
--3b. How Many Students where born in each month? Display the Month Name and the Number of Students. Put the result in order by month.
SELECT DATENAME(month,Birthdate) AS 'Month',
       COUNT (*) AS 'Student Count'
FROM   Student 
GROUP BY DATENAME(month, Birthdate), MONTH(Birthdate)
ORDER BY MONTH(Birthdate)
--4. Select the Names of all the students born in December.
SELECT FirstName  + ' ' + LastName AS 'Student Name'
FROM   Student
WHERE  MONTH(Birthdate) = 12 


----- String Manipulation  -------
--5. Select all the course names that have grades from 2004. NOTE: the first 4 characters of the semester indicate the year.
SELECT CourseId
FROM   Registration 
WHERE  LEFT(Semester, 4) = '2004'


--6. select last three characters of all the courses
PRINT  '6. select last three characters of all the courses'
SELECT RIGHT(CourseId, 3) AS 'Course Numbers'
FROM   Course

--7. Select the characters from position 8 to 12 for PositionID 5
PRINT  'Here is the full Position Description'
SELECT PositionDescription
FROM   Position
WHERE  PositionID = 5

PRINT  'Here is the Position Description starting at character #8 to character #12'
SELECT SUBSTRING(PositionDescription, 8, 5) AS 'Partial Name'
FROM   Position
WHERE  PositionID = 5

--8. Select all the Student First Names as upper case.
PRINT  'Here are the student first names as they are stored in the database'
SELECT FirstName
FROM   Student

PRINT  'Here are the student first names in upper-case'
SELECT UPPER(FirstName) AS 'Upper Case First Name'
FROM   Student

--9. Select the First Names of students whose first names are 3 characters long.
SELECT FirstName
FROM   Student
WHERE  LEN(FirstName) = 3 


