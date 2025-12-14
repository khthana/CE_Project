Create table Curiculum
( Curiculum_Id		Char 	(2) 	not null,
  Faculty_Id		Char	(2) 	not null,  
  Dept_Id		Char	(3)	not null,
  Dept_Name 		Char	(45)	null,
  Curiculum_Name_Thai	Char	(80)	null,
  Curiculum_Name_Eng	Char	(80) 	null,
  Year			Char 	(4)	null,  

 
Constraint PKcuriculum primary key (Curiculum_Id,Faculty_Id)
)