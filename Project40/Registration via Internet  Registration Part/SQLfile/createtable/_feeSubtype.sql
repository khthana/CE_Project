Create Table FeeSubType
( Fee_Type_No       int not null,
  Fee_Sub_Type_No   int not null,
  Fee_Sub_type_Name char(50) null,
  For_Whom   char(50) null,
  
Constraint PKfeeSubtype primary key (Fee_Type_No,Fee_Sub_Type_No))