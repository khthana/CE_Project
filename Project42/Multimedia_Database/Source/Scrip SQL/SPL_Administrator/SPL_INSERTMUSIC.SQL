DROP FUNCTION INSERTMUSIC;

CREATE FUNCTION INSERTMUSIC(Input_MusicCode varchar(15),Input_MusicName varchar(30),Input_Arthist varchar(25),Input_Album varchar(20),Input_Genre varchar(10),Input_Publishing varchar(20),Input_year integer,Input_Song varchar(100),Input_Shelfid integer,Input_Layer integer,Input_Part char(1)) returning integer,char(1);
    DEFINE Output_Count integer;
    DEFINE Result varchar(15);
    DEFINE Flag_Insert char(1);
  
    LET Result = ( SELECT musiccode FROM music WHERE musiccode = Input_MusicCode );
   
    IF ( Result IS NULL ) THEN  
   
     INSERT INTO Music
     VALUES(0,Input_MusicCode,Input_MusicName,Input_Arthist,Input_Album,Input_Genre,Input_Publishing,Input_Year,Input_Song);
     LET Output_Count = (SELECT musicid FROM music WHERE musiccode = Input_MusicCode);
     INSERT INTO ADDRESSMUSIC
     VALUES(Output_Count,Input_Shelfid,Input_Layer,Input_Part);
     LET Flag_Insert = "Y";
     ELSE LET Flag_Insert = "N";
     END IF;
    LET Output_Count = ( SELECT COUNT(*) FROM music );
    RETURN Output_Count,Flag_Insert;
END FUNCTION;
 




