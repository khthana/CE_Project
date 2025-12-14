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

$IndexOfCopy = 1;
$strIndex = "0001";
$msgQ = "SELECT code  from copy where code = '0001'";
$Bqr = $dbh->query($msgQ);
while (  $strtemp = $Bqr->fetchrow )
{      
    $IndexOfCopyT = $IndexOfCopy ++ ;
    $idx = $IndexOfCopyT % 10;
    $IndexOfCopyT /= 10;
    $idxx = $IndexOfCopyT % 10;
    $IndexOfCopyT /= 10;
    $idxxx = $IndexOfCopyT % 10;
    $IndexOfCopyT /= 10;
    $idxxxx = $IndexOfCopyT % 10;
    $strIndex = "$idxxxx$idxxx$idxx$idx";
    $msgQ = "SELECT code from copy where code = '$strIndex'";
    $Bqr = $dbh->query($msgQ);
}


print "Content-Type:text/html\n\n";
print "<html>\n";
print "\n";
print "<head>\n";
print "<title>New Page 2</title>\n";
print "</head>\n";
print "\n";
print "<body>\n";
print "\n";
print "<p><big><big>Add <strong>สำนักพิมพ์</strong></big></big></p>\n";
print "\n";
print "<form method='POST' action='/cgi-bin/esl_lib/AddCopy.pl'>\n";
print "  <div align='left'><p><big><big>Code&nbsp;&nbsp; </big></big>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  $strIndex <input type='hidden' name='CODE' size='8' value='$strIndex'></p>\n";
print "  </div><div align='left'><p><big><big>Name&nbsp;&nbsp; </big></big><small><small><small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  <input type='text' name='C_NAME' size='60'></small></small></small></p>\n";
print "  </div><div align='left'><p><big><big>Address&nbsp;&nbsp; </big></big><small><small><small>\n";
print "  <input type='text' name='C_ADR' size='100'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \n";
print "  <input type='submit' value='Submit' name='B1'>&nbsp;&nbsp;&nbsp; <input type='reset'";
print "  value='Reset' name='B2'></small></small></small></p>\n";
print "  </div>\n";
print "</form>\n";
print "</body>\n";
print "</html>\n";
