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
<head><title>Config Room</title></head>
<center><h1>Room Configuration</h1></center>
<br>
<b><a href="del_room.cgi">Delete Room</a></b><br>
<b><a href="add_room.cgi">Add Room</a></b><br>
<b><a href="update_room.cgi">Change the name of room</a></b><br>
</body>
</html>
EOF


