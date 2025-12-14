<?php
include('/www/htdocs/auction1/bid/next_price_class.php3');

class bid_item
{

function display_detail($id,$title,$category,$description,$picture,$quantity,
        $start_bid,$auction_type,$start_date,$stop_date,$owner,$payment,
	$shipping,$now_price,$num_bid,$location,$rating,$highest_bidder,
	$e_mail)

{                       
$price1 = new next_price;
$minprice = $price1->get_next_price($now_price);

$hour = (date("h"));
$minute = (date("i"));
$second = (date("s"));
$ampm = (date("A"));
$date = (date("d"));
$t = (date("S"));
$mount = (date("F"));
$year = (date("Y"));  

echo"
<body bgcolor='white'  bgcolor='#FFFFFF' link='#cc00cc' alink='#006633'
vlink='#cc00cc' text='#666600'> 
<p><font size='+2' color='#339900'><U><b><font size='+2'>ประมูลสินค้า
</font></b></u></font></p>

<P align=right><FONT SIZE='+2'><B><FONT SIZE='+1'>
        $date $t $mount $year
        $hour:$minute:$second
	$ampm</FONT></B></FONT></P> 

<table width='100%' border='0' height='895'>
  <tr bgcolor='#FFCC99'> 
    <td> 
      <table width='100%' border='0' height='68'>
        <tr bgcolor='#CC66FF'> 
          <td height='31'> 
            <div align='center'> <b><font
color='#FFFF66'>$title</font></b> </div>
          </td>
        </tr>
        <tr bgcolor='#9999FF'> 
          <td height='29'> 
            <div align='center'> <b><font
color='#99FF00'>หมายเลขสินค้า = $id</font></b> </div>
          </td>
        </tr>
      </table>
      <table width='100%' border='0' bgcolor='#FFCC99' height='280'>
        
	<tr> 
          <td width='20%' height='29'> 
            <div align='right'><font color='#6600FF'>ราคาปัจจุบัน
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='17%' height='29'><font
color='#FF3300'>$now_price บาท</font></td>
          
	<td width='26%' height='29'>
            <div align='right'><font color='#6300FF'>จำนวนการประมูล
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td height='29'><font color='#FF3300'>$num_bid
(ครั้ง)</font></td> 
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
          <td width='4%' height='29'>&nbsp;</td>
          <td height='29'><font
color='#FF3300'>$auction_type</font></td>
        </tr>
        

	<tr>
          <td width='20%' height='29'>
            <div align='right'><font color='#6600FF'>ประเภทสินค้า
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='17%' height='29'><font
color='#FF3300'>$category</font></td>

          <td width='26%' height='29'>
            <div align='right'><font color='#6300FF'>ที่อยู่สินค้า
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'>$location</font></td>
        </tr>      


	<tr> 
          <td width='20%' height='29'> 
            <div align='right'><font color='#6600FF'>วันเริ่มประมูล 
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='20%' height='29'><font
color='#FF3300'>$start_date</font></td> 

          <td width='26%'> 
            <div align='right'><font color='#6600FF'>วันสิ้นสุดการประมูล 
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'>$stop_date</font></td>
          </tr>


        <tr> 
          <td width='20%' height='29'> 
            <div align='right'><font color='#6600FF'><font
color='#6600FF'>เจ้าของสินค้า 
              :</font></font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td height='29'><font
color='#FF3300'>
<a href='http://161.246.5.146/interface/display_feedback_interface.php3?
nickname=$owner&status=1' target=$id>$owner</a> (ดู  
feedback)
<a href='mailto:$e_mail'>$e_mail</a>
</font></td>
         
        </tr>

        <tr> 
          <td width='20%' height='29'> 
            <div align='right'><font color='#6600FF'><font
color='#6600FF'><font color='#6600FF'>การจ่ายเงิน</font> 
              :</font></font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='17%' height='29'><font
color='#FF3300'>$payment</font></td>

