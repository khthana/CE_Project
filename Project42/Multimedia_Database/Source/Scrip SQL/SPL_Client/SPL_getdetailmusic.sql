DROP FUNCTION getdetailmusic;

CREATE FUNCTION getdetailmusic(input_musiccode varchar(15)) returning integer,varchar(15),varchar(30),varchar(25),varchar(20),integer,varchar(10),varchar(20),integer,integer,varchar(8),media_t,char(1),integer,integer;
    DEFINE output_musiccode varchar(15);
    DEFINE output_musicname varchar(30);
    DEFINE output_year integer;
    DEFINE output_genre varchar(10);
    DEFINE output_song media_t;
    DEFINE output_arthist varchar(25);
    DEFINE output_album,output_publishing varchar(20);
    DEFINE output_musicid,output_shelfid,output_layer,output_position_x,output_position_y integer;
    DEFINE output_part char(1);
    DEFINE output_room varchar(8);
        
      FOREACH Cursor1 FOR
         select t1.musicid,musiccode,musicname,arthist,album,year,genre,publishing,t2.shelfid,t2.layer,t5.roomname,song,part,position.x,position.y
         into output_musicid,output_musiccode,output_musicname,output_arthist,output_album,output_year,output_genre,output_publishing,output_shelfid,output_layer,output_room,output_song,output_part,output_position_x,output_position_y
         from music t1,addressmusic t2,musicshelf t3,addressmusicshelf t4,room t5 
         where t1.musiccode = input_musiccode and t2.musicid =  t1.musicid and t3.shelfid = t2.shelfid and t4.roomid = t5.roomid and t3.shelfid = t4.shelfid
         RETURN output_musicid,output_musiccode,output_musicname,output_arthist,output_album,output_year,output_genre,output_publishing,output_shelfid,output_layer,output_room,output_song,output_part,output_position_x,output_position_y with resume;
      END FOREACH
END FUNCTION

  
execute function getdetailmusic("MS001");