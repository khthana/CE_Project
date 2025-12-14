Datasource: traff_DBNOW
Username: sa
Template: Rsch1X.htx
MaxRecords: 500
SQLStatement:
	+select *
	+from index_goal
	+where  pass_place='%info_d%' and type_place='%tDplace%' and
	+       (type_vehicle='%bus%' or type_vehicle='%train%' or type_vehicle='%chess%' or type_vehicle='%van%') 	


	
	
