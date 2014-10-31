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
WHERE ClubId = 
    (SELECT ClubID 
     FROM Club 
     WHERE ClubName = 'Association of Computing Machinery')

SELECT StudentID 
FROM Activity A
    INNER JOIN Club C
        ON A.ClubId = C.ClubId
WHERE ClubName = 'Association of Computing Machinery'

--3. SELECT All the staff full names that have taught a course.
SELECT FirstName + ' ' + LastName AS 'Staff' 
FROM Staff 
WHERE StaffID IN (SELECT DISTINCT StaffID FROM Registration)


SELECT DISTINCT FirstName + ' ' + LastName AS 'Staff'
FROM Staff
    INNER JOIN Registration
        ON Staff.StaffID = Registration.StaffID 


--4. SELECT All the staff full names that taught DMIT172.
SELECT FirstName + ' ' + LastName AS 'Staff'
FROM Staff 
WHERE StaffID IN (SELECT StaffID 
                  FROM Registration 
                  WHERE CourseId = 'DMIT172')

SELECT DISTINCT FirstName + ' ' + LastName AS 'Staff'
FROM Staff
    INNER JOIN Registration
        ON Staff.StaffID = Registration.StaffID
WHERE CourseId = 'DMIT172'


--5. SELECT All the staff full names that have never taught a course
SELECT FirstName + ' ' + LastName AS 'Staff'
FROM Staff 
WHERE StaffID NOT IN (SELECT DISTINCT StaffID FROM Registration)

SELECT FirstName + ' ' + LastName 'Staff'
FROM Staff 
    LEFT OUTER JOIN Registration
        ON Staff.StaffID =Registration.StaffID
WHERE Registration.StaffID IS NULL

--6. SELECT the Payment TypeID(s) that have the highest number of Payments made.
SELECT PaymentTypeID
FROM Payment
GROUP BY PaymentTypeID 
HAVING COUNT(PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
                                    FROM Payment
                                    GROUP BY PaymentTypeID)

--7. SELECT the Payment Type Description(s) that have the highest number of Payments made.
SELECT PaymentTypeDescription
FROM   Payment 
    INNER JOIN PaymentType 
        ON Payment.PaymentTypeID = PaymentType.PaymentTypeID
GROUP BY PaymentType.PaymentTypeID, PaymentTypeDescription 
HAVING COUNT(PaymentType.PaymentTypeID) >= ALL (SELECT COUNT(PaymentTypeID)
                                                FROM Payment 
                                                GROUP BY PaymentTypeID)

--8. What is the total avg mark for the students FROM Edm?
SELECT AVG(Mark) AS 'Average'
FROM   Registration 
WHERE  StudentID IN (SELECT StudentID FROM Student WHERE City = 'Edm')

SELECT AVG(Mark) AS 'Average'
FROM   Registration 
    INNER JOIN Student
        ON Registration.StudentID = Student.StudentID
WHERE City = 'Edm'


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







