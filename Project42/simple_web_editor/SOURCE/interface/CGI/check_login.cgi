#!/usr/bin/perl

push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('write_main.cgi');
ReadParse(*mydata);
$|=1;

$date=`/bin/date +"%a %d %h, %Y : %T"`;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

$ip=$ENV{'REMOTE_ADDR'};
$room=1;

#$i = rand(9);
#$i=($i*10000000);
#($keygen,$del) = split(/\./,$i);

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Result login</title></head>
<body>
EOF

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
$pwd=$mydata{pwd};

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
#        $dbh->do("update user set keygen=password('$keygen') where Login='$mydata{login}'");
        $dbh->do("update user set Ip='$ip' where Login='$mydata{login}'");
        $dbh->do("update user set Last_log='$date' where Login='$mydata{login}'");
        &write_main();
	}
}
