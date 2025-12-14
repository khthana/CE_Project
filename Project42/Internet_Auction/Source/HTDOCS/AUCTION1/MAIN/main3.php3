<?php
include('/www/htdocs/auction1/item_class.php3'); 
$item_list1 = new item;

$item_list = $item_list1->get_item_list($category_id);
for ($j=0;$j<count($item_list);$j++)
{
	
	$item_id 	=	$item_list[$j]['item_id'];
	$title		=	$item_list[$j]['title'] ;	
	$now_price	=	$item_list[$j]['now_price'];
	$bid_num	=	$item_list[$j]['bid_num'];	 
	$stop_date	=	$item_list[$j]['stop_date'];
	$picture_url	=	$item_list[$j]['picture_url'];
	
	echo "
	<a
	href='http://161.246.5.146/auction1/main/Item_detail.php3?item_id=$item_id'>
 	$item_id $title $now_price $bid_num $stop_date $picture_url</a> 
	 	<br>";    } 
?>
