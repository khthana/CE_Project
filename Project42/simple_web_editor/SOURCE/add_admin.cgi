#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
&ReadParse(*mydata);

$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Add Admin</title></head>
<body bgcolor="#5ea0a0">
<form method="post" action="add_admin2.cgi">
<center>
<h3>The users which you can add to admin group:</h3>
</center>
EOF

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

$i=1;
$sth=$dbh->prepare("select Login,Admin from user;");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	if ($field[1] eq '') {
		print "$i.<input type=\"checkbox\" name=\"$i\" value=\"$field[0]\">\n";
		print "$field[0]<br>\n";
		$i++;
		}
	}
$sth->finish;
$dbh->disconnect;

print <<EOF;
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
<br>
<a href="title2.cgi">Back to Main Page</a>
</body>
</html>
EOF

exit;
