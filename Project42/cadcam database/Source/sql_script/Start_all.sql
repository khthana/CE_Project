{----------------------------------------------  create table ----------------------------------------}

CREATE TABLE project_tab
(	project_id SERIAL NOT NULL,
	project_name VARCHAR(20) NOT NULL,
	project_desc VARCHAR(255),
	PRIMARY KEY (project_id),
 	UNIQUE (project_name) 
);
	
CREATE TABLE component_type_tab
(	type_id  INTEGER NOT NULL ,
	type_name  VARCHAR(20) NOT NULL,
	type_desc  VARCHAR(255) ,
	type_input_size INTEGER NOT NULL,
	type_output_size INTEGER NOT NULL,
	type_size  INTEGER NOT NULL ,
	type_delay_time INTEGER NOT NULL,
	picture BLOB,
	PRIMARY KEY (type_id),
	CHECK (type_id>0 AND type_size>0)
);

CREATE  TABLE pin_type_tab 
(	pin_type_id  INTEGER NOT NULL,
	type_id        INTEGER NOT NULL,
	pin_type_name  VARCHAR(20) NOT NULL,
	pin_type_desc   VARCHAR(255),
	pin_spec     INTEGER,
	pin_type_loc   LOC,
	PRIMARY KEY (pin_type_id,type_id),
	FOREIGN KEY (type_id) REFERENCES component_type_tab(type_id) ON DELETE CASCADE,
	CHECK (pin_type_id>0 AND pin_spec IN (0,1))
);

CREATE TABLE comp_tab
(	project_id INTEGER NOT NULL,
	comp_opaque COMPONENT NOT NULL,
	comp_name   VARCHAR(20) ,
	comp_desc    VARCHAR(255),
	PRIMARY KEY(project_id,comp_opaque)
);

CREATE TABLE pin_tab
(	project_id INTEGER NOT NULL,
	pin_opaque PIN NOT NULL,
	PRIMARY KEY(project_id,pin_opaque),
	FOREIGN KEY (project_id) REFERENCES project_tab(project_id) ON DELETE CASCADE
);

CREATE TABLE wire_tab
(	project_id  INTEGER NOT NULL,
	wire_opaque  WIRE NOT NULL,
	wire_name   VARCHAR(20),
	name_loc	     LOC,
	wire_locs      LIST(LOC NOT NULL),
	PRIMARY KEY (project_id,wire_opaque),
	FOREIGN KEY (project_id) REFERENCES project_tab(project_id) ON DELETE CASCADE
);

CREATE TABLE truth_tab
(
	type_id   INTEGER NOT NULL,
	case      INTEGER NOT NULL,
	input_list LIST (INTEGER NOT NULL) NOT NULL,
	outputval INTEGER,
	primary key (type_id,case)
);

{---------------------------------------------------- create trigger and triggered procedure ----------------------------------------------------------------}

CREATE PROCEDURE InsNewPin(Proj_ID INTEGER,Comp Component)
	DEFINE  Comp_id,Comp_type ,Pin_id,Pspec  INTEGER;
	DEFINE  tempPin Pin;
	LET Comp_id=getid(Comp);
	LET Comp_type=gettype(Comp);
	LET tempPin='0 0 0 0 0';
	FOREACH  InsPinCursor FOR 
		SELECT pin_type_id,pin_spec  INTO Pin_id,Pspec  FROM pin_type_tab 
			 WHERE type_id=Comp_type
		EXECUTE PROCEDURE setall(tempPin,Pin_id,Comp_id,0,Pspec,1);
		{    first  	pin_value=0 
			isterminal=1 }	
		INSERT  INTO Pin_tab VALUES (Proj_ID,tempPin) ;
	END FOREACH
END PROCEDURE;

CREATE TRIGGER InsComp
	INSERT ON Comp_tab
	REFERENCING NEW as new 
	FOR EACH ROW 
	    (
		EXECUTE PROCEDURE InsNewPin(new.project_id,new.comp_opaque) 
	    );


CREATE PROCEDURE DelRelatePin(Proj_ID INTEGER,Comp Component)
	DEFINE  Comp_id  INTEGER;
	LET Comp_id=getid(Comp);
	DELETE FROM pin_tab 
  	     	WHERE project_id=Proj_ID and getcomp(Pin_opaque)=Comp_id;
END PROCEDURE;

CREATE TRIGGER DelComp
	DELETE ON Comp_tab
	REFERENCING OLD as old
	FOR EACH ROW 
	    (
		EXECUTE PROCEDURE DelRelatePin(old.Project_id,old.comp_opaque)
	    );

