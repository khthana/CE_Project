CREATE ROW TYPE ERType
(
	ProjectID		integer,
	ID		integer
);

CREATE ROW TYPE entityType
(
	Name	char(20),
	Px	Integer,
	Py	Integer
) UNDER  ERType;

CREATE ROW TYPE RelationType
(
	SourceID		integer,
	DestinationID	integer,
	Type		char(5),
	Relationship	char(30),
	Sx		Integer,
	Sy		Integer,
	Dx		Integer,
	Dy		Integer
) UNDER ERType;