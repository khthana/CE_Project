Datasource: traff_DBNOW
Username: sa
Template: sch2.htx
SQLStatement:
	+select p1.pass_place,p1.type_place,p2.service_time,p2.route_fwd,p2.route_rev
	+from index_goal p1,vehicle_property p2
	+where p1.id_vehicle = '%id_value%' and p1.id_vehicle=p2.Id_vehicle and p1.type_vehicle='¢ ¡°' and
	         +p1.type_vehicle=p2.type_vehicle



