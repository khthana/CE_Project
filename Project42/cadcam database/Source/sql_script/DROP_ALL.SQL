drop procedure InsNewPin(Integer,component);
DROP procedure DelRelatePin(Integer,component);
DROP TRIGGER insComp;
DROP TRIGGER DelComp;
DROP TRIGGER Delproject;
DROP TABLE project_tab;
DROP TABLE component_type_tab;
DROP TABLE pin_type_tab;
DROP TABLE comp_tab;
DROP TABLE pin_tab;
DROP TABLE wire_tab;
DROP TABLE truth_tab;
DROP PROCEDURE PinUpdateValue(integer,integer,integer,integer);
DROP PROCEDURE PinUpdateTerm(integer,integer,integer,integer);
DROP PROCEDURE WireUpdateValue(integer,integer,integer);
DROP FUNCTION PinGetValue(integer,integer,integer);
DROP FUNCTION PinGetTerm(integer,integer,integer);
DROP FUNCTION WireGetValue(integer,integer);
DROP FUNCTION InsertNewComp(INTEGER,INTEGER,INTEGER, INTEGER, INTEGER,
				   CHAR(20), CHAR(255)) ;
DROP FUNCTION InsertNewWire(INTEGER, INTEGER,INTEGER,INTEGER,INTEGER,INTEGER);
DROP FUNCTION InsertWireLoc(INTEGER,INTEGER,  INTEGER,  INTEGER);
DROP FUNCTION  ClearWireLoc(INTEGER,INTEGER);
DROP FUNCTION  GetWireLoc( INTEGER, INTEGER) ;
DROP FUNCTION  tosequence(alist  LIST(INTEGER NOT NULL) ) ;

