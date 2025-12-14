CREATE TABLE projectTable
(
	projectID integer,
	projectName char(20),
	
	PRIMARY KEY ( projectID),
	CHECK ( projectName IS NOT NULL ),
	CHECK ( projectID >=1 )
);

CREATE TABLE  processTable  OF TYPE  processType
(	
	PRIMARY KEY ( projectID , ID ),
	FOREIGN KEY ( projectID ) REFERENCES projectTable ( projectID ),
	CHECK ( name IS NOT NULL ),
	CHECK ( description IS NOT NULL),
	CHECK ( Px IS NOT NULL ),
	CHECK ( Py IS NOT NULL ),
	CHECK ( ID >= 1 ),
	CHECK (( subProcess >= 0 ) and ( subProcess IS NOT NULL ))
 );

CREATE TABLE  externalTable  OF TYPE  externalType
(	
	PRIMARY KEY ( projectID , subProcess , ID ),
	FOREIGN KEY ( projectID ) REFERENCES projectTable ( projectID ),
	CHECK ( name IS NOT NULL ),
	CHECK ( Px IS NOT NULL ),
	CHECK ( Py IS NOT NULL ),
	CHECK ( ID >= 1 ),
	CHECK (( subProcess >= 0 ) and ( subProcess IS NOT NULL ))
);

CREATE TABLE  datastoreTable  OF TYPE  datastoreType
(	
	PRIMARY KEY ( projectID , subProcess , ID ),
	FOREIGN KEY ( projectID ) REFERENCES projectTable ( projectID ),
	CHECK ( name IS NOT NULL ),
	CHECK ( Px IS NOT NULL ),
	CHECK ( Py IS NOT NULL ),
	CHECK ( ID >= 1 ),
	CHECK (( subProcess >= 0 ) and ( subProcess IS NOT NULL ))
);

CREATE TABLE  dataflowTable  OF TYPE  dataflowType
(	
	PRIMARY KEY ( projectID , subProcess , ID ),
	FOREIGN KEY ( projectID ) REFERENCES projectTable ( projectID ),

	CHECK ( ID >= 1 ),
	CHECK (( subProcess >= 0 ) and ( subProcess IS NOT NULL )),
	CHECK (formatData IS NOT NULL),

	CHECK (( SourceID IS NOT NULL) and ( SourceID >=1)),
	CHECK (( DestinationID IS NOT NULL)  and( DestinationID >=1)),
	CHECK (( SourceType IS NOT NULL)  and ( SourceType in ('P','E','D','GP','GD','GE'))),
	CHECK (( DestinationType IS NOT NULL)  and ( DestinationType in ('P','E','D','GP','GD','GE'))),
	CHECK (Sx  IS NOT NULL),
	CHECK (Sy  IS NOT NULL),
	CHECK (Dx  IS NOT NULL),
	CHECK (Dy IS NOT NULL)
);


CREATE TABLE GateTable OF TYPE GateType
(
	PRIMARY KEY ( projectID,subprocess,ID),
	FOREIGN KEY ( projectID ) REFERENCES projectTable ( projectID ),

	CHECK ( ID >= 1 ),
	CHECK (( subProcess >0 ) and ( subProcess IS NOT NULL )),
	CHECK ( ModelID IS NOT NULL ),
	CHECK (( ModelType IS NOT NULL ) and (ModelType IN ('P','E','D','GP','GE','GP'))),
	CHECK ( ModelName IS NOT NULL ),
	CHECK ( Px  IS NOT NULL ),
	CHECK ( Py  IS NOT NULL )
);
