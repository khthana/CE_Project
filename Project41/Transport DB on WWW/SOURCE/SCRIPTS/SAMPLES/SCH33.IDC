Datasource: traff_DBNOW
Username: sa
Template: sch33.htx
SQLStatement:
	+select p1.detail_vehicle,p2.pass_place,p2.time_out,p2.time_in,p1.start_station,p1.dest_station,p3.level3_charge
	+from vehicle_property p1,index_goal p2,place_property p3
	+where p1.id_vehicle='%Id_tValue%' and p2.type_place=' ∂“π’√∂‰ø' and p2.type_place=p3.type_place and 
	      +p2.pass_place=p3.pass_place and p1.Id_vehicle=p2.id_vehicle and p1.type_vehicle='√∂‰ø' 


