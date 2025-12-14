Create Table FeeCost
( Fee_Type_No     int     not null,
  Fee_Year        char(4) not null,
  Fee_Term        char(4) not null,
  Fee_Sub_Type_No int     not null,
  Std_Type_No     char(2) not null,
  Std_Faculty_Id     char(2) not null,
  Std_Year_Enter1 char(4) not null,
  Std_Year_Enter2 char(4) null,
  Fee_Cost        int     null,
Constraint PKfeecost primary key (Fee_Type_No,Fee_Year,Fee_Term,Fee_Sub_Type_No,Std_Type_No,Std_Faculty_Id,Std_Year_Enter1)) 
