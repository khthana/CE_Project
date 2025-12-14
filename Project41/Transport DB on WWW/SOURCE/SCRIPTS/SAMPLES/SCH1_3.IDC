Datasource: traff_DBNOW
Username: sa
Template: sch1_3.htx
MaxRecords: 500
SQLStatement:
+Select start31,type_dest31,id_vehicle31,type_vehicle31,pass31,type_pass31,id_vehicle32,type_vehicle32,pass32,type_pass32,id_vehicle33,type_vehicle33,dest31,type_dest31
+From search_step3,search_step1
+Where start31='%info_s%'  and  type_start31='%tSplace% 'and dest31='%info_d%' and type_dest31='%tDplace%'
   +and  start11='%info_s%'  and  type_start11='%tSplace%' and dest11='%info_d%' and type_dest11='%tDplace%'

+and ((id_vehicle31 != id_vehicle11) or (type_vehicle31 != type_vehicle11)) 
+and ((id_vehicle32 != id_vehicle11) or (type_vehicle32 != type_vehicle11))
+and ((id_vehicle33 != id_vehicle11) or (type_vehicle33 != type_vehicle11))
+and ((type_vehicle31='%bus%' or type_vehicle31='%train%' or type_vehicle31='%chess%' or type_vehicle31='%van%')  and
	+       (type_vehicle32='%bus%' or type_vehicle32='%train%' or type_vehicle32='%chess%' or type_vehicle32='%van%') and
	+       (type_vehicle33='%bus%' or type_vehicle33='%train%' or type_vehicle33='%chess%' or type_vehicle33='%van%')) 	 	  