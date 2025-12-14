<?php
echo "
<html>
<body bgcolor='#FFFFFF'>
<P><FONT SIZE='+2' COLOR='#ff9900'><U><B><FONT
                SIZE='+3'>Feedback</FONT></B></U></FONT></P>
<form action='http://161.246.5.146/auction1/feedback.php3' method=post>
<table width='77%' border='1' height='380' align=center>
  <tr>
    <td height='378'> 
      <center><br>

        <table width='98%' border='0' bgcolor='#ccffcc'>
          <tr> 
            <td width='25%' height='34' align=right><b><font
color='#660066'> ชื่อเล่น :</font></b></td>
            <td width='70%' height='34'> 
              <input type='text' name='nickname1'><font color='#663300'>
              (ตัวเล็ก ตัวใหญ่มีผลด้วย)</font> </td>
          </tr>

          <tr> 
            <td width='25%' height='35' align=right><b><font
color='#660066'> รหัสผ่าน :</font></b></td>
            <td width='70%' height='35'> 
              <input type='password' name='password'>
            </td>
          </tr>

          <tr> 
            <td width='25%' height='35'>&nbsp;</td>
            <td width='70%' height='35'>&nbsp;</td>
          </tr>

          <tr> 
            <td width='25%' height='34' align=right><b><font
color='#660066'>คุณคือ :</font></b></td>
            <td width='70%' height='34'> <font color='#663300'> 
              <input type='radio' name='status' value='1'>
              ผู้ขาย 
              <input type='radio' name='status' value='2' checked>
              ผู้ซื้อ </font></td>
          </tr>

          <tr> 
            <td width='25%' height='34' align=right><b><font
color='#660066'>ชื่อเล่นของเขา 
              :</font></b></td>
            <td width='70%' height='34'> <font color='#663300'> 
              <input type='text' name='nickname2'>
              (ตัวเล็ก ตัวใหญ่มีผลด้วย)</font></td>
          </tr>

          <tr> 
            <td width='25%' height='34' align=right><b><font
color='#660066'>หมายเลขสินค้า :</font></b></td>
            <td width='70%' height='34'> <font color='#663300'> 
              <input type='text' name='itemid'>
              </font></td>
          </tr>

          <tr> 
            <td width='25%' height='34' align=right><b><font
color='#660066'>Feedback :</font></b></td>
            <td width='70%' height='34'> <font color='#663300'> 
              <input type='radio' name='grade' value='1'>
              ดี
              <input type='radio' name='grade' value='2'
checked>
              ปานกลาง 
              <input type='radio' name='grade' value='3'>
              ควรปรับปรุง </font></td>
          </tr>

          <tr> 
            <td width='25%' height='34' align=right><b><font
color='#660066'>ข้อความวิจารณ์ 
              :</font></b></td>
            <td width='70%' height='34'> <font color='#663300'> 
              <textarea name=description rows=5 cols=70></textarea>
              </font></td>
          </tr>
        </table><br>

          <input type='submit' name='submit' value='ตกลง'>
          <input type='reset' name='reset' value='ลบข้อมูล'>
      </center>
</table>
</form>
</body>
</html>";
?>
