Datasource: traff_DBNOW
Username: sa
Template: sch3.htx
SQLStatement:
	+select p1.Id_vehicle, p1.detail_vehicle,p2.time_in,p2.time_out,p1.start_station,p1.dest_station
	+from vehicle_property p1,index_goal p2
	+where p2.pass_place='%N_officeValue%' and p1.type_vehicle=p2.type_vehicle and
	      +p1.Id_vehicle=p2.id_vehicle and p1.type_vehicle='Ã¶ä¿'	


