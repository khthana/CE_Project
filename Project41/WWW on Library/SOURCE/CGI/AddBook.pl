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
$msgQ = "INSERT INTO maintable VALUES ( '$FORM{'S_G'}', '$FORM{'S_N'}', " .
                "'$FORM{'NAME'}', '$FORM{'TYPE'}', ".
	"'$FORM{'DF_T'}', '$FORM{'DF_E'}', " .
	"'$FORM{'NAME_A'}', '$FORM{'C_CODE'}', " .
	"'$FORM{'B_DATE'}', '$FORM{'HOW_GET'}', " .
	"'$FORM{'PRICE'}', '$FORM{'NUMPAPGE'}', " .
	"'$FORM{'YEAR_PRINT'}', '$FORM{'STATUS'}', '$FORM{'S_N'}.gif' ) ";
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
print "<h1> UpLoad File</h1>\n";
print "\n";
print "<p>Picture Of The Book or Other</p>\n";
print "\n";
print "<form METHOD='POST' ENCTYPE='multipart/form-data' ACTION='/cgi-bin/esl_lib/Load.pl'>\n";
print "  <table>\n";
print "    <tr>\n";
print "      <td>File Name: </td>\n";
print "      <td><input TYPE='file' NAME='file' SIZE='35'> </td>\n";
print "    </tr>\n";
print "    <tr>\n";
print "      <td></td>\n";
print "      <td><input TYPE='submit' NAME='UPLOAD' VALUE='UPLOAD'></td>\n";
print "    </tr>\n";
print "  </table>\n";
print "</form>\n";
print "</body>\n";
print "</html>\n";