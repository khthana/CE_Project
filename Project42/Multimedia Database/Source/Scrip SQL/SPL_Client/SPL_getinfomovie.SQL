DROP FUNCTION getinfomovie

CREATE FUNCTION getinfomovie(input_moviecode varchar(15),input_moviename varchar(35),input_actor varchar(20),input_movieclass varchar(20),input_year integer,input_publishing varchar(20)) returning varchar(15),varchar(35),varchar(20),integer,varchar(20);
    DEFINE output_moviecode varchar(15);
    DEFINE output_moviename varchar(35);
    DEFINE output_movieclass varchar(20);
    DEFINE output_year integer;
    DEFINE output_publishing varchar(20);
         
       LET input_moviecode = concat("%",concat(input_moviecode,"%"));
       LET input_moviename = concat("%",concat(input_moviename,"%"));
       LET input_actor = concat("%",concat(input_actor,"%"));
       LET input_movieclass = concat("%",concat(input_movieclass,"%"));
       LET input_publishing = concat("%",concat(input_publishing,"%"));
       IF input_year !=   0  THEN  
	FOREACH Cursor1 FOR
    	   select moviecode,moviename,movieclass,year,publishing
	   into output_moviecode,output_moviename,output_movieclass,output_year,output_publishing
    	   from movie
    	   where moviecode like input_moviecode and moviename like input_moviename and (actor.actor1 like input_actor or actor.actor2 like input_actor) and movieclass like input_movieclass and year =  input_year and publishing like input_publishing
    	   RETURN  output_moviecode,output_moviename,output_movieclass,output_year,output_publishing with resume;
       END FOREACH;
	ELSE FOREACH Cursor1 FOR
    	   select moviecode,moviename,movieclass,year,publishing
	   into output_moviecode,output_moviename,output_movieclass,output_year,output_publishing
    	   from movie
    	   where moviecode like input_moviecode and moviename like input_moviename and (actor.actor1 like input_actor or actor.actor2 like input_actor) and movieclass like input_movieclass and publishing like input_publishing
    	   RETURN  output_moviecode,output_moviename,output_movieclass,output_year,output_publishing with resume;
       END FOREACH;
	END IF;
END FUNCTION;




execute function getinfomovie("MV001","","","",0,"")


