DROP PROCEDURE  DELETESHELF_ROOM;

CREATE PROCEDURE DELETESHELF_ROOM(Input_shelf_roomid  integer,Input_Type integer)

     IF Input_Type = 0 THEN
        DELETE FROM bookshelf WHERE shelfid = Input_shelf_roomid;
     ELIF Input_Type = 1 THEN
        DELETE FROM musicshelf WHERE shelfid = Input_shelf_roomid;
     ELIF Input_Type = 2 THEN 
        DELETE FROM movieshelf WHERE shelfid = Input_shelf_roomid;
     ELSE
        DELETE FROM room WHERE roomid = Input_shelf_roomid;
     END IF;

END PROCEDURE;
 
execute procedure deletebook()

select * from book