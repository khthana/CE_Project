#!/usr/bin/perl
push(INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Update Room's Name</title></head>
<body bgcolor="#5ea0a0">
<center>
<h1> Change your room's name</h1>
<form action="update_room2.cgi" method="post">
<table border=0>

EOF

$i=1;
$j=1;

$sth = $dbh->prepare("select * from room");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
	print "<tr><th align=left>Name Room$j:</th>\n";
	print "	    <td><input type=text size=30 maxlength=75 name=\"$i\"
value=\"$hash_ref->{N_room}\"></td>\n";
	print "</tr>\n";
	$i++;
	print "<input type=\"hidden\" name=\"$i\" value=\"$hash_ref->{Room}\">\n";
	$i++;
	$j++;
	}


print <<EOF;
</table>
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
</body>
</html>
EOF

                            

