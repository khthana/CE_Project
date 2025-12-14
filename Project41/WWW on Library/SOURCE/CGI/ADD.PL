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
$msgQ = "SELECT code, c_name  from copy";
$Bqr = $dbh->query($msgQ);
($code, $c_name) = $Bqr->fetchrow;

print "Content-Type:text/html\n\n";
print "<html>\n";
print "\n";
print "<head>\n";
print "<title>Add</title>\n";
print "</head>\n";
print "\n";
print "<body bgcolor='#3D7A7A' text='#FFFFFF'>\n";
print "\n";
print "<form ACTION='/cgi-bin/esl_lib/AddBook.pl' METHOD='POST'\n";
print "NAME='marquee1'>\n";
print "  <p><big><strong>เลขหมู่ </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  <select SIZE='1' NAME='S_G' tabindex='1'>\n";
print "    <option selected value='301'> 301 Economic </option>\n";
print "    <option value='302'> 302 Education </option>\n";
print "    <option value='303'> 303 Religion&Philosophy </option>\n";
print "    <option value='304'> 304 Misc </option>\n";
print "    <option value='601'> 601 Application Software </option>\n";
print "    <option value='602'> 602 Artificial Inteligent </option>\n";
print "    <option value='603'> 603 Computer Design </option>\n";
print "    <option value='604'> 604 DataBase </option>\n";
print "    <option value='605'> 605 Data Structure </option>\n";
print "    <option value='606'> 606 Device </option>\n";
print "    <option value='607'> 607 Internet </option>\n";
print "    <option value='608'> 608 Microprocesser </option>\n";
print "    <option value='609'> 609 Multimedia&Graphic </option>\n";
print "    <option value='610'> 610 Network </option>\n";
print "    <option value='611'> 611 Object Oriented </option>\n";
print "    <option value='612'> 612 Operating System </option>\n";
print "    <option value='613'> 613 Programming Language </option>\n";
print "    <option value='614'> 614 Security </option>\n";
print "    <option value='615'> 615 Software Engineering </option>\n";
print "    <option value='616'> 616 Misc </option>\n";
print "  </select> </big></p>\n";
print "  <p><big><strong>เลขทะเบียน&nbsp;</strong>&nbsp; <font color='#FF8000'>&nbsp;&nbsp;&nbsp;&nbsp;</font></big>\n";

$IndexOfBook = 1;
$strIndex = "0001";
$msgQ = "SELECT s_n  from maintable where s_n = '0001'";
$Bqr = $dbh->query($msgQ);
while (  $strtemp = $Bqr->fetchrow )
{      
    $IndexOfBookT = $IndexOfBook ++ ;
    $idx = $IndexOfBookT % 10;
    $IndexOfBookT /= 10;
    $idxx = $IndexOfBookT % 10;
    $IndexOfBookT /= 10;
    $idxxx = $IndexOfBookT % 10;
    $IndexOfBookT /= 10;
    $idxxxx = $IndexOfBookT % 10;
    $strIndex = "$idxxxx$idxxx$idxx$idx";
    $msgQ = "SELECT s_n  from maintable where s_n = '$strIndex'";
    $Bqr = $dbh->query($msgQ);
}

print "  $strIndex <input TYPE='hidden' SIZE='6' NAME='S_N' VALUE = '$strIndex'> </p>\n";

print "  <p><big><strong>ชื่ออุปกรณ์&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp;&nbsp;&nbsp;&nbsp; <input TYPE='text' SIZE='60' NAME='NAME'\n";
print "  tabindex='2'> </small></p>\n";
print "  <p><big><strong>ประเภท</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </big><small>&nbsp;\n";
print "  <select LANGUAGE='JavaScript' SIZE='1' NAME='TYPE' tabindex='3'>\n";
print "    <option selected value='TB'> Thai Book </option>\n";
print "    <option value='EB'> Text Book </option>\n";
print "    <option value='CD'> CD_ROM </option>\n";
print "    <option value='TA'> Tape </option>\n";
print "    <option value='VD'> VDO </option>\n";
print "    <option value='DK'> Disk </option>\n";
print "  </select> </small></p>\n";
print "  <p><big><strong>ส่วนขยายไทย </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp; <input TYPE='text' SIZE='59' NAME='DF_T' tabindex='4'> </small></p>\n";
print "  <p><big><strong>ส่วนขยายอังกฤษ</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp;&nbsp;&nbsp; <input TYPE='text' SIZE='58' NAME='DF_E' tabindex='5'> </small></p>\n";
print "  <p><big><strong>ชื่อผู้แต่ง </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp;&nbsp; <input TYPE='text' SIZE='40' NAME='NAME_A' tabindex='6'> </small></p>\n";
print "  <p><big><strong>สำนักพิมพ์</strong> </big><small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </small><select name='C_CODE' size='1'>\n";
print "    <option selected value='$code'> $c_name</option>\n";

while (($code, $c_name) = $Bqr->fetchrow)
{
print "    <option  value='$code'> $c_name</option>\n";
}
print "  </select><small> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <+++++++ </small> </small><a\n";
print "  href='/ESL/library/Admin/AddCopy.html'><big><big>New</big></big></a></p>\n";
print "  <p><big><strong>วันที่ซื้อ</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='8' NAME='B_DATE' tabindex='9'> </small></p>\n";
print "  <p><big><strong>ที่มา</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='20' NAME='HOW_GET' tabindex='10'> </small></p>\n";
print "  <p><big><strong>ราคา </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='8' NAME='PRICE' tabindex='11'> </small></p>\n";
print "  <p><big><strong>จำนวนหน้า</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </big><small><input\n";
print "  TYPE='text' SIZE='4' NAME='NUMPAGE' tabindex='12'> </small></p>\n";
print "  <p><big><strong>ปีที่พิมพ์ </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='4' NAME='YEAR_PRINT' tabindex='13'> </small></p>\n";
print "  <p><big><big><big><big>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</big></big></big></big>\n";
print "  <p><big><strong>สถานะ </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  <select SIZE='1' NAME='STATUS' tabindex='1'>\n";
print "    <option selected value='0'> ยังอยู่ </option>\n";
print "    <option value='1'> หาย </option>\n";
print "  </select> </big></p>\n";
print "  <input TYPE='submit' VALUE='Submit' NAME='B1'> <big>&nbsp;&nbsp; </big>&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  <input TYPE='reset' VALUE='Reset' NAME='B2'> </p>\n";
print "</form>\n";
print "</body>\n";
print "</html>\n";

