#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('in_out.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL_Value[1];

if ($room eq '') {$room = 1;}

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Main Post Page</title></head>
<body>
<h1>Main Page</h1>
<a href="first_post.cgi?room=$room">Add Post</a>
<a href="ip_user.cgi">Add New User</a>
<a href="profile.cgi">Edit Profile</a>
<a href="ip_search.cgi">Search</a>
EOF

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&in_out();

print <<EOF;
<a href="title2.cgi?room=1">Room 1</a>
<a href="title2.cgi?room=2">Room 2</a>
<a href="title2.cgi?room=3">Room 3</a>
<a href="title2.cgi?room=4">Room 4</a>
EOF

print "<table cellpadding=0 cellspacing=0 border=0 width=100%>\n";


$sth = $dbh->prepare("select * from head_post where Room='$room'");
$sth->execute;
while($hash_ref = $sth->fetchrow_hashref) {
	print "<tr>\n";
	print "<th align=left><a
href=\"title.cgi?title=$hash_ref->{Id_post}\">$hash_ref->{Title_post}</a></th>\n";
	print "<td align=left>$hash_ref->{Name_post}</td>\n";
	print "<td aling=left>$hash_ref->{No_reply}</td>\n";
	print "<td align=left>$hash_ref->{Time_post}</td>\n";
	print "</tr>\n";
	}
$sth->finish;
$dbh->disconnect;
 
print <<EOF;
</table>
</body>
</html>
EOF

exit;
