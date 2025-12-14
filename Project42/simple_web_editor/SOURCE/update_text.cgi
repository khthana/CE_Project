#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('end2.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Add background</title></head>
<body bgcolor=#5ea0a0>
EOF

@URL_Value = split(/&/,$ENV{'QUERY_STRING'});
@URL_Value2 = split(/=/,$URL_Value[0]);
$no=$URL_Value2[1];
@URL_Value2 = split(/=/,$URL_Value[1]);
$user=$URL_Value2[1];

if ($mydata{link} eq 'y') {$link = $mydata{url};}
if ($mydata{br} eq 'y') {$br = $mydata{no_br};}

$dbh->do("update homepage set Form='$mydata{message}' where User='$user' and No='$no'");
$dbh->do("update homepage set Color='$mydata{color}' where User='$user' and No='$no'");
$dbh->do("update homepage set Position='$mydata{position}' where User='$user' and No='$no'");
$dbh->do("update homepage set Size='$mydata{size}' where User='$user' and No='$no'");
$dbh->do("update homepage set Bold='$mydata{bold}' where User='$user' and No='$no'");
$dbh->do("update homepage set Italic='$mydata{italic}' where User='$user' and No='$no'");
$dbh->do("update homepage set Underline='$mydata{under}' where User='$user' and No='$no'");
$dbh->do("update homepage set Blink='$mydata{blink}' where User='$user' and No='$no'");
$dbh->do("update homepage set Link='$link' where User='$user' and No='$no'");
$dbh->do("update homepage set Br='$br' where User='$user' and No='$no'");

$sth = $dbh->prepare("select Id_homepage from user where Login='$user'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $no_homepage = $field[0];
        }

unlink("../htdocs/$tmp$user.html");
&end2();
