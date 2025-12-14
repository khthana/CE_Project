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

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Forgot Password</title></head>
<body bgcolor="#5ea0a0">
<center><h1>Please Enter Your Answer</h1></center>
<form method=post action="forgot2.cgi">
<table>
EOF

$sth = $dbh->prepare("select question from user where
Login='$mydata{login}'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$question = $field[0];
	}

print <<EOF
<tr><th align=left>$question</th>
    <td></td>
</tr>
<tr><th align=left>Answer:</th>
    <td><input type=text size=20 maxlength=125 name=answer></td>
</tr>
</table>
<input type="hidden" value="$mydata{login}" name=login>
<p><input type="submit" value="submit">
   <input type="reset" value="Clear">
</form>
<br>
</body>
</html>
EOF

