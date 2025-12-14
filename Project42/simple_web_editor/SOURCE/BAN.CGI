#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
&ReadParse(*mydata);

$|=1;
print "Content-type:text/html\n\n";
print <<EOF;
<html>
<body bgcolor="#5ea0a0">
<head><title>Ban for this board</title></head>
<center><h1>Ban For This Board</h1></center>
<br>
<b><a href="ban_ip.cgi">Ban Ip Address</a><br>
<a href="ban_user.cgi">Ban User</a><br></b>
</body>
</html>
EOF


