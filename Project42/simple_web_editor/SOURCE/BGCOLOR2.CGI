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
<body>
EOF

if ($ENV{'HTTP_VIA'} eq '') {
	$ip = $ENV{'REMOTE_ADDR'};
	}
else { $ip = $ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select Login from user where Ip='$ip'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$user = $field[0];
	}

if ($mydata{bgcolor} eq 'basic') {$color = $mydata{color1};}
if ($mydata{bgcolor} eq 'example') {$color = $mydata{color2};}
if ($mydata{bgcolor} eq 'code') {$color = $mydata{color3};}

$dbh->do("insert into homepage values
('background','$mydata{bgcolor}','$color','','0','n','n','n','n','','1','$user','0')");

$dbh->do("update user set Id_homepage='1' where Login='$user'");

print <<EOF;
<center>
<h1><b>Choose It for Your Homepage</b></h1>
</center><br>
<a href="upload.cgi">Add Picture</a><br>
<a href="add_text.cgi">Add Text</a><br>
</body>
</html>
EOF

