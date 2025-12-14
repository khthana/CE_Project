sub in_out {
$ip=$ENV{'REMOTE_ADDR'};
$sth = $dbh->prepare("select Ip,Login from user");
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
if ($y eq 'y') {print "<a href=\"logout.cgi?login=$login\">Logout</a><br>\n";}
else {print "<a href=\"login.cgi\">Login</a><br>\n";}
}
1;#return true
