DROP FUNCTION searchupdatebook;

CREATE FUNCTION searchupdatebook(Input_BookId integer) returning varchar(15),varchar(40),varchar(20),varchar(20),varchar(20),varchar(13),varchar(20),integer,varchar(15),integer,integer,char(1),integer
    DEFINE Output_BookCode,Output_BookClass varchar(15);
    DEFINE Output_ISBN varchar(13);
    DEFINE Output_Publishing,Output_Author1,Output_Author2,Output_Author3 varchar(20);
    DEFINE Output_BookName varchar(40);
    DEFINE Output_Part char(1);
    DEFINE Output_CountLayer,Output_ShelfId,Output_Year,Output_Layer integer;

            FOREACH Cursor1 FOR      
	    SELECT bookcode,bookname,author.author1,author.author2,author.author3,isbn,publishing,year,bookclass,t2.shelfid,t2.layer,part,t3.layer
            INTO Output_BookCode,Output_BookName,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part,Output_CountLayer
	    FROM book t1,addressbook t2,bookshelf t3
	    WHERE t1.bookid = Input_BookId and t2.bookid = t1.bookid and t3.shelfid = t2.shelfid
             RETURN Output_BookCode,Output_Bookname,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part,Output_CountLayer with resume;
            END FOREACH;
     
    END FUNCTION;

execute function searchupdatebook(9)
select * from book