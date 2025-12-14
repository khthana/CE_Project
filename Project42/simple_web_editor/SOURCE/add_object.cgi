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

$dbh = DBI->connect("DBI:mysql:$database",$user,$password);
&pathy();

if ($ENV{'HTTP_VIA'} eq '') {
        $ip=$ENV{'REMOTE_ADDR'};
        }
else { $ip = $ENV{'HTTP_X_FORWARDED_FOR'};}

$sth = $dbh->prepare("select
Ip,Login from user");
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

print "Content-type:text/html\n\n";

print <<EOF;
<html>
<head><title>Add Object</title></head>
<body bgcolor="#5ea0a0">
EOF

if ($y eq 'y') {
print <<EOF;
<center>
<h1><b>Choose It for Your Homepage</b></h1>
</center><br>
<a href="upload.cgi">Add Picture</a><br>
<a href="add_text.cgi">Add
Text</a><br>
</body>
</html>
EOF

}
else {   
        print " <center><h1><a href=\"login.cgi\">Please
Login!!!</a></h1></center>\n";
        }

print "</body></html>\n";


