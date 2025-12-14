DROP FUNCTION getinfomusic;

CREATE FUNCTION getinfomusic(input_musiccode varchar(15),input_musicname varchar(30),input_arthist varchar(25),input_album varchar(20),
input_year integer,input_genre varchar(10),input_publishing varchar(20)) returning varchar(15),varchar(30),varchar(25),varchar(20),integer,varchar(10),varchar(20);
    DEFINE output_musiccode varchar(15);
    DEFINE output_musicname varchar(30);
    DEFINE output_arthist varchar(25);
    DEFINE output_album,output_publishing varchar(20);
    DEFINE output_year integer;
    DEFINE output_genre varchar(10);
     
       LET input_musiccode = concat("%",concat(input_musiccode,"%"));
       LET input_musicname = concat("%",concat(input_musicname,"%"));
       LET input_arthist = concat("%",concat(input_arthist,"%"));
       LET input_album = concat("%",concat(input_album,"%"));
       LET input_genre = concat("%",concat(input_genre,"%"));	
       LET input_publishing = concat("%",concat(input_publishing,"%"));
       IF input_year != 0 THEN
                   FOREACH Cursor1 FOR
    	   select musiccode,musicname,arthist,album,year,genre,publishing
	   into output_musiccode,output_musicname,output_arthist,output_album,output_year,output_genre,output_publishing 	
    	   from music
    	   where musiccode like input_musiccode and musicname like input_musicname and arthist like input_arthist and album like input_album and 
 year = input_year and genre like input_genre and publishing like input_publishing
    	   RETURN  output_musiccode,output_musicname,output_arthist,output_album,output_year,output_genre,output_publishing with resume;
                   END FOREACH;
         ELSE  FOREACH Cursor1 FOR
    	   select musiccode,musicname,arthist,album,year,genre,publishing
	   into output_musiccode,output_musicname,output_arthist,output_album,output_year,output_genre,output_publishing 	
    	   from music
    	   where musiccode like input_musiccode and musicname like input_musicname and arthist like input_arthist and album like input_album and genre like input_genre and publishing like input_publishing
    	   RETURN  output_musiccode,output_musicname,output_arthist,output_album,output_year,output_genre,output_publishing with resume;
                   END FOREACH;
        END IF;
END FUNCTION;

execute function getinfomusic("MS001","","","",0,"","");

select * from music
