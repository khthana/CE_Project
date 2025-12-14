#!/usr/bin/perl

push(INC,"/cgi");
require('cgi_lib2.cgi');
ReadParse(*mydata);

$|=1;

$database='webboard';
$user='web';
$password='project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Profile</title></head>
<body>
<center>
<h2>Profile</h2>
</center>
EOF

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$user = $URL_Value[1];

$sth = $dbh->prepare("select * from user where Login='$user'");
$sth->execute;

