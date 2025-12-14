#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL_Value[1];

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Delete user</title></head>
<body bgcolor="#5ea0a0">
<h1><blink> Are You Sure To Delete These Rooms!!! </blink></h1><br>
<i>The room which you delete may have some contents</i><br>
The room which you will delete is:<br><br>
EOF

$i=0;
$sth = $dbh->prepare("select N_room from room");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$i++;
	}

$j=1;
$p=1;
while ($j <= $i) {
if ($mydata{$j} ne '') {
	$sth = $dbh->prepare("select N_room from room where Room='$mydata{$j}'");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		print "<b>$p. $field[0]</b>\n";
		}
	print "<br>\n";
	$p++;
	}
$j++;
}

print <<EOF;
<form method="post" action="del_room3.cgi">
EOF

$j=1;
while ($j <= $i) {
print "<input type=\"hidden\" name=\"$j\" value=\"$mydata{$j}\">\n";
$j++;
}

print <<EOF;
<p><input type="submit" value="Accept">
</form>
</body>
</html>
EOF

