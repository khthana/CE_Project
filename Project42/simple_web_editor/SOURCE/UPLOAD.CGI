#!/usr/bin/perl
push(@INC,"../tmp/");  
require('path.cgi');

&pathy();
print "Content-type:text/html\n\n";
print <<EOF
<html>
<head><title>file upload</title></head>
<body bgcolor="#5ea0a0">
<form method='post' enctype='multipart/form-data' action='load.cgi'>
Picture's File Name: <INPUT TYPE=file NAME=file  SIZE=35 ><br>
<br>
<input type=submit name=upload value=upload> to upload the file!
</form>
</body>
</html>
EOF