          <td width='26%' height='29'> 
            <div align='right'><font color='#6600FF'><font
color='#6600FF'>การส่งของ 
              :</font></font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'>$shipping</font></td>
        </tr>


	 <tr>
          <td width='20%' height='29'>
            <div align='right'><font color='#6600FF'>ผู้ประมูลสูงสุด
:</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>";

	if ($highest_bidder =='0') 
	{
		$highest_bidder='-';
		$link1='';
		$link2='';
	}
	else 
	{
		$link1="<a
href='http://161.246.5.146/interface/display_feedback_interface.php3?
nickname=$highest_bidder&status=2' target=$id>";
		$link2="</a> (ดู feedback)";
	}
	echo"
          <td width='17%' height='29'><font
color='#FF3300'>$link1 $highest_bidder $link2</font></td>

          <td width='26%' height='29'>
          <div align='right'><font color='#6600FF'>ประวัติการประมูล</font></div>
          </td>
          <td width='4%' height='29'>&nbsp;</td>
          <td width='30%' height='29'><font
color='#FF3300'><a
href='http://161.246.5.146/interface/history.php3?
item_id=$id' target= $id>ประวัติ</a></font></td>
        </tr>      

      </table>
    </td>
  </tr>
  <tr bgcolor='#FFCC99'> 
    <td height='192'> 
      <table width='100%' border='0' height='31'>
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
    </td>
  </tr>
  <tr bgcolor='#FFCC99'> 
    <td> 
      <table width='100%' border='0' height='34'>
        <tr bgcolor='#CE65FF'> 
          <td> 
            <div align='center'> <font color='#FFFF63'>การประมูล</font>
</div>
          </td>
        </tr>
      </table>
      <p align='center'><font>ราคาต่ำสุด :</font><font
color='#ff0099'> $minprice บาท</font> </p>
      <form method='post'
action='http://161.246.5.146/auction1/bid/bid_preview.php3'>
        <input type='hidden' name='item_id' value = $id>
	<table width='100%' border='0'>
          <tr> 
            <td width='47%'> 
              <div align='right'>ชื่อเล่น : 
                <input type='text' name='nickname'>
              </div>
            </td>
            <td width='5%'> 
              <div align='left'></div>
            </td>
            <td width='48%'> รหัสผ่าน : 
              <input type='password' name='password'>
            </td>
          </tr>
        </table>
        <table width='100%' border='0'>
          <tr>"; 
	if ($auction_type == 'การประมูลแบบสินค้าหลายชิ้น')
	{echo" 
            <td width='46%'> 
              <div align='right'>จำนวนที่ต้องการ : </div>
            </td>
            <td width='54%'> 
              <input type='text' name='bid_quantity' value=1>
            </td>";
	}
	else 
	{echo"
	     <td width='54%'>
              <input type='hidden' name='bid_quantity' value=$quantity
maxlength=5>
             </td>";	
	}
	echo"
          </tr>
          <tr> 
            <td height='19' width='46%'> 
              <div align='right'>ราคาที่ประมูล: </div>
            </td>
            <td height='19' width='54%'> 
              <input type='text' name='bid_price'  maxlength=10>
            </td>
          </tr>
	<tr>
	  <td height='19' width='46%' align=right><br>
		<input type='checkbox' name=proxy value=1>
	  </td>
	  <td><br>ใช้ Proxy
	  </td>
	</tr>
	<tr>
	  <td height='19' width='46%' align=right>ราคาที่ยอมรับได้
:</td>
          <td height='19' width='46%' align=left>
               <input type='text' name=proxy_price  maxlength=10> บาท
          </td>  
	</tr>
        </table><br>
	<center>
        <font color='#000000'> 
          <input type='submit' name='Submit' value=' ตกลง '>
          </font></center>
      </form>
      <p><br>
      </p>
      <p>&nbsp;</p>
      <p>&nbsp; </p>
    </td>
  </tr>
</table>";
}
}
?>
