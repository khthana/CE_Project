#!/usr/bin/perl

push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

$date=`/bin/date +"%a %d %h, %Y : %T"`;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

print "Content-type:text/html\n\n";
$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

if ($ENV{'HTTP_VIA'} eq '') {$ip=$ENV{'REMOTE_ADDR'};}
else {$ip=$ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select ip_admin,Login from user");
$sth->execute;
$y='n';
$n='n';
while (@field = $sth->fetchrow_array) {
        $ip2=$field[0];
        if ($ip2 eq $ip) {$y = 'y';
                          $login = $field[1];
                          }
        else {$n = 'y';}
        }                
if ($y eq 'y') {     

$check = 'n';
$sth = $dbh->prepare("select Login from user");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	if ($mydata{name} eq $field[0]) {
		$check = 'y';
		}
        }

if ($check eq 'y') {

	if ($mydata{type} eq 'add') {
		$dbh->do("insert into ban values('','$mydata{name}')");
		}

	if ($mydata{type} eq 'remove') {
        	$dbh->do("delete from ban where Ban_name = '$mydata{name}'");
	       	}
	$dbh->do("update user set ip_admin='' where Login='$login'");   
	&write_main();
	}
else {
	print "<head><title>No User</title></head>\n";
	print "<body bgcolor=#5ea0a0>\n";
	print "<center>\n";
	print "<blink><h1>The  User which you want to ban isn't exist!!</h1></blink>\n";
	print "</center>\n";
	print "</body>\n";
	print "</html>\n";
	}
}
else {
print "<html>\n";
print "<head><title>Incorrect</title></head>\n";
print "<body bgcolor=#5ea0a0>\n";
print "<h1><center>You are not Login</center></h1>\n";
print "<a href=\"title2.cgi\">Back to main page</a>\n";
print "</body>\n";
print "</html>\n";
}
