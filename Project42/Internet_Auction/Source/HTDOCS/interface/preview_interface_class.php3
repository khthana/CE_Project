<?php
include('/www/htdocs/auction1/item_class.php3');

class preview_interface{
function print_preview($nickname,$password,$title,$firstname,$lastname,
		    $birth,$email,$address,$bound,$province,$postal,
	            $phone,$page,$fax){

$item1 = new item;
$province = $item1->get_province($province);
echo "
<body  bgcolor='white' >
<P><B><FONT SIZE='+2' COLOR='#336633'><U>
<FONT SIZE='+2'>ยืนยันการสมัครสมาชิก</FONT></U></FONT></B></P>
<CENTER>
<TABLE WIDTH='60%' BGCOLOR='#FFCC99' BORDER='2'>
<TR><TD HEIGHT='140' ALIGN='CENTER'><h2>
<font COLOR='#6633FF'>ตรวจดูข้อมูลอีกครั้ง.</font></h2>
<h3>$title $firstname  $lastname ($nickname)
<br> วันเกิด =$birth
<br> $address $bound $province $postal
<br> โทรศัพท์=$phone แฟกซ์ =$fax เพจ = $page
<br> อีเมล์ = $email
</h3>
</TD>
                  </TR>
                </TABLE>";

}//print_preview function
//-------------------------------------------------
/*



*/
//------------------------------------------------- 
}// preview_interface class
?>
