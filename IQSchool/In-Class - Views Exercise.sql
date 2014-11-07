-- Views Exercise
USE IQSchool
GO

-- 1. Create a view of staff full names called staff_list.
CREATE VIEW staff_list
AS
    SELECT FirstName + ' ' + LastName AS 'StaffName'
    FROM   Staff
GO

-- 2.Create a view of staff ID's, full names, positionID's and datehired called staff_confidential.


-- 2.a. Create a view of staff teaching assignments that includes the Staff iD, First and Last names (as separate columns), and the Course Name, Course ID, and Course Hours for all the courses they have taught. Call this view TeachingAssignments.


-- 3.Create a view of student ID's, full names, courseId's, course names, and grades called student_grades.
CREATE VIEW student_grades
as
SELECT Student.StudentID, 
       FirstName + ' ' + LastName AS 'Student Name',
       Course.CourseId, CourseName, 
       Mark
FROM   Student 
    INNER JOIN Registration 
            ON Student.StudentID = Registration.StudentID
    INNER JOIN Course 
            on Course.CourseId = Registration.CourseId
GO

-- 4.Use the student_grades view to create a grade report for studentID 199899200 that shows the students ID, full name, course names and marks.
SELECT StudentID,
       [Student Name],
--     courseid,
       CourseName,
       Mark
FROM  student_grades
WHERE StudentID = '199899200'

-- 5. Select the same information using the student_grades view for studentID 199912010.

-- 6. Using the student_grades view  update the mark for studentID 199899200 in course dmit152 to be 90  and change the coursename to be 'basket weaving 101'.

-- 7. Using the student_grades view, update the  mark for studentID 199899200 in course dmit152 to be 90.

-- 8. Using the student_grades view, delete the same record from question 7.

-- 9. Retrieve the code for the student_grades view from the database.


