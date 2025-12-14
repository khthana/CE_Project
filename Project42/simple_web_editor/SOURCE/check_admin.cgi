#!/usr/bin/perl

push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

$date=`/bin/date +"%a %d %h, %Y : %T"`;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

if ($ENV{'HTTP_VIA'} eq '') {
        $ip=$ENV{'REMOTE_ADDR'};
        }
else { $ip = $ENV{'HTTP_X_FORWARDED_FOR'}; }
                                                 
print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Result login</title></head>
<body bgcolor="5ea0a0">
EOF

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

$pwd=$mydata{pwd};

$sth = $dbh->prepare("select Room from room");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$d_room = $field[0];
	}
$room = $d_room;

$admin = '';
$sth = $dbh->prepare("select Admin from user where Login='$mydata{login}'");
$sth->execute;
while(@field = $sth->fetchrow_array) {
	$admin = $field[0];
	}

if ($admin eq 'admin') {
$sth = $dbh->prepare("select Login from user where Password=password('$pwd')");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
	$login[$row] = $hash_ref->{Login};
	$row++;
	}

for($i=0;$i<$row;$i++) {
if ($mydata{login} ne $login[$i] || $mydata{login} eq ''){
        print "<center>\n";
        print "<h1><blink>Your Password Incorrect</blink></h1><br>\n";
	print "<a href=\"admin.cgi\">Login again</a><br>\n";
        print "</center>\n";
	print "</body>\n";
	print "</html>\n";
	}
else {
        $dbh->do("update user set Last_log='$date' where Login='$mydata{login}'");
	print "<center>\n";
	print "<h1><b> Adminstrator<b></h1>\n";
	print "<br><br>\n";
	print "</center>\n";
	print "<a href=\"delete.cgi\">Delete Post or Reply</a><br>\n";
	print "<a href=\"config_user.cgi\">User Configuration</a><br>\n";
	print "<a href=\"config_room.cgi\">Room Configuration</a><br>\n";
	print "<a href=\"range.cgi\">Display Post per Page</a><br>\n";
	print "<a href=\"ban.cgi\">Ban for This Board</a><br>\n";
	print "</body>\n";
	print "</html>\n";

	$dbh->do("update user set ip_admin='$ip' where Login='$mydata{login}'");
	}
}
}
else {
	print "<center>\n";
	print "<h1><blink><b> You don't have Permission </b></blink></h1>\n";
        print "<a href=\"admin.cgi\">Login again</a><br>\n";
	print "</center>\n";
	print "</body>\n";
	print "</html>\n";
	}
