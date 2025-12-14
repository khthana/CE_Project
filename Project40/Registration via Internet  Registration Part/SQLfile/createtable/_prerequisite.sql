Create Table Prerequisite
(	Subj_Id  	char(8)		not null,
	PreSubj_Id	char(8)		not null,
	Logic		char(1)		null,

Constraint PK_Prerequisite primary key(Subj_Id,PreSubj_Id))