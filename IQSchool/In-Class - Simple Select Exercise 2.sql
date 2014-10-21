--Simple Select Exercise 2
-- This set of exercises demonstrates performing simple Aggregate functions
-- to get results such as SUM(), AVG(), COUNT()
-- All aggregates are done using built-in functions in the database

Use IQSCHOOL -- Database

--1.	Select the average Mark from all the Marks in the registration table
SELECT AVG(Mark) AS 'Average Mark' -- I am using an alias for the column name's output
FROM   Registration

--2.	Select the average Mark of all the students who are taking DMIT104
SELECT AVG(Mark) AS 'Average Mark'
FROM   Registration
WHERE  CourseId = 'DMIT104'

--3.	Select how many students are there in the Student Table
SELECT Count(*) AS 'Student Count' -- the * means "all columns"
FROM   Student

--4.	Select how many students are taking (have a grade for) DMIT152
SELECT Count(Mark) AS 'Student Count for DMIT152'
FROM   Registration
WHERE  CourseId = 'DMIT152'

--5.	Select the average payment amount for payment type 5
SELECT AVG(Amount) AS 'Average Payment Amount'
FROM   Payment
WHERE  PaymentTypeID = 5

--6. Select the highest payment amount

--7.	 Select the lowest payment amount

--8. Select the total of all the payments that have been made

--9. How many different payment types does the school accept?

--10. How many students are in club 'CSS'?

