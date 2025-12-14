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

print "Content-Type:text/html\n\n";
print "<html>\n";
print "<head>\n";
print "   <title>ESL Laboratory</title>\n";
print "</head>\n";

print "<body  bgcolor = '99CCFF'>\n";

$Sn = $ENV{'QUERY_STRING'};
$dbh = Msql->connect;
$dbh->selectdb('Library');
$msg = "SELECT * FROM maintable WHERE maintable.s_n = '$Sn'";
$Bqr = $dbh->query($msg);
@list = $Bqr->fetchrow;
($s_g,$s_n,$name,$type,$df_t,$df_e,$name_a,$c_code,$b_date,$how_get,$price,$numpage,$year_print,$status,$pic) = @list;

print "<form method='POST' action='/cgi-bin/esl_lib/BookBook.pl?$Sn'>";
print " <p><img src='/ESL/library/img/$pic'>";
$msg = "SELECT s_n FROM book WHERE s_n = '$Sn'";
$Bqr = $dbh->query($msg);
if ( $xxx = $Bqr->fetchrow )
{
print " <input type='button' value='Back' name='Booked' onclick = 'history.go(-1)'>";
}
else
{
print " <input type='submit' value='Book' name='Booked'>";
}
print "  </p><p><strong><big><u>No.</u>&nbsp; <font color='#FF00FF'>$s_g-$s_n</font></big></strong></p>";
print "  <p><strong><big><u>The book's name is</u>&nbsp; <font color='#0000FF'>$name</font></big></strong></p>";
print "  <p><big><strong><u>Type</u> <font color='#FF0000'>$type</font></strong></big></p>";
print "  <p><big><strong><u>Author</u>&nbsp; <font color='#0000FF'>$name_a</font></strong></big></p>";

if ($c_code == "none")
{
print "  <p><big><strong><u>Print</u>&nbsp; $c_code</strong></big></p>";
}
else
{
$msgC = "SELECT c_name, c_adr FROM copy WHERE  code = '$c_code'";
$BqrC = $dbh->query($msgC);
($c_name, $c_adr) = $BqrC->fetchrow;  
print "  <p><big><strong><u>Print</u>&nbsp; $c_name * Address $c_adr *</strong></big></p>";
}

print "  <p><big><strong><u>Num of page</u>&nbsp; $numpage &nbsp;";
print " <u>Year on print</u>&nbsp; $year_print</strong></big></p>";
print "  <p><big><strong><u>Status</u>&nbsp; Available</strong></big></p>";
print "  <p><big><strong><u>Comment</u> :- </strong></big></p>";
print "  <p><big><strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; $df_e.</strong></big></p>";
print "</form>";
print "</body>\n";

print "</html>"; 
