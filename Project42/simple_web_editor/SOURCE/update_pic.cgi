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

@URL_Value = split(/&/,$ENV{'QUERY_STRING'});
@URL_Value2 = split(/=/,$URL_Value[0]);
$no=$URL_Value2[1];
@URL_Value2 = split(/=/,$URL_Value[1]);
$user=$URL_Value2[1];

print "Content-type:text/html\n\n";
print <<EOF;
<html>
<head><title>Add background</title></head>
<body bgcolor=#5ea0a0>
EOF

if ($mydata{link} eq 'y') {$link = $mydata{url};}
if ($mydata{br} eq 'y') {$br = $mydata{no_br};}

$dbh->do("update homepage set Position='$mydata{position}' where User='$user' and No='$no'");
$dbh->do("update homepage set Link='$link' where User='$user' and No='$no'");
$dbh->do("update homepage set Br='$br' where User='$user' and No='$no'");

#$dbh->do("insert into homepage values
#('pic','$mydata{file}','','$mydata{position}','','n','n','n','n','$link','$id','$user','$br')");

#$dbh->do("update user set Id_homepage='$id' where Login='$user'");

$sth = $dbh->prepare("select Id_homepage from user where Login='$user'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $no_homepage = $field[0];
        }

&end2();

