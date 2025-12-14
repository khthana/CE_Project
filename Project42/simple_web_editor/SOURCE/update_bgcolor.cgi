#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('end2.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Add background</title></head>
<body>
EOF

@URL_Value = split(/&/,$ENV{'QUERY_STRING'});
@URL_Value2 = split(/=/,$URL_Value[0]);
$no=$URL_Value2[1];
@URL_Value2 = split(/=/,$URL_Value[1]);
$user=$URL_Value2[1];

if ($mydata{bgcolor} eq 'basic') {$color = $mydata{color1};}
if ($mydata{bgcolor} eq 'example') {$color = $mydata{color2};}
if ($mydata{bgcolor} eq 'code') {$color = $mydata{color3};}

$dbh->do("update homepage set Form='$mydata{bgcolor}' where User='$user'
and No='1'");
$dbh->do("update homepage set Color='$color' where User='$user' and No='1'");

$sth = $dbh->prepare("select Id_homepage from user where Login='$user'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $no_homepage = $field[0];
        }

&end2();

