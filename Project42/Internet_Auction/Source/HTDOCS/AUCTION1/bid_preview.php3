<?php
include('/www/htdocs/data_check/bid_checker_class.php3');  
include('/www/htdocs/auction1/bid/proxy_bidding.php3');

$bid_checker 	= new bid_checker;
$item1 		= new item;
$proxy1 	= new proxy_bidder;
$rect 		= new rectang_interface;


$bid_quantity = str_replace(",","",$bid_quantity);
$bid_price    = str_replace(",","",$bid_price);
$proxy_price  = str_replace(",","",$proxy_price);
$save_result['complete']= false;

 if ( $proxy == 1)
 {
	$proxy_null = $bid_checker->check_proxy_null($proxy,$proxy_price);
	if($proxy_null)
	 {// proxy data  is not null
$save_result =  $proxy1->save_proxy_data($nickname,$item_id,$bid_quantity,$proxy_price);
	}
 }

if( $save_result['complete'] or ($proxy == ""))
{// begin check normal bid
if
(!$bid_checker->normal_bid_checker($nickname,$password,$bid_quantity,
	$bid_price,$item_id))
 	{
	//	$message = " incorrect data<br>";
	}
else
	{
		$result = $item1->normal_bid($nickname,$item_id,$bid_price,$bid_quantity);
	 	if ($result['bid_complete'])
		{
		if($save_result['complete'])
			{
			ocicommit($save_result['conn']);
			}
			$message = "<br><font
color='#6600FF'>การประมูลถูกต้อง</font><br>";  
			$proxy1->proxy_bid($item_id);
	 	}	
		else
		{// have error
		if($result['message'] != "")
		{
			$message = $result['message'];
		}
		else{
		$message= "<br><font
color='#6600FF'>ราคาที่จะประมูลต่ำกว่าราคาที่กำหนด 
<br>กรุณาป้อนราคาใหม่</font><br>"; }
		if($save_result['complete'])
			{
			ocirollback($save_result['conn']);
			}
		}//end have error
	}
}// end begin check normal bid
else //proxy is not complete
{
	$message = $save_result['message'];
	// rollback save data
	if (!$save_result['complete'] and ($proxy_null))
	{
	ocirollback($save_result['conn']);
	}
	else $message = 'กรุณาใส่ราคาตัวแทนการประมูล';
}
	$rect->simple_reg($message);    

 ?>
