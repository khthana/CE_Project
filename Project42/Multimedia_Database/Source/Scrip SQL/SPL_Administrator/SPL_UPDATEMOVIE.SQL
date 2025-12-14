DROP procedure UPDATEMOVIE;

CREATE PROCEDURE UPDATEMOVIE(Input_MovieID integer,Input_MovieCode varchar(15),Input_MovieName varchar(35),Input_Actor1 varchar(20),Input_Actor2 varchar(20),Input_Publishing varchar(20),Input_year integer,Input_Film varchar(100),Input_MovieClass varchar(20),Input_Shelfid integer,Input_Layer integer,Input_Part char(1))

    DEFINE Result varchar(15);
      
    LET Result = ( SELECT MOVIECODE FROM MOVIE WHERE MOVIECODE = Input_MovieCode );
   
    IF ( Result IS NULL ) THEN  
   
            IF Input_Film != '"NOT"' THEN
                 UPDATE MOVIE
                 SET moviecode = Input_MovieCode,moviename = Input_MovieName,actor = row(Input_Actor1,Input_Actor2)::actor_t,movieclass = Input_Movieclass,publishing = Input_Publishing,year = Input_Year,film = Input_Film
                 WHERE  movieid = Input_MovieID;
            ELSE  UPDATE MOVIE
                 SET moviecode = Input_MovieCode,moviename = Input_MovieName,actor = row(Input_Actor1,Input_Actor2)::actor_t,movieclass = Input_Movieclass,publishing = Input_Publishing,year = Input_Year
                 WHERE  movieid = Input_MovieID;
            END IF;
     ELSE  

             IF Input_Film != '"NOT"' THEN
             UPDATE MOVIE
                 SET moviename = Input_MovieName,actor = row(Input_Actor1,Input_Actor2)::actor_t,movieclass = Input_Movieclass,publishing = Input_Publishing,year = Input_Year,film = Input_Film
                 WHERE  movieid = Input_MovieID;
            ELSE  UPDATE MOVIE
                 SET moviename = Input_MovieName,actor = row(Input_Actor1,Input_Actor2)::actor_t,movieclass = Input_Movieclass,publishing = Input_Publishing,year = Input_Year
                 WHERE  movieid = Input_MovieID;       
	   END IF;
      END IF;

     UPDATE ADDRESSMOVIE
     SET shelfid = Input_shelfid,layer = Input_Layer,part = Input_Part
      WHERE movieid = Input_MovieID;

    END PROCEDURE;
 
EXECUTE FUNCTION  UPDATEBOOK(10,"PLE","TEST","PLE","OUY","OH","125-56-8999","AMAZON",1999,'"NOT"',"CARTOON",1,2,"M");