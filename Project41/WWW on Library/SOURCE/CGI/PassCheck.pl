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

$Sn = $Sn = $ENV{'QUERY_STRING'};
  
$dbh = Msql->connect;
$dbh->selectdb('Library');
$msgQ = "SELECT passwd from passwd WHERE id = '$FORM{'UNAME'}'";
$Bqr = $dbh->query($msgQ);
$pass = $Bqr->fetchrow;

$msgQ = "SELECT id FROM book WHERE id = '$FORM{'UNAME'}'";
$Bqr = $dbh->query($msgQ);
$count = 0;
while(($id) = $Bqr->fetchrow)
{
  $count++;
}

if ( $count >= 3)
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "<meta http-equiv='refresh' content='3; url=/ESL/library/frame2.html'>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "<H1>Can't Book, Plase wait...</H1>";
print "</body>\n";

print "</html>";   
}
elsif ($pass eq "")
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "<form method='POST' name='LogOnForm' action='/cgi-bin/esl_lib/PassCheck.pl?$Sn'>\n";
print "  <div align='center'>Login Name is incorrect!<br><center><table border='1' width='40%'\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>LoginName</td>\n";
print "      <td width='61%' align='center'><input type='text' name='UNAME' size='20'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='PASSWORD' size='20'></td>\n";
print "    </tr>\n";
print "  </table>\n";
print "  </center></div><div align='center'><center><p><input type='submit' value='Submit'\n";
print "  name='B1'><input type='reset' value='Reset' name='B2'></p>\n";
print "  </center></div>\n";
print "</form>\n";
print "</body>\n";

print "</html>"; 
}
elsif ($pass eq $FORM{'PASSWORD'})
{
$msgQ = "SELECT * from passwd WHERE id = '$FORM{'UNAME'}'";
$Bqr = $dbh->query($msgQ);
($id,$name,$sname,$pass) = $Bqr->fetchrow;

$msgQ = "INSERT INTO book VALUES ('$id','$Sn','0')";
$Bqr = $dbh->query($msgQ);

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
   $qtype = "Unknown";
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
   $qtype = "Unknown";
 }

  print ("<br>           $s_n    $name   ($qtype)");
  ($s_n) = $Bqr->fetchrow;
}
}

print "</body>\n";
print "</html>";
}
else
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "<form method='POST' name='LogOnForm' action='/cgi-bin/esl_lib/PassCheck.pl'>\n";
print "  <div align='center'>Password is incorrect!<br><center><table border='1' width='40%'\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>LoginName</td>\n";
print "      <td width='61%' align='center'><input type='text' name='UNAME' size='20' value = '$FORM{'UNAME'}'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='PASSWORD' size='20'></td>\n";
print "    </tr>\n";
print "  </table>\n";
print "  </center></div><div align='center'><center><p><input type='submit' value='Submit'\n";
print "  name='B1'><input type='reset' value='Reset' name='B2'></p>\n";
print "  </center></div>\n";
print "</form>\n";
print "</body>\n";

print "</html>";
}