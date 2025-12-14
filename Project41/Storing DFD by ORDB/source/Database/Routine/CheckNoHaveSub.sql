CREATE FUNCTION  CheckNoHaveSub (project integer, SubProc Integer)
  RETURNING    Integer , Char(1);

  DEFINE  	Ans 	Char(1);
  DEFINE		Number	Integer;  	

  LET Ans='T';

FOREACH  Gate_cursor  FOR

	SELECT  ID  INTO Number
	FROM  ProcessTable
	WHERE (projectID=project) AND (subprocess=SubProc)
	
	IF  Number   IN (Select   subprocess
		          From  ProcessTable
		          Where (projectID=project) AND (subprocess<>0))
	Then  LET Ans = 'F';
	END IF;
	
END FOREACH; 

	RETURN  SubProc , Ans ; 
	
END FUNCTION;