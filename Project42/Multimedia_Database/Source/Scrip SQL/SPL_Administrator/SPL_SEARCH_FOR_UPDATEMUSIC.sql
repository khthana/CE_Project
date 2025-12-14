DROP FUNCTION searchupdatemusic;

CREATE FUNCTION searchupdatemusic(Input_MusicId integer) returning varchar(15),varchar(30),varchar(25),varchar(20),varchar(20),integer,varchar(10),integer,integer,char(1),integer
    DEFINE Output_MusicCode varchar(15);
    DEFINE Output_Genre varchar(10);
    DEFINE Output_Arthist varchar(25);
    DEFINE Output_Publishing,Output_Album varchar(20);
    DEFINE Output_MusicName varchar(30);
    DEFINE Output_Part char(1);
    DEFINE Output_CountLayer,Output_ShelfId,Output_Year,Output_Layer integer;
    
           FOREACH Cursor1 FOR  
	    SELECT musiccode,musicname,arthist,album,publishing,year,genre,t2.shelfid,t2.layer,part,t3.layer
            INTO Output_MusicCode,Output_MusicName,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part,Output_CountLayer
	    FROM music t1,addressmusic t2,musicshelf t3
	    WHERE t1.musicid = Input_MusicId and t2.musicid = t1.musicid and t3.shelfid = t2.shelfid
             RETURN Output_MusicCode,Output_Musicname,Output_Arthist,Output_Album,Output_Publishing,Output_Year,Output_Genre,Output_ShelfId,Output_Layer,Output_Part,Output_CountLayer with resume;
            END FOREACH; 
     
    END FUNCTION;

execute function searchupdatebook(9)
select * from book