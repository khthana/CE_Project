Datasource: traff_DBNOW
Username: sa
Template: sch22.htx
SQLStatement:
	+select p1.id_vehicle,p2.service_time,p2.start_station,p2.dest_station
	+from index_goal p1,vehicle_property p2
	+where p1.pass_place='%Nplace_value%' and 
	      +p1.type_place='%Type_value%' and
	      +p1.type_vehicle='¢ ¡°' and p1.type_vehicle=p2.type_vehicle and
	      +p2.Id_vehicle = p1.id_vehicle  		    



