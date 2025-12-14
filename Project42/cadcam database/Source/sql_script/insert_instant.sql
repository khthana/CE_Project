-- ***************************  insert project 1  *********************************
insert into project_tab values(1,'simple1','test circuit for cad cam database');
insert into comp_tab values(1,'1 1 60 20','G1','And gate 1');
insert into comp_tab values(1,'2 3 60 80','G2','Nand gate 1');
insert into comp_tab values(1,'3 2 140 50','G3','Or gate 1');
insert into comp_tab values(1,'4 6 140 50','G4','and gate 3 input');
insert into wire_tab values (1,'1 0 0 1 1 0','W1','30 20',"LIST{'20 25','60 25'}");
insert into wire_tab values (1,'2 0 0 1 2 0','W2','30 40',"LIST{'20 43','60 43'}");
insert into wire_tab values (1,'3 0 0 2 1 0','W3','30 80',"LIST{'20 85','60 85'}");
insert into wire_tab values (1,'4 0 0 2 2 0','W4','30 100',"LIST{'20 103','60 103'}");
insert into wire_tab values (1,'5 1 3 3 1 0','W5','120 50',"LIST{'90 34','110 34','110 55','140 55'}");
insert into wire_tab values (1,'6 2 3 3 2 1','W6','120 70',"LIST{'90 94','110 94','110 73','140 73'}");
insert into wire_tab values (1,'7 3 3 0 0 1','W7','180 60',"LIST{'170 64','210 64'}");

-- ***************************  insert project 2  *********************************

insert into project_tab values(2,'easy','test circuit for cad cam database circuit 2');
insert into comp_tab values(2,'1 1 0 0','G1','And gate 1');
insert into comp_tab values(2,'2 1 0 0','G2','Nand gate 1');
insert into comp_tab values(2,'3 2 0 0','G3','Or gate 1');
insert into wire_tab values (2,'1 1 3 3 1 0','W1','0 0',"LIST{'20 25','60 25'}");
insert into wire_tab values (2,'2 2 3 3 2 0','W2','0 0',"LIST{'20 43','60 43'}");

execute procedure PinUpdateTerm(2,1,1,1);
execute procedure PinUpdateTerm(2,1,2,1);
execute procedure PinUpdateTerm(2,1,3,0);

execute procedure PinUpdateTerm(2,2,1,1);
execute procedure PinUpdateTerm(2,2,2,1);
execute procedure PinUpdateTerm(2,2,3,0);

execute procedure PinUpdateTerm(2,3,1,0);
execute procedure PinUpdateTerm(2,3,2,0);
execute procedure PinUpdateTerm(2,3,3,0);

execute  procedure PinUpdatevalue(2,1,1,0);
execute  procedure PinUpdatevalue(2,1,2,1);
execute  procedure PinUpdatevalue(2,1,3,0);

execute  procedure PinUpdatevalue(2,2,1,1);
execute  procedure PinUpdatevalue(2,2,2,1);
execute  procedure PinUpdatevalue(2,2,3,0);

execute  procedure PinUpdatevalue(2,3,1,0);
execute  procedure PinUpdatevalue(2,3,2,0);
execute  procedure PinUpdatevalue(2,3,3,0);

execute procedure wireupdatevalue(2,1,0);
execute procedure wireupdatevalue(2,2,0);

-- ***************************  insert project 3 *********************************

insert into project_tab values(3,'agate','test circuit for one gate');
insert into comp_tab values(3,'1 3 0 0','G1','nand gate 1');


execute procedure PinUpdateTerm(3,1,1,1);
execute procedure PinUpdateTerm(3,1,2,1);
execute procedure PinUpdateTerm(3,1,3,0);

execute  procedure PinUpdatevalue(3,1,1,0);
execute  procedure PinUpdatevalue(3,1,2,0);
execute  procedure PinUpdatevalue(3,1,3,0);

-- ***************************  insert project 5  *********************************

insert into project_tab values(5,'simple5','test and gate 3 input');

insert into comp_tab values(5,'1 6 0 0','G1','xxx');

execute procedure PinUpdateTerm(5,1,1,1);
execute procedure PinUpdateTerm(5,1,2,1);
execute procedure PinUpdateTerm(5,1,3,1);

execute  procedure PinUpdatevalue(5,1,1,0);
execute  procedure PinUpdatevalue(5,1,2,0);
execute  procedure PinUpdatevalue(5,1,3,1);



-- ***************************  insert project 6  *********************************

insert into project_tab values(6,'simple6','test 6');

insert into comp_tab values(6,'1 1 0 0','G1','xxx');
insert into comp_tab values(6,'2 3 0 0','G2','xxx');
insert into comp_tab values(6,'3 4 0 0','G3','xxx');

insert into wire_tab values (6,'1 1 3 3 1 0','W1','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (6,'2 2 3 3 2 0','W2','0 0',"LIST{'0 0','0 0'}");

execute procedure PinUpdateTerm(6,1,1,1);
execute procedure PinUpdateTerm(6,1,2,1);
execute procedure PinUpdateTerm(6,2,1,1);
execute procedure PinUpdateTerm(6,2,2,1);

execute  procedure PinUpdatevalue(6,1,1,0);
execute  procedure PinUpdatevalue(6,1,2,0);
execute  procedure PinUpdatevalue(6,2,1,0);
execute  procedure PinUpdatevalue(6,2,2,0);



-- ***************************  insert project 7  *********************************

insert into project_tab values(7,'simple7','test 7');

insert into comp_tab values(7,'1 3 0 0','G1','xxx');
insert into comp_tab values(7,'2 5 0 0','G2','xxx');

insert into wire_tab values (7,'1 1 3 2 1 0','W1','0 0',"LIST{'0 0','0 0'}");

execute procedure PinUpdateTerm(7,1,1,1);
execute procedure PinUpdateTerm(7,1,2,1);

execute  procedure PinUpdatevalue(7,1,1,0);
execute  procedure PinUpdatevalue(7,1,2,0);



-- ***************************  insert project 8  *********************************

insert into project_tab values(0,'simplex','xxx');

insert into comp_tab values(8,'1 1 0 0','G1','xxx');
insert into comp_tab values(8,'2 4 0 0','G2','xxx');
insert into comp_tab values(8,'3 5 0 0','G3','xxx');
insert into comp_tab values(8,'4 3 0 0','G4','xxx');

insert into wire_tab values (8,'1 1 3 3 1 0','W1','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (8,'2 3 2 4 1 0','W2','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (8,'3 2 3 4 2 0','W3','0 0',"LIST{'0 0','0 0'}");

execute procedure PinUpdateTerm(8,1,1,1);
execute procedure PinUpdateTerm(8,1,2,1);
execute procedure PinUpdateTerm(8,2,1,1);
execute procedure PinUpdateTerm(8,2,2,1);

execute  procedure PinUpdatevalue(8,1,1,0);
execute  procedure PinUpdatevalue(8,1,2,0);
execute  procedure PinUpdatevalue(8,2,1,0);
execute  procedure PinUpdatevalue(8,2,2,0);


-- ***************************  insert project 9  *********************************

insert into project_tab values(9,'simple9','test multiwire out from gate');

insert into comp_tab values(9,'1 1 0 0','G1','xxx');
insert into comp_tab values(9,'2 2 0 0','G2','xxx');
insert into comp_tab values(9,'3 1 0 0','G3','xxx');
insert into comp_tab values(9,'4 3 0 0','G4','xxx');
insert into comp_tab values(9,'5 2 0 0','G5','xxx');
insert into comp_tab values(9,'6 3 0 0','G6','xxx');


insert into wire_tab values (9,'1 1 3 4 1 0','W1','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (9,'2 2 3 4 2 0','W2','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (9,'3 2 3 5 1 0','W3','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (9,'4 3 3 5 2 0','W4','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (9,'5 4 3 6 1 0','W5','0 0',"LIST{'0 0','0 0'}");
insert into wire_tab values (9,'6 5 3 6 2 0','W6','0 0',"LIST{'0 0','0 0'}");

execute procedure PinUpdateTerm(9,4,1,0);
execute procedure PinUpdateTerm(9,4,2,0);
execute procedure PinUpdateTerm(9,5,1,0);
execute procedure PinUpdateTerm(9,5,2,0);
execute procedure PinUpdateTerm(9,6,1,0);
execute procedure PinUpdateTerm(9,6,2,0);

execute  procedure PinUpdatevalue(9,1,1,0);
execute  procedure PinUpdatevalue(9,1,2,0);
execute  procedure PinUpdatevalue(9,2,1,0);
execute  procedure PinUpdatevalue(9,2,2,0);
execute  procedure PinUpdatevalue(9,3,1,0);
execute  procedure PinUpdatevalue(9,3,2,0);



-- ***************************  insert project 11  *********************************

insert into project_tab values(11,'simple11','test multiwire out from gate');

insert into comp_tab values(11,'1 5 0 0','G1','xxx');
insert into comp_tab values(11,'2 1 0 0','G2','xxx');
insert into comp_tab values(11,'3 3 0 0','G3','xxx');
insert into comp_tab values(11,'4 3 0 0','G4','xxx');
insert into comp_tab values(11,'5 4 0 0','G5','xxx');

insert into wire_tab values (11,'1 1 2 3 1 0','W1','0 0',"LIST{}");
insert into wire_tab values (11,'2 1 2 4 2 0','W2','0 0',"LIST{}");
insert into wire_tab values (11,'3 2 3 3 2 0','W3','0 0',"LIST{}");
insert into wire_tab values (11,'4 2 3 4 1 0','W4','0 0',"LIST{}");
insert into wire_tab values (11,'5 3 3 5 1 0','W5','0 0',"LIST{}");
insert into wire_tab values (11,'6 4 3 5 2 0','W6','0 0',"LIST{}");

execute procedure PinUpdateTerm(11,1,2,0);
execute procedure PinUpdateTerm(11,3,1,0);
execute procedure PinUpdateTerm(11,3,2,0);
execute procedure PinUpdateTerm(11,4,1,0);
execute procedure PinUpdateTerm(11,4,2,0);
execute procedure PinUpdateTerm(11,5,1,0);
execute procedure PinUpdateTerm(11,5,2,0);

execute  procedure PinUpdatevalue(11,1,1,0);
execute  procedure PinUpdatevalue(11,2,1,0);
execute  procedure PinUpdatevalue(11,2,2,0);


-- ***************************  insert project 12  *********************************

insert into project_tab values(12,'simple12','test multiwire out from gate');

insert into comp_tab values(12,'1 1 0 0','G1','xxx');
insert into comp_tab values(12,'2 1 0 0','G2','xxx');
insert into comp_tab values(12,'3 3 0 0','G3','xxx');
insert into comp_tab values(12,'4 4 0 0','G4','xxx');
insert into comp_tab values(12,'5 3 0 0','G5','xxx');

insert into wire_tab values (12,'1 1 3 3 1 0','W1','0 0',"LIST{}");
insert into wire_tab values (12,'2 2 3 3 2 0','W2','0 0',"LIST{}");
insert into wire_tab values (12,'3 2 3 4 1 0','W3','0 0',"LIST{}");
insert into wire_tab values (12,'4 3 3 5 1 0','W4','0 0',"LIST{}");
insert into wire_tab values (12,'5 4 3 5 2 0','W5','0 0',"LIST{}");

execute procedure PinUpdateTerm(12,3,1,0);
execute procedure PinUpdateTerm(12,3,2,0);
execute procedure PinUpdateTerm(12,4,1,0);
execute procedure PinUpdateTerm(12,5,1,0);
execute procedure PinUpdateTerm(12,5,2,0);

execute  procedure PinUpdatevalue(12,1,1,0);
execute  procedure PinUpdatevalue(12,1,2,0);
execute  procedure PinUpdatevalue(12,2,1,0);
execute  procedure PinUpdatevalue(12,2,2,0);
execute  procedure PinUpdatevalue(12,4,2,0);
