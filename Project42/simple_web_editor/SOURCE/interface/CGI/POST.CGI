#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
ReadParse(*mydata);
$|=1;

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL_Value[1];

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Accept Post</title></head>
<body>
<h1> Please Check Your Post Again </h1><br>
<h2>$mydata{'subject'}</h2><br>
$mydata{'detail'}<br>
<form method="post" action="post2.cgi?room=$room">
<input type="hidden" name="name" value="$mydata{'name'}">
<input type="hidden" name="subject" value="$mydata{'subject'}">
<input type="hidden" name="detail" value="$mydata{'detail'}">
<p><input type="submit" value="Accept">
</form>
</body>
</html>
EOF

