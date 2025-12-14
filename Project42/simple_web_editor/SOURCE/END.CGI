#!/usr/bin/perl
push(INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('end2.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

print "Content-type:text/html\n\n";

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

if ($ENV{'HTTP_VIA'} eq '') {$ip = $ENV{'REMOTE_ADDR'};}
else {$ip = $ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select Login,Id_homepage from user where Ip =
'$ip'");
$sth->execute;
while (@field = $sth->fetchrow_array) {
        $user = $field[0];
        $no_homepage = $field[1];
        }
        

&end2();
