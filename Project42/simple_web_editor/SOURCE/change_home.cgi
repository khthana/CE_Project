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

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$login=$URL_Value[1];

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Update Homepage</title></head>
<body bgcolor="#5ea0a0">
<h3>Do you want to?</h3>
<a href="del_home.cgi?No=$mydata{change}&user=$login">Delete Object</a><br>
<a href="change_home2.cgi?No=$mydata{change}&user=$login">Update Object</a><br>
</body>
</html>
EOF
