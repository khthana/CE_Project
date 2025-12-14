Datasource: traff_DBNOW
Username: sa
Template: sch1_2.htx
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
+       Order By pass21
	