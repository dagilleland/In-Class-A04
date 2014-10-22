--1. How many staff are there in each position? Select the number and Position Description
Select PositionDescription, COUNT(*) 'Number of Staff' from Staff 
inner join Position on Staff.PositionID = Position.PositionID
group by position.PositionId, PositionDescription

--2. Select the average mark for each course. Display the CourseName and the average mark
Select CourseName, AVG(mark)'Average mark' from registration
inner join Course
on registration.CourseId = Course.CourseId
group by Course.CourseId,coursename

--3. How many payments where made for each payment type. Display the PaymentTypeDescription and the count
Select PaymentTypeDescription, COUNT(*) 'Count of Payment Type' from Payment
inner join PaymentType
on PaymentType.PaymentTypeID =Payment.PaymentTypeID
group by Payment.PaymentTypeID,PaymentTypeDescription

--4. Select the average Mark for each student. Display the Student Name and their average mark
Select firstname  + ' ' + lastname 'Student Name' , AVG(mark)'Average' from registration
inner join Student
on Student.StudentID = registration.StudentID
group by  Student.StudentID, firstname  + ' ' + lastname


--5. Select the same data as question 4 but only show the student names and averages that are > 80
Select firstname  + ' ' + lastname 'Student Name' , AVG(mark)'Average' from registration
inner join Student
on Student.StudentID = registration.StudentID
group by Student.StudentID, firstname  + ' ' + lastname
having AVG(mark) > 80

 
--7.what is the highest, lowest and average payment amount for each payment type Description? 
Select PaymentTypeDescription, MAX(amount)'Highest', MIN(amount)'Lowest', AVG(amount)'Average' from payment
inner join PaymentType
on Payment.PaymentTypeID = PaymentType.PaymentTypeID
group by PaymentType.PaymentTypeID, PaymentTypedescription

--8. How many students are there in each club? Show the clubName and the count
Select ClubName, COUNT(*)'Number of Students' from Activity
inner join Club
on Activity.ClubId = Club.ClubId
group by Club.ClubId, clubName

--9. Which clubs have 3 or more students in them? Display the Club Names.
Select clubName from Activity
inner join Club 
on Activity.ClubId = Club.ClubId
group by Club.ClubId, ClubName having COUNT(*) >=3