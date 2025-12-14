CREATE FUNCTION  genProjectID()
	RETURNING integer;

	DEFINE rowNum integer;
	DEFINE resultNum integer;
	DEFINE i integer ;
	LET i = 1;
	
	SELECT count(*)  INTO rowNum FROM  projectTable ;
	
	IF rowNum > 0 THEN	
		WHILE ( i <= rowNum )

			SELECT count(*) INTO resultNum FROM projectTable WHERE projectID=i;
			IF resultNum = 0 THEN  
				EXIT WHILE;
			END IF;
			LET i=i+1;

		END WHILE;

	ELIF rowNum = 0 THEN LET i=1; 
	END IF;

	RETURN i;
END FUNCTION
