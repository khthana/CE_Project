CREATE TABLE entityTable OF TYPE entityType
(
	PRIMARY KEY (projectID , ID),
	FOREIGN KEY ( projectID) REFERENCES projectTable (projectID) ,
	CHECK (name IS NOT NULL),
	CHECK (Px IS NOT NULL),
	CHECK (Py IS NOT NULL),
	CHECK (ID >=1)
);

CREATE TABLE RelationTable OF TYPE relationType
(
	PRIMARY KEY (projectID , ID),
	FOREIGN KEY ( projectID) REFERENCES projectTable (projectID) ,

	CHECK (Relationship IS NOT NULL),
	CHECK ((SourceID IS NOT NULL) and (SourceID >=1)), 
	CHECK ((DestinationID IS NOT NULL) and (DestinationID >=1)), 
	CHECK ((Type IS NOT NULL) and(Type  in ('OTO','OTM','MTM'))),
	
	CHECK (Sx IS NOT NULL),
	CHECK (Sy IS NOT NULL),
	CHECK (Dx IS NOT NULL),
	CHECK (Dy IS NOT NULL),	
	CHECK (ID >=1)
	
);