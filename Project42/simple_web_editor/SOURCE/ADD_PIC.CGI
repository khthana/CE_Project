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
<head><title>Add background</title></head>
<body bgcolor=#5ea0a0>
EOF

if ($ENV{'HTTP_VIA'} eq '') {
	$ip = $ENV{'REMOTE_ADDR'};
	}
else { $ip = $ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select Login,Id_homepage from user where Ip='$ip'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$user = $field[0];
	$id = $field[1];
	}

$id++;
if ($mydata{link} eq 'y') {$link = $mydata{url};}
if ($mydata{br} eq 'y') {$br = $mydata{no_br};}

$dbh->do("insert into homepage values
('pic','$mydata{file}','','$mydata{position}','','n','n','n','n','$link','$id','$user','$br')");

$dbh->do("update user set Id_homepage='$id' where Login='$user'");

print <<EOF;
<form method=post action=end.cgi>
If you don't want to add anything 
<input type=submit value="Click Here">
</form>
If you want to add something
<a href="upload.cgi">Add Picture</a><br>
<a href="add_text.cgi">Add Text</a><br>
</body>
</html>
EOF

