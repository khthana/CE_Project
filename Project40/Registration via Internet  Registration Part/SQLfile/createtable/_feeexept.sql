Create Table FeeExcept
( Std_Pay_Type_No  char(4) not  null,
  Term             char(1) not null,
  Year             char(4) not null,
  Fee_Type_No1     int     null,
  Fee_Type_No2     int     null,
  Fee_Type_No3     int     null,
  Fee_Type_No4     int     null,
  Fee_Type_No5     int     null,
  Fee_Type_No6     int     null,
  Fee_Type_No7     int     null,
  Fee_Type_No8     int     null,
  Fee_Type_No9     int     null,
  Fee_Type_No10    int     null,
  Fee_Type_No11    int     null,
  Fee_Type_No12    int     null,

Constraint PKfeeexcept primary key (Std_Pay_Type_No,Term,Year))