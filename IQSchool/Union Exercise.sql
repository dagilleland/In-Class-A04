Select StudentID 'ID','Student Born' +':'+ FirstName + ' ' + LastName 'Event:Name' from Student
where DATEPART (mm,birthdate)  = 10
UNION
Select StaffID,'Staff Hired' + ':' + FirstName + ' ' + LastName from Staff
where DATEPART (mm,datehired)  = 10
Order by ID desc




