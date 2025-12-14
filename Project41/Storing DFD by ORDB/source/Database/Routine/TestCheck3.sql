CREATE  FUNCTION  TestCheck3(ProjID Integer , SubProc Integer)
  RETURNING   Char(1);

DEFINE  TempID    		Integer ;
DEFINE  TempName	Char(15) ;
DEFINE	Last		Char(1) ; 

	Let	Last='N';
FOREACH Cursor1 FOR

	Select Id , Name  
	INTO  TempID,TempName
	From  DataStoreTable
	Where (ProjectID=ProjID) And (SubProcess=SubProc)

	Let	Last='N';

	IF TempName In ( 	Select Name
			From  EntityTable
			Where ProjectID=ProjID  )
	THEN  Let  Last='Y';
	End If;

END FOREACH;

RETURN  Last ;

END FUNCTION;