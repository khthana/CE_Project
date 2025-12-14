Datasource: traff_DBNOW
Username: sa
Template: sch5.htx
SQLStatement:
	+select p1.service_time,p1.start_station,p1.dest_station,p2.pass_place,p2.type_place
	+from vehicle_property p1,index_goal p2
	+where p1.detail_vehicle='%N_ChessValue%' and p1.type_vehicle=p2.type_vehicle and
	          + p1.Id_vehicle='%IdChessValue%' and p1.Id_vehicle=p2.id_vehicle and
		+ p1.type_vehicle='เรือ'
		

