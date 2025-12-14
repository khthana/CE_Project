<?php

include('/www/htdocs/auction1/item_class.php3');
include('/www/htdocs/data_check/post_checker_class.php3');
include('/www/htdocs/data_check/member_checker_class.php3');
include('/www/htdocs/warning/error_warning_class.php3');
include('/www/htdocs/interface/preview_post_interface_class.php3');


$item1 = new item;
$post_checker1 = new post_checker;
$error1	     = new error_warning;  		
$member_check1 = new member_checker;
$preview1 	= new preview_item;
$message1	= new message;
$rectang1	= new rectang_interface;



$title=str_replace("\'","'",$title);

$tmp_des = $description;
$description=str_replace("\'","*x|x*",$tmp_des);
$description1=str_replace("\'","'",$tmp_des);
$description1 = nl2br($description1);

echo "<html><body bgcolor=white>";

$title1 = $title;
$title = str_replace("'","*x|x*",$title);

$member_id = $member_check1->check_nick_pass($nickname,$password);

if ($member_id != "") 
{

list($result[1],$result[2],$result[3],$result[4],$result[5],$result[6],$result[7])
	= $post_checker1->check_preview_data( 
$nickname,$password,$title,$quantity,$auctiontype,$startprice, 
$minprice,$callnameid); 	

	if (($result[1] == 0 )&&($result[2] == 0 )&&($result[3] ==0)&&($result[4] == 0 )&&
 	     ($result[5] == 0 )&&($result[6] == 0)&&($result[7] == 0))	
{

//--------------------------------------
$post_preview_data =
$item1->get_post_preview_data($auctiontype,$payment,$shipment,$location,$callnameid);

	$auctype 	=  	$post_preview_data['auction_type'];
	$pay		=	$post_preview_data['payment'];
	$ship		=	$post_preview_data['shipment'];
	$loc		=	$post_preview_data['province'];
	$cat		=	$post_preview_data['category'];
//--------------------------------------

$preview1->display_detail($title1,$cat,$description1,$userfile,$quantity,    
    $startprice,$auctype,$nickname,$pay,$ship,$loc,$period);


if ($minprice == "") {$minprice = 0;}

echo"
<form action ='http://161.246.5.146/auction1/post/post_item.php3'  method =post>
	<INPUT TYPE = hidden NAME = member_id value=$member_id  > 
	<INPUT TYPE = hidden NAME = nickname value='$nickname'  > 
	<INPUT TYPE = hidden NAME = password value='$password'  > 
	<INPUT TYPE = hidden NAME = title value='$title'  > 
	<INPUT TYPE = hidden NAME = category value='$callnameid'  > 
	<INPUT TYPE = hidden NAME = description value='$description'  > 
	<INPUT TYPE = hidden NAME = quantity value='$quantity'  > 
	<INPUT TYPE = hidden NAME = auctiontype value='$auctiontype'  > 
	<INPUT TYPE = hidden NAME = startprice value='$startprice' > 
	<INPUT TYPE = hidden NAME = minprice value='$minprice' > 
	<INPUT TYPE = hidden NAME = period value='$period'  > 
	<INPUT TYPE = hidden NAME = payment value='$payment'  > 
	<INPUT TYPE = hidden NAME = shipment value='$shipment'  > 
	<INPUT TYPE = hidden NAME = userfile value='$userfile'  > 
	<INPUT TYPE = hidden NAME = location value='$location' >

	<br><center><input type= 'submit' value= ' ตกลง '>	
	</form></center>";

} // end if input currect
	else
	{ 
	echo "<h1>";
	echo "<h1>Please Input<h1>";
	$error1->post_warning($result);
	}

}// end if check nick_name and password
else
{
$rectang1->simple_reg('<h1>'.$message1->incorrect_login.'<h1>');
}
echo "</body></html>";
?>
