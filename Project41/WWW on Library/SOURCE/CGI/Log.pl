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

$xxx = $ENV{'QUERY_STRING'};  
$dbh = Msql->connect;
$dbh->selectdb('Library');

$msgQ = "SELECT id, name, sname, passwd from passwd WHERE id = '$xxx'";
$Bqr = $dbh->query($msgQ);
($id,$name,$sname,$pass) = $Bqr->fetchrow;
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";
print "<body>\n";
print "<B><FONT SIZE=+1>Login Name(ID) is <FONT COLOR='#FF0000'>$id</FONT></FONT></B>\n";
print "<BR><B><FONT SIZE=+1>Full Name  is <FONT COLOR='#FF0000'>$name</FONT></FONT></B>\n";
print "<BR><B><FONT SIZE=+1>SurName    is <FONT COLOR='#FF0000'>$sname</FONT></FONT></B>\n";

print "<hr>\n";
print "<BR><B><FONT SIZE=+1>Booked book</FONT></B>\n";

$msgQ = "SELECT s_n from book WHERE status = '0' AND id = '$id'";
$Bqr = $dbh->query($msgQ);
($s_n) = $Bqr->fetchrow;

if ($s_n eq "")
{
  print "<br><B><FONT COLOR = '#FF0000' SIZE=+1>(None)</FONT></B>\n";
}
else
{
while ($s_n ne "") 
{
  $msgQ = "SELECT name, type from maintable WHERE s_n = '$s_n'";
  $BqrN = $dbh->query($msgQ); 
  ($name,$type) = $BqrN->fetchrow;

 if ( $type eq "CD" )
 {
   $qtype = "CD-ROM";
 }
 elsif ( $type eq "VD" )
 {
   $qtype = "VDO";
 }
 elsif ( $type eq "TP" )
 {
   $qtype = "TAPE";
 }
 elsif ( $type eq "TB" )
 {
   $qtype = "Thai Book";
 }
 elsif ( $type eq "EB" )
 {
   $qtype = "English Book";
 }
 elsif ( $type eq "DK" )
 {
   $qtype = "Disk";
 }
 else 
 { 
   $qtype = $type;
 }

  print ("<br>           $s_n    $name   ($qtype)");
  ($s_n) = $Bqr->fetchrow;
}
}

print "<hr>\n";
print "<BR><B><FONT SIZE=+1>The book is you</FONT></B>\n";

$msgQ = "SELECT s_n from book WHERE status = '1' AND id = '$id'";
$Bqr = $dbh->query($msgQ);
($s_n) = $Bqr->fetchrow;

if ($s_n eq "")
{
  print "<br><B><FONT COLOR = '#FF0000' SIZE=+1>(None)</FONT></B>\n";
}
else
{
while ($s_n ne "") 
{
  $msgQ = "SELECT name, type from maintable WHERE s_n = '$s_n'";
  $BqrN = $dbh->query($msgQ); 
  ($name,$type) = $BqrN->fetchrow;

 if ( $type eq "CD" )
 {
   $qtype = "CD-ROM";
 }
 elsif ( $type eq "VD" )
 {
   $qtype = "VDO";
 }
 elsif ( $type eq "TP" )
 {
   $qtype = "TAPE";
 }
 elsif ( $type eq "TB" )
 {
   $qtype = "Thai Book";
 }
 elsif ( $type eq "EB" )
 {
   $qtype = "English Book";
 }
 elsif ( $type eq "DK" )
 {
   $qtype = "Disk";
 }
 else 
 { 
   $qtype = $type;
 }

  print ("<br>           $s_n    $name   ($qtype)");
  ($s_n) = $Bqr->fetchrow;
}
}

print "<br><br><center><a href = '/ESL/library/PassChange.html'>Change Password</a></center>\n";
print "</body>\n";
print "</html>";
