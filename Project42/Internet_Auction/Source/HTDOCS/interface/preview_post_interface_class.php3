<?php
class preview_item
{

function display_detail($title,$category,$description,$picture,$quantity,
        $startprice,$auction_type,$owner,$payment,
        $shipping,$location,$period)

{                       

$datetime=date("j-n-Y H:i:s A");
echo"
<p><font size='+2' color='#339900'><U><b><font
size='+2'>แสดงตัวอย่างหน้อจอสินค้า
item</font></b></u></font></p>
<table width='100%' border='1' height='364'>
  <tr bgcolor='#FFCC99'> 
    <td> 
      <table width='100%' border='0' height='31'>
        <tr bgcolor='#CC66FF'> 
          <td height='31'> 
            <div align='center'> <b><font
color='#FFFF66'>$title</font></b> </div>
          </td>
        </tr>
      </table>
      <table width='100%' border='0' bgcolor='#FFCC99' height='303'>
        <tr> 
          <td width='20%' height='31'> 
            <div align='right'><font color='#6600FF'>ราคาเริ่มต้น 
:</font></div>
          </td>
          <td width='4%' height='31'>&nbsp;</td>
          <td width='17%' height='31'><font
color='#FF3300'>$startprice Bath</font></td>
          <td width='26%' height='29'>
            <div align='right'><font color='#6300FF'>จำนวนการประมูล
:</font></div>
          </td>
          <td width='3%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'>0</font></td>
        </tr> 
        <tr> 
          <td width='20%' height='29'> 
            <div align='right'><font color='#6600FF'>จำนวนสินค้า
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='17%' height='29'><font
color='#FF3300'>$quantity</font></td>
          <td width='26%' height='29'> 
            <div align='right'><font color='#6300FF'>ชนิดการประมูล
:</font></div>
          </td>
          <td width='3%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'>$auction_type</font></td>
        </tr>
        <tr>
          <td width='20%' height='31'>
            <div align='right'><font color='#6600FF'>ประเภทสินค้า
:</font></div>
          </td>
          <td width='4%' height='31'>&nbsp;</td>
          <td width='17%' height='31'><font
color='#FF3300'>$category</font></td>
          <td width='26%' height='29'>
            <div align='right'><font color='#6300FF'>ที่อยูสินค้า
:</font></div>
          </td>
          <td width='3%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'>$location</font></td>  
	</tr>
        <tr> 
          <td width='20%' height='19'> 
            <div align='right'><font color='#6600FF'>วันเริ่มประมูล
:</font></div>
          </td>
          <td width='4%' height='19'>&nbsp;</td>
          <td width='20%' height='19'><font
color='#FF3300'>$datetime</font></td>
          <td width='26%'> 
            <div align='right'><font color='#6600FF'>ระยะเวลาประมูล 
:</font></div>
          </td>
          <td width='4%'>&nbsp;</td>
          <td width='17%'><font color='#FF3300'>$period 
week(s)</font></td>
        </tr>
        <tr> 
          <td width='20%' height='19'> 
            <div align='right'><font color='#6600FF'><font
color='#6600FF'>เจ้าของสินค้า
              :</font></font></div>
          </td>
          <td width='4%' height='19'>&nbsp;</td>
          <td width='17%' height='19'><font
color='#FF3300'>$owner</font></td>
          <td width='26%' height='19'> 
            <div align='right'></div>
          </td>
          <td width='3%' height='19'>&nbsp;</td>
          <td width='30%' height='19'>&nbsp;</td>
        </tr>
        <tr> 
          <td width='20%' height='19'> 
            <div align='right'><font color='#6600FF'><font
color='#6600FF'><font color='#6600FF'>การจ่ายเงิน</font> 
              :</font></font></div>
          </td>
          <td width='4%' height='19'>&nbsp;</td>
          <td width='17%' height='19'><font
color='#FF3300'>$payment</font></td>
          <td width='26%' height='19' > 
            <div align='right'><font color='#6600FF'><font
color='#6600FF'>การส่งมอบสินค้า
              :</font></font></div>
          </td>
          <td width='4%' height='19'>&nbsp;</td>
          <td width='17%' height='19'><font
color='#FF3300'>$shipping</font></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr bgcolor='#FFCC99'> 
    <td height='19'> 
      <table width='100%' border='0'>
        <tr bgcolor='#CE65FF'> 
          <td height='31'> 
            <div align='center'> <font
color='#FFFF66'>รายละเอียดสินค้า</font> </div>
          </td>
        </tr>
      </table>
      <table>
	<tr width='50%'>
	<td>";
	if ($picture>"http://")
	{
	echo"   
	<a Href='$picture'><Img src='$picture' Height='200'
width='200'>";
	}
	echo"
        </td>
	<td>	
           <p><fontcolor='#000000'>$description</font></p>
        </td>
	</tr>
       </table>	
  </tr>
</table>";
}
}
?>
