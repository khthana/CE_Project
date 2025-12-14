#!/usr/bin/perl

push(INC,"/cgi");
require('cgi_lib2.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Profile</title></head>
<body bgcolor=#5ea0a0>
EOF

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$user = $URL_Value[1];

$sth = $dbh->prepare("select * from user where Login='$user'");
$sth->execute;
while ($hash_ref = $sth->fetchrow_hashref) {
	print "<center><h1>$user\'s Profile</h1></center>\n";
	print "<table border=0>\n";
	print "<tr><th align=left>Name:</th><td>$hash_ref->{Name}</td></tr>\n";
	print "<tr><th align=left>Address:</th><td>$hash_ref->{Address}</td></tr>\n";
	print "<tr><th align=left>E-mail:</th><td>$hash_ref->{Email}</td></tr>\n";	
	print "<tr><th align=left>Telephone:</th><td>$hash_ref->{Tel}</td></tr>\n";
	print "<tr><th align=left>Page Number:</th><td>$hash_ref->{Page}</td></tr>\n";
	print "<tr><th align=left>Occupation:</th><td>$hash_ref->{Occupation}</td></tr>\n";
if (($hash_ref->{Homepage} ne '') && ($hash_ref->{Homepage} ne '-')) {
	print "<tr><th align=left>Homepage:</th><td><a
href=\"http://$hash_ref->{Homepage}\">http://$hash_ref->{Homepage}</a></td></tr>\n";
	}
else {print "<tr><th align=left>Homepage:</th><td>-</td></tr>\n";
	}
	print "<tr><th align=left><a
href=\"http://$base_host$tmp$user.html\">Personnel Homepage in Webboard</a></th><td></td></tr>\n";
	}
print "</table></body>\n</html>\n";


