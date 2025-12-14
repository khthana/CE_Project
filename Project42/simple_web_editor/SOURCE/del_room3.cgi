#!/usr/bin/perl
push(@INC,"/cgi-bin");
require('cgi_lib2.cgi');
require('write_main.cgi');
require('path.cgi');
ReadParse(*mydata);
$|=1;

use DBI;
$database = 'webboard';
$user = 'web';
$password = 'project';

print "Content-type:text/html\n\n";
$dbh = DBI->connect("DBI:mysql:$database",$user,$password);

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

$i=0;
$sth = $dbh->prepare("select N_room from room");
$sth->execute;
while (@field = $sth->fetchrow_array) {
	$i++;
	}
$j=1;
$p=$i;
while ($j <= $i) {
	if ($mydata{$j} ne '') {
		$dbh->do("delete from room where Room='$mydata{$j}'");
		$dbh->do("delete from Detail_post where Room='$mydata{$j}'");
		$dbh->do("delete from head_post where Room='$mydata{$j}'");
		$dbh->do("delete from detail_reply where Room_reply='$mydata{$j}'");
		$dbh->do("delete from head_reply where Room='$mydata{$j}'");
		$p--;
		$dbh->do("update Total_board set No_room='$p'");
		}
	$j++;
	}
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
