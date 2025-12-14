Datasource: traff_DBNOW
Username: sa
Template: sch7.htx
SQLStatement:
	+select p1.id_vehicle,p1.type_vehicle,p2.comment
	+from Index_goal p1,place_property p2
	+where p1.pass_place='%NplaceValue%' and p1.type_place='%TypeValue%' and p1.pass_place=p2.pass_place and
		+p1.type_place=p2.type_place


