DROP FUNCTION INSERTBOOK;

CREATE FUNCTION INSERTBOOK(Input_BookCode varchar(15),Input_ISBN varchar(13),Input_BookName varchar(40),Input_Author1 varchar(20),Input_Author2 varchar(20),Input_Author3 varchar(20),Input_BookClass varchar(15),Input_Publishing varchar(20),Input_year integer,Input_Title varchar(100),Input_Preface varchar(100),Input_Shelfid integer,Input_Layer integer,Input_Part char(1)) returning integer,char(1);
    DEFINE Output_Count integer;
    DEFINE Result varchar(15);
    DEFINE Flag_Insert char(1);
  
    LET Result = ( SELECT BOOKCODE FROM BOOK WHERE BOOKCODE = Input_BookCode );
   
    IF ( Result IS NULL ) THEN  
   
     INSERT INTO BOOK
     VALUES(0,Input_BookCode,Input_ISBN,Input_BookName,ROW(Input_Author1,Input_Author2,Input_Author3)::Author_t,Input_BookClass,Input_Publishing,Input_year,Input_Title,Input_Preface);
     LET Output_Count = (SELECT BOOKID FROM BOOK WHERE BOOKCODE = Input_Bookcode);
     INSERT INTO ADDRESSBOOK
     VALUES(Output_Count,Input_Shelfid,Input_Layer,Input_Part);
     LET Flag_Insert = "Y";
     ELSE LET Flag_Insert = "N";
     END IF;
    LET Output_Count = ( SELECT COUNT(*) FROM BOOK );
    RETURN Output_Count,Flag_Insert;
END FUNCTION;