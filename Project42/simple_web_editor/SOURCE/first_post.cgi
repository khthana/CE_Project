#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('path.cgi');
&ReadParse(*mydata);


$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$room=$URL_Value[1];

if ($room eq '') {
	$sth = $dbh->prepare("select Room from room");
	$sth->execute;
	while (@field = $sth->fetchrow_array) {
		$room=$field[0];
		}
	}

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Add New Post</title></head>
<body bgcolor="#5ea0a0">
<h1>Add Your Post</h1>
<form method="post" action="post.cgi?room=$room">
<table>
<tr><th>Subject:</th><td><input type="text" name="subject" size=30
maxlength=150></td></tr>
<tr><th>Detail:</th><td><textarea name="detail" wrap=virtual rows=10
cols=40></textarea></td></tr>
</table>
<p><input type="submit" value="Submit">
   <input type="reset" value="Clear">
</form>
</body>
</html>
EOF


