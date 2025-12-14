Datasource: traff_DBNOW
Username: sa
Template: sch1.htx
MaxRecords: 500
SQLStatement:
	+select *
	+from search_step1
	+where start11='%info_s%' and type_start11='%tSplace%' and
	+       dest11='%info_d%' and type_dest11='%tDplace%'  and
	+       (type_vehicle11='%bus%' or type_vehicle11='%train%' or type_vehicle11='%chess%' or type_vehicle11='%van%') 	


	