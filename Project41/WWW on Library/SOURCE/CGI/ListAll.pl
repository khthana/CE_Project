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
$msgQ = "DELETE FROM book WHERE _timestamp < $times and status = '0'";
$Bqr = $dbh->query($msgQ);
$msgQ = "DELETE FROM book WHERE id = 'temp'";
$Bqr = $dbh->query($msgQ);

$dbh = Msql->connect;
$dbh->selectdb('Library');
$msgQ = "INSERT INTO book VALUES ('temp','1234','0')";
$Bqr = $dbh->query($msgQ);
$msgQ = "SELECT _timestamp FROM book WHERE id = 'temp'";
$Bqr = $dbh->query($msgQ);
($times) = $Bqr->fetchrow;
$times -= 604800;
$msgQ = "DELETE FROM book WHERE id = 'temp'";
$Bqr = $dbh->query($msgQ);

print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";
print "<body  bgcolor='#99CCFF'>\n";
$msgQ = "SELECT DISTINCT book.id, passwd.name,  passwd.sname, book._timestamp  from book, passwd where book.id = passwd.id and  book.status = '1'";
$Bqr = $dbh->query($msgQ);

print "<big><center> อยู่ในกำหนด <br><div align='center'><center><table border='1' width='40%'>";
while (@arr = $Bqr->fetchrow)
{
  ($id,$name,$sname,$x) = @arr;
  if ($x >= $times)
  {
  print "<tr><td><center><a href = /cgi-bin/esl_lib/Log.pl?$id>$id</a></center></td><td><center>$name</center></td><td><center>$sname</center></td></tr>";
  }
}
print "</table></div></big>";

$msgQ = "SELECT DISTINCT book.id, passwd.name,  passwd.sname , book._timestamp from book, passwd where book.id = passwd.id and  book.status = '1'";
$Bqr = $dbh->query($msgQ);

print "<big><center> เกินกำหนด <br><div align='center'><center><table border='1' width='40%'>";
while (@arr = $Bqr->fetchrow)
{
  ($id,$name,$sname) = @arr;
  if ($x < $times)
  {
  print "<tr><td><center><a href = /cgi-bin/esl_lib/Log.pl?$id>$id</a></center></td><td><center>$name</center></td><td><center>$sname</center></td></tr>";
  }
}
print "</table></div></big>";

print "</body>\n";
print "</html>";

