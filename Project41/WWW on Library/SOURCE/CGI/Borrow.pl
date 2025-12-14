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
$msgQ = "SELECT status  from book WHERE id = '$FORM{'ID'}' and s_n = '$FORM{'S_N'}' ";
$Bqr = $dbh->query($msgQ);
$pass = $Bqr->fetchrow;

if ($pass eq "")
{

$msgQ = "SELECT status  from book WHERE s_n = '$FORM{'S_N'}' ";
$Bqr = $dbh->query($msgQ);
if ($pass = $Bqr->fetchrow)
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";
print "<body bgcolor ='#FFBB55'>\n";
print "This book is booked <a href = '/ESL/library/Admin/Borrow.html'>Back</a>\n"; 
print "</body>\n";
print "</html>";
}
else
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";print "</head>\n";
print "<body bgcolor ='#FFBB55'>\n";
print "Now You Borrow. OK!\n";
print "</body>\n";
$msgQ =  "INSERT INTO book VALUES ('$FORM{'ID'}',  '$FORM{'S_N'}', '1')";
$Bqr = $dbh->query($msgQ);
print "</html>"; 
}
}
elsif ( $pass eq "0" )
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";print "</head>\n";
print "<body bgcolor ='#FFBB55'>\n";
print "Now You Borrow. OK!\n";
print "</body>\n";
$msgQ = "UPDATE book SET status = '1'  WHERE id = '$FORM{'ID'}' and s_n = '$FORM{'S_N'}' ";
$Bqr = $dbh->query($msgQ);
print "</html>"; 
}
else
{
print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";
print "<body bgcolor ='#FFBB55'>\n";
print "You must Back before. <a href = '/ESL/library/Admin/Borrow.html'>Back</a>\n"; 
print "</body>\n";
print "</html>";
}