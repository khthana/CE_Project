#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

print "Content-type:text/html\n\n";

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
       
print <<EOF;
<html>
<head><title>Add Room</title></head>
<body bgcolor="#5ea0a0">
EOF

if ($mydata{name} eq ''){
	print "<center>\n";
	print "<h1>Your Information is not Complete</h1>\n";
	print "</center>\n";
	print "</body>\n";
	}
else {
	$ch_room=0;
	$sth = $dbh->prepare("select N_room from room");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		if ($mydata{name} eq $field[0]) {
			$ch_room++;
			}
	 	}
	if ($ch_room ne 0) {
		print "<h1>Please change your room\'s name because it is in used</h1><br>\n";
		}
	else {
	$sth = $dbh->prepare("select Room from room");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		$room = $field[0];
		}

	if ($room eq '') {$room=3;}
	$room++;
	$dbh->do("insert into room values('$room','0','','$mydata{name}')");

	$sth = $dbh->prepare("select No_room from Total_board");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		$no_room = $field[0];
		}
	$no_room++;
	$dbh->do("update Total_board set No_room='$no_room'");

	$dbh->disconnect;

	} }

$dbh->do("update user set ip_admin='' where Login='$login'");
&write_main();
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
exit;

