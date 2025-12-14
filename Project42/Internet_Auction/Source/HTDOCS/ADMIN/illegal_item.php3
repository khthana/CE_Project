<?php
echo "
<html>
<body bgcolor='#FFFFFF'>
<p><font color='#oo6600'><b><font size='5'>Delete Illegal Item
:</font></b></font></p>

<form action='http://161.246.5.146/admin/do_illegal.php3' method=post>
  <table width='100%' border='1'>

    <tr>
      <td height='107'><br> 

        <table width='100%' border='0' bgcolor='#CCFFCC'>

          <tr bgcolor='#CCFFCC'> 
            <td width='47%' height='48'> 
              <div align='right'><font size='4'><b><font size='+1'
color='#660000'>หมายเลขสินค้า :</font></b></font> </div>
            </td>
            <td width='3%' height='48'>&nbsp;</td>
            <td width='50%' height='48'> 
              <input type='text' name='item_id' value=''>
            </td>
          </tr>

          <tr bgcolor='#CCFFCC'>
            <td width='47%' height='48'>
              <div align='right'><font size='4'><b><font size='+1'
color='#660000'>ระดับความผิด :</font></b></font> </div>
            </td>
            <td width='3%' height='48'>&nbsp;</td>
            <td width='50%' height='48'>
              <input type='radio' name='type1' value='1' checked>ตักเตือน
              <input type='radio' name='type1' value='2'>ตัดสิทธิ์
            </td>
          </tr>        

        </table>
 
  <p align='center'>
    <input type='submit' name='Submit' value='Delete'>
  </p>
      </td>
    </tr> 

  </table>	
  </form>
</body>
</html>";
?>
