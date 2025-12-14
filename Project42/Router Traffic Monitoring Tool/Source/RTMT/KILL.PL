#!/usr/bin/perl
use DBI;
use CGI;

require 'common.pl';

read_conf();

$query = new CGI;
$user = $query->param('user');
$passwd = $query->param('passwd');

print 	$query -> header();

read_template($RTMT_DIR."html/result.html");

begin_template();

open (FILE, "$CONFIG_DIR$LOG");
@buffer = <FILE>;
close (FILE);

$kill_pid = 0;
$countip = 0;
$totalline = @buffer;

for ($countip=0; $countip<$totalline; $countip++) {

	($ip[$countip], $pid[$countip]) = split(/ /, $buffer[$countip]);

	$checkip = $query->param('ip');


	if ($ip[$countip] =~ /^$checkip$/i) {
	
		$dbh = DBI->connect("DBI:mysql:rtmt", 'root', $LOGIN_PASSWD);
		$sth = $dbh->prepare("select user, passwd from ip where ip = \"$checkip\"");
		$sth->execute;
	
		while (@field = $sth->fetchrow_array) {
		
			if (($field[0] =~ /^$user$/) && ($field[1] =~ /^$passwd$/)) { 	

				$kill_pid = $pid[$countip];

			}
		}		#end while check field	
	}				#end if checkip	
}		#end for loop countip

if ($kill_pid == 0) {
	print	$query->h1("ERROR:\n"),
		"Your name or password is incorrect!<P>\n";
} else {
	kill(QUIT, $kill_pid);

	print	$query->h1("KILLING:\n"),
		"Completed.<P>\n";
}

end_template();