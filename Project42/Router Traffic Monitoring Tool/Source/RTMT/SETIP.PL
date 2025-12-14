#!/usr/bin/perl

use DBI;
use CGI;
use BER;
require 'SNMP_Session.pm';
require 'common.pl';

$port = 161;


read_template("$RTMT_DIR"."html/result.html");

$query = new CGI;

$check_host	= $query -> param('ip');
$max	= $query -> param('max');
$min	= $query -> param('min');
$user	= $query -> param('user');
$passwd	= $query -> param('passwd');
$community = $query -> param('community');

if ($community == ' ') {
	$community = 'public';
}

$check_host =~ s/ //;
$user	=~ s/ //;
$community =~ s/ //;


if (length($max) == 0) {
	$max = 1000;
}		#end if max

if (length($min) == 0) {
	$min = 0;
}		#end if min

print	$query->header();

#-- Start HTML
begin_template();


if (length($user) == 0
	|| length($passwd) == 0) {
	print "<H1>ERROR:</H1>\n";
	print "You must enter user name and passwd!<BR>\n";
	goto quit;
}

%check_oids = ('1'=> "1.3.6.1.2.1.2.1.0", '2'=> "1.3.6.1.2.1.2.1.0");

foreach (keys %check_oids) {
	$check_oids{$_} = encode_oid (split (/\./, $check_oids{$_}));
	$nice_oids{$check_oids{$_}} = $_;
}					#end foreach

$check_session = SNMP_Session->open($check_host,$community,$port); 
	
$ifnumber = 0;
$interface = 0;
snmp_check ($check_session, keys(%check_oids));

$check_session->close();
	
if ($ifnumber <= 2) {
	print "<H1>ERROR:</H1>\n";
	print "Your ip address may not be router!<BR>\n";
	print "Please, try again or enter new IP Address.<BR>\n";
}					#end if ifnumber <= 2
else {
	open (FILE,"$CONFIG_DIR$LOG");
	@tempCon = <FILE>;
	$countCon = @tempCon;
	close (FILE);

	$find = 0;
	for ($j = 0; $j < $countCon; $j++) {
	
		if ($tempCon [$j] =~ /$check_host/) {
			$find = 1; 
			print "<H1>ERROR:</H1><p>\n";
			print "Your ip address is monitored!<BR>\n";
			$j = $countCon;
		 }				#end if
	}					#end for

	
	if ($find == 0) {

		if ($dbh = DBI->connect('DBI:mysql:rtmt', $LOGIN_NAME, $LOGIN_PASSWD)) {
			
			print "Your ip address is just monitored.<BR>\n";

			$dbh->do("insert into ip (ip, user, passwd)
				values (\"$check_host\", \"$user\", \"$passwd\")");
			$dbh->disconnect;		
		
			$tempString = "$check_host $interface $community $max $min";

			if (fork == 0) {
				exec "perl getinfor.pl $tempString";
			}
		} else {
			print "<H1>ERROR:</H1><p>\n";
			print "Cann't connect to database!<BR>\n";
		}

	}				#end if check find
}					#end else check ifnumber <= 2 

quit:

end_template();

#*************************
#** End of Main Program **
#*************************

#************************************************** 
sub snmp_check
{
	my($check_session, @oids) = @_;
	my($response, $bindings, $binding, $value, $oid);
	my($i);
	
	grep ($_ = $check_oids{$_}, @oids);
		
	if ($check_session->get_request_response(@oids)) {
		($bindings) = $check_session->
			decode_get_response($check_session->{pdu_buffer});
		$i = 0;
		while ($bindings ne '') {
			$i++;
			($binding,$bindings) = decode_sequence($bindings);
			($oid,$value) = decode_by_template($binding,"%O%@");
			if ($i == 1) {
				$ifnumber = pretty_print($value);
			}			#end if check service
			if ($i == 2) {
				$interface = pretty_print($value);
			}			#end if check interface

		}		#end while
		return 1;	
	}			#end if sub snmp check
	
	return 0;
}		#end sub snmp check
#************************************************

sub write_log()	# pass file name and interface number
{
	my($name, $int) = @_;
	my($count, $line) = (0, 0);
	$line = (($int+1)*12)-1;	#calculate number of line from interface number
	open(FILE, ">$CONFIG_DIR$name");
	while ($count <= $line) {
		print FILE "\n";
		$count++;
	}
	close(FILE);
}				#end sub write

#***********************************************
