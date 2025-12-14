#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

@URL_Value = split(/=/,$ENV{'QUERY_STRING'});
$login=$URL_Value[1];

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
$dbh->do("update user set Ip = '' where Login ='$login' ");
print "Content-type:text/html\n\n";
&write_main();
