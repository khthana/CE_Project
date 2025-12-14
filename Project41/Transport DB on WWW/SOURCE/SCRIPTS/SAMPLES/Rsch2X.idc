Datasource: traff_DBNOW
Username: sa
Template: Rsch3X.htx
MaxRecords: 500
SQLStatement:
	+select type_place,pass_place,key_section
	+from place_property
	+where  pass_place='%info_d%' and type_place='%tDplace%' 
	


	
	
