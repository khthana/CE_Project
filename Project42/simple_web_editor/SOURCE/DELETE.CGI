#!/usr/bin/perl
push(@INC,"../tmp/");
require('cgi_lib2.cgi');
require('write_main2.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1; 

use DBI;
$database='webboard';
$user='web';
$password='project';

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

&write_main2.cgi()
