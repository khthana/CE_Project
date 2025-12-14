DROP FUNCTION INSERTMOVIE;

CREATE FUNCTION INSERTMOVIE(Input_MovieCode varchar(15),Input_MovieName varchar(35),Input_Actor1 varchar(20),Input_Actor2 varchar(20),Input_MovieClass varchar(20),Input_Publishing varchar(20),Input_year integer,Input_Film varchar(100),Input_Shelfid integer,Input_Layer integer,Input_Part char(1)) returning integer,char(1);
    DEFINE Output_Count integer;
    DEFINE Result varchar(15);
    DEFINE Flag_Insert char(1);
  
    LET Result = ( SELECT moviecode FROM movie WHERE moviecode = Input_MovieCode );
   
    IF ( Result IS NULL ) THEN  
   
     INSERT INTO Movie
     VALUES(0,Input_MovieCode,Input_MovieName,ROW(Input_Actor1,Input_Actor2)::Actor_t,Input_MovieClass,Input_Publishing,Input_Year,Input_Film);
     LET Output_Count = (SELECT movieid FROM movie WHERE moviecode = Input_MovieCode);
     INSERT INTO ADDRESSMOVIE
     VALUES(Output_Count,Input_Shelfid,Input_Layer,Input_Part);
     LET Flag_Insert = "Y";
     ELSE LET Flag_Insert = "N";
     END IF;
    LET Output_Count = ( SELECT COUNT(*) FROM movie );
    RETURN Output_Count,Flag_Insert;
END FUNCTION;
 




