--1. Select the Payment dates and payment amount for all payments that were Cash
Select PaymentDate, Amount from Payment 
where paymentTypeID = (Select paymentTypeID from PaymentType where PaymentTypeDescription = 'cash') 

Select PaymentDate, Amount from Payment inner join PaymentType
on paymenttype.PaymentTypeID = Payment.PaymentTypeID 
where PaymentTypeDescription = 'cash'

--2. Select The Student ID's of all the students that are in the 'Association of Computing Machinery' club
Select StudentID from Activity 
where clubID = (Select ClubID from club where ClubName = 'Association of Computing Machinery')

Select StudentID from Activity inner join Club
on activity.ClubId = Club.ClubId
where ClubName = 'Association of Computing Machinery'


--3. Select All the staff full names that have taught a course.
Select firstname + ' ' + lastname 'Staff' from staff 
where staffID in (Select  StaffID from registration)

Select distinct firstname + ' ' + lastname 'Staff' from staff inner join registration
on staff.StaffID = registration.StaffID 

--4. Select All the staff full names that taught DMIT172.
Select firstname + ' ' + lastname 'Staff' from staff 
where staffID in (Select StaffID from registration where courseID = 'DMIT172')

Select distinct firstname + ' ' + lastname 'Staff' from staff inner join registration
on staff.StaffID = registration.StaffID
where CourseId = 'dmit172'

--5. Select All the staff full names that have never taught a course
Select firstname + ' ' + lastname 'Staff' from staff 
where staffID not in (Select StaffID from registration)

Select firstname + ' ' + lastname 'Staff' from staff left outer join registration
on staff.StaffID =registration.StaffID
where registration.staffID is null

--6. Select the Payment TypeID(s) that have the highest number of Payments made.
Select PaymentTypeID from Payment
group by PaymentTypeID 
having count(*) >=ALL(Select count(*) from Payment group by PaymentTypeID)


--7. Select the Payment Type Description(s) that have the highest number of Payments made.
Select PaymentTypeDescription from Payment inner join PaymentType on payment.paymenttypeid = paymenttype.paymenttypeid
group by paymenttype.paymenttypeid,PaymentTypeDescription 
having count(*) >=ALL(Select count(*) from Payment group by PaymentTypeID)

--8. What is the total avg mark for the students from Edm?
Select avg(mark)'Average' from registration 
where studentID in (Select studentID from student where city = 'Edm')

Select avg(mark)'Average' from registration inner join Student
on registration.StudentID = Student.StudentID
where city = 'Edm'

--9. What is the avg mark for each of the students from Edm? Display their StudentID and avg(mark)
Select StudentID, avg(mark)'Average' from registration
where studentID in (Select studentID from student where city = 'Edm')
group by StudentID

Select student.StudentID, avg(mark)'Average' from registration inner join Student
on registration.StudentID = Student.StudentID
where city = 'Edm'
group by student.StudentID

--BAD
Select StudentID, avg(mark)'Average' from registration
group by StudentID
having studentID in (Select studentID from student where city = 'Edm')







