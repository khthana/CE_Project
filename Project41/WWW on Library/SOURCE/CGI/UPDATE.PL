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
$msgQ = "SELECT s_g, s_n, name, type, df_t, df_e, name_a, c_code, b_date, how_get, price, numpage, year_print, status  from maintable where s_n = '$FORM{'S_N'}'";
$Bqr = $dbh->query($msgQ);
($s_g, $s_n,$name, $type, $df_t, $df_e, $name_a, $c_code, $b_date, $how_get, $price,$numpage,$year_print, $status) = $Bqr->fetchrow;

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
print "<form ACTION='/cgi-bin/esl_lib/UpdateBook.pl' METHOD='POST'\n";
print "NAME='marquee1'>\n";
print "  <p><big><strong>เลขหมู่ </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  <input TYPE='text' SIZE='6' NAME='S_G' VALUE = '$s_g'> </p>\n";
print "  <p><big><strong>เลขทะเบียน&nbsp;</strong>&nbsp; <font color='#FF8000'>&nbsp;&nbsp;&nbsp;&nbsp;</font></big>\n";
print "  <input TYPE='text' SIZE='6' NAME='S_N' VALUE = '$s_n'> </p>\n";
print "  <p><big><strong>ชื่ออุปกรณ์&nbsp;</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp;&nbsp;&nbsp;&nbsp; <input TYPE='text' SIZE='60' NAME='NAME'\n";
print "  tabindex='2' VALUE = '$name'> </small></p>\n";
print "  <p><big><strong>ประเภท</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </big><small>&nbsp;\n";
print "  <input TYPE='text' SIZE='6' NAME='TYPE' VALUE = '$type'> </p>\n";
print "  <p><big><strong>ส่วนขยายไทย </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp; <input TYPE='text' SIZE='59' NAME='DF_T' tabindex='4' VALUE = '$df_t'> </small></p>\n";
print "  <p><big><strong>ส่วนขยายอังกฤษ</strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp;&nbsp;&nbsp; <input TYPE='text' SIZE='58' NAME='DF_E' tabindex='5' VALUE = '$df_e'> </small></p>\n";
print "  <p><big><strong>ชื่อผู้แต่ง </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small>&nbsp;&nbsp; <input TYPE='text' SIZE='40' NAME='NAME_A' tabindex='6' VALUE = '$name_a'> </small></p>\n";
print "  <p><big><strong>สำนักพิมพ์</strong> </big><small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </small><select name='C_CODE' size='1'>\n";
if ($code eq  $c_code)
{
print "    <option selected value='$code'>  $c_name</option>\n";
}
else
{
print "    <option value='$code'>  $c_name</option>\n";
}
while (($code, $c_name) = $Bqr->fetchrow)
{
if ($code eq  $c_code)
{
print "    <option selected value='$code'> $c_name</option>\n";
}
else
{
print "    <option value='$code'> $c_name</option>\n";
}}
print "  </select><small> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </small> </small>\n";
print "  </p>\n";
print "  <p><big><strong>วันที่ซื้อ</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='8' NAME='B_DATE' tabindex='9' VALUE = '$b_date'> </small></p>\n";
print "  <p><big><strong>ที่มา</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='20' NAME='HOW_GET' tabindex='10' VALUE = '$how_get'> </small></p>\n";
print "  <p><big><strong>ราคา </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='8' NAME='PRICE' tabindex='11' VALUE = '$price'> </small></p>\n";
print "  <p><big><strong>จำนวนหน้า</strong>\n";
print "  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </big><small><input\n";
print "  TYPE='text' SIZE='4' NAME='NUMPAGE' tabindex='12' VALUE = '$numpage'> </small></p>\n";
print "  <p><big><strong>ปีที่พิมพ์ </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  </big><small><input TYPE='text' SIZE='4' NAME='YEAR_PRINT' tabindex='13' VALUE = '$year_print'> </small></p>\n";
print "  <p><big><big><big><big>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</big></big></big></big>\n";

print "  <p><big><strong>สถานะ </strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;\n";print "  <select SIZE='1' NAME='STATUS' tabindex='1'>\n";if ($status == '0' )
{
print "    <option selected value='0'> ยังอยู่ </option>\n";print "    <option value='1'> หาย </option>\n";}
else
{
print "    <option value='0'> ยังอยู่ </option>\n";print "    <option selected value='1'> หาย </option>\n";}
print "  </select> </big></p>\n";
print "  <input TYPE='submit' VALUE='Submit' NAME='B1'> <big>&nbsp;&nbsp; </big>&nbsp;&nbsp;&nbsp;&nbsp;\n";
print "  <input TYPE='reset' VALUE='Reset' NAME='B2'> </p>\n";
print "</form>\n";
print "</body>\n";
print "</html>\n";
