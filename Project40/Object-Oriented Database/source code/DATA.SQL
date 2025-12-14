---------------------------------------------------------------------------
--
-- Insert_Data.sql-
-- 14-03-98 2:10 AM
--
---------------------------------------------------------------------------

delete from master_degree;
delete from bachelor;
delete from student;
delete from teacher;
delete from users;
delete from book;
delete from text_book;
delete from magazine;
---------------------------------------------------------------------------
--
-- Insert Data into Table
--
---------------------------------------------------------------------------
	
INSERT INTO Master_Degree VALUES 
	(	'38013285',
		'Monthon',
		'Khomwan',
		'Jan 20 1975',
		'M',
		'Computer Engineer',
		'Engineer',
		'3',
		'Test'
	);

INSERT INTO Bachelor VALUES
	(	'11111111',
		'Arthid',
		'Hensuk',
		'Jun 24 1973',
		'M',
		'Computer Engineer',
		'Engineer',
		'3',
		'P',
		'Computer Engineer'
	);

INSERT INTO Users Values
	(	'38013001',
		'SOMSAK',
		'SRIWAT',
		'FEB 25 1975',
		'M'
	);

INSERT INTO Student Values
	(	'38013002',
		'Mana',
		'Chaiwid',
		'JAN 15 1968',
		'M',
		'Computer Engineer',
		'Engineer',
		'3'
	);

INSERT INTO TEACHER Values
	(	'T0000001',
		'Thana',
		'Srichai',
		'JUN 25 1955',
		'M',
		'DR.',
		'Engineer'
	);
INSERT INTO BOOK Values
	(	'TB000001',
		'Software Engineer',
		NULL,NULL,NULL
	);

INSERT INTO TEXT_BOOK Values
	(	'TB000002',
		'DATABASE MANAGERMENT',
		NULL,NULL,NULL,
		'Monthon  Khomwan',
		'1',
		'Siam Publisher'
 	);

INSERT INTO MAGAZINE Values
	(	'TB000003',
		'Micro Computer',
		NULL,NULL,NULL,
		'5',
		'1998'
	);
