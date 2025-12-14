#!/usr/bin/perl

use DBI;
use CGI;

require 'common.pl';

#read_conf();

$query = new CGI;

$checkip	= $query->param('ip');
$checkoid	= $query->param('oid');
$checktype	= 0;
	
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
		$checktable = $compare[3].'_m';
		$i = $countread1;
	}					#end ip
}						#end for countread1
	
#-- create file from database

$date = `date`;
extract ($date);
$numdate = $dateNo;			#real day number in table
$filename = $checkip.'.mon';	#name of file for graph
	
		
$dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);

if ($checkoid == 1) {
	$sth = $dbh->prepare("select inf,day,inoctavg,outoctavg from $checktable
		where day <= $numdate");
	$tth = $dbh->prepare("select inf,MIN(inoctavg),MAX(inoctavg),MIN(outoctavg),
		MAX(outoctavg) from $checktable group by inf ");	
	$message = 'octet average';		
} elsif ($checkoid == 2) {
	$sth = $dbh->prepare("select inf,mon,inerravg,outerravg from $checktable
		where day <= $numdate");
	$tth = $dbh->prepare("select inf,MIN(inerravg),MAX(inerravg),MIN(outerravg),
		MAX(outerravg) from $checktable group by inf ");
	$message = 'error average';			
}

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
	
open (WRITELOG,">>$CONFIG_DIR$filename");

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
		print "<image src=\"/rtmt/gd/image/month/$checkip"
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
=head	
	if ($month =~ /Jan/) { $monthno = 1; }
	elsif ($month =~ /Feb/) { $monthno = 2; }
	elsif ($month =~ /Mar/) { $monthno = 3; }
	elsif ($month =~ /Apr/) { $monthno = 4; }
	elsif ($month =~ /May/) { $monthno = 5; }
	elsif ($month =~ /Jun/) { $monthno = 6; }
	elsif ($month =~ /Jul/) { $monthno = 7; }
	elsif ($month =~ /Aug/) { $monthno = 8; }
	elsif ($month =~ /Sep/) { $monthno = 9; }
	elsif ($month =~ /Oct/) { $monthno = 10; }
	elsif ($month =~ /Nov/) { $monthno = 11; }
	elsif ($month =~ /Dec/) { $monthno = 12; }
	else {$monthno = 0; }
=cut		
}						#end sub extract

#**********************************************
