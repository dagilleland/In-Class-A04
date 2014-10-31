--SUBQUERY EXERCISE 1
--USE THE IQSCHOOL DATABASE 
USE IQSchool
GO


--1. SELECT the Payment dates and payment amount for all payments that were Cash
SELECT PaymentDate,
       Amount 
FROM Payment 
WHERE PaymentTypeID = 
      (SELECT PaymentTypeID 
       FROM PaymentType 
       WHERE PaymentTypeDescription = 'cash') 

SELECT PaymentDate, Amount 
FROM Payment P
    INNER JOIN PaymentType PT
        ON PT.PaymentTypeID = P.PaymentTypeID 
WHERE PaymentTypeDescription = 'cash'


























--2. SELECT The Student ID's of all the students that are in the 'Association of Computing Machinery' club
SELECT StudentID 
FROM Activity 
WHERE clubID = 
    (SELECT ClubID 
     FROM club 
     WHERE ClubName = 'Association of Computing Machinery')

SELECT StudentID 
FROM Activity A
    INNER JOIN Club C
        ON A.ClubId = C.ClubId
WHERE ClubName = 'Association of Computing Machinery'



























--3. SELECT All the staff full names that have taught a course.
SELECT FirstName + ' ' + LastName 'Staff' 
FROM Staff 
WHERE StaffID IN (SELECT  StaffID FROM Registration)

SELECT DISTINCT firstname + ' ' + lastname 'Staff' FROM staff INNER JOIN registration
ON staff.StaffID = registration.StaffID 


























--4. SELECT All the staff full names that taught DMIT172.
SELECT firstname + ' ' + lastname 'Staff' FROM staff 
WHERE staffID in (SELECT StaffID FROM registration WHERE courseID = 'DMIT172')

SELECT distinct firstname + ' ' + lastname 'Staff' FROM staff INNER JOIN registration
ON staff.StaffID = registration.StaffID
WHERE CourseId = 'dmit172'


























--5. SELECT All the staff full names that have never taught a course
SELECT firstname + ' ' + lastname 'Staff' FROM staff 
WHERE staffID not in (SELECT StaffID FROM registration)

SELECT firstname + ' ' + lastname 'Staff' FROM staff left outer join registration
ON staff.StaffID =registration.StaffID
WHERE registration.staffID is null


























--6. SELECT the Payment TypeID(s) that have the highest number of Payments made.
SELECT PaymentTypeID FROM Payment
GROUP BY PaymentTypeID 
HAVING COUNT(*) >=ALL(SELECT COUNT(*) FROM Payment GROUP BY PaymentTypeID)



























--7. SELECT the Payment Type Description(s) that have the highest number of Payments made.
SELECT PaymentTypeDescription FROM Payment INNER JOIN PaymentType ON payment.paymenttypeid = paymenttype.paymenttypeid
GROUP BY paymenttype.paymenttypeid,PaymentTypeDescription 
HAVING COUNT(*) >=ALL(SELECT COUNT(*) FROM Payment GROUP BY PaymentTypeID)


























--8. What is the total avg mark for the students FROM Edm?
SELECT avg(mark)'Average' FROM registration 
WHERE studentID in (SELECT studentID FROM student WHERE city = 'Edm')

SELECT AVG(mark)'Average' FROM registration INNER JOIN Student
ON registration.StudentID = Student.StudentID
WHERE city = 'Edm'


























--9. What is the avg mark for each of the students FROM Edm? Display their StudentID and avg(mark)
SELECT StudentID, AVG(mark)'Average' FROM registration
WHERE studentID in (SELECT studentID FROM student WHERE city = 'Edm')
GROUP BY StudentID

SELECT student.StudentID, AVG(mark)'Average' FROM registration INNER JOIN Student
ON registration.StudentID = Student.StudentID
WHERE city = 'Edm'
group by student.StudentID

--BAD
SELECT StudentID, AVG(mark)'Average' FROM registration
GROUP BY StudentID
HAVING studentID IN (SELECT studentID FROM student WHERE city = 'Edm')







