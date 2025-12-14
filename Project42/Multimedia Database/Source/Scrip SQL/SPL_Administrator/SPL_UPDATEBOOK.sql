DROP PROCEDURE UPDATEBOOK;

CREATE PROCEDURE UPDATEBOOK(Input_BookID integer,Input_BookCode varchar(15),Input_BookName varchar(40),Input_Author1 varchar(20),Input_Author2 varchar(20),Input_Author3 varchar(20),Input_ISBN varchar(13),Input_Publishing varchar(20),Input_year integer,Input_Title varchar(100),Input_Preface varchar(100),Input_BookClass varchar(15),Input_Shelfid integer,Input_Layer integer,Input_Part char(1))

    DEFINE Result varchar(15);
  
    LET Result = ( SELECT BOOKCODE FROM BOOK WHERE BOOKCODE = Input_BookCode );
   
    IF ( Result IS NULL ) THEN  
   
          IF (Input_Title != '"NOT"') and (Input_Preface != '"NOT"') THEN
               UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,Image = Input_Title,Preface = Input_Preface,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;
          ELIF (Input_Title != '"NOT"') and (Input_Preface = '"NOT"') THEN
               UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,Image = Input_Title,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;
          ELIF  (Input_Title = '"NOT"') and (Input_Preface != '"NOT"') THEN
               UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,Preface = Input_Preface,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;
          ELSE  UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;       
          END IF;
              
     ELSE 

	IF (Input_Title != '"NOT"') and (Input_Preface != '"NOT"') THEN
               UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,Image = Input_Title,Preface = Input_Preface,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;
          ELIF (Input_Title != '"NOT"') and (Input_Preface = '"NOT"') THEN
               UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,Image = Input_Title,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;
          ELIF  (Input_Title = '"NOT"') and (Input_Preface != '"NOT"') THEN
               UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,Preface = Input_Preface,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;
          ELSE  UPDATE BOOK
               SET bookcode = Input_BookCode,bookname = Input_BookName,bookclass = Input_BookClass,isbn = Input_ISBN,publishing = Input_Publishing,year = Input_Year,author = row(Input_Author1,Input_Author2,Input_Author3)::Author_t
                WHERE  bookid = Input_BookID;       
          END IF;

     END IF;
        
     UPDATE ADDRESSBOOK
     SET shelfid = Input_shelfid,layer = Input_Layer,part = Input_Part
      WHERE bookid = Input_BookID;
    
END PROCEDURE;
 
