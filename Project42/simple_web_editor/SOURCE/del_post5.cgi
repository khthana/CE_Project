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
&pathy();

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

$i=1;
while ($i <= $mydata{no}) {
	if ($mydata{$i} ne '') {
		$sth = $dbh->prepare("select no,Room from head_post where Id_post='$mydata{$i}'");
		$sth->execute;
		while (@field = $sth->fetchrow_array) {
			$no = $field[0];
			$room = $field[1];
			}
		$sth = $dbh->prepare("select No_post from room where Room='$room'");
		$sth->execute;
		while (@field = $sth->fetchrow_array) {
			$no_change = $field[0];
			}
		$dbh->do("delete from head_post where Id_post='$mydata{$i}'");
		$dbh->do("delete from head_reply where Id_post='$mydata{$i}'");
		$dbh->do("delete from Detail_post where Id_post='$mydata{$i}'");
		$dbh->do("delete from detail_reply where Id_post='$mydata{$i}'");
		$no_change--;
		$dbh->do("update room set No_post='$no_change' where Room='$room'");
		$no_change++;
		$max = $no_change;
		for ($p=$no+1;$p<=$max;$p++) {
			$dbh->do("update head_post set no='$no' where no='$p' and Room='$room'");
			$no++;		
			}
		}
	$i++;
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
