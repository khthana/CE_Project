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
<head><title>Change Range</title></head>
<body bgcolor="#5ea0a0">
<center>
<h1> Change Number of Post per Page</h1>
<form action="range2.cgi" method="post">
<table border=0>
EOF

$sth = $dbh->prepare("select width from Total_board");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	print "<tr><th align=left>Number:</th>\n";
	print "	    <td><input type=text size=5 maxlength=5 name=\"no\" value=\"$field[0]\"></td>\n";
	print "</tr>\n";
	}


print <<EOF;
</table>
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
</body>
</html>
EOF

                            

