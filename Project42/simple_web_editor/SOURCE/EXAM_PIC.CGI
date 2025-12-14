#!/usr/bin/perl

push(INC,"/cgi");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$back = $URL_Value[1];

&pathy();
print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>example background</title></head>
<body background = "http://$base_host$background$back">
</body>
</html>
EOF

