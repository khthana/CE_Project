<?php
include('/www/htdocs/sql_class/search.php3');

$search1=new search;

if (($search_type=='id' ) && ($item_id != ''))
	{ 
	$item_list=$search1->search_id($item_id); 
	}
elseif (($search_type=='title' ) && ($title != ''))
	{ 
	if ($maxprice > $nimprice)
	  {
	  $item_list=
		$search1->search_title($title,$descrip,$status,$category,
		$auction_type,$sort1,$sort2,$minprice,
		$maxprice); 
	  }
	}
elseif (($search_type=='seller') && ($nickname != ''))
	{ 
	$item_list=$search1->search_seller($nickname,$status,$category,
			     $auction_type,$sort1,$sort2); 
	}  


if ($item_list[0]['num']==0) 
{ echo "
	<body bgcolor='white'>
        <center>
        <h2><font color='#000099'>Search result : 0 item</font> </h2>
        <h3><font color='#cc3344'>Does not has Item in Data base.</font>
	</h3> 	
        </center>
	</body>  ";
}
else
{
$num = $item_list[0]['num'];
echo "
        <body bgcolor='white' link='#22aa22' alink='#22aa22'
vlink='#22aa22' text='#800040'>

	<center>
        <h2><font color='#000099'>Search result : $num item(s)</font></h2>
        </center>
        
	<TABLE WIDTH=100% border=0>
        <TR bgcolor='#ffcccc'>
        <TD width=10%>
        <P align=center><STRONG><FONT color=#6600ff>Item
id</FONT></STRONG></P></TD>
        <TD>
        <P align=center><STRONG><FONT
color=#6600ff>Title</FONT></STRONG></P></TD>
        <TD width=15%>
        <P align=center><STRONG><FONT color=#6600ff>Now
price (บาท)</FONT></STRONG></P></TD>    
        <TD width=8%>
        <P align=center><STRONG><FONT color=#6600ff>Time of
bids</FONT></STRONG></P></TD>
        <TD width=20%>
        <P align=center><FONT color=#6600ff><STRONG>Stop date</STRONG>
</FONT></P></TD></TR>
";

for ($j=1;$j<=$item_list[0]['num'];$j++)
{                 

        $item_id        =       $item_list[$j]['item_id'];
        $title          =       $item_list[$j]['title'] ;
        $now_price      =       $item_list[$j]['now_price'];
        $bid_num        =       $item_list[$j]['bid_num'];
        $stop_date      =       $item_list[$j]['stop_date'];
        $picture_url    =       $item_list[$j]['picture_url'];
        if ($j % 2 ==0)
        {echo "<TR bgcolor='#ffffcc'>";}
        else {echo "<TR bgcolor='white'>";} 

        echo "
        <TD width=10%>
<a
href='http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id'
        target = '$item_id'>$item_id</a></TD>
        <TD>
<a
href='http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id'
        target = '$item_id'>$title</a></TD> 
       <TD width=15% align=center>$now_price</TD>
        <TD width=8% align=center>$bid_num</TD>
        <TD width=20% align=center>$stop_date</TD></TR>";
}
echo "</table>"; 

}// end else  item_list <> 0
  
?>
