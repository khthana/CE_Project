#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
&ReadParse(*mydata);


$|=1;

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL_Value[1];

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Add New Post</title></head>
<body>
<h1>Add Your Post</h1>
<form method="post" action="post.cgi?room=$room">
<table>
<tr><th>Subject:</th><td><input type="text" name="subject" size=30
maxlength=30></td></tr>
<tr><th>Detail:</th><td><textarea name="detail" wrap=virtual rows=10
cols=40></textarea></td></tr>
</table>
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
</body>
</html>
EOF


