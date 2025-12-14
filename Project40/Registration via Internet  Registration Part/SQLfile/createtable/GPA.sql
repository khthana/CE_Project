Create Table GPA
(	Std_Id		char(8)		not null,
	Year		char(4)		not null,
	Term		char(1)		not null,
	GPS		float		null,
	GPA		float		null,
	status		char(1)		null,

Constraint	PK_GPA	Primary key (Std_Id,Year,Term))