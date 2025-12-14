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
$msgQ = "INSERT INTO book VALUES ('temp','1234','0')";
$Bqr = $dbh->query($msgQ);
$msgQ = "SELECT _timestamp FROM book WHERE id = 'temp'";
$Bqr = $dbh->query($msgQ);
($times) = $Bqr->fetchrow;
$times -= 259200;
$msgQ = "DELETE FROM book WHERE (status = '0') and ( _timestamp <
$times)";
$Bqr = $dbh->query($msgQ);
$msgQ = "DELETE FROM book WHERE id = 'temp'";
$Bqr = $dbh->query($msgQ);

$Sn = $Sn = $ENV{'QUERY_STRING'};
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "<form method='POST' name='LogOnForm' action='/cgi-bin/esl_lib/PassCheck.pl?$Sn'>\n";

$msgQ = "SELECT id FROM book where _timestamp < $times";
$Bqr = $dbh->query($msgQ);
print "$msgQ <br>";
while ( $xxxx = $Bqr->fetchrow)
{
print "$xxxx<br>";
}
print "$times<br>";

print "  <div align='center'><center><table border='1' width='40%'\n";
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
