DROP FUNCTION searchdetailmovie;

CREATE FUNCTION searchdetailmovie(Input_MovieID integer,Input_MovieCode varchar(15),Input_MovieName varchar(35),Input_Actor varchar(20),Input_Publishing varchar(20),Input_year integer,Input_MovieClass varchar(20)) returning integer,varchar(15),varchar(35),varchar(20),varchar(20),varchar(20),integer,varchar(20),integer,integer,char(1);
    DEFINE Output_MovieCode varchar(15);
    DEFINE Output_Publishing,Output_MovieClass,Output_Actor1,Output_Actor2 varchar(20);
    DEFINE Output_MovieName varchar(35);
    DEFINE Output_Part char(1);
    DEFINE Output_MovieId,Output_ShelfId,Output_Year,Output_Layer integer;
    
    LET Input_MovieCode = concat("%",concat(Input_MovieCode,"%"));
    LET Input_MovieClass = concat("%",concat(Input_MovieClass,"%"));
    LET Input_MovieName = concat("%",concat(Input_MovieName,"%"));
    LET Input_Actor = concat("%",concat(Input_Actor,"%"));
    LET Input_Publishing = concat("%",concat(Input_Publishing,"%"));
    
    IF (Input_MovieID  != 0)  and (Input_Year = 0) THEN    
           FOREACH Cursor1 FOR
                   SELECT t1.movieid,moviecode,moviename,actor.actor1,actor.actor2,publishing,year,movieclass,t2.shelfid,layer,part
                   INTO Output_MovieId,Output_MovieCode,Output_MovieName,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part
	           FROM movie t1,addressmovie t2
	           WHERE t1.movieid  =  Input_MovieID and moviecode like Input_MovieCode and moviename like Input_MovieName and (actor.actor1 like Input_Actor or actor.actor2 like Input_Actor) and movieclass like Input_MovieClass and publishing like Input_Publishing and t2.movieid = t1.movieid
                   RETURN Output_MovieId,Output_MovieCode,Output_Moviename,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part with resume;
         END FOREACH;

     ELIF (Input_MovieID = 0)  and (Input_Year != 0) THEN
           FOREACH Cursor1 FOR
                   SELECT t1.movieid,moviecode,moviename,actor.actor1,actor.actor2,publishing,year,movieclass,t2.shelfid,layer,part
                   INTO Output_MovieId,Output_MovieCode,Output_MovieName,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part
	           FROM movie t1,addressmovie t2
	           WHERE moviecode like Input_MovieCode and moviename like Input_MovieName and (actor.actor1 like Input_Actor or actor.actor2 like Input_Actor) and movieclass like Input_MovieClass and publishing like Input_Publishing and t2.movieid = t1.movieid and year = Input_Year
                   RETURN Output_MovieId,Output_MovieCode,Output_Moviename,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part with resume;
           END FOREACH;
    
      ELIF (Input_MovieID != 0)  and (Input_Year != 0) THEN
           FOREACH Cursor1 FOR
                   SELECT t1.movieid,moviecode,moviename,actor.actor1,actor.actor2,publishing,year,movieclass,t2.shelfid,layer,part
                   INTO Output_MovieId,Output_MovieCode,Output_MovieName,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part
	           FROM movie t1,addressmovie t2
	           WHERE t1.movieid  =  Input_MovieID and moviecode like Input_MovieCode and moviename like Input_MovieName and (actor.actor1 like Input_Actor or actor.actor2 like Input_Actor) and movieclass like Input_MovieClass and publishing like Input_Publishing and t2.movieid = t1.movieid and year = Input_Year
                   RETURN Output_MovieId,Output_MovieCode,Output_Moviename,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part with resume;
	   END FOREACH; 
             
       ELSE FOREACH Cursor1 FOR
                        SELECT t1.movieid,moviecode,moviename,actor.actor1,actor.actor2,publishing,year,movieclass,t2.shelfid,layer,part
                        INTO Output_MovieId,Output_MovieCode,Output_MovieName,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part
	                FROM movie t1,addressmovie t2
	               WHERE moviecode like Input_MovieCode and moviename like Input_MovieName and (actor.actor1 like Input_Actor or actor.actor2 like Input_Actor) and movieclass like Input_MovieClass and publishing like Input_Publishing and t2.movieid = t1.movieid
                       RETURN Output_MovieId,Output_MovieCode,Output_Moviename,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part with resume;
                  END FOREACH;
       END IF; 
        
    END FUNCTION;
    	  

select * from music
	  

execute function searchdetailmovie(0,"","","","",0,"")