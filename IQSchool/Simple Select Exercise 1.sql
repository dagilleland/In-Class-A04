--SIMPLE SELECT EXERCISE 1
--USE THE IQSchool database
USE IQSchool
GO


--1.  Select all the information from the club table
Select ClubID, Clubname from Club

--2. Select the FirstNames and LastNames of all the students
Select Firstname, Lastname from student

--3. Select all the CourseId and CourseName of all the coureses. Use the column aliases of Course ID and Course Name
Select CourseID 'Course ID', CourseName 'Course Name' from course

--4. Select all the course information for courseID 'DMIT101'
Select CourseId, CourseName, coursehours, MaxStudents, coursecost from Course
where CourseId = 'DMIT101'

--5. Select the Staff names who have positionID of 3
Select firstname, lastname from Staff
where PositionID = 3

--6. select the CourseNames whos CourseHours are less than 96
Select coursename from Course where CourseHours <96

--7. Select the studentID's, CourseID and mark where the Mark is between 70 and 80
Select studentid, courseid, mark from Registration where Mark between 70 and 80

--8. Select the studentID's, CourseID and mark where the Mark is between 70 and 
--80 and the courseID is DMIT223 or DMIT168
Select studentid, courseid, mark from Registration 
where (Mark between 70 and 80) and CourseId in('DMIT223','DMIT168')

--9. Select the students first and last names who have last names starting with S
Select firstname, lastname from Student
where LastName LIKE 'S%'

--10. Select Coursenames whose CourseID  have a 1 as the fifth character
Select Coursename from Course
where CourseId like '____1%'

--11. Select the CourseID's and Coursenames where the CourseName contains the word 'programming'
Select courseid, Coursename from Course 
where CourseName like '%programming%'

--12. Select all the ClubNames who start with N or C.
Select clubname from club where clubname like 'N%' or Clubname like 'C%'
--OR
Select clubname from club where clubname like '[NC]%'

--13. Select Student Names, Street Address and City where the lastName has only 3 letters long.
Select firstname, lastname, streetaddress, city from Student
where  lastname like '___'
--OR wth len function (have not learned yet)
Select firstname, lastname, streetaddress, city from Student
where  len(lastname) =3
--14. Select all the StudentID's where the PaymentAmount < 500 OR the PaymentTypeID is 5
Select studentid from Payment where amount <500 or PaymentTypeID =5

