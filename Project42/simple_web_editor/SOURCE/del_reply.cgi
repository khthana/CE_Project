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
<head><title>Accept Post</title></head>
<body bgcolor="#5ea0a0">
<h1><blink> Are You Sure To Delete These posts!!! </blink></h1><br><br>
The topic of your posts which you will delete is:<br><br>
EOF

$i=1;
$j=1;
$sth = $dbh->prepare("select No_reply from head_post where Id_post='$mydata{title}'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$no_reply = $field[0];
	}

while ($i <= $no_reply) {
if ($mydata{$i} ne '') {
	$sth = $dbh->prepare("select Title_reply,Room from head_reply where Id_reply='$mydata{$i}'");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		print "<b><i>$j. $field[0]</i></b><br>\n";
		$room = $field[1];
		}
	$j++;
	}
$i++;
}

print <<EOF;
<form method="post" action="del_reply2.cgi?room=$room">
<input type="hidden" name="title" value="$mydata{title}">
EOF

$i=1;
while ($i <= $no_reply) {
print "<input type=\"hidden\" name=\"$i\" value=\"$mydata{$i}\">\n";
#<input type="hidden" name="subject" value="$mydata{'subject'}">
#<input type="hidden" name="detail" value="$mydata{'detail'}">
$i++;
}

print <<EOF;
<p><input type="submit" value="Accept">
</form>
</body>
</html>
EOF

