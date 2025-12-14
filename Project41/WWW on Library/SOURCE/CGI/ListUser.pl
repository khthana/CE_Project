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
$msgQ = "SELECT id, name, sname  from passwd";
$Bqr = $dbh->query($msgQ);

print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";
print "<body  bgcolor='#99CCFF'>\n";
print "<big> <div align='center'><center><table border='1' width='40%'>";
while (@arr = $Bqr->fetchrow)
{
  ($id,$name,$sname) = @arr;
  print "<tr><td><center><a href = /cgi-bin/esl_lib/Log.pl?$id>$id</a></center></td><td><center>$name</center></td><td><center>$sname</center></td></tr>";
}
print "</table></div></big>";
print "</body>\n";
print "</html>";

