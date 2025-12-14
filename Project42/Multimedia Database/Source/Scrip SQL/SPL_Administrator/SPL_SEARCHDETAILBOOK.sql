DROP FUNCTION searchdetailbook;

CREATE FUNCTION searchdetailbook(Input_BookId integer,Input_BookCode varchar(15),Input_ISBN varchar(13),Input_BookName varchar(40),Input_Author varchar(20),Input_Publishing varchar(20),Input_year integer,Input_BookClass varchar(15)) returning integer,varchar(15),varchar(40),varchar(20),varchar(20),varchar(20),varchar(13),varchar(20),integer,varchar(15),integer,integer,char(1);
    DEFINE Output_BookCode,Output_BookClass varchar(15);
    DEFINE Output_ISBN varchar(13);
    DEFINE Output_Publishing,Output_Author1,Output_Author2,Output_Author3 varchar(20);
    DEFINE Output_BookName varchar(40);
    DEFINE Output_Part char(1);
    DEFINE Output_BookId,Output_ShelfId,Output_Year,Output_Layer integer;
    
    LET Input_BookCode = concat("%",concat(Input_BookCode,"%"));
    LET Input_ISBN = concat("%",concat(Input_ISBN,"%"));
    LET Input_BookName = concat("%",concat(Input_BookName,"%"));
    LET Input_Author = concat("%",concat(Input_Author,"%"));
    LET Input_BookClass = concat("%",concat(Input_BookClass,"%"));
    LET Input_Publishing = concat("%",concat(Input_Publishing,"%"));
    
    IF (Input_BookID  != 0)  and (Input_Year = 0) THEN    
        FOREACH Cursor1 FOR
            SELECT t1.bookid,bookcode,bookname,author.author1,author.author2,author.author3,isbn,publishing,year,bookclass,t2.shelfid,layer,part
            INTO Output_BookId,Output_BookCode,Output_BookName,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part
	    FROM book t1,addressbook t2
	    WHERE t1.bookid  =  Input_BookID and bookcode like Input_BookCode and bookname like Input_BookName and (author.author1 like Input_Author or author.author2 like Input_Author or author.author3 like Input_Author) and bookclass like Input_Bookclass and isbn like Input_ISBN and publishing like Input_Publishing and t2.bookid = t1.bookid
                    RETURN Output_BookId,Output_BookCode,Output_Bookname,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part with resume;
         END FOREACH;

     ELIF (Input_BookID = 0)  and (Input_Year != 0) THEN
                   FOREACH Cursor1 FOR
            SELECT t1.bookid,bookcode,bookname,author.author1,author.author2,author.author3,isbn,publishing,year,bookclass,t2.shelfid,layer,part
            INTO Output_BookId,Output_BookCode,Output_BookName,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part
	    FROM book t1,addressbook t2
	    WHERE bookcode like Input_BookCode and bookname like Input_BookName and (author.author1 like Input_Author or author.author2 like Input_Author or author.author3 like Input_Author) and bookclass like Input_Bookclass and isbn like Input_ISBN and publishing like Input_Publishing and t2.bookid = t1.bookid and year = Input_Year
                    RETURN Output_BookId,Output_BookCode,Output_Bookname,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part with resume;
         END FOREACH;
    
            ELIF (Input_BookID != 0)  and (Input_Year != 0) THEN
                   FOREACH Cursor1 FOR
            SELECT t1.bookid,bookcode,bookname,author.author1,author.author2,author.author3,isbn,publishing,year,bookclass,t2.shelfid,layer,part
            INTO Output_BookId,Output_BookCode,Output_BookName,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part
	    FROM book t1,addressbook t2
	    WHERE t1.bookid  =  Input_BookID and bookcode like Input_BookCode and bookname like Input_BookName and (author.author1 like Input_Author or author.author2 like Input_Author or author.author3 like Input_Author) and bookclass like Input_Bookclass and isbn like Input_ISBN and publishing like Input_Publishing and t2.bookid = t1.bookid and year = Input_Year
                    RETURN Output_BookId,Output_BookCode,Output_Bookname,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part with resume;
         END FOREACH; 
             
            ELSE FOREACH Cursor1 FOR
            SELECT t1.bookid,bookcode,bookname,author.author1,author.author2,author.author3,isbn,publishing,year,bookclass,t2.shelfid,layer,part
            INTO Output_BookId,Output_BookCode,Output_BookName,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part
	    FROM book t1,addressbook t2
	    WHERE bookcode like Input_BookCode and bookname like Input_BookName and (author.author1 like Input_Author or author.author2 like Input_Author or author.author3 like Input_Author) and bookclass like Input_Bookclass and isbn like Input_ISBN and publishing like Input_Publishing and t2.bookid = t1.bookid
                    RETURN Output_BookId,Output_BookCode,Output_Bookname,Output_Author1,Output_Author2,Output_Author3,Output_ISBN,Output_Publishing,Output_Year,Output_BookClass,Output_ShelfId,Output_Layer,Output_Part with resume;
         END FOREACH;
     END IF; 
        
    END FUNCTION;
    	  

select * from book
execute function searchdetailbook(0,"","","MUL","","",0,"")	  
DELETE FROM BOOK
WHERE BOOKID = 3