DROP FUNCTION searchupdatemovie;

CREATE FUNCTION searchupdatemovie(Input_MovieId integer) returning varchar(15),varchar(35),varchar(20),varchar(20),varchar(20),integer,varchar(20),integer,integer,char(1),integer
    DEFINE Output_MovieCode varchar(15);
    DEFINE Output_Publishing,Output_Actor1,Output_Actor2,Output_MovieClass varchar(20);
    DEFINE Output_MovieName varchar(35);
    DEFINE Output_Part char(1);
    DEFINE Output_CountLayer,Output_ShelfId,Output_Year,Output_Layer integer;
    
            FOREACH Cursor1 FOR
	    SELECT moviecode,moviename,actor.actor1,actor.actor2,publishing,year,movieclass,t2.shelfid,t2.layer,part,t3.layer
            INTO Output_MovieCode,Output_MovieName,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part,Output_CountLayer
	    FROM movie t1,addressmovie t2,movieshelf t3
	    WHERE t1.movieid = Input_MovieId and t2.movieid = t1.movieid and t3.shelfid = t2.shelfid
             RETURN Output_MovieCode,Output_Moviename,Output_Actor1,Output_Actor2,Output_Publishing,Output_Year,Output_MovieClass,Output_ShelfId,Output_Layer,Output_Part,Output_CountLayer with resume;
             END FOREACH;
     
    END FUNCTION;

execute function searchupdatemovie(3)
select * from book