<?php
include ('/www/htdocs/sql_class/comment.php3');
include ('/www/htdocs/data/data_arranger.php3');

echo "
<html>
<body bgcolor='#FFFFFF' link=#0077ff aling=#22aa22 vling=#0077ff> ";

$data=new data_arranger;

$detail=$data->add_quote($detail);
                            
$comment1=new comment;
if ($detail!='')
{
$result1=$comment1->keep_comment($sender,$mail,$detail);
}

$result=$comment1->display_comment();
$num=$result['num'][0];

if ($num>0)
{
	echo "
	<p><font color='#336600'><b><font
	size='5'>ข้อเสนอแนะ</font></b></font></p>";
	$i=0;
	if ($i<$num) 
	{ echo "<center><table width=80%>"; }

	while ($i!=$num)
	{
	$a=$result['name'][$i+1];
	$b=$result['e_mail'][$i+1]; 
	$c=$result['detial'][$i+1]; 
	$d=$result['date'][$i+1];

	$c=$data->add_br($c);
        if ($i % 2 ==0) { $colour='bgcolor=#ccFFcc';}
        else { $colour='bgcolor=#ffffcc'; }
        echo "
        <tr $colour width=40%>
                <td><a href='mailto:$b'>$a</a><br>$d</td>
                <td>$c</td></tr>
        <tr width=40%></tr>";
        $i++;
        }
        echo "</table></center>";  
}

echo"
<p><font color='#336600'><b><font
size='5'>ให้ข้อเสนอแนะ</font></b></font></p>
<table width='90%' border='1' height='230' align=center>
  <tr>
    <td height='315'> 
      <center>
        <form action='http://161.246.5.146/auction1/comment.php3'
method=post >
          <table width='90%' border='0' align=center bordercolor='#FFCCCC' bgcolor='#FFCCCC'>
            <tr bgcolor='#FFCCCC'> 
              <td width='46%'> 
                <div align='right'><font size='4'><b><font color='#3300CC'>ผู้ส่ง 
                  : </font></b></font></div>
              </td>
              <td width='2%'>&nbsp;</td>
              <td width='52%'> 
                <input type='text' name=sender>
              </td>
            </tr>

            <tr bgcolor='#FFCCCC'> 
              <td width='46%' height='30'> 
                <div align='right'><font size='4'><b><font color='#3300CC'>อีเมล์ 
                  : </font></b></font></div>
              </td>
              <td width='2%' height='30'>&nbsp;</td>
              <td width='52%' height='30'> 
                <input type='text' name=mail>
              </td>
            </tr>

            <tr bgcolor='#FFCCCC'> 
              <td width='46%'> 
                <div align='right'><font size='4'><b><font color='#3300CC'>ข้อความ 
                  : </font></b></font></div>
              </td>
              <td width='2%'>&nbsp;</td>
              <td width='52%'> 
                <textarea name=detail rows=5 cols=70></textarea>
              </td>
            </tr>
          </table><p>
          <input type='submit' name='Submit' value='       ส่ง      '>
          <input type='reset' name='Submit2' value=' ลบข้อมูล '> 
 			<p>
      </form>
      </center>
    </td>
  </tr>
</table>
</body>
</html>";
?>
