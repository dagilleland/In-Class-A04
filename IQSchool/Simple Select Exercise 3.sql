--SIMPLE SELECT EXERCISE 3
--USE THE IQSchool database
USE IQSchool
GO

--1. Select the average mark for each course. Display the CourseID and the average mark
Select CourseID, AVG(mark)'Average mark' from Registration group by CourseID
--2. How many payments where made for each payment type. Display the Payment typeID and the count
Select PaymentTypeid, COUNT(*) 'Count of Payment Type' from Payment group by PaymentTypeID
--3. Select the average Mark for each studentID. Display the StudentId and their average mark
Select StudentID, AVG(mark)'Average' from Registration group by studentid
--4. Select the same data as question 3 but only show the studentID's and averages that are > 80
Select StudentID, AVG(mark)'Average' from Registration group by studentid having AVG(Mark) > 80
--5. How many students are from each city? Display the City and the count.
Select City, COUNT (*) 'Number of students' from Student group by City
--6. Which cities have 2 or more students from them? (HINT, remember that fields that we use in the where or having do not need to be selected.....)
 Select City from Student group by City having COUNT(*) >=2
--7.what is the highest, lowest and average payment amount for each payment type? 
Select PaymentTypeID, MAX(amount)'Highest', MIN(amount)'Lowest', AVG(amount)'Average' from payment group by PaymentTypeid
--8. How many students are there in each club? Show the clubID and the count
Select Clubid, COUNT(*)'Number of Students' from Activity group by clubid
--9. How many clubs have 3 or more students in them?
Select clubID from Activity group by ClubId having COUNT(*) >=3