CREATE TRIGGER Delproject
	DELETE ON project_tab
	REFERENCING OLD as old
	FOR EACH ROW
	(
		DELETE FROM comp_tab  WHERE old.project_id=project_id
	);

{----------------------------------------   create procedures  ----------------------------------------------------------}
CREATE PROCEDURE PinUpdateValue(Proj_id INTEGER,Cid INTEGER,Pid INTEGER,Val INTEGER)
	DEFINE Ptemp Pin;
	SELECT pin_opaque INTO Ptemp  FROM pin_tab 
		WHERE project_id=Proj_id and getcomp(pin_opaque)=Cid and  getid(pin_opaque)=Pid;
	EXECUTE PROCEDURE setvalue(Ptemp,Val);
	UPDATE  pin_tab  
		SET pin_opaque=Ptemp
		WHERE project_id=Proj_id and getcomp(pin_opaque)=Cid and  getid(pin_opaque)=Pid;
END PROCEDURE;

CREATE PROCEDURE PinUpdateTerm(Proj_id INTEGER,Cid INTEGER,Pid INTEGER,Term INTEGER)
	DEFINE Ptemp Pin;
	SELECT pin_opaque INTO Ptemp  FROM pin_tab 
		WHERE project_id=Proj_id and getcomp(pin_opaque)=Cid and  getid(pin_opaque)=Pid;
	EXECUTE PROCEDURE setterm(Ptemp,Term);
	UPDATE  pin_tab  
		SET pin_opaque=Ptemp
		WHERE project_id=Proj_id and getcomp(pin_opaque)=Cid and  getid(pin_opaque)=Pid;
END PROCEDURE;

CREATE PROCEDURE WireUpdateValue(Proj_id INTEGER,Wid INTEGER,Val INTEGER)
	DEFINE Wtemp Wire;
	SELECT wire_opaque INTO Wtemp  FROM wire_tab 
		WHERE project_id=Proj_id and getid(wire_opaque)=Wid;
	EXECUTE PROCEDURE setvalue(Wtemp,Val);
	UPDATE  wire_tab  
		SET wire_opaque=Wtemp
		WHERE project_id=Proj_id and getid(wire_opaque)=Wid;
END PROCEDURE;

CREATE FUNCTION  PinGetValue(Proj_id INTEGER , Cid INTEGER , Pid INTEGER) RETURNING INTEGER;
	DEFINE Ptemp Pin;
	SELECT pin_opaque INTO Ptemp  FROM pin_tab 
		WHERE project_id=Proj_id and getcomp(pin_opaque)=Cid and  getid(pin_opaque)=Pid;
	RETURN getvalue(Ptemp);
END FUNCTION;

CREATE FUNCTION PinGetTerm(Proj_id INTEGER,Cid INTEGER,Pid INTEGER) RETURNING INTEGER;
	DEFINE Ptemp Pin;
	SELECT pin_opaque INTO Ptemp  FROM pin_tab 
		WHERE project_id=Proj_id and getcomp(pin_opaque)=Cid and  getid(pin_opaque)=Pid;
	RETURN getterm(Ptemp);
END FUNCTION;


CREATE FUNCTION WireGetValue(Proj_id INTEGER,Wid  INTEGER) RETURNING INTEGER;
	DEFINE Wtemp Wire;
	SELECT wire_opaque INTO Wtemp  FROM wire_tab 
		WHERE project_id=Proj_id and getid(wire_opaque)=Wid;
	RETURN getvalue(Wtemp);
END FUNCTION;


CREATE FUNCTION  InsertNewComp(Proj_id INTEGER,Comp_id INTEGER,Comp_type INTEGER,Xpos INTEGER,Ypos INTEGER,
				  Comp_name CHAR(20),Comp_desc CHAR(255))   RETURNING INTEGER
	DEFINE tcomp component;
	DEFINE tnum INTEGER;

	SELECT count(*) INTO tnum FROM project_tab WHERE project_id=Proj_id;
	IF (tnum=0) THEN
		return -998;
	END IF;
	SELECT count(*)  INTO tnum FROM comp_tab WHERE project_id=Proj_id AND getid(comp_opaque)=Comp_id;
	IF (tnum>0) THEN
		return -999;
	END IF;
	LET tcomp='0 0 0 0';
	EXECUTE PROCEDURE setid(tcomp,Comp_id);
	EXECUTE PROCEDURE settype(tcomp,Comp_type);
	EXECUTE PROCEDURE setxpos(tcomp,Xpos);
	EXECUTE PROCEDURE setypos(tcomp,Ypos);
	insert into comp_tab values(Proj_id,tcomp,Comp_name,Comp_desc);
	RETURN 0;
END FUNCTION;

CREATE FUNCTION  InsertNewWire(Proj_id INTEGER,Wire_id INTEGER,C1 INTEGER,P1 INTEGER,C2 INTEGER,P2 INTEGER)
	RETURNING INTEGER

	DEFINE twire wire;
	DEFINE tnum INTEGER;

	SELECT count(*) INTO tnum FROM project_tab WHERE project_id=Proj_id;
	IF (tnum=0) THEN
		return -998;
	END IF;
	SELECT count(*)  INTO tnum FROM wire_tab WHERE project_id=Proj_id AND getid(wire_opaque)=Wire_id;
	IF (tnum>0) THEN
		return -999;
	END IF;
	LET twire='0 0 0 0 0 0';
	EXECUTE PROCEDURE setid(twire,Wire_id);
	EXECUTE PROCEDURE setfirstcomp(twire,C1);
	EXECUTE PROCEDURE setfirstpin(twire,P1);
	EXECUTE PROCEDURE setseccomp(twire,C2);
	EXECUTE PROCEDURE setsecpin(twire,P2);
	insert into wire_tab values (Proj_id,twire,' ','0 0',"LIST{}");
	RETURN 0;
END FUNCTION;

CREATE FUNCTION  InsertWireLoc(Proj_id INTEGER,Wid INTEGER, Xpos INTEGER, Ypos INTEGER) RETURNING INTEGER
	DEFINE tnum INTEGER;
	DEFINE wloc loc;
	DEFINE templocs LIST(loc NOT NULL);

	SELECT count(*) INTO tnum FROM project_tab WHERE project_id=Proj_id;
	IF (tnum=0) THEN
		return -998;
	END IF;
	SELECT count(*)  INTO tnum FROM wire_tab WHERE project_id=Proj_id AND getid(wire_opaque)=Wid;
	IF (tnum=0) THEN
		return -997;
	END IF;
	LET wloc ='0 0 ';
	EXECUTE PROCEDURE setxpos(wloc,Xpos);
	EXECUTE PROCEDURE setypos(wloc,Ypos);
	SELECT wire_locs INTO templocs  FROM wire_tab WHERE project_id=Proj_id AND getid(wire_opaque)=Wid;
	INSERT  INTO TABLE(templocs) VALUES(wloc);	
	UPDATE wire_tab SET wire_locs=templocs WHERE project_id=Proj_id AND getid(wire_opaque)=Wid;
	RETURN 0;
END FUNCTION;

CREATE FUNCTION  ClearWireLoc(Proj_id INTEGER,Wid INTEGER)
	DEFINE tnum INTEGER;
	DEFINE templocs LIST(loc NOT NULL);

	SELECT count(*) INTO tnum FROM project_tab WHERE project_id=Proj_id;
	IF (tnum=0) THEN
		return -998;
	END IF;
	SELECT count(*)  INTO tnum FROM wire_tab WHERE project_id=Proj_id AND getid(wire_opaque)=Wid;
	IF (tnum=0) THEN
		return -997;
	END IF;
	LET templocs="LIST{}";
	UPDATE wire_tab SET wire_locs=templocs WHERE project_id=Proj_id AND getid(wire_opaque)=Wid;
	RETURN 0;
END FUNCTION;

CREATE FUNCTION  GetWireLoc(Proj_id INTEGER,Wid INTEGER) RETURNING VARCHAR(255)
	DEFINE tnum,x,y  INTEGER;
	DEFINE stemp VARCHAR(255);
	DEFINE wloc loc;
	DEFINE templocs LIST(loc NOT NULL);
	LET stemp="";
	SELECT wire_locs INTO templocs  FROM wire_tab WHERE project_id=Proj_id AND getid(wire_opaque)=Wid;
	FOREACH selectloc FOR SELECT *  INTO wloc  FROM TABLE(templocs)
		LET stemp=stemp || " ";	
		LET x=Getxpos(wloc);
		LET y=Getypos(wloc);
		LET stemp=stemp ||  x || "&" || y || " ";	
	END FOREACH;
	return stemp;
END FUNCTION;


CREATE FUNCTION  tosequence(alist  LIST(INTEGER NOT NULL) )  RETURNING VARCHAR(255)
	DEFINE stemp VARCHAR(255);
	DEFINE ltemp INTEGER;
	LET stemp="";
	FOREACH selectloc FOR SELECT *  INTO ltemp  FROM TABLE(alist)
		LET stemp=stemp ||  ltemp || " ";	
	END FOREACH;
	return stemp;
END FUNCTION;


{---------------------------------------------------------  insert instance  --------------------------------------------------------------}

{---------------------------------  insert into component_type_tab ------------------------------------------}

insert into component_type_tab values(1,'and2',	'and gate 2 input',2,1,40,0,	FILETOBLOB('c:\informix\dblogic\and2.jpg','Server'));
insert into component_type_tab values(2,'or2',	'or gate 2 input',2,1,40,0,	FILETOBLOB('c:\informix\dblogic\or2.jpg','Server'));
insert into component_type_tab values(3,'nand2',	'nand gate 2 input',2,1,40,0,	FILETOBLOB('c:\informix\dblogic\nand2.jpg','Server'));
insert into component_type_tab values(4,'nor2',	'nor gate 2 input',2,1,40,0,	FILETOBLOB('c:\informix\dblogic\nor2.jpg','Server'));
insert into component_type_tab values(5,'notg',	'not gate',1,1,40,0,		FILETOBLOB('c:\informix\dblogic\notg.jpg','Server'));
insert into component_type_tab values(6,'and3',	'and gate 3 input',3,1,40,0,	FILETOBLOB('c:\informix\dblogic\and3.jpg','Server'));
insert into component_type_tab values(7,'or3',	'or gate 3 input',3,1,40,0,	FILETOBLOB('c:\informix\dblogic\or3.jpg','Server'));
insert into component_type_tab values(8,'nand3',	'nand gate 3 input',3,1,40,0,	FILETOBLOB('c:\informix\dblogic\nand3.jpg','Server'));
insert into component_type_tab values(9,'nor3',	'nor gate 3 input',3,1,40,0,	FILETOBLOB('c:\informix\dblogic\nor3.jpg','Server'));
insert into component_type_tab values(10,'xor2',	'xor gate 2 input',2,1,40,0,	FILETOBLOB('c:\informix\dblogic\xor2.jpg','Server'));
insert into component_type_tab values(11,'xnor2',	'xnor gate 2 input',2,1,40,0,	FILETOBLOB('c:\informix\dblogic\xnor2.jpg','Server'));

{------------------------------------------ insert into pin_type_tab ---------------------------------------------------}
insert into pin_type_tab  values(1,1,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,1,'in2','input 2',	0,'0 30');
insert into pin_type_tab  values(3,1,'out1','output 1',	1,'40 19');
insert into pin_type_tab  values(1,2,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,2,'in2','input 2',	0,'0 30');
insert into pin_type_tab  values(3,2,'out1','output 1',	1,'40 19');
insert into pin_type_tab  values(1,3,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,3,'in2','input 2',	0,'0 30');
insert into pin_type_tab  values(3,3,'out1','output 1',1,'40 19');
insert into pin_type_tab  values(1,4,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,4,'in2','input 2',	0,'0 30');
insert into pin_type_tab  values(3,4,'out1','output 1',	1,'40 19');
insert into pin_type_tab  values(1,5,'in1','input 1',	0,'0 19');
insert into pin_type_tab  values(2,5,'out1','output 1',1,'40 19');
insert into pin_type_tab  values(1,6,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,6,'in2','input 2',	0,'0 19');
insert into pin_type_tab  values(3,6,'in3','input3',	0,'0 29');
insert into pin_type_tab  values(4,6,'out1','output 1',1,'40 19');
insert into pin_type_tab  values(1,7,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,7,'in2','input 2',	0,'0 19');
insert into pin_type_tab  values(3,7,'in3','input3',	0,'0 29');
insert into pin_type_tab  values(4,7,'out1','output 1',1,'40 19');
insert into pin_type_tab  values(1,8,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,8,'in2','input 2',	0,'0 19');
insert into pin_type_tab  values(3,8,'in3','input3',	0,'0 29');
insert into pin_type_tab  values(4,8,'out1','output 1',1,'40 19');
insert into pin_type_tab  values(1,9,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,9,'in2','input 2',	0,'0 19');
insert into pin_type_tab  values(3,9,'in3','input3',	0,'0 29');
insert into pin_type_tab  values(4,9,'out1','output 1',1,'40 19');
insert into pin_type_tab  values(1,10,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,10,'in2','input 2',	0,'0 30');
insert into pin_type_tab  values(3,10,'out1','output 1',1,'40 19');
insert into pin_type_tab  values(1,11,'in1','input 1',	0,'0 10');
insert into pin_type_tab  values(2,11,'in2','input 2',	0,'0 30');
insert into pin_type_tab  values(3,11,'out1','output 1',1,'40 19');


