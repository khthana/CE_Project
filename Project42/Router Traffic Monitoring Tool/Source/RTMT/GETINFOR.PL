#!/usr/bin/perl
use DBI;
use BER;

require 'SNMP_Session.pm';
require 'common.pl';

$port = 161;


$host	= $ARGV[0];			#total number of address
$int	= $ARGV[1];			#total number of interface
$community = $ARGV[2];		#community name
$vmax	= $ARGV[3];			#max value of graph
$vmin	= $ARGV[4];			#min value of graph

@tempiptable = split(/\./,$host);
$tablename = $tempiptable[0].'_'.$tempiptable[1].'_'.$tempiptable[2].'_'.$tempiptable[3];

$dtable	= $tablename.'_d';
$mtable	= $tablename.'_m';
$ytable	= $tablename.'_y';

close (STDOUT);
close (STDIN);

$SIG{QUIT} = \&kill_process;
$childproc = $$;	#process id

$stringconf="$host "."$childproc "."$int "."$tablename "."$vmax "."$vmin "."\n";

$lineconf = 0;
$countconf = 0;
open (FILE1, "$CONFIG_DIR$LOG");
@buffer = <FILE1>;
close (FILE1); 
$lineconf = @buffer;

$findip = 0;
for ($k=0; $k<$lineconf; $k++) {
	if ($buffer[$k] =~ /^$host$/) {
		$findip = 1; 
		$k = $lineconf;
	}
}					#end for


if ($findip == 0) {
	open (FILE2, ">>$CONFIG_DIR$LOG");
	while ($countconf < $lineconf) {
		$countconf++;
	}				#end while

	
	print FILE2 "$stringconf";
	close (FILE2);	

#**************** create table *************************

	table($dtable, $int);
	monthtable($mtable, $int);
	yeartable($ytable, $int);

} else {
	open (FILE3, "$CONFIG_DIR$LOG");
	@tempcheck = <FILE3>;
	close(FILE3);

	$checkline = 0;
	while ($tempcheck[$checkline] !~ /$host/i) {
		$checkline++;
	}

	$repstring = "$host "."$childproc "."$int "."$tablename "
		."$vmax "."$vmin "."\n";		
	replace ($checkline, $CONFIG, $repstring);	 	
}				#end else

  
#***********************************************************
 
$init		= 1;		#for initial value of interface
$tot		= $int+1;	#total number of interface plus 1
$count		= $tot*4;	#count number of interfaces of all oids
$countOid	= 1;		#count number of oids
$sumPac		= 0;		#initial value of sum of packet 
$sumLine	= 0;		#base line of sum	
$countMin	= 0;		#count minutes
$countDay	= 0;		#count days
$first		= 0;		#first five minutes round

#initial array of all value
for ($j = 0; $j < $count; $j++)
{
	$inc[$j] = 0;		#create sa som for each interface:0 for total
	$pac[$j] = 0;		#create packet each minute
	$avgMin[$j] = 0;	#create average minute
	$diff[$j] = 0;		#create different 
	$avgDay[$j] = 0;	#create average for minute of day
	$avgMon[$j] = 0;	#create average for day of month
	$sumAvgDay[$j] = 0;	#create sum of average day of month
}					#end for array initial   

$session = SNMP_Session->open($host,$community,$port); 

