DROP FUNCTION getdetailbook;

CREATE FUNCTION getdetailbook(input_bookcode varchar(15)) returning integer,varchar(15),varchar(40),varchar(15),varchar(15),varchar(15),varchar(15),varchar(15),integer,varchar(15),integer,integer,varchar(8),media_t,char(1),integer,integer,media_t;
    DEFINE output_bookcode,output_bookclass,output_isbn,output_author1,output_author2,output_author3,output_publishing varchar(15);
    DEFINE output_bookname varchar(40);
    DEFINE output_year integer;
    DEFINE output_image media_t;
    DEFINE output_bookid,output_shelfid,output_layer,output_position_x,output_position_y integer;
    DEFINE output_part char(1);
    DEFINE output_room varchar(8);
    DEFINE output_preface media_t;
        
      FOREACH Cursor1 FOR
         select t1.bookid,bookcode,bookname,author.author1,author.author2,author.author3,bookclass,publishing,year,isbn,t2.shelfid,t2.layer,t5.roomname,image,part,position.x,position.y,preface
         into output_bookid,output_bookcode,output_bookname,output_author1,output_author2,output_author3,output_bookclass,output_publishing,output_year,output_isbn,output_shelfid,output_layer,output_room,output_image,output_part,output_position_x,output_position_y,output_preface
         from book t1,addressbook t2,bookshelf t3,addressbookshelf t4,room t5
         where t1.bookcode = input_bookcode and t2.bookid =  t1.bookid and t3.shelfid = t2.shelfid and t4.roomid = t5.roomid and t3.shelfid = t4.shelfid
         RETURN  output_bookid,output_bookcode,output_bookname,output_author1,output_author2,output_author3,output_bookclass,output_publishing,output_year,output_isbn,output_shelfid,output_layer,output_room,output_image,output_part,output_position_x,output_position_y,output_preface
with resume;
      END FOREACH
END FUNCTION;
    	  
execute function getdetailbook("QC.754.26.B3")

SELECT * FROM BOOK
select bookcode from book