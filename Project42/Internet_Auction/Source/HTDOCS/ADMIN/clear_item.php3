<?php
include ('/www/htdocs/admin/admin_sql_class.php3');
include ('/www/htdocs/interface/rectang_interface_class.php3');   

$sql = new admin_sql;
$result=$sql->num_old_item();

if ($result >=0)
{
echo "
<html>
<body bgcolor='#FFFFFF'>
<p><font color='#oo6600'><b><font size='5'>Clear Old Item
:</font></b></font></p>

<form action='http://161.246.5.146/admin/do_delete_old.php3' method=post >
<table width='100%' border='1' align=center>
  <tr>
      <td height='206'> <br>
        <table width='100%' border='0' bgcolor='#CCCCFF'>
          <tr>
            <td>
              <p align='center'><font color='#993366' size='5'><b><font
color='#990000'>สินค้าที่สิ้นสุดการประมูลกว่า 
                3 เดือน</font></b></font></p>
              <p align='center'> <font size='4'><b><font size='5'
color='#666600'>จำนวน 
                <font color='#FF3333'>$result</font>
ชิ้น</font></b></font></p>
        </td>
          </tr>
        </table>
        <p align='center'>";

	if ($result!=0) 
        {echo " <input type='submit' name='Submit' value='Delete'>";}

echo "
        </p>
        </td>
  </tr>
</table>
</form>

</body>
</html>";
}

else 
{
$rec = new rectang_interface;
echo"<html><body bgcolor=white><br>";
        $rec->simple_reg($result);
echo"</body></html>"; 
}

?>
