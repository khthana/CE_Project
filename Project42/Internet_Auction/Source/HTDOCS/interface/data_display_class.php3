<?php

class data_display{

function  exist_name()
{

echo "
<body  bgcolor='white'>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR>
<TD HEIGHT='140' ALIGN='CENTER'><h2><font COLOR='#6633FF'>
มีสมาชิกท่านอื่นใช้ชื่อนี้แล้ว</font></h2><h3>
กรุณาป้อนชื่อใหม่</h3>
</TD>
</TR>
</TABLE><br>

</form>

</CENTER>";

}// function exist_name
//-----------------------------------------------------------------
//--function exist_email PRINT EXISTING EMAIL
//--INPUT NO
//--RETURN NO
function exist_email() {

echo "
<body  bgcolor='white'>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR>
<TD HEIGHT='140' ALIGN='CENTER'><h2><font COLOR='#6633FF'>
e-mail นี้เป็นของสมาชิกท่านอื่นแล้ว</font></h2><h3>
กรุณาป้อน e-mail ใหม่</h3>
</TD>
</TR>
</TABLE><br>

</form>

</CENTER>";

}//function exist_name
//-----------------------

function exist_name_email() {

echo "
<body  bgcolor='white'>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR>
<TD HEIGHT='140' ALIGN='CENTER'><h2><font COLOR='#6633FF'>
ทั้งชื่อเล่นและ e-mail ได้มีสมาชิกท่านอื่นใช้แล้ว</font></h2><h3>
กรุณาป้อนชื่อเล่นและ e-mail ใหม่</h3>
</TD>
</TR>
</TABLE><br>     

</form>

</CENTER>";

}//function exist_name_email  
//-----------------------------
function  regis_ok()
{

echo "
<body  bgcolor='white'>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR>
<TD HEIGHT='140' ALIGN='CENTER'><h2><font COLOR='#6633FF'>
Welcome to BK-auction.</font></h2><h3>
คุณจะได้รับ e-mail จาก BK-auction ในไม่ช้า
<br>ตอนนี้คุณสามารถเข้ารวมการประมูลของทางเว็บไซต์แล้ว</h3>
</TD>
</TR>
</TABLE><br>
</CENTER>";

}// function regis_ok
//----------------------------------------

function  regis_notok()
{
echo "
<body  bgcolor='white'>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR>
<TD HEIGHT='140' ALIGN='CENTER'><h2><font COLOR='#6633FF'>
มีปัญหาในส่วนของการเก็บลงฐานข้อมูล</font></h2><h3> 
กรูณาป้อนชื่อเล่นและ e-mail ใหม่<br>เนื่องจาก
อาจจะมีสมาชิกท่านอื่นใช้ชื่อเล่นนี้แล้ว
</h3>
</TD>
</TR>
</TABLE><br>
</CENTER>";

}// function regis_notok 
//----------------------------------------
function  update_ok()
{

echo "
<body  bgcolor='white'>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR>
<TD HEIGHT='140' ALIGN='CENTER'><h3><font COLOR='#6633FF'>
ข้อมูลของคุณได้ทำการแก้ไขเรียบร้อยแล้วครับ</font></h3>
</TD>
</TR>
</TABLE><br>
</CENTER>";

}// function update_ok   
//------------------------------------
function notmember()
{

echo "
<body  bgcolor='white'>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR>
<TD HEIGHT='140' ALIGN='CENTER'><h2><font COLOR='#6633FF'>
ขออภัยครับ !</font></h2><h3>
กรุณาตรวจสอบชื่อเล่น หรือรหัสผ่านของท่าน 
<br>แล้วทดลองใหม่อีกครั้ง</h3>
</TD>                                  
</TR>
</TABLE><br>
</CENTER>";

}// function notmember 
//-----------------------------
  
}// class

?>
