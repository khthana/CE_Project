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
$msgQ = "UPDATE maintable SET  s_g =  '$FORM{'S_G'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  pic =  '$FORM{'S_G'}.gif' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);

$msgQ = "UPDATE maintable SET  name =  '$FORM{'NAME'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  df_t =  '$FORM{'DF_T'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  df_e =  '$FORM{'DF_E'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  name_a =  '$FORM{'NAME_A'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  type =  '$FORM{'TYPE'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  c_code =  '$FORM{'C_CODE'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  b_date =  '$FORM{'B_DATE'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  how_get =  '$FORM{'HOW_GET'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  price =  '$FORM{'PRICE'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  numpage =  '$FORM{'NUMPAGE'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  year_print =  '$FORM{'YEAR_PRINT'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
$msgQ = "UPDATE maintable SET  status =  '$FORM{'STATUS'}' WHERE s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);

print "Content-Type:text/html\n\n";
print "<html>\n";
print "\n";
print "<head>\n";
print "<title>Upload Failed</title>\n";
print "</head>\n";
print "\n";
print "<body bgcolor='white'>\n";
print "\n";
print "<h1> UpDate Book</h1>\n";
print "\n";
print "<p>Compelete</p>\n";
print "\n";
print "</body>\n";
print "</html>\n";