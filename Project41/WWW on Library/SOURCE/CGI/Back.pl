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
$msgQ = "SELECT id from book WHERE id = '$FORM{'ID'}' and s_n = '$FORM{'S_N'}' and status = '1' ";
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
print "You're Never Borrow <a href = '/ESL/library/Admin/Borrow.html'>Back</a>\n"; 
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
print " <Big>";

$msgQ = "SELECT _timestamp FROM book  WHERE id = '$FORM{'ID'}' and s_n = '$FORM{'S_N'}'  ";
$Bqr = $dbh->query($msgQ);
$x = $Bqr->fetchrow;

$msgQ = "INSERT INTO book VALUES ('temp','1234','0')";
$Bqr = $dbh->query($msgQ);

$msgQ = "SELECT _timestamp FROM book";
$Bqr = $dbh->query($msgQ);
$y = $Bqr->fetchrow;

$day  = int((int($y)-int($x))/86400) + 1;

$msgQ = "DELETE FROM book WHERE id = 'temp'";
$Bqr = $dbh->query($msgQ);

print "You Borrow at $day </Big>";
$msgQ = "DELETE from book WHERE id = '$FORM{'ID'}' and s_n = '$FORM{'S_N'}' ";
$Bqr = $dbh->query($msgQ);
print "</body>\n";
print "</html>"; 
}
