DROP FUNCTION getinfobook;

CREATE FUNCTION getinfobook(input_bookcode varchar(15),input_bookname varchar(40),input_author varchar(20),input_bookclass varchar(15),input_publishing varchar(20),input_year integer) returning varchar(15),varchar(40),varchar(15),varchar(15),integer;
    DEFINE output_bookcode,output_bookclass varchar(15);
    DEFINE output_author,output_publishing varchar(15);
    DEFINE output_bookname varchar(40);
    DEFINE output_year integer;
    
    LET input_bookcode = concat("%",concat(input_bookcode,"%"));
    LET input_bookname = concat("%",concat(input_bookname,"%"));
    LET input_author = concat("%",concat(input_author,"%"));
    LET input_bookclass = concat("%",concat(input_bookclass,"%"));
    LET input_publishing = concat("%",concat(input_publishing,"%"));
    IF input_year != 0 THEN 
          FOREACH Cursor1 FOR
         select bookcode,bookname,bookclass,publishing,year
         into output_bookcode,output_bookname,output_bookclass,output_publishing,output_year
         from book
         where bookcode like input_bookcode and bookname like input_bookname and (author.author1 like input_author or author.author2 like input_author or author.author3 like input_author) and bookclass like input_bookclass and publishing like input_publishing and year = input_year
	 RETURN output_bookcode,output_bookname,output_bookclass,output_publishing,output_year with resume;
         END FOREACH;
   ELSE FOREACH Cursor1 FOR
         select bookcode,bookname,bookclass,publishing,year
         into output_bookcode,output_bookname,output_bookclass,output_publishing,output_year
         from book
         where bookcode like input_bookcode and bookname like input_bookname and (author.author1 like input_author or author.author2 like input_author or author.author3 like input_author) and bookclass like input_bookclass and publishing like input_publishing
	 RETURN output_bookcode,output_bookname,output_bookclass,output_publishing,output_year with resume;
         END FOREACH;
   END IF;
END FUNCTION;
    	  
execute function getinfobook("QC.754.26","","","","",0);

select * from book


