CREATE  FUNCTION  CheckERdiagram(pj  integer)
   RETURNING   char(1);

DEFINE	EID		Integer;
DEFINE   Tempname	Char(20);
DEFINE	Answer		Char(1);

	LET  Answer='Y';
   FOREACH  ERcursor  FOR
	SELECT  ID, Name  INTO  EID,TempName
	FROM   EntityTable
	WHERE  ProjectID=pj

	IF TempName IN ( 	SELECT Name 
			FROM  EntityTable
			WHERE  ( (ProjectID=pj)  AND (ID<>EID) ) ) 
	THEN   LET   Answer='N';
	END  IF;
   END  FOREACH ;
           	RETURN   Answer ;
END  FUNCTION;