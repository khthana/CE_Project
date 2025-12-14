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
$msgQ = "SELECT passwd from passwd WHERE id = '$FORM{'ID'}'";
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
print "User $FORM{'ID'} is not exists <a href = '/ESL/library/Admin/Add_Form.html'>Back</a>\n"; 
print "</body>\n";
print "</html>";
}
else
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";print "</head>\n";



print "<body  background='/ESL/library/user2.jpg'>\n";


print "User $FORM{'ID'} is Deleted\n";
print "</body>\n";
$msgQ = "DELETE FROM passwd WHERE id = '$FORM{'ID'}'";
$Bqr = $dbh->query($msgQ);
print "</html>"; 
}
