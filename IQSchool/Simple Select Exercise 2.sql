--Simple Select Exercise 2
--USE THE IQSchool database
USE IQSchool
GO

--1.	Select the average Mark from all the Marks in the grade table
Select AVG(mark) 'Average Mark' from Registration
--2.	Select the average Mark of all the students who are taking DMIT104
Select AVG(mark) 'Average Mark' from Registration
where CourseId = 'DMIT104' 
--3.	Select how many students are there in the Student Table
Select COUNT(*) 'Student Count' from Student
--4.	Select how many students are taking DMIT152
Select count(*) 'Students with mark' from Registration 
where CourseId = 'DMIT152' 
--5.	Select the average payment amount for payment type 5
Select AVG(Amount)'Average Payment Amount' from Payment 
where PaymentTypeID = 5

--6. Select the highest payment amount
Select MAX(Amount) 'Highest Payment Amount' from payment

--7.	 Select the lowest payment amount
Select MIN(Amount) 'Lowest Payment Amount' from payment

--8. Select the total of all the payments that have been made
Select SUM (Amount)'Sum of Payments' from payment

--9. How many different payment types does the school accept?
Select COUNT (*)'Payment Type Count' from Paymenttype

--10.How many students are in club 'CSS'?
Select COUNT(*) 'CSS Club Count' from activity
where ClubId = 'CSS'