.<?php
include ('/www/htdocs/sql_class/history.php3');   

$history1 = new history_class;
$result=$history1->display_history($item_id);   

echo "
<html>
<body bgcolor='#FFFFFF'>
<center>

<p><font size= +4><b><font color='#006633'>
หมายเลขสินค้า : $item_id</font></b></font></p> ";

$c=$result[1]['price'];
if ($c=='*')  
{
echo "
<p><font size= +2><b><font color='#cc22ff'>
* = จะแสดงเมื่อสิ้นสุดการประมูล</font></b></font></p>";
}

echo"
<table width='90%' border='0'>
  <tr bgcolor='#FFFFCC'> 
    <td width='10%'> 
      <div align='center'><font size='4'><b><font color='#FF6633'>ลำดับ</font></b></font></div>
    </td>
    <td width='22%'> 
      <div align='center'><font size='4'><b><font color='#FF6633'>ผู้ประมูล</font></b></font></div>
    </td>
    <td width='25%'> 
      <div align='center'><font size='4'><b><font color='#FF6633'>ราคาประมูล (บาท)</font></b></font></div>
    </td>
    <td width='29%'> 
      <div align='center'><font size='4'><b><font color='#FF6633'>วัน เวลา</font></b></font></div>
    </td>
    <td width='19%'> 
      <div align='center'><font size='4'><b><font size='4'><b><font color='#FF6633'>จำนวน 
        (ชิ้น)</font></b></font></b></font></div>
    </td>
  </tr>";
$i=1;
$num=$result[0]['num']+1;
while ($i<$num)
{
	$a=$result[$i]['nickname'];
        $b=$result[$i]['time'];  
        $c=$result[$i]['price'];  
        $d=$result[$i]['quantity'];  
        $e=$result[$i]['type'];  
	$f=$result[$i]['e_mail'];
if ($i % 2 ==0) {$colour='bgcolor=#ccffcc' ;}
else {$colour='';}

if ($e==2) {$proxy='(Proxy)';}
else {$proxy='';}

echo " 
 <tr $colour> 
    <td width='9%'> 
      <div align='center'><font color='#9933CC'>$i</font></div>
    </td>
    <td width='22%'> 
      <div align='center'><font color='#9933CC'>
	<a href='mailto:$f'>$a</a></font></div>
    </td>
    <td width='21%'> 
      <div align='center'><font color='#cc22ff'>$c $proxy</font></div>
    </td>
    <td width='29%'> 
      <div align='center'><font color='#9933cc'>$b</font></div>
    </td>
    <td width='19%'> 
      <div align='center'><font color='#cc22ff'>$d</font></div>
    </td>
  </tr>";
$i++;
}

echo "
</table></center>
</body>
</html>";
?>
