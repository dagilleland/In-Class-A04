IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Activity')
    DROP TABLE Activity
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Grade')
    DROP TABLE Grade
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Club')
    DROP TABLE Club
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Course')
    DROP TABLE Course
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Student')
    DROP TABLE Student
GO


CREATE TABLE Student
(
    StudentId           int         NOT NULL
        CONSTRAINT PK_Student
            PRIMARY KEY                     ,
    StudentFirstName    varchar(40) NOT NULL,
    StudentLastName     varchar(40) NOT NULL,
    GenderCode          char(1)     NOT NULL,
    [Address]           varchar(30)     NULL,
    Birthdate           datetime        NULL,
    PostalCode          char(6)         NULL,
    AvgMark             decimal(4,1)    NULL,
    NoOfCourses         smallint        NULL    
)
GO

CREATE TABLE Course
(
    CourseId            char(6)     NOT NULL
        CONSTRAINT PK_Course
            PRIMARY KEY clustered,
    CourseName          varchar(40) NOT NULL,
    [Hours]             smallint        NULL,
    NoOfStudents        smallint        NULL
)
GO

CREATE TABLE Club
(
    ClubId              int         NOT NULL
        CONSTRAINT PK_Club
            PRIMARY KEY clustered           ,
    ClubName            varchar(50) NOT NULL
)
GO

CREATE TABLE Grade
(
    StudentId           int         NOT NULL
        CONSTRAINT FK_GradeToStudent
            REFERENCES Student(StudentId)   ,
    CourseId            char(6)     NOT NULL
        CONSTRAINT FK_GradeToCourse
            REFERENCES Course(CourseId)     ,
    Mark                smallint        NULL,
    -- Table-level constraints
    CONSTRAINT PK_Grade
        PRIMARY KEY (StudentId,CourseId)
)
GO

CREATE TABLE Activity
(
    StudentId           int         NOT NULL
        CONSTRAINT FK_ActivityToStudent
            REFERENCES Student(StudentId)   ,
    ClubId              int         NOT NULL
        CONSTRAINT FK_ActivityToClub
            REFERENCES Club(ClubId)         ,
    -- Table-level constraints
    CONSTRAINT PK_Activity
        PRIMARY KEY (StudentId,ClubId)
)
GO
