------ Create table music for save detail

CREATE TABLE music
(
MUSICID serial primary key,
MUSICCODE varchar(15) not null unique,
MUSICNAME varchar(30) not null,
ARTHIST varchar(25),
ALBUM varchar(20),
GENRE varchar(10),
PUBLISHING varchar(20),
YEAR integer,
SONG media_t
);

------ Create table addressmusic for save address of music

CREATE TABLE ADDRESSMUSIC
(
MUSICID integer REFERENCES music (musicid) ON DELETE CASCADE,
SHELFID integer REFERENCES musicshelf (shelfid) ON DELETE CASCADE,
LAYER integer not null,
PART char(1) not null,
primary key (MUSICID,SHELFID)
);

------ Create table musicshelf for save detail

CREATE TABLE MUSICSHELF
(
SHELFID serial primary key,
SHELFNAME varchar(10) not null,
LAYER integer
);

------ Create table addressmusicshelf for save detail

CREATE TABLE ADDRESSMUSICSHELF
(
SHELFID integer REFERENCES musicshelf (shelfid) ON DELETE CASCADE,
ROOMID integer REFERENCES room (roomid) ON DELETE CASCADE,
POSITION position_t not null,
PRIMARY KEY (SHELFID,ROOMID)
);


-------- Insert Into Table

-------- Insert Into Music Table

INSERT INTO MUSIC
VALUES(0,"MS001","CARTOON HERO","AQUA","AQUALISE","POP",
"BMG",2000,'"E:\SONG\INTER\Aqua - Cartoon Hero.MP3"');

INSERT INTO MUSIC
VALUES(0,"MS002","SOMETIMES","BRITNEY SPEARS","SOMETIMES","POP",
"SONY",2000,'"E:\SONG\INTER\Britne~3.MP3"');

INSERT INTO MUSIC
VALUES(0,"MS003","SHOW ME THE MEANING OF BEING LONELY",
"BACKSTREET BOYS","MILLENNIUM","POP",
"GMM",2000,'"E:\SONG\INTER\BACKST~1.MP3"');

-------- Insert Into Addressmusic Table

INSERT INTO ADDRESSMUSIC
VALUES(1,1,3,"L");

INSERT INTO ADDRESSMUSIC
VALUES(2,1,3,"L");

INSERT INTO ADDRESSMUSIC
VALUES(3,1,3,"M");

------- Insert Into Musicshelf

INSERT INTO MUSICSHELF
VALUES(0,"MSS001",3);

INSERT INTO MUSICSHELF
VALUES(0,"MSS002",3);

------- Insert Into Addressmusicshelf

INSERT INTO ADDRESSMUSICSHELF
VALUES(1,1,ROW(8925,5100)::POSITION_T);

INSERT INTO ADDRESSMUSICSHELF
VALUES(2,1,ROW(8925,5100)::POSITION_T);