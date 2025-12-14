Create table Subject
( Subj_Id			Char 	(8) 	not null,
  Subj_Name_Thai		Char	(50)	null,
  Subj_Name_Eng		Char	(50) 	null,
  Subj_Type		Char	(2) 	null,
  Subj_Descrip_Thai	Char	(255)	null,
  Subj_Descrip_Eng	Char	(255)	null,
  Credit_Lec		SmallInt		null,
  Credit_Lab		SmallInt		null,
  Year_Begin		Datetime		null,
  Year_End		Datetime		null,

Constraint PKsubject primary key (Subj_Id))
