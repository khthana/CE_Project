<?php
include('/www/htdocs/interface/rectang_interface_class.php3');  
include('/www/htdocs/auction1/item_class.php3');
include('/www/htdocs/data_check/member_checker_class.php3');
include('/www/htdocs/auction1/mail_class.php3');

echo "<html><body bgcolor=white>";
$item1 = new item;
$member_check1 = new member_checker;
$mail1	= new mail_class;
$rectang1 = new rectang_interface; 

$description = str_replace("*x|x*","''",$description);
$title = str_replace("*x|x*","''",$title);


if ($member_check1->check_member($nickname,$password))
{

$post_result =
$item1->post_item($member_id,$title,$category,$description,$quantity,
$auctiontype,$startprice,$minprice,$period,$payment,$shipment,
$userfile,$location);
if($post_result['complete'])
{
$mail1->post_mail($post_result['e-mail'],$nickname,$post_result['item_id']);
}
}
else{
$post_result['message'] = "<font color='#6600FF'><br><h2>ขออภัยครับ
</h2><br><h3>มีปัญหาในการเก็บข้อมูล/h3>"   ;
}
      $rectang1->simple_reg($post_result['message']);    
echo "</body></html>";
?>
