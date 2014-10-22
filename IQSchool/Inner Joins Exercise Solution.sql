--1. Select Student full names and the course ID's they are registered in.
Select FirstName + ' ' + LastName 'Student Name',CourseID 
from Student inner join registration
ON Student.StudentID = registration.StudentID


--2. Select the Staff full names and the Course ID's they teach
Select distinct firstname + ' ' + lastname 'Student Name', CourseID 
from Staff inner join registration
ON Staff.StaffID = registration.StaffID

--3. Select the Club ID's and the Student full names that are in them
Select ClubID, FirstName + ' ' + LastName 'Student Name' 
from Activity Inner Join Student
ON Student.StudentID = Activity.StudentID

--4. Select the Student full name, courseID's and marks for studentID 199899200.
Select firstname + ' ' + lastname 'Student Name' ,courseid, mark
from Student Inner Join registration
ON Student.StudentID = registration.StudentID
Where student.studentID = 199899200

--5. Select the Student full name, course names and marks for studentID 199899200.
Select firstname + ' ' + lastname 'Student Name' ,coursename, mark
from Student
Inner Join registration ON Student.StudentID = registration.StudentID
Inner Join Course ON Course.CourseId= registration.CourseId
Where student.studentID = 199899200

--6. Select the CourseID, CourseNames, and the Semesters they have been taught in
Select distinct  course.CourseId, CourseName, Semester from 
Course Inner Join registration
On course.CourseId = registration.CourseId
order by courseid

--7. What Staff Full Names have taught Networking 1?
Select distinct firstname + ' ' + lastname 'Staff Name' from Staff
Inner Join registration on Staff.StaffID = registration.StaffID
Inner Join Course on Course.CourseId = registration.CourseId
where CourseName = 'Networking 1'

--8. What is the course list for student ID 199912010 in semester 2001S. Select the Students Full Name and the CourseNames
Select firstname + ' ' + lastname 'Student Name' ,coursename from Student 
Inner Join registration on Student.StudentID = registration.StudentID
Inner Join Course on Course.CourseId = registration.CourseId 
Where Student.StudentID = 199912010 and Semester = '2001S'

--9. What are the Student Names and courseID's that have Marks >80?
Select firstname + ' ' + lastname 'Student Name' ,CourseID from Student
inner Join registration on Student.StudentID = registration.StudentID
where Mark > 80

 

