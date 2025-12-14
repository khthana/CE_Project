DROP FUNCTION searchdetailmusic;
																																		
CREATE FUNCTION searchdetailmusic(Input_MusicID integer,Input_MusicCode varchar(15),Input_MusicName varchar(30),Input_Arthist varchar(25),Input_Album varchar(20),Input_Publishing varchar(20),Input_year integer,Input_Genre varchar(10)) returning integer,varchar(15),varchar(30),varchar(25),varchar(20),varchar(20),integer,varchar(10),integer,integer,char(1);
    DEFINE Output_MusicCode varchar(15);
    DEFINE Output_Genre varchar(10);
    DEFINE Output_Publishing,Output_Album varchar(20);
    DEFINE Output_MusicName varchar(30);
    DEFINE Output_Arthist varchar(25) ;
    DEFINE Output_Part char(1);
    DEFINE Output_MusicId,Output_ShelfId,Output_Year,Output_Layer integer;
    
    LET Input_MusicCode = concat("%",concat(Input_MusicCode,"%"));
    LET Input_Genre = concat("%",concat(Input_Genre,"%"));
    LET Input_MusicName = concat("%",concat(Input_MusicName,"%"));
    LET Input_Arthist = concat("%",concat(Input_Arthist,"%"));
    LET Input_Album = concat("%",concat(Input_Album,"%"));
    LET Input_Publishing = concat("%",concat(Input_Publishing,"%"));
    
    IF (Input_MusicID  != 0)  and (Input_Year = 0) THEN    
           FOREACH Cursor1 FOR
                   SELECT t1.musicid,musiccode,musicname,arthist,album,publishing,year,genre,t2.shelfid,layer,part
                   INTO Output_MusicId,Output_MusicCode,Output_MusicName,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part
	           FROM music t1,addressmusic t2
	           WHERE t1.musicid  =  Input_MusicID and musiccode like Input_MusicCode and musicname like Input_MusicName and arthist like Input_Arthist and genre like Input_Genre and album like Input_Album and publishing like Input_Publishing and t2.musicid = t1.musicid
                   RETURN Output_MusicId,Output_MusicCode,Output_Musicname,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part with resume;
         END FOREACH;

     ELIF (Input_MusicID = 0)  and (Input_Year != 0) THEN
           FOREACH Cursor1 FOR
                     SELECT t1.musicid,musiccode,musicname,arthist,album,publishing,year,genre,t2.shelfid,layer,part
                     INTO Output_MusicId,Output_MusicCode,Output_MusicName,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part
	             FROM music t1,addressmusic t2
	             WHERE musiccode like Input_MusicCode and musicname like Input_MusicName and arthist like Input_Arthist and genre like Input_Genre and album like Input_Album and publishing like Input_Publishing and year = Input_Year and t2.musicid = t1.musicid
                     RETURN Output_MusicId,Output_MusicCode,Output_Musicname,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part with resume;
           END FOREACH;
    
      ELIF (Input_MusicID != 0)  and (Input_Year != 0) THEN
           FOREACH Cursor1 FOR
                     SELECT t1.musicid,musiccode,musicname,arthist,album,publishing,year,genre,t2.shelfid,layer,part
                     INTO Output_MusicId,Output_MusicCode,Output_MusicName,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part
	             FROM music t1,addressmusic t2
	             WHERE t1.musicid  =  Input_MusicID and musiccode like Input_MusicCode and musicname like Input_MusicName and arthist like Input_Arthist and genre like Input_Genre and album like Input_Album and publishing like Input_Publishing and year = Input_Year and t2.musicid = t1.musicid
                     RETURN Output_MusicId,Output_MusicCode,Output_Musicname,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part with resume;
	   END FOREACH; 
             
       ELSE FOREACH Cursor1 FOR
                     SELECT t1.musicid,musiccode,musicname,arthist,album,publishing,year,genre,t2.shelfid,layer,part
                     INTO Output_MusicId,Output_MusicCode,Output_MusicName,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part
	             FROM music t1,addressmusic t2
	             WHERE musiccode like Input_MusicCode and musicname like Input_MusicName and arthist like Input_Arthist and genre like Input_Genre and album like Input_Album and publishing like Input_Publishing and t2.musicid = t1.musicid
                     RETURN Output_MusicId,Output_MusicCode,Output_Musicname,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part with resume;
                   END FOREACH;
       END IF; 
        
    END FUNCTION;
    	  

select * from music
execute function searchdetailmusic(0,"","","MUL","","",0,"")	  
DELETE FROM MUSIC
WHERE MUSICID = 3