#!/usr/bin/perl

push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$login=$mydata{login};

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);

$dbh->do("update user set Name='$mydata{name}' where Login='$login'");

$dbh->do("update user set Email='$mydata{email}' where Login='$login'");

$dbh->do("update user set Tel='$mydata{tel}' where Login='$login'");

$dbh->do("update user set Page='$mydata{page}'where Login='$login'");

$dbh->do("update user set Address='$mydata{add}' where Login='$login'");

$dbh->do("update user set Occuppation='$mydata{job}' where Login='$login'");

$dbh->do("update user set Homepage='$mydata{home}' where Login='$login'");

$dbh->do("update user set Icq='$mydata{icq}' where Login='$login'");

print "Content-type:text/html\n\n";
&write_main();
