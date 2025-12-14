<?php
class header_interface
{

function print_head()
{
 echo "             
<body bgcolor='#ffffff' link='#0077ff' vlink='#cc00cc' alink='#0077ff'>  
<TABLE WIDTH='100%' BORDER='0'>
<TR>
<TD WIDTH='200'><B><FONT SIZE='+3'
COLOR='#6633FF'>BK-auction</FONT></B></TD>
<TD WIDTH='480'>
<FONT SIZE='+1'>
| 
<FONT COLOR='#336600'><a  
href='http://161.246.5.146/auction1/main.php3'
target='body'>หน้าจอหลัก</a></FONT> 
|
<FONT COLOR='#336600'><a 
href='http://161.246.5.146/auction1/post/post_page.php3'
target='body'>ขายสินค้า</a></FONT> 
|   
<FONT COLOR='#336600'><a
href='http://161.246.5.146/auction1/regis/regis_page.php3' 
target='body'>สมัครสมาชิก</a></FONT>
|
<FONT COLOR='#336600'><a
href='http://161.246.5.146/interface/check.php3'
target='body'>แก้ไขข้อมูลสมาชิก</a></FONT>
| 
<FONT COLOR='#336600'><a 
href='http://161.246.5.146/auction1/search/search_page.php3'
target='body'>ค้นหา</a></FONT>
|
<FONT COLOR='#336600'><a
href='http://161.246.5.146/interface/feedback_interface.php3'
target='body'>Feedback</a></FONT>  
| 
<FONT COLOR='#336600'><a
href='http://161.246.5.146/interface/comment.php3'
target='body'>ให้ข้อเสนอแนะ</a></FONT> 
|
<FONT COLOR='#336600'><a
href='http://161.246.5.146/auction1/help.php3'
target='body'>วิธีใช้งาน</a></FONT> 
|
</FONT>  </TD> </TR> </TABLE>
";
}// fn print_head()

function print_buttle()
{
 echo "               
<BR><HR>
<TABLE WIDTH='100%' BORDER='0'>
<TR>
<TD WIDTH='329'><B><FONT SIZE='+4' COLOR='#6633FF'>BK-auction</FONT></B></TD>
<TD WIDTH='399'>
<FONT SIZE='+2'>| 
<FONT COLOR='#336600'><a
href='http://161.246.5.146/auction1/main.php3'>Home</a></FONT> |   
<FONT COLOR='#336600'>Bid</FONT> |
<FONT COLOR='#336600'><a
href='http://161.246.5.146/auction1/post_page.php3'>Post</a></FONT> |   
<FONT COLOR='#336600'><a
href='http://161.246.5.146/auction1/regis_page.php3'>Registration</a></FONT> |
<FONT COLOR='#336600'><a
href='http://161.246.5.146/auction1/verify_page.php3'>Verify</a></FONT> | 
<FONT COLOR='#336600'>Search</FONT> |  <FONT COLOR='#336600'>Comment</FONT> |
<FONT COLOR='#336600'>Help</FONT>|</FONT>  </TD> </TR> </TABLE>";
}// fn print_head()

}//class header_interface
?>
