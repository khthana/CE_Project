DROP procedure UPDATEMUSIC;

CREATE PROCEDURE UPDATEMUSIC(Input_MusicID integer,Input_MusicCode varchar(15),Input_MusicName varchar(30),Input_Arthist varchar(25),Input_Album varchar(20),Input_Publishing varchar(20),Input_year integer,Input_Song varchar(100),Input_Genre varchar(10),Input_Shelfid integer,Input_Layer integer,Input_Part char(1))

    DEFINE Result varchar(15);
      
    LET Result = ( SELECT MUSICCODE FROM MUSIC WHERE MUSICCODE = Input_MusicCode );
   
    IF ( Result IS NULL ) THEN  
   
            IF Input_Song != '"NOT"' THEN
                 UPDATE MUSIC
                 SET musiccode = Input_MusicCode,musicname = Input_MusicName,arthist = Input_Arthist,genre = Input_Genre,album = Input_Album,publishing = Input_Publishing,year = Input_Year,Song = Input_Song
                 WHERE  musicid = Input_MusicID;
            ELSE  UPDATE MUSIC
                 SET musiccode = Input_MusicCode,musicname = Input_MusicName,arthist = Input_Arthist,genre = Input_Genre,album = Input_Album,publishing = Input_Publishing,year = Input_Year
                 WHERE  musicid = Input_MusicID;       
            END IF;
       
     ELSE  

             IF Input_Song != '"NOT"' THEN
                 UPDATE MUSIC
                 SET musicname = Input_MusicName,arthist = Input_Arthist,genre = Input_Genre,album = Input_Album,publishing = Input_Publishing,year = Input_Year,Song = Input_Song
                 WHERE  musicid = Input_MusicID;
            ELSE  UPDATE MUSIC
                 SET musicname = Input_MusicName,arthist = Input_Arthist,genre = Input_Genre,album = Input_Album,publishing = Input_Publishing,year = Input_Year
                 WHERE  musicid = Input_MusicID;       
           END IF;

     END IF;
     
     UPDATE ADDRESSMUSIC
     SET shelfid = Input_shelfid,layer = Input_Layer,part = Input_Part
     WHERE musicid = Input_MusicID;
       
    END PROCEDURE;
 
EXECUTE FUNCTION  UPDATEBOOK(10,"PLE","TEST","PLE","OUY","OH","125-56-8999","AMAZON",1999,'"NOT"',"CARTOON",1,2,"M");