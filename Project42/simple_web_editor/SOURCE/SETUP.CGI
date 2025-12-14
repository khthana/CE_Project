#!/usr/bin/perl
use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';      

$dbh = DBI->connect("DBI:mysql:$database",$user,$password); 

$dbh->do("create table Total_board
(Name_board char(1) NOT NULL DEFAULT 'project',
No_room int(1) NOT NULL DEFAULT'0',
No_user int(4) NOT NULL DEFAULT'0',
Id int(5) NOT NULL DEFAULT'0',
width int(3) NOT NULL DEFAULT'20',
PRIMARY KEY (Id))");

$dbh->do("create table head_post
(Title_post char(155) NOT NULL DEFAULT'',
Name_post char(15) NOT NULL DEFAULT'',
Time_post char(30) NOT NULL DEFAULT'',
No_reply int(3) NOT NULL DEFAULT'0',
Last_reply char(30) NOT NULL DEFAULT'',
Id_post int(5) NOT NULL DEFAULT'0',
Room char(20) NOT NULL DEFAULT'',
no int(3) NOT NULL DEFAULT'0',
Day int(10) NOT NULL DEFAULT'0',
Time int(7) NOT NULL DEFAULT'0',
Ip char(20) NOT NULL DEFAULT'',
PRIMARY KEY (Title_post))");

$dbh->do("create table head_reply
(Title_reply char(155) NOT NULL DEFAULT'',
Name_reply char(15) NOT NULL DEFAULT'',
Time_reply char(30)  NOT NULL DEFAULT'',
Title_post char(155) NOT NULL DEFAULT'',
Id_post int(5)  NOT NULL DEFAULT'0',
Room char(20) NOT NULL DEFAULT'',
Id_reply int(5) NOT NULL DEFAULT'0',
Day int(10) NOT NULL DEFAULT'0',
Time int(7) NOT NULL DEFAULT'0',
Ip char(20) NOT NULL DEFAULT'',
PRIMARY KEY (Title_reply))");

$dbh->do("create table Detail_post
(Title_post char(155) NOT NULL DEFAULT'',
Room char(20) NOT NULL DEFAULT'',
Detail_post text,
Name_post char(15) NOT NULL DEFAULT'',
Id_post int(5) NOT NULL DEFAULT'0',
PRIMARY KEY (Title_post))");

$dbh->do("create table detail_reply
(Title_reply char(155) NOT NULL DEFAULT'',
Detail_reply text,
Room_reply char(20) NOT NULL DEFAULT'',
Name_reply char(15) NOT NULL DEFAULT'',
Id_post int(5) NOT NULL DEFAULT'0',
Id_reply int(5) NOT NULL DEFAULT'0',
PRIMARY KEY (Title_reply))");

$dbh->do("create table room
(Room char(20) NOT NULL DEFAULT'',
No_post int(3) NOT NULL DEFAULT'0',
Last_post char(30) NOT NULL DEFAULT'',
N_room char(75) NOT NULL DEFAULT'',
PRIMARY KEY (Room,No_post))");

$dbh->do("create table user
(Login char(15) NOT NULL DEFAULT'',
Password char(30) NOT NULL DEFAULT'',
Email char(60) NOT NULL DEFAULT'',
Tel char(20) NOT NULL DEFAULT'',
Page char(20) NOT NULL DEFAULT'',
Address char(255) NOT NULL DEFAULT'',
Occuppation char(20) NOT NULL DEFAULT'',
No_post int(3) NOT NULL DEFAULT'0',
Last_log char(20) NOT NULL DEFAULT'',
Homepage char(40) NOT NULL DEFAULT'',
Icq char(15) NOT NULL DEFAULT'',
Name char(60) NOT NULL DEFAULT'',
Ip char(20) NOT NULL DEFAULT'',
Admin char(7) NOT NULL DEFAULT'',
Id_homepage int(3) NOT NULL DEFAULT'0',
question text,
answer text,
ip_admin char(15) NOT NULL DEFAULT'',
PRIMARY KEY (Login,Name))");

$dbh->do("create table homepage
(Type char(10) NOT NULL DEFAULT'',
Form text,
Color char(10) NOT NULL DEFAULT'',
Position char(10) NOT NULL DEFAULT'',
Size int(3) NOT NULL DEFAULT'0',
Bold char(1) NOT NULL DEFAULT'n',
Italic char(1) NOT NULL DEFAULT'n',
Underline char(1) NOT NULL DEFAULT'n',
Blink char(1) NOT NULL DEFAULT'n',
Link char(80) NOT NULL DEFAULT'',
No int(3) NOT NULL DEFAULT'0',
User char(20) NOT NULL DEFAULT'',
Br int(3) NOT NULL DEFAULT'0')");

$dbh->do("create table ban
(Ban_ip char(20) NOT NULL DEFAULT'',
Ban_name char(20) NOT NULL DEFAULT'')");

$dbh->do("insert into user values
('admin',password('webboard'),'','','','','','0','','','',
'Administrator','','admin','0','Are you admin?','NO','')");

$dbh->disconnect;
exit;

