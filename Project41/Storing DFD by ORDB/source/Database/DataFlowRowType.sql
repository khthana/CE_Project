CREATE ROW TYPE  componentType
(
	projectID 		integer,
	subProcess 	integer,
	ID 		integer
);


CREATE ROW TYPE  processType
(
	name 		char(15),
	Px		Integer,
	Py		Integer,
	description 	lvarchar	
) UNDER  componentType;

CREATE ROW TYPE  externalType
(
	name 		char(15),
	Px		Integer,
	Py		Integer
) UNDER  componentType;

CREATE ROW TYPE  datastoreType
(
	name 		char(15),
	Px		Integer,
	Py		Integer
) UNDER componentType;

CREATE ROW TYPE  dataflowType
(
	SourceID		integer,
	SourceType	char(2),
	DestinationID	integer,
	DestinationType	char(2),
	formatData 	char(20),
	Sx		Integer,
	Sy		Integer,
	Dx		Integer,
	Dy		Integer
)  UNDER componentType;

CREATE ROW TYPE  GateType
(
	ModelID		Integer,
	ModelType	char(2),
	ModelName	char(15),	
	Px		Integer,
	Py		Integer
) UNDER componentType;