#********************************
# main program run every minute
#********************************
while (1) {
	$old = `date`;
	extract($old);
	$oldmonth = $month;
	$olddate = $dateNo;
	sleep(60);
	$date = `date`;
	extract($date);

	for ($countOid = 1; $countOid <= 4; $countOid++)
	{
		$init = 1;
  		if ($countOid == 1) {		#oid of ifOutErrors
		  	while ($init <= $int) {	#find oid of total interfaces
				$ugly_oids{$init++} = "1.3.6.1.2.1.2.2.1.10.".$init;
 			}	#end while
			$part = 0;
			$sumLine = 0;
		}					#end if for countOid 1 ifInOctets
  
		if ($countOid == 2) {
			while ($init <= $int) {
				$ugly_oids{$init++} = "1.3.6.1.2.1.2.2.1.16.".$init;
			}
			$part = $tot;
			$sumLine = 0 + $part;
  		}					#end if for countOid 2 ifOutOctets

		if ($countOid == 3) {
		  	while ($init <= $int) {
				$ugly_oids{$init++} = "1.3.6.1.2.1.2.2.1.14.".$init;		
			}
			$part = $tot * 2;
			$sumLine = 0 + $part;
		  }					#end if for countOid 3 ifInErrors

		if ($countOid == 4) {
					while ($init <= $int) {
						$ugly_oids{$init++} = "1.3.6.1.2.1.2.2.1.20.".$init;
					}
					$part = $tot * 3;
					$sumLine = 0 + $part;
				}					#end if for countOid 4 ifOutErrors
		 
				foreach (keys (%ugly_oids)) {
					$ugly_oids{$_} = encode_oid (split (/\./, $ugly_oids{$_}));
					$pretty_oids{$ugly_oids{$_}} = $_;
				}		#end foreach  
				snmp_get($session, keys(%ugly_oids));
			}					#end for each oid

			#-- check new day?

			if (($hour == 00) && ($min == 00)) {
				for ($k = 0; $k < $count; $k++) {
					$avgDay[$k] = $avgMin[$k];
					$sumAvgDay[$k] = $sumAvgDay[$k] + $avgMin[$k];
					$inc[$k] = 0;
				}				#end for
			
				$nMin = 0;	
				$countDay++;
				$countMin = 0;

               


#-- update database
			
		for ($k = 0; $k < $tot; $k++) {
			$inoct = $k;
			$outoct = $k + $tot;
			$inerr = $k + ($tot*2);
			$outerr = $k + ($tot*3);
			
			update_monthtable($mtable,$k,$olddate, 
				$avgDay[$inoct], $avgDay[$outoct], 
				$avgDay[$inerr], $avgDay[$outerr]);	
		
	}				#end for update database
			
#-- check new month?

	if (($dateNo == 01) && ($hour == 00) && ($min == 00)) {
		for ($k = 0; $k < $count; $k++) {
			$avgMon[$k] = $sumAvgDay[$k] / $countDay;
			$sumAvgDay[$k] = 0;
		}			#end for
	$countDay = 0;

#-- update database

		for ($k = 0; $k < $tot; $k++) {
		$inoct = $k;
		$outoct = $k + $tot;
		$inerr = $k + ($tot*2);
		$outerr = $k + ($tot*3);
			
		update_yeartable($ytable,$k, $oldmonth, 
			$avgMon[$inoct], $avgMon[$outoct], 
			$avgMon[$inerr], $avgMon[$outerr]);	
			
}				#end for update database
				
}				#end if check new month
}				#end if check new day

#-- check five minutes for write different for graph

	if ($min % 5 == 0) {

		if ($first == 0) {
			$nMin = ($hour*60)+$min;
			$first = 1;
		} else {
			$nMin = $nMin + 5;
	}				#end else $first
			
			
#-- Update database
			
		for ($k = 0; $k < $tot; $k++) {
		$inoct = $k;
		$outoct = $k + $tot;
		$inerr = $k + ($tot*2);
		$outerr = $k + ($tot*3);
			
		update_table($dtable,$k, $nMin,	$pac[$inoct], 
		$inc[$inoct], $avgMin[$inoct], $diff[$inoct], 
		$pac[$outoct], $inc[$outoct], $avgMin[$outoct], 
		$diff[$outoct], $pac[$inerr], $inc[$inerr], 
		$avgMin[$inerr], $diff[$inerr],	$pac[$outerr], 
		$inc[$outerr], $avgMin[$outerr], $diff[$outerr]);	
			
}				#end for update database
				
			
}                               #end if five minutes
						 
		$countMin++;
}					#end while

$session->close ();

#*************************
#** End of Main Program **
#*************************

