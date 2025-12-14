#!/usr/bin/perl

use DBI;
use CGI;

require 'common.pl';

#read_conf();

$query = new CGI;

$checkip	= $query->param('ip');
$checkoid	= $query->param('oid');
$checktype	= $query->param('type');
	
print 	$query -> header();

read_template("$RTMT_DIR"."html/result.html");

begin_template();

print "<font color=blue><h1>$checkip</h1></font>";

#-- read config file for send parameter
	
open(READ1,"$CONFIG_DIR$LOG");
@bufread1 = <READ1>;
close(READ1);
$countread1 = @bufread1;
	
for ($i = 0; $i < $countread1; $i++) {
	@compare = split(/ /,$bufread1[$i]);
	if ($compare[0] =~ /^$checkip$/) {
		$checkmax = $compare[4];
		$checkmin = $compare[5];
		$checkint = $compare[2];
		$checktable = $compare[3].'_d';
		$i = $countread1;
	}					#end ip
}						#end for countread1
	
#-- create file from database

$date = `date`;
extract($date);
$realmin = ($hour*60)+$min;	#real minute in table
$filename = $checkip.'.day';	#name of file for graph
	
		
$dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);

if ($checkoid == 1) {
	if ($checktype == 1) {
		$col1 = 'inoctpac';
		$col2 = 'outoctpac';
		$message = 'octet package';
	} elsif ($checktype == 2) {
		$col1 = 'inoctsum';
		$col2 = 'outoctsum';
		$message = 'octet sum';
	} elsif ($checktype == 3) {
		$col1 = 'inoctavg';
		$col2 = 'outoctavg';
		$message = 'octet average';
	} elsif ($checktype == 4) {
		$col1 = 'inoctdiff';
		$col2 = 'outoctdiff';
		$message = 'octet different';
	}
} elsif ($checkoid == 2) {
	if ($checktype == 1) {
		$col1 = 'inerrpac';
		$col2 = 'outerrpac';
		$message = 'error package';
	} elsif ($checktype == 2) {
		$col1 = 'inerrsum';
		$col2 = 'outerrsum';
		$message = 'error sum';
	} elsif ($checktype == 3) {
		$col1 = 'inerravg';
		$col2 = 'outerravg';
		$message = 'error average';
	} elsif ($checktype == 4) {
		$col1 = 'inerrdiff';
		$col2 = 'outerrdiff';
		$message = 'error different';
	}
}


$sth = $dbh->prepare("select inf, min, $col1, $col2 from $checktable 
	where min <= $realmin ");
$tth = $dbh->prepare("select inf, MIN($col1), MAX($col1), MIN($col2),MAX($col2)
	from $checktable group by inf ");
			
$sth->execute;

open (WRITELOG,">$CONFIG_DIR$filename");

while (@field = $sth->fetchrow_array) {

	$wint = $field[0];
	$wmin = $field[1];
	$inval = $field[2];
	$outval = $field[3];
	print WRITELOG "i $wint $wmin $inval $outval\n";
			
}						#end while 
		
$sth->finish;

$tth->execute;

close(WRITELOG);
	
open (WRITELOG,">>$CONFIG_DIR$filename");	#new edit

while (@logfield = $tth->fetchrow_array) {

	$sint = $logfield[0];
	$inmin = $logfield[1];
	$inmax = $logfield[2];
	$outmin = $logfield[3];
	$outmax = $logfield[4];
	print WRITELOG "m $sint $inmin $inmax $outmin $outmax\n";
	
}						#end while logfile
	
$tth->finish;

$dbh->disconnect;

close(WRITELOG);

if (!system($RTMT_DIR."html/gd/create5", "$checkip", "$checkmax",
	"$checkmin", "$checkoid", "$checktype")) {

	for ($i=0; $i<$checkint; $i++) {
		print "<p><font color=green>in</font><font color=red>out</font>
				$message Interface #$i<br>\n";
		print "<image src=\"/rtmt/gd/image/day/$checkip"
			."_$i.png\"></p>\n";
	}
} else {
	print "<h2>ERROR:</h2><p>\n";
	print "Cann't display graph!<BR>\n";
}

end_template();
	 	
#***********************************************
	 	
sub extract ($)				#pass date 
{
	my ($temp1) = shift;
	my (@date) = split(' ',$temp1);
	$dayName = $date[0];			#name of day in a week
	$month = $date[1];			#name of month in a year
	$dateNo = $date[2];			#date
	$year = $date[5];			#year xxxx
	my (@temp2) = split(':',$date[3]);	#split time	
	$hour = $temp2[0];			#hour 0-23
	$min = $temp2[1];			#minute	0-59
	$sec = $temp2[2];			#second	0-59	
}						#end sub extract

#**********************************************
	 	
	 	
