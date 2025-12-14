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
$msgQ = "SELECT passwd from passwd WHERE id = '$FORM{'UNAME'}'";
$Bqr = $dbh->query($msgQ);
$pass = $Bqr->fetchrow;

if ($pass eq "")
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "<form method='POST' name='LogOnForm' action='/cgi-bin/esl_lib/PassChange.pl'>\n";
print "  <div align='center'>Login Name is incorrect!<br><center><table border='1' width='40%'\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>LoginName</td>\n";
print "      <td width='61%' align='center'><input type='text' name='UNAME'  value ='$FORM{'UNAME'}' size='8'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Old Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='PASSWORD' value ='$FORM{'PASSWORD'}' size='8'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>New Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='NPASSWORD'  size='8'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Retype Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='MPASSWORD' size='8'></td>\n";
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
  if ($FORM{'MPASSWORD'} ne $FORM{'NPASSWORD'})
  {
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "<form method='POST' name='LogOnForm' action='/cgi-bin/esl_lib/PassChange.pl'>\n";
print "  <div align='center'>Not macth New Password<br><center><table border='1' width='40%'\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>LoginName</td>\n";
print "      <td width='61%' align='center'><input type='text' name='UNAME'  value ='$FORM{'UNAME'}' size='8'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Old Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='PASSWORD' value ='$FORM{'PASSWORD'}' size='8'></td>\n";
print "    </tr>\n";print "    <tr>\n";
print "      <td width='39%' align='center'>New Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='NPASSWORD' size='8'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Retype Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='MPASSWORD' size='8'></td>\n";
print "    </tr>\n";print "  </table>\n";
print "  </center></div><div align='center'><center><p><input type='submit' value='Submit'\n";
print "  name='B1'><input type='reset' value='Reset' name='B2'></p>\n";
print "  </center></div>\n";
print "</form>\n";
print "</body>\n";

print "</html>"; 
  }
  else
  {
     $msgQ = "UPDATE passwd SET passwd = '$FORM{'NPASSWORD'}' WHERE id = '$FORM{'UNAME'}'";
     $Bqr = $dbh->query($msgQ);
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "  $Mqr           Password Changed\n";
print "</body>\n";

print "</html>"; 
  }
}
else
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  background='/ESL/library/user2.jpg'>\n";
print "<form method='POST' name='LogOnForm' action='/cgi-bin/esl_lib/PassChange.pl'>\n";
print "  <div align='center'>Password is incorrect!<br><center><table border='1' width='40%'\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>LoginName</td>\n";
print "      <td width='61%' align='center'><input type='text' name='UNAME'  value ='$FORM{'UNAME'}' size='8'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Old Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='PASSWORD' value ='$FORM{'PASSWORD'}' size='8'></td>\n";
print "    </tr>\n";print "    <tr>\n";
print "      <td width='39%' align='center'>New Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='NPASSWORD' size='8'></td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td width='39%' align='center'>Retype Password</td>\n";
print "      <td width='61%' align='center'><input type='password' name='MPASSWORD' size='8'></td>\n";
print "    </tr>\n";
print "  </table>\n";
print "  </center></div><div align='center'><center><p><input type='submit' value='Submit'\n";
print "  name='B1'><input type='reset' value='Reset' name='B2'></p>\n";
print "  </center></div>\n";
print "</form>\n";
print "</body>\n";

print "</html>";
}