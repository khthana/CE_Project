CREATE  FUNCTION  NewFlow5 (project integer ,sub integer ,GID integer ,MoID integer ,MoType Char(2),NewMoType Char(2))  	
RETURNING  Char(1);

DEFINE		Answer 		Char(1);		
DEFINE		Data1		Char(20);	

	LET  Answer='Y';
FOREACH Gate_Cursor FOR

	Select   Formatdata  INTO  Data1
	From     DataFlowTable
	Where 	(ProjectID=project)
	                         AND
         		( ( (SourceID=GID)  and  (SourceType=NewMoType) )
				OR
 		( (DestinationID=GID)  and  (DestinationType=NewMoType) ) )

	
	IF     Data1    NOT  IN 	
		(Select  FormatData  
		From   DataflowTable
		Where  	( ProjectID=project)  
				AND
	                	(((SourceID=MoID)  and  (SourceType=MoType)  and  (DestinationID=sub) and (DestinationType='P')) 
		    		OR
 		               	((DestinationID=MoID)  and  (DestinationType=MoType)  and  (SourceID=sub) and (SourceType='P'))) )

	THEN   LET  Answer='N';
	END IF;

END FOREACH;

	RETURN  Answer;

END FUNCTION;