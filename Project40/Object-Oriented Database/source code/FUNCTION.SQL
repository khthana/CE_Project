DROP Function Borrow(Users,char8,char8,date);
DROP Function Borrow(Student,char8,char8,date);
DROP Function Borrow(Bachelor,char8,char8,date);
DROP Function Borrow(Master_Degree,char8,char8,date);
DROP Function Borrow(Teacher,char8,char8,date);
DROP Function Restore(char8);

CREATE FUNCTION Borrow(Users,char8,char8,date) RETURNS int4 as
'update Text_Book set U_ID      = $2,
		      Amount    = 0,
		      startdate = $4	
 where Book_ID = $3;
 select 1 as result;' LANGUAGE 'sql';

CREATE FUNCTION Borrow(Student,char8,char8,date) RETURNS int4 as 
'update Text_Book set U_ID      = $2,
		      Amount    = 5,
		      startdate = $4
where Book_ID = $3;
select 2 as result;'  LANGUAGE 'sql';

CREATE FUNCTION Borrow(Bachelor,char8,char8,date) RETURNS int4 as
'update Text_Book set U_ID      = $2,
		      Amount    = 7,
		      startdate = $4
where Book_ID = $3;
select 3 as result' LANGUAGE 'sql';

CREATE FUNCTION Borrow(Master_Degree,char8,char8,date) RETURNS int4 as
'update Text_Book set U_ID      = $2,
		      Amount    = 14,
		      startdate = $4
where Book_ID = $3;
select 4 as result' LANGUAGE 'sql';

CREATE FUNCTION Borrow(Teacher,char8,char8,date) RETURNS int4 as
'update Text_Book set U_ID      = $2,
		      Amount    = 30,
		      startdate = $4
where Book_ID = $3;
select 5 as result' LANGUAGE 'sql';

CREATE FUNCTION Restore(char8) RETURNS int4 as
'update Text_Book set 	U_ID      = NULL,
		       	Amount    = NULL,
			StartDate = NULL	
where Book_ID = $1;
select 1 as result;' LANGUAGE 'sql';
