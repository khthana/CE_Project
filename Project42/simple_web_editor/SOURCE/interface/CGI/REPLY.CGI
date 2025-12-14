#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
ReadParse(*mydata);
$|=1;

@URL = split(/=/,$ENV{'QUERY_STRING'});
$title=$URL[1];

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Accept Reply</title></head>
<body>
<h1> Please Check Your Reply Again </h1><br>
<h2>$mydata{subject}</h2><br>
<b>$mydata{'subject_p'}<b><br>
$mydata{'detail'}<br>
<form method="post" action="reply2.cgi?room=$mydata{room}">
<input type="hidden" name="name" value="$mydata{'name'}">
<input type="hidden" name="title" value="$title">
<input type="hidden" name="detail" value="$mydata{'detail'}">
<input type="hidden" name="subject_p" value="$mydata{'subject_p'}">
<input type="hidden" name="subject" value="$mydata{'subject'}">
<p><input type="submit" value="Accept">
</form>
</body>
</html>
EOF

UUUUUUUUUUUUUUUUUUU
