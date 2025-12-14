<?php
include '/www/htdocs/sql_class/feedback.php3';
include ('/www/htdocs/data/data_arranger.php3');  

$data=new data_arranger; 

$feedback1 = new feedback_class;
$back=$feedback1->display_feedback($nickname,$status);

$result = $back[1];
$result1 = $back[2];

echo "
<html>
<body bgcolor='#FFFFFF' link='#cc00cc' alink='#006633' vlink='#cc00cc'
text='#666600'>
<center>
<p><font size= +7><b><font color='#006633'>
$nickname : </font></b></font>
<font color='#ff6633' size=+3>$result[status] ($result[num])</font></p>

<table width='25%' border='0' align=center>
  <tr align=center>
    <td width='20%'>Good <font color='#FF0033'>$result[good]</font></td>
    <td width='25%'>Normal <font color='#FF0033'>$result[normal]</font>
</td>
    <td width='18%'>Bad <font color='#FF0033'>$result[bad]</font></td>
  </tr>
</table>
</center>
<p><font color='#990033'>
<a href='http://161.246.5.146/interface/display_feedback_interface.php3?
nickname=$nickname&status=1' target=$owner>Seller</a><font> 
| 
<font color='#990033'>
<a href='http://161.246.5.146/interface/display_feedback_interface.php3?
nickname=$nickname&status=2' target=$owner>Buyer</a></font></p>

<table width='800' border='0'>
  <tr bgcolor='#FFFFCC'>
    <td width='3%' height='35'><font color='#333399' 
 size='4'><b>No</b></font></td> 

    <td width='12%' height='35'><font color='#333399'
 size='4'><b>Date</b></font></td>

    <td width='8%' height='35'><font color='#333399' size='4'><b>Item
ID</b></font></td>

    <td width=360 height='35'><font color='#333399'
size='4'><b>Comment</b></font></td>

    <td width='7%' height='35'><font color='#333399'
size='4'><b>Grade</b></font></td>

    <td width='10%' height='35'><font color='#333399'
size='4'><b>From</b></font></td>

  </tr>";


  $num=$result1[0]['num'];

  for ($i=1; $i<=$num; $i++)
{
  if ($i % 2 ==0) {$bg= "bgcolor='#ffcccc' ";}
  else {$bg='';}

        $x=$result1[$i]['item_id'];
       	$t=$result1[$i]['time'];
	$y=$result1[$i]['description'];

        $z=$result1[$i]['sender'];
	if ($result1[$i]['grade']==1) {$g='Good';}
	elseif ($result1[$i]['grade']==2) {$g='Normal';}
        elseif ($result1[$i]['grade']==3) {$g='Bad';}         
        $status = ($status%2)+1;

$y=$data->add_br($y);  
 	
  echo "
  <tr $bg> 
    <td width=3%>$i</td>
    <td width=12%>$t</td>
    <td width=8%>$x</td>
    <td width=60%>$y</td>
    <td width=7%>$g</td>
    <td width=10%>
<a href='http://161.246.5.146/interface/display_feedback_interface.php3?
nickname=$z&status=$status' target=$z>$z</a></td>
  </tr>";
} 

echo "
</table>
<p>&nbsp;</p>
</body>
</html>";
?>
