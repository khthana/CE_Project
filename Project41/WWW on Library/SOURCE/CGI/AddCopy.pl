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
$msgQ = "INSERT INTO copy VALUES ( '$FORM{'CODE'}', '$FORM{'C_NAME'}', '$FORM{'C_ADR'}' ) ";
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
print "<form ACTION='' METHOD='POST'\n";
print "<h1>New Copy Ok</h1>\n";
print "\n";
print "<p><input  LANGUAGE='VBScript' TYPE='button' VALUE='Continue' ONCLICK='history.go(-2)' NAME='B1'> </p>";
print "</form>\n";
print "</body>\n";
print "</html>\n";