<?php
echo "
<html>
<body bgcolor='#ffffff' text='#ff3333'> 
<center><h2>ค้นหาจาก หมายเลขสินค้า</h2></center>
<form action='http://161.246.5.146/auction1/search/result.php3'
method=post>
  <table width='100%' height='150' border='1'>
    <tr>
      <td height='120'> 
        <table width='100%' border='0' bgcolor='#aaffbb'>
          <tr> 
            <td width='43%' height='60'> 
              <div align='right'><b><font
color='#3333FF'>หมายเลขสินค้า</font></b> :</div>
            </td>
            <td width='57%' height='60'> 
              <input type='hidden' name='search_type' value='id' >  
              <input type='text' name='item_id' >
            </td>
          </tr>
        </table>
        <center>
        <input type='submit' name='Submit' value='ค้นหา'></center>
      </td>
    </tr>
  </table>
</form>
</body>
</html>";
?>