sub snmp_get
{
	my($session, @oids) = @_;
	my($response, $bindings, $binding, $value, $oid, $inf);
	grep ($_ = $ugly_oids{$_}, @oids);

# Wait for respond
	if ($session->get_request_response(@oids)) {
			
	($bindings) = $session->decode_get_response ($session->{pdu_buffer});
	$sumPac = 0;
	while ($bindings ne '') {	# round equal number of interface
	  ($binding,$bindings)= decode_sequence($bindings);
	  ($oid,$value)= decode_by_template($binding,"%O%@");
	  $inf = $pretty_oids{$oid};

# keep packet (bytes)	
	  $line = $inf+$part;
	  $pac[$line] = pretty_print($value);
	  $string = $inf." ".pretty_print($value)." ".$date;	  
	  $sumPac = $sumPac + pretty_print($value);
	  if ($countOid == 1)
		  {   $pac[0] = $sumPac;      }	
		  if ($countOid == 2)
		  {	$pac[0+$part] = $sumPac;  }
		  if ($countOid == 3)
		  {	$pac[0+$part] = $sumPac;  }	  
		  if ($countOid == 4)
		  {	$pac[0+$part] = $sumPac;  }	
			 

# find increase : Sa som = old Sa som + packet
			
	  $inc[$line] =  $inc[$line] + pretty_print($value);
	  $incSum = 0;
	  for ($i = 1; $i < $tot; $i++)
	  {	  
		$incSum = $incSum + $inc[$i+$part];
		$inc[$part] = $incSum;		
	  }									#end for
	
# find and keep difference

	for ($i = 0; $i < $tot; $i++)
	{	
		$temp = $i + $part;
		$diff[$temp] = $pac[$temp] - $avgMin[$temp];	
	}
	 
# find and keep Average of Minute
				
	for ($i = 0; $i < $tot; $i++)
	{
		if ($countMin == 0) {
		$avgMin[$i+$part] = $inc[$i+$part];
	}						
	#end if 	 	
	else { 				
	$avgMin[$i+$part] = $inc[$i+$part]/$countMin; 		
	}	 		#end else

	}	#end for  	
	

	}		#end while
	return 1;
	  } 
  	return 0;    
}			#end sub snmp_get


#********************************************* 
sub table() {		#pass table name and interface 
	my ($name,$int) = @_;
	my ($countint,$mincount,$minute);
			
	$dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);
			
	$dbh->do("create table $name (
		inf int not null, min int not null,
		inoctpac real not null, inoctsum real not null,
		inoctavg real not null, inoctdiff real not null ,
		outoctpac real  not null, outoctsum real not null,
		outoctavg real not null, outoctdiff real not null,
		inerrpac real  not null, inerrsum real  not null,
		inerravg real  not null, inerrdiff real  not null, 
		outerrpac real  not null, outerrsum real  not null,
		outerravg real  not null, outerrdiff real  not null,
		PRIMARY KEY(inf,min))");
			
	$sth = $dbh->prepare("insert into $name (inf,min) 
	values (?,?)");
		for ($countint = 0; $countint <= $int; $countint++) {
		for ($mincount = 0; $mincount < 288; $mincount++) {
			$minute = $mincount*5;
			$sth -> execute ($countint,$minute);	

	}			#end loop for round of minutes
	}			#end loop for interface
		$sth->finish;  
			
		$dbh->disconnect;
}				#end sub table

#*****************************************************
sub update_table() {	#pass table name and 19 values of table
	my($name,$tint,$minute,$val1,$val2,$val3,$val4,$val5,$val6,$val7,
	$val8,$val9,$val10,$val11,$val12,$val13,$val14,$val15,$val16) = @_;	
			
	$dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);
	
	$dbh->do ("update $name set
		inoctpac = $val1,inoctsum = $val2,
		inoctavg = $val3,inoctdiff = $val4, 
		outoctpac= $val5,outoctsum = $val6,outoctavg = $val7,outoctdiff = $val8,
		inerrpac = $val9,inerrsum = $val10,inerravg = $val11,inerrdiff = $val12,
		outerrpac= $val13,outerrsum= $val14,outerravg= $val15,outerrdiff=$val16
		where (inf = $tint) AND (min = $minute)");	

	$dbh->disconnect;
}				#end sub update_table

#**********************************************************

sub monthtable() {		#pass table name and interface 
   	my ($name,$int) = @_;
    my ($countint,$daycount,$day);

    $dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);

    $dbh->do("create table $name (
        inf int not null, day int not null,
        inoctavg real not null, outoctavg real not null ,
        inerravg real not null, outerravg real  not null,
        PRIMARY KEY(inf,day))");

    $sth = $dbh->prepare("insert into $name (inf,day)
        values (?,?)");
    for ($countint = 0; $countint <= $int; $countint++) {
        for ($daycount = 0; $daycount < 31; $daycount++) {
        $day = $daycount+1;
        $sth -> execute ($countint,$day);                    


        }           #end loop for round of days
    }               #end loop for interface
    $sth->finish;

    $dbh->disconnect;

}               #end sub monthtable

