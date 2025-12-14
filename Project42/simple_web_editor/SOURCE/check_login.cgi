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

if ($ENV{'HTTP_VIA'} eq '') {
	$ip=$ENV{'REMOTE_ADDR'};
	}
else { $ip = $ENV{'HTTP_X_FORWARDED_FOR'}; }

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Result login</title></head>
<body bgcolor="#5ea0a0">
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

$sth = $dbh->prepare("select Login from user where Password=password('$pwd')");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
	$login[$row] = $hash_ref->{Login};
	$row++;
	}
for($i=0;$i<=$row;$i++) {
if ($mydata{login} ne $login[$i] || $mydata{login} eq ''){
        print "<center>\n";
        print "<h1><blink>Your Password Incorrect</blink></h1><br>\n";
	print "<a href=\"login.cgi\">Login again</a><br>\n";
        print "</center>\n";
	print "</body>\n";
	print "</html>\n";
	}
else {
        $dbh->do("update user set Ip='$ip' where Login='$mydata{login}'");
        $dbh->do("update user set Last_log='$date' where Login='$mydata{login}'");
        &write_main();
	}
}
