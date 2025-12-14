Datasource: traff_DBNOW
Username: sa
Template: Rsch1.htx
MaxRecords: 1
SQLStatement:
	+select *
	+from search_step1
	+where start11='%info_s%'  and type_start11='%tSplace%' and
	+       dest11='%info_d%' and type_dest11='%tDplace%'  and
	+       (type_vehicle11='%bus%' or type_vehicle11='%train%' or type_vehicle11='%chess%' or type_vehicle11='%van%') 	

SQLStatement:
+select * 
+from search_step2 
+where start21='%info_s%' and type_start21='%tSplace%' and dest21='%info_d%' and type_dest21='%tDplace%'   
+	and (id_vehicle21 not in (select id_vehicle11
+	from search_step1 
+	where 	(start11=start21 and type_start11=type_start21)and
+		(dest11=dest21  and type_dest11=type_dest21)and
+		(type_vehicle11=type_vehicle21))) 
+		and (id_vehicle22 not in (select id_vehicle11
+			from search_step1 
+			where 	(start11=start21 and type_start11=type_start21)and
+				(dest11=dest21  and type_dest11=type_dest21)and
+				(type_vehicle11=type_vehicle22)))  and
+       ((type_vehicle21='%bus%' or type_vehicle21='%train%' or type_vehicle21='%chess%' or type_vehicle21='%van%')  and
+       (type_vehicle22='%bus%' or type_vehicle22='%train%' or type_vehicle22='%chess%' or type_vehicle22='%van%')) 	 

SQLStatement:
+Select *
+From search_step3,search_step1,search_step2
+Where 	start31='%info_s%' and type_start31='%tSplace%'and dest31='%info_d%' and type_dest31='%tDplace%'
+and  start11='%info_s%' and type_start11='%tSplace%'and dest11='%info_d%' and type_dest11='%tDplace%'
+and  start21='%info_s%' and type_start21='%tSplace%'and dest21='%info_d%' and type_dest21='%tDplace%'
+and ((id_vehicle31 !=id_vehicle11) or (type_vehicle31!=type_vehicle11)) 
+and ((id_vehicle32 !=id_vehicle11) or (type_vehicle32!=type_vehicle11))
+and ((id_vehicle33 !=id_vehicle11) or (type_vehicle33!=type_vehicle11))
+and ((id_vehicle31 !=id_vehicle21) or (type_vehicle31!=type_vehicle21)) 
+and ((id_vehicle32 !=id_vehicle21) or (type_vehicle32!=type_vehicle21))
+and ((id_vehicle33 !=id_vehicle21) or (type_vehicle33!=type_vehicle21))
+and ((id_vehicle31 !=id_vehicle22) or (type_vehicle31!=type_vehicle22)) 
+and ((id_vehicle32 !=id_vehicle22) or (type_vehicle32!=type_vehicle22))
+and ((id_vehicle33 !=id_vehicle22) or (type_vehicle33!=type_vehicle22))
+ and ((type_vehicle31='%bus%' or type_vehicle31='%train%' or type_vehicle31='%chess%' or type_vehicle31='%van%')  and
+     (type_vehicle32='%bus%' or type_vehicle32='%train%' or type_vehicle32='%chess%' or type_vehicle32='%van%') and
+       (type_vehicle33='%bus%' or type_vehicle33='%train%' or type_vehicle33='%chess%' or type_vehicle33='%van%')) 	 	  
	
	
