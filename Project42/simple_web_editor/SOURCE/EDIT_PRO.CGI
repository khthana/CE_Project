#!/usr/bin/perl

push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$login=$mydata{login};

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

$sth  = $dbh->prepare("select Password from user where Login='$login'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$pwd1 = $field[0];
	}
if ($mydata{pwd} ne $pwd1) {
	$dbh->do("update user set Password=password('$mydata{pwd}') where Login='$login'");
	}

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
