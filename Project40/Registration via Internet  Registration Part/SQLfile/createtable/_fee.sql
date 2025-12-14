Create Table Fee
( Subj_id        char(6) not null,
  Fee_Year_Begin char(4) not null,
  Fee_Term_Begin char(1) not null,
  Fee_Lecture    int     null,
  Fee_Lab        int     null,
  Astd_Begin     char(4) null,
  Astd_End       char(4) null,
Constraint PKfee primary key (Subj_id,Fee_Year_Begin,Fee_Term_Begin))