CREATE FUNCTION  CheckDataER (pj integer)
  RETURNING      Char(1);

  DEFINE  Answer1 		Integer;
  DEFINE  Answer2 		Char(1);
  DEFINE SubProc		Integer;  	
  DEFINE	LastCheck  	Char(3);
  DEFINE Final		Char(1);
  DEFINE LastAnswer	Char(3);

   LET  LastAnswer='Y' ;
        FOREACH  Sub_Cursor  FOR

	SELECT  Distinct subprocess 	INTO SubProc
	FROM  ProcessTable 
	WHERE ((projectID=pj) AND (subprocess<>0))
	
 	Execute Function CheckNoHaveSub(pj,SubProc) INTO Answer1 , Answer2; 

	LET  	Final='Y';

	If   Answer2 ='T' 
	Then Execute Function TestCheck3(pj,SubProc) Into  Final ;     
		If Final = 'N' 
		Then LET LastAnswer='N'; 
		End If;
	End If;	

	If Final = 'N' 
	Then LET LastAnswer='N'; 
	End If;

         END FOREACH; 

RETURN   LastAnswer ;	  

END FUNCTION;