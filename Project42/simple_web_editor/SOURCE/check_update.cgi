#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Update Homepage</title></head>
<body bgcolor="#5ea0a0">
EOF

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$login=$URL_Value[1];

$pwd  = $mydata{pwd};
$sth = $dbh->prepare("select Login from user where Password=password('$pwd')");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$login2 = $field[0];
	}

if ($login ne $login2)  {
	print "<body bgcolor=\"#5ea0a0\">\n";
	print "<center><h1><blink> Your Password Incorrect </blink></h1></center>\n";
	print "<form method=post action=\"check_update.cgi?user=$login\">\n";
	print "<table>\n";
	print "<tr><th>Password:</th>\n";
	print "    <td><input type=password size=20 maxlength=20 name=\"pwd\"></td>\n";
	print "</tr>\n";
	print "</table>\n";
	print "<p><input type=\"submit\" value=\"submit\">\n";
	print "   <input type=\"reset\" value=\"Clear\">\n";
	print "</form>\n";
	print "<br>\n";
	}
else {
	&object_change();
	}
print <<EOF;
</body>
</html>
EOF
	
sub object_change {

$sth = $dbh->prepare("select Form,Color from homepage where User='$login' and No='1'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	if ($field[0] eq 'example') {
		print "<body
background=\"http://$base_host$background$field[1]\">\n";
		}
	if ($field[0] eq 'code') {
		print "<body bgcolor=\"\#$field[1]\">\n";
		}
	if ($field[0] eq 'basic') {
		print "<body bgcolor=\"$field[1]\">\n";
		}
	}

$sth = $dbh->prepare("select Id_homepage from user where Login='$login'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$max = $field[0];
	}

print "<form method=post action=\"change_home.cgi?user=$login\">\n";
print "<input type=radio name=change value=1>Background<br>\n";

$i=2;
while ($i <= $max) {
	$sth = $dbh->prepare("select * from homepage where User='$login' and No='$i'");
	$sth->execute;
	while ($hash_ref = $sth->fetchrow_hashref) {
		print "<input type=radio name=change value=$i>";
		if ($hash_ref->{Type} eq 'pic') {
			print "Picture  <img
src=\"http://$base_host$tmp$hash_ref->{Form}\"
border=0><br>\n";
			}
		if ($hash_ref->{Type} eq 'txt') {
			print "Text <font color=$hash_ref->{Color} size=10>";
			print "$hash_ref->{Form}</font><br>\n";
			}
		}
	$i++;
	}

print <<EOF;
<p><input type=submit value="Submit">
   <input type=reset value="Clear">
</form>
<br>
EOF
}
