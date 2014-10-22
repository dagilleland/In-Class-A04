--1. Select the staff names and the name of the month they were hired
Select Firstname + ' '+ lastName 'Staff', datename(mm,Datehired) 'Hire Month' from Staff

--2. How many days did Tess Agonor work for the school?
Select DATEDIFF(dd,DateHired, Datereleased) 'Days worked' from Staff
where FirstName = 'Tess' and lastName ='Agonor'

--3. How Many Students where born in each month? Display the Month Name and the Number of Students.
Select datename(MM,birthdate) 'Month',COUNT (*)'Student Count' from Student 
group by DATENAME(mm, birthdate)

--4. Select the Names of all the students born in December.
Select FirstName  + ' ' + LastName 'Student Name' from Student
where month(birthdate) = 12 

--5. Select all the course names that have grades from 2004. NOTE: the first 4 characters of the semester indicate the year.
Select CourseId from Registration 
where LEFT(semester,4) = '2004'

--6. select last three characters of all the courses
Select RIGHT(courseid,3)'Course Numbers' from Course

--7. Select the characters from position 8 to 13 for PositionID 5
Select SUBSTRING(PositionDescription,8,5)'Partial Name' from Position where PositionID = 5

--8. Select all the Student First Names as upper case.
Select upper(FirstName)'Upper Case First Name' from Student

--9. Select the First Names of students whose first names are 3 characters long.
Select FirstName from Student where LEN(firstName) = 3 


