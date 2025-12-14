Datasource: traff_DBNOW
Username: sa
Template: sch55.htx
SQLStatement:
	+select p1.Id_vehicle,p1.type_vehicle,p1.service_time,p1.start_station,p1.dest_station
	+from vehicle_property p1,index_goal p2
	+where p2.pass_place='%NofficChValue%' and p1.type_vehicle=p2.type_vehicle and
	          + p1.Id_vehicle=p2.id_vehicle and p2.type_place='ท่าเรือ' and p1.type_vehicle='เรือ'
	          


