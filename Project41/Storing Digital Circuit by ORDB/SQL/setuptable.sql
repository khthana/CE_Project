create row type WIRED
(
	Wid int,
	Gid list(int not null),
	value char(1),
	isoutput char(1)
);
create row type GATE
(
	Gid int,
	Input list(int not null),
	Output list(int not null)
);
create row type AND under GATE;
create row type OR under GATE;
create row type NOT under GATE;
create row type XOR under GATE;
create row type XNOR under GATE;
create row type NAND under GATE;
create row type NOR under GATE;
create table ANDGATE of type AND (primary key (Gid) );
create table ORGATE of type OR (primary key (Gid) );
create table NOTGATE of type NOT (primary key (Gid) );
create table XORGATE of type XOR (primary key (Gid) );
create table XNORGATE of type XOR (primary key (Gid) );
create table NANDGATE of type NAND (primary key (Gid) );
create table NORGATE of type NOR (primary key (Gid) );
create table WIRED of type WIRED (primary key (Wid) );
create table PROJ_LAYOUT
(
	Pid char(25),
	Lid int,
	Newcomp char,
	primary key (Pid)
);
create table LAYOUT
(
	Gid int,
	Pos_x int,
	Pos_y int,
	Lid int,
	primary key (Gid) 
);
create row type NEW (n_layout int) under GATE;
create table NEWGATE of type NEW (primary key (Gid) );