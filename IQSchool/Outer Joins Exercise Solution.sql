--1. Select All position descriptions and the staff ID's that are in those positions
Select PositionDescription, StaffID from Position
left outer join Staff
on Position.PositionID = Staff.PositionID

--2. Select the Position Description and he count of how many staff are in those positions. Returnt the count for ALL positions.
--HINT: Count can use either count(*) which means records or a field name. Which gives the correct result in this question?
Select Positiondescription, COUNT(StaffID)'Count' from Position 
left outer join Staff on Position.PositionID = Staff.PositionID 
group by position.Positionid,PositionDescription

--3. Select the average mark of ALL the students. Show the student names and averages.
Select FirstName  + ' ' + LastName 'Student Name' , AVG(mark)'Average' from student 
left outer join registration on student.studentID  = registration.studentid
group by student.StudentID ,FirstName,LastName

--4. Select the highest and lowest mark for each student. 
Select  FirstName  + ' ' + LastName 'Student Name' , max(mark)'Highest', MIN(mark) 'Lowest' from student 
left outer join registration on Student.StudentID = registration.StudentID
group by student.StudentID,FirstName,LastName

--5. How many students are in each club? Display club name and count
Select ClubName, COUNT(activity.ClubId) 'Student Count' from Club left outer join Activity
on Club.ClubId = Activity.ClubId
group by club.ClubId,clubname




