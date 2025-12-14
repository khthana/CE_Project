Create Table Subject_for_Register
( Subj_Id	char(8)  not null,
  Curiculum_Id	char(2)  not null,
  Faculty_Id	char(2)  not null,
  Term		char(1)  not null,
  YearStudy	Char(1)  not null,
 
Constraint Pk_SubjForReg primary key (Subj_Id,Curiculum_Id,Faculty_Id,Term,YearStudy)) 