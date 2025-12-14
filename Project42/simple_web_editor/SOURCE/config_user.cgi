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
<head><title>Config User</title></head>
<center><h1>User Configuration</h1></center>
<br>
<b><a href="del_user.cgi">Delete User</a></b><br>
<b><a href="add_admin.cgi">Add user to adminstrator group</a></b><br>
<b><a href="rem_admin.cgi">Remove user from adminstrator group</a></b><br>
</body>
</html>
EOF


