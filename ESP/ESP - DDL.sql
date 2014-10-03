-- In SQL, a single-line comment begins with two dashes
/* Multiline comments work just like in C#
   The comment begins with a slash and asterix,
   and ends with an asterix and slash
*/
USE [EPS-Db] -- this is a statement that tells us to switch to a particular database
-- Notice in the database name above, I had to "wrap" the name in square brackets
-- because the name had a hypen in it. 
-- For our objects (tables, columns, etc), we won't use hypens or spaces, so
-- the brackets are optional...

-- To create a database table, we use the CREATE TABLE statement.
CREATE TABLE Customers
(
    CustomerNumber int,
    FirstName varchar(50),
    LastName varchar(60),
    [Address] varchar(40),
    City varchar(35),
    Province char(2),
    PostalCode char(6),
    PhoneNumber char(13)
)

DROP TABLE Customers

