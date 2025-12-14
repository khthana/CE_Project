Create Table Register
( Regis_No                int     not null,
  Regis_Subj_Id           char(8) not null,
  Regis_Lab_Group_No_Char char(2) null,
  Regis_Lec_Group_No_Char char(2) null,
  Subj_Regis_Type         char(1) null,
  Regis_Status            char(1) null,
  Regis_Subj_Grade        char(2) null,
  Regis_Flag              char(1) null,
  
Constraint PKregister primary key (Regis_No,Regis_Subj_Id)) 