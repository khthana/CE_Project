#!/usr/bin/perl

push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('path.cgi');
ReadParse(*mydata);

$|=1;

use DBI;
$database='webboard';
$user='web';
$password='project';

$login=$mydata{login};

$dbh=DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

print "Content-type:text/html\n\n";

if ($ENV{'HTTP_VIA'} eq '') {$ip=$ENV{'REMOTE_ADDR'};}
else {$ip=$ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select ip_admin,Login from user");
$sth->execute;
$y='n';
$n='n';
while (@field = $sth->fetchrow_array) {
        $ip2=$field[0];
        if ($ip2 eq $ip) {$y = 'y';
                          $login = $field[1];
                          }
        else {$n = 'y';}
        }                
if ($y eq 'y') { 

$dbh->do("update Total_board set width='$mydata{no}'");
$dbh->do("update user set ip_admin='' where Login='$login'");  
&write_main();
}
else {
print "<html>\n";
print "<head><title>Incorrect</title></head>\n";
print "<body bgcolor=#5ea0a0>\n";
print "<h1><center>You are not Login</center></h1>\n";
print "<a href=\"title2.cgi\">Back to main page</a>\n";
print "</body>\n";
print "</html>\n";
}