#*******************************************************
sub update_monthtable() {	#pass table name and 4 values of table

	my($name,$tint,$date,$val1,$val2,$val3,$val4) = @_;	
			
	$dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);
	
	$dbh->do ("update $name set
		inoctavg = $val1,outoctavg = $val2,
		inerravg = $val3,outerravg = $val4 
		
		where (inf = $tint) AND (day = $date)");	

	$dbh->disconnect;
}				#end sub update_monthtable

#**********************************************************

sub yeartable() {		#pass table name and interface 
    my ($name,$int) = @_;
    my ($countint,$moncount,$mon);

    $dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);

    $dbh->do("create table $name (
        inf int not null, mon int not null,
        inoctavg real not null, outoctavg real not null,
        inerravg real  not null, outerravg real not null,
        PRIMARY KEY(inf,mon))");

    $sth = $dbh->prepare("insert into $name (inf,mon)
        values (?,?)");
    for ($countint = 0; $countint <= $int; $countint++) {
        for ($moncount = 0; $moncount < 12; $moncount++) {
            $mon = $moncount+1;
        $sth -> execute ($countint,$mon);                  

        }           #end loop for round of months
    }               #end loop for interface
    $sth->finish;

    $dbh->disconnect;

}               #end sub yeartable   

#*****************************************************
sub update_yeartable() {	#pass table name and 4 values of table

	my($name,$tint,$monthNo,$val1,$val2,$val3,$val4) = @_;	
			
	$dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);
	
	$dbh->do ("update $name set
		inoctavg = $val1,outoctavg = $val2,
		inerravg = $val3,outerravg = $val4 
		
		where (inf = $tint) AND (mon = $monthNo)");	

	$dbh->disconnect;
}				#end sub update_yeartable

#**********************************************************

sub replace ($$$)       # pass number of line, log file, new string
{
my ($templine) = shift;
my ($tempfile) = shift;
my ($new) = shift;
my ($count,$line) = 0;

open (REFILE,"$CONFIG_DIR$LOG");
@logbuffer = <REFILE>;
close (REFILE);
$count = @logbuffer;

open (REFILE2,">$CONFIG_DIR$LOG");

for ($line = 0; $line < $count; $line++) {
	if ($line == $templine) {
		$logbuffer[$line] = $new;
	}			#end if = 
	print REFILE2 "$logbuffer[$line]";

}				#end for
close (REFILE2);

}						#end sub replace
#*****************************************
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

sub kill_process ()
{
	open (KFILE,"$CONFIG_DIR$LOG");
	@bufconf = <KFILE>;
	close (KFILE);

	open (KFILE2,">$CONFIG_DIR$LOG");
	foreach (@bufconf) {
		if ($_ !~ /$host/) {
			print KFILE2 $_;
		}			#end if	
	}				#end for $bufcount 
	close (KFILE2);
	
	$delfile1 = $host.'.day';
	$delfile2 = $host.'.mon';
	$delfile3 = $host.'.yrs';
	
	$delete1 = "$CONFIG_DIR$delfile1";
	$delete2 = "$CONFIG_DIR$delfile2";
	$delete3 = "$CONFGI_DIR$delfile3";
	

	delete_file($delete1);
	delete_file($delete2);
	delete_file($delete3);
	
	
	
	$dbh = DBI->connect("DBI:mysql:rtmt", $LOGIN_NAME, $LOGIN_PASSWD);
	
	$dbh->do("drop table $dtable");
	$dbh->do("drop table $mtable");
	$dbh->do("drop table $ytable");
	$dbh->do("delete from ip where ip = \"$host\" "); 
	
	$dbh->disconnect;
	
	
	die;
}				#end sub kill process

#***********************************************

sub delete_file()
{
	my($file_name) = @_;
	my($i) = (0);
	if (-e $file_name) {
		while ((unlink $file_name) && $i<5){
			sleep(1);
			$i++;
		}
	}
}			#end sub delete_file

#***********************************************
