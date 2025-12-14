---------------------------------------------------------------------------
--
-- Create_Table.sql-
-- 14-03-98 2:00 AM
--
---------------------------------------------------------------------------

-----------------------------
-- Create User Table :
-----------------------------

DROP TABLE Bachelor;
DROP TABLE Master_Degree;
DROP TABLE Teacher;
DROP TABLE Student;
DROP TABLE Users;
DROP TABLE Magazine;
DROP TABLE Text_Book;
DROP TABLE Book;

CREATE TABLE Users(
	U_ID	char8,
	NAME	varchar(40),
	LNAME   varchar(40),
	BDate   date,
	Sex     char
);

CREATE TABLE Student(
	Major   varchar(30),
	Faculty varchar(30),
	Years   char4
) INHERITS (Users);

CREATE TABLE Bachelor(
	Class   	char2,
	Department 	varchar(30)
) INHERITS (Student);

CREATE TABLE Master_Degree(
	MType		varchar(30)
) INHERITS (Student);

CREATE TABLE Teacher(
	Degree 		varchar(40),
	Faculty		varchar(40)
) INHERITS (Users);

CREATE TABLE Book(
	Book_ID 	char8,
	Title		varchar(40),
	StartDate	Date,
	Amount		int,
	U_ID		char8
);

CREATE TABLE Text_Book(
	Author		varchar(40),
	Edition		int,
	Publisher	varchar(40)
) INHERITS (Book);

CREATE TABLE Magazine(
	Issue		int,
	Years		char4
) INHERITS (Book);
