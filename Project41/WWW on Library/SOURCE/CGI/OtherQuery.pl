#!/usr/bin/perl
use Msql;

read(STDIN,$buffer,$ENV{'CONTENT_LENGTH'});
@pairs=split(/&/,$buffer);
$size=@pairs;

foreach $pair(@pairs){
  ($name,$value) = split(/=/,$pair);
  # Un-Webify plus signs and %-encoding
  $value=~tr/+/ /;
  $value=~s/%([a-fA-F0-9][a-fA-F0-9])/pack("C",hex($1))/eg;
  $FORM{$name} = $value;
}

  
$dbh = Msql->connect;
$dbh->selectdb('Library');

$sel  = "";
$sel1 = "";
$sel2 = "";
$sel3 = "";
$sel4 = "";
$sel5 = "";
$si1 = 0;
$si2 = 0;
$si3 = 0;

$type = $FORM{'D1'};
if ( $type eq "CD-ROM" )
{
   $qtype = "CD";
}
if ( $type eq "VDO" )
{
   $qtype = "VD";
}
if ( $type eq "TAPE" )
{
   $qtype = "TP";
}
if ( $type eq "Disk" )
{
   $qtype = "D%";
}

if ( $FORM{'C1'})
{
  $sel1 =  "maintable.s_g  = '$FORM{'S_G'}' ";
  $sel = $sel . $sel1;
  $si1 = 1;
}

if ($FORM{'C2'})
{
   $sel2 =  "maintable.s_n  clike '$FORM{'T3'}%' ";
   if ( $si1 == 1 ) {  $sel = "$sel AND $sel2"; }
   else {  $sel = $sel . $sel2; }
   $si2 = 1;
}
if ($FORM{'C3'})
{
   $name_temp = $FORM{'T3'};
   @strmname=split(/ /,$name_temp);
   $localflag = 0;
  foreach $strmbuffer( @strmname )
    { 
       if ($localflag == 0)
          {
            $localflag = 1;
            $sel3 = "maintable.name clike '%$strmbuffer%' ";
          }
       else
         {
           $sel3 .= " and maintable.name clike '%$strmbuffer%' ";
         }
    }
   if ( ($si1 == 1)||($si2 == 1) ) {  $sel = "$sel AND $sel3"; }
   else {  $sel = $sel . $sel3; }
   $si3 = 1;
}

$msgQ = "SELECT maintable.s_g, maintable.s_n, maintable.name, copy.c_name FROM copy, maintable";

if ( ($si1 == 1)||($si2 == 1)||($si3 == 1) )
{
  $msgQ = "$msgQ WHERE maintable.c_code = copy.code AND maintable.type like '$qtype' AND $sel";
}
else
{
  $msgQ = "$msgQ WHERE maintable.c_code = copy.code AND maintable.type like '$qtype'";
}


$Bqr = $dbh->query($msgQ);

print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";
print "<body>\n";
print "<br><br>";

print "<TABLE BORDER COLS=5 WIDTH='100%' BGCOLOR='#CCFFFF' >";
print "<TR>";
print "<TD WIDTH='40' HEIGHT='20'>";
print "<CENTER>Group</CENTER>";
print "</TD>";

print "<TD WIDTH='40' HEIGHT='20'>";
print "<CENTER>Code</CENTER>";
print "</TD>";

print "<TD WIDTH='200'>";
print "<CENTER>Name of Book</CENTER>";
print "</TD>";

print "<TD WIDTH='200'>";
print "<CENTER>Copy</CENTER>";
print "</TD>";
print "</TR>";

while (@arr = $Bqr->fetchrow )
{
  ($Sg,$Sn,$Name, $Cc) = @arr;

$msgQ_yoot = "SELECT status FROM maintable WHERE s_n = '" . $Sn . "'";
$Bqr_yoot = $dbh->query($msgQ_yoot);
$status =  $Bqr_yoot->fetchrow;

if ($status == 0) 
{
print "<TR>";
print "<TD WIDTH='40' HEIGHT='20'>";
print "<CENTER><a href='/cgi-bin/esl_lib/ShowB.pl?$Sn'>$Sg</CENTER>";
print "</TD>";

print "<TD WIDTH='40' HEIGHT='20'>";
print "<CENTER><a href='/cgi-bin/esl_lib/ShowB.pl?$Sn'>$Sn</CENTER>";
print "</TD>";

print "<TD WIDTH='200'>";
print "<CENTER><a href='/cgi-bin/esl_lib/ShowB.pl?$Sn'>$Name</CENTER>";
print "</TD>";

print "<TD WIDTH='200'>";
print "<CENTER><a href='/cgi-bin/esl_lib/ShowB.pl?$Sn'>$Cc</CENTER>";
print "</TD>";
print "</TR>";
}
}  
print "</TABLE>";
print "</body>\n";
print "</html>";