{---------------------------------------------  insert into truth_tab ---------------------------------------------}

insert into truth_tab values (1,1,"LIST{0,0}",0); -- and gate 2 input
insert into truth_tab values (1,2,"LIST{0,1}",0);
insert into truth_tab values (1,3,"LIST{1,0}",0);
insert into truth_tab values (1,4,"LIST{1,1}",1);
insert into truth_tab values (2,1,"LIST{0,0}",0);  -- or gate 2 input
insert into truth_tab values (2,2,"LIST{0,1}",1);
insert into truth_tab values (2,3,"LIST{1,0}",1);
insert into truth_tab values (2,4,"LIST{1,1}",1);
insert into truth_tab values (3,1,"LIST{0,0}",1);  -- nand gate 2 input
insert into truth_tab values (3,2,"LIST{0,1}",1);
insert into truth_tab values (3,3,"LIST{1,0}",1);
insert into truth_tab values (3,4,"LIST{1,1}",0);
insert into truth_tab values (4,1,"LIST{0,0}",1);  -- nor gate 2 input
insert into truth_tab values (4,2,"LIST{0,1}",0);
insert into truth_tab values (4,3,"LIST{1,0}",0);
insert into truth_tab values (4,4,"LIST{1,1}",0);
insert into truth_tab values (5,1,"LIST{0}",1);  -- not gate 
insert into truth_tab values (5,2,"LIST{1}",0);
insert into truth_tab values (6,1,"LIST{0,0,0}",0);  -- and gate 3 input
insert into truth_tab values (6,2,"LIST{0,0,1}",0);
insert into truth_tab values (6,3,"LIST{0,1,0}",0);
insert into truth_tab values (6,4,"LIST{0,1,1}",0);
insert into truth_tab values (6,5,"LIST{1,0,0}",0);
insert into truth_tab values (6,6,"LIST{1,0,1}",0);
insert into truth_tab values (6,7,"LIST{1,1,0}",0);
insert into truth_tab values (6,8,"LIST{1,1,1}",1);
insert into truth_tab values (7,1,"LIST{0,0,0}",0);  -- or gate 3 input
insert into truth_tab values (7,2,"LIST{0,0,1}",1);
insert into truth_tab values (7,3,"LIST{0,1,0}",1);
insert into truth_tab values (7,4,"LIST{0,1,1}",1);
insert into truth_tab values (7,5,"LIST{1,0,0}",1);
insert into truth_tab values (7,6,"LIST{1,0,1}",1);
insert into truth_tab values (7,7,"LIST{1,1,0}",1);
insert into truth_tab values (7,8,"LIST{1,1,1}",1);
insert into truth_tab values (8,1,"LIST{0,0,0}",1);  -- nand gate 3 input
insert into truth_tab values (8,2,"LIST{0,0,1}",1);
insert into truth_tab values (8,3,"LIST{0,1,0}",1);
insert into truth_tab values (8,4,"LIST{0,1,1}",1);
insert into truth_tab values (8,5,"LIST{1,0,0}",1);
insert into truth_tab values (8,6,"LIST{1,0,1}",1);
insert into truth_tab values (8,7,"LIST{1,1,0}",1);
insert into truth_tab values (8,8,"LIST{1,1,1}",0);
insert into truth_tab values (9,1,"LIST{0,0,0}",1);  -- nor gate 3 input
insert into truth_tab values (9,2,"LIST{0,0,1}",0);
insert into truth_tab values (9,3,"LIST{0,1,0}",0);
insert into truth_tab values (9,4,"LIST{0,1,1}",0);
insert into truth_tab values (9,5,"LIST{1,0,0}",0);
insert into truth_tab values (9,6,"LIST{1,0,1}",0);
insert into truth_tab values (9,7,"LIST{1,1,0}",0);
insert into truth_tab values (9,8,"LIST{1,1,1}",0);
insert into truth_tab values (10,1,"LIST{0,0}",0);  -- xor gate 2 input
insert into truth_tab values (10,2,"LIST{0,1}",1);
insert into truth_tab values (10,3,"LIST{1,0}",1);
insert into truth_tab values (10,4,"LIST{1,1}",0);
insert into truth_tab values (11,1,"LIST{0,0}",1);  --xnor gate 2 input
insert into truth_tab values (11,2,"LIST{0,1}",0);
insert into truth_tab values (11,3,"LIST{1,0}",0);
insert into truth_tab values (11,4,"LIST{1,1}",1);
