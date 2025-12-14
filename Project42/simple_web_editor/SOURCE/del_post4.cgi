#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
&ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Delete Post from user</title></head>
<body bgcolor="#5ea0a0">
<form method="post" action="del_post5.cgi">
<center>
<h3>The posts which you will delete from user:</h3>
</center>
EOF

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

$i=1;
$sth=$dbh->prepare("select * from head_post where Name_post = '$mydata{name}'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
	print "$i.<input type=\"checkbox\" name=\"$i\" value=\"$hash_ref->{Id_post}\">\n";
	print "<a href=\"title.cgi?title=$hash_ref->{Id_post}\">$hash_ref->{Title_post}</a>\n";
	print "<br>\n";
	$i++;
	}

$sth=$dbh->prepare("select * from head_reply where Name_reply = '$mydata{name}'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
	print "$i.<input type=\"checkbox\" name=\"$i\" value=\"$hash_ref->{Id_post}\">\n";
	print "<a
href=\"title.cgi?title=$hash_ref->{Id_post}#$hash_ref->{Id_reply}\">$hash_ref->{Title_reply}</a>\n";
	print "<br>\n";
	$i++;
	}
$i--;

$sth->finish;
$dbh->disconnect;

if ($i ne '0') {
print <<EOF;
<input type=hidden name=no value=$i>
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
<br>
<a href="title2.cgi">Back to Main Page</a>
</body>
</html>
EOF
}
else {
print <<EOF;
<h3>No post you can delete!!</h3>
</form>
<br>
<a href="title2.cgi">Back to Main Page</a>
</body>
</html>
EOF
}
exit;
