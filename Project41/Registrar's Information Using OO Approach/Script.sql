DISK INIT
NAME = 'INFORMATION',
PHYSNAME = 'C:\MSSQL\DATA\INFORMATION.DAT',
VDEVNO = 90,
SIZE = 5120
USE master
CREATE DATABASE REGISTERDATAS
ON INFORMATION
create table student
(Std_Id char(10),
 Std_Name_thai char(20),
 Std_title_thai char(6),
 Std_Surname_thai char(25),
 Std_name_Eng char(20),
 Std_title_Eng char(6),
 Std_Surname_Eng char(25),
 Std_Birthday char(8),
 Std_Sex char(6),
 Std_Religion char(20),
 Std_Nation char(25),
 Std_Citizen char(25),
 Std_Addrno char(10),
 Std_Addrsoi char(25),
 Std_Addrroad char(50),
 Std_Addrdistinct char(50),
 Std_Addrborder char(50),
 Std_Addrprovince char(50),
 Std_Addrcode char(6),
 Std_Addrtel char(15),
 Std_Addrfax char(15),
 Std_Addrpager char(15),
 Std_Caddrno char(10),
 Std_Caddrsoi char(50),
 Std_Caddrroad char(50),
 Std_Caddrdistinct char(50),
 Std_Caddrborder char(50),
 Std_Caddrprovince char(50),
 Std_Carrdcode char(6),
 Std_Caddrtel char(15),
 Std_Caddrfax char(15),
 Std_Curriculum char(40),
 Std_Faculty_Id char(2),
 Std_Department_Id char(3))
create table teacher
(Teacher_Id char(4),
Teacher_Title char(6),
Teacher_Name char(50),
Teacher_Sname char(50),
Dept_Name char(3),
Teacher_Position char(20))
create table RegisterCourse
(Reg_Std_Id char(8),
Reg_Year char(4),
Reg_Term char(6),
Reg_Date char(10),
Reg_Sub_Id char(8))
create table subject
(Subject_Id char(8),
Year_Study char(2),
Subject_Category char(30),
Subject_Group char(30),
Subject_Name_Thai char(50),
Subject_Name_Eng char(50),
Subject_Sum_Credit int(4),
Subject_Lec_Credit int(4),
Subject_Lab_Credit int(4),
Faculty_Id char(4),
Dept_Id char(4),
Subject_Description char(255))
create table curriculum
(Curriculum_Id char(10),
Curriculum_Name_Thai char(50),
Curriculum_Name_Eng char(50),
Sum_Credit int(4),
Subj_Specific_Category_Credit int(4),
Subj_General_Category_Credit int(4),
Subj_Elective_Category_Credit int(4),
Faculty_Id char(4),
Dept_Id char(4))
create table faculty
(Faculty_Id char(2),
Faculty_Name_Thai char(50),
Faculty_Name_Eng char(50),
Faculty_Description char(255))
create table major
(Major_Id char(3),
Major_Name_Thai char(50),
Major_Name_Eng char(50),
Dept_Name char(50))
