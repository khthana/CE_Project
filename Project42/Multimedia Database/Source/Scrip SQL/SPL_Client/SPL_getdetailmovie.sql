DROP FUNCTION getdetailmovie;

CREATE FUNCTION getdetailmovie(input_moviecode varchar(15)) returning integer,varchar(15),varchar(35),varchar(20),varchar(20),varchar(20),integer,varchar(20),integer,integer,varchar(8),media_t,char(1),integer,integer;
    DEFINE output_moviecode varchar(15);
    DEFINE output_moviename varchar(35);
    DEFINE output_year integer;
    DEFINE output_film media_t;
    DEFINE output_movieclass,output_publishing,output_actor1,output_actor2 varchar(20);
    DEFINE output_movieid,output_shelfid,output_layer,output_position_x,output_position_y integer;
    DEFINE output_part char(1);
    DEFINE output_room varchar(8);
        
      FOREACH Cursor1 FOR
         select t1.movieid,moviecode,moviename,actor.actor1,actor.actor2,movieclass,year,publishing,t2.shelfid,t2.layer,t5.roomname,film,part,position.x,position.y
         into output_movieid,output_moviecode,output_moviename,output_actor1,output_actor2,output_movieclass,output_year,output_publishing,output_shelfid,output_layer,output_room,output_film,output_part,output_position_x,output_position_y
         from movie t1,addressmovie t2,movieshelf t3 ,addressmovieshelf t4 ,room t5
         where t1.moviecode = input_moviecode and t2.movieid =  t1.movieid and t3.shelfid = t2.shelfid and t4.roomid = t5.roomid and t3.shelfid = t4.shelfid
         RETURN output_movieid,output_moviecode,output_moviename,output_actor1,output_actor2,output_movieclass,output_year,output_publishing,output_shelfid,output_layer,output_room,output_film,output_part,output_position_x,output_position_y with resume;
      END FOREACH;
END FUNCTION;
    	  
execute function getdetailmovie("MV001")
select * from movie
