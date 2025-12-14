CREATE FUNCTION  NewFlow10(project integer,sub integer )
  RETURNING    Char(1) ;

  DEFINE 	MoID		Integer;
  DEFINE		MoType		Char(2);
  DEFINE		NewMoType	Char(2);
  DEFINE		GID		Integer;
  DEFINE		Answer		Char(1);
  DEFINE		LastAnswer	Char(1);

	LET  LastAnswer='Y';
	FOREACH  Gate  FOR

		SELECT  id , ModelId , ModelType   INTO GID , MoID , MoType
		FROM  GateTable
		WHERE  (projectid=project) AND (Subprocess=sub)
		
		If  MoType='P' Then LET    NewMoType='GP' ;  End  If;
		If  MoType='E' Then LET    NewMoType='GE' ;  End  If;
		If  MoType='D' Then LET    NewMoType='GD' ;  End  If;		
		If  MoType='GP' Then LET  NewMoType='GP' ;  End  If;
		If  MoType='GE' Then LET  NewMoType='GE' ;  End  If;
		If  MoType='GD' Then LET NewMoType='GD' ;  End  If;	 

		EXECUTE  FUNCTION  NewFlow5(project,sub,GID,MoID,MoType,NewMoType)  INTO Answer ;		
		
		If Answer='N' Then LET LastAnswer='N';   End If;		
	
	END FOREACH;	

	RETURN  LastAnswer  ;

END FUNCTION;