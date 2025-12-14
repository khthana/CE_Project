<?php
echo "
<html>
<body bgcolor='#FFFFFF'>
<h1><font color='#993300'><b>Administrator Page :</b></font></h1>
<form name='form' action='http://161.246.5.146/admin/admin_page.php3' 
method = post >

<table width='90%' border='1' align=center>
  <tr>
    <td height='126'> 
        <p align='center'>&nbsp;</p>
        <div align='center'>

          <table width='80%' border='0' bgcolor='#CCFFCC' align=center>

            <tr bgcolor='#CCFFCC'> 
              <td width='49%' height='43'> 
                <div align='right'><font size='4'><b><font color='#3333FF'>Admin 
                  Name : </font></b></font></div>
              </td>
              <td width='2%' height='43'><b><font color='#3333FF'></font></b></td>
              <td width='49%' height='43'> <b><font color='#3333FF'> 
                <input type='text' name='name'>
                </font></b></td>
            </tr>

            <tr bgcolor='#CCFFCC'> 
              <td width='49%' height='43'> 
                <div align='right'><font size='4'><b><font color='#3333FF'>Password1 
                  : </font></b></font></div>
              </td>
              <td width='2%' height='43'><b><font color='#3333FF'></font></b></td>
              <td width='49%' height='43'> <b><font color='#3333FF'> 
                <input type='password' name='password1'>
                </font></b></td>
            </tr>

 			<tr bgcolor='#CCFFCC'> 
              <td width='49%' height='43'> 
                <div align='right'><font size='4'><b><font color='#3333FF'>Password2 
                  : </font></b></font></div>
              </td>
              <td width='2%' height='43'><b><font color='#3333FF'></font></b></td>
              <td width='49%' height='43'> <b><font color='#3333FF'> 
                <input type='password' name='password2'>
                </font></b></td>
            </tr>

          </table>
        </div>
        <p align='center'> 
          <input type='submit' name='Submit' value='Next'>
        </p>
        <p align='center'>&nbsp;</p>
      </td>
  </tr>
</table>

 </form>
<p>&nbsp; </p>
</body>
</html>";
?>
