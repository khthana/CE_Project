drop database student_data;
create database student_data;

create table Student
	(	StdID Char(8),   
		TPren Char(20),
		EPren Char(20),
		TName Char(45),
		Ename Char(45),
		Degree Char(3),
		StdType Char(3),
		Std_serial serial,
		PRIMARY KEY (StdID)
	);

create table Student_TT
	(	StdID Char(8),   
		TPren Char(20),
		EPren Char(20),
		TName Char(45),
		Ename Char(45),
		Degree Char(3),
		StdType Char(3),
		std_int  int,
		Valid_From date,
		Valid_To date,
		TxStart date,
		TxStop date,
		PRIMARY KEY (StdID,Valid_From,Valid_To,TxStart,TxStop)
	);

create table Subject
	(	SubID Char(8),
		EName Char(75),
		TName Char(75),
		Presub1 Char(8),
		Presub2 Char(8),
		Credit int,
		Type Char(1),
		sub_serial serial,
		PRIMARY KEY (SubID)
	);

create table Subject_TT
	(	SubID Char(8),
		EName Char(75),
		TName Char(75),
		Presub1 Char(8),
		Presub2 Char(8),
		Credit int,
		Type Char(1),
		sub_int int,
		Valid_From date,
		Valid_To date,
		TxStart date,
		TxStop date,
		PRIMARY KEY (SubID,Valid_From,Valid_To,TxStart,TxStop)
	);

create table Registeration
	(	Stdid char(8),
		Subid char(8),
		Yr Char(4),
		Term Char(1),
		Grade Char(2),
		Section Char(2),
		regis_serial serial,
		PRIMARY KEY (Stdid,Subid,Yr,Term)
	);

create table Registeration_TT
	(	Std_int int,
		Sub_int int,
		Yr Char(4),
		Term Char(1),
		Grade Char(2),
		Section Char(2),
		regis_int int,
		Valid_From date,
		Valid_To date,
		TxStart date,
		TxStop date,
		PRIMARY KEY (Std_int,Sub_int,Yr,Term,Valid_From,Valid_To,TxStart,TxStop)
	);

