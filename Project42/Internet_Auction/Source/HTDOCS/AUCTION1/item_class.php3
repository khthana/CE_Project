<?php
include('/www/htdocs/sql_class/item.php3');
include('/www/htdocs/mail/normal_close_mail.php3');
include('/www/htdocs/mail/normal_bid_mail.php3');
include('/www/htdocs/sql_class/time.php3');
include('/www/htdocs/auction1/dutch_item_class.php3');

class item {

  	
//function post_item-------------------------------
//--Use to post item for auction
//--INPUT = $title,$category,$description,$quantity,
//--$auctiontype,$startprice,$minprice,$period,$payment,$shipment,$userfile,$location
//--OUTPUT = item_id
function post_item($member_id,$title,$category,$description,$quantity,
$auctiontype,$startprice,$minprice,$period,$payment,$shipment,
$userfile,$location){

$item_sql1 = new item_sql;
$period	   = $period*7;
$post_result =
$item_sql1->insert_all($member_id,$title,$category,$description,$quantity,
$auctiontype,$startprice,$minprice,$period,$payment,$shipment,
$userfile,$location);

return $post_result;

}//end function post_item

function get_province($province_id)
{
			switch($province_id) {
			case 1 : return 'เชียงใหม่' ; break;
			case 2 : return 'เชียงราย' ; break;
			case 3 : return 'กำแพงเพชร' ; break;
			case 4 : return 'ลำปาง' ; break;
			case 5 : return 'ลำพูน' ; break;
			case 6 : return 'แม่ฮ่องสอน' ; break;
			case 7 : return 'นครสวรรค์' ; break;
			case 8 : return 'น่าน' ; break;
			case 9 : return 'พะเยา' ; break;
			case 10 : return 'เพชรบูรณ์' ; break;
			case 11 : return 'พิจิตร' ; break;
			case 12 : return 'พิษณุโลก' ; break;
			case 13 : return 'แพร่' ; break;
			case 14 : return 'สุโขทัย' ; break;
			case 15 : return 'ตาก' ; break;
			case 16 : return 'อุทัยธานี' ; break;
			case 17 : return 'อุตรดิตถ์' ; break;
			case 18 : return 'อำนาจเจริญ' ; break;
			case 19 : return 'บุรีรัมย์' ; break;
			case 20 : return 'ชัยภูมิ' ; break;
			case 21 : return 'กาฬสินธุ์' ; break;
			case 22 : return 'ขอนแก่น' ; break;
			case 23 : return 'เลย' ; break;
			case 24 : return 'มหาสารคาม' ; break;
			case 25 : return 'มุกดาหาร' ; break;
			case 26 : return 'นครราชสีมา' ; break;
			case 27 : return 'นครพนม' ; break;
			case 28 : return 'หนองบัวลำภู' ; break;
			case 29 : return 'หนองคาย' ; break;
			case 30 : return 'ร้อยเอ็ด' ; break;
			case 31 : return 'สกลนคร' ; break;
			case 32 : return 'ศรีสะเกษ' ; break;
			case 33 : return 'สุรินทร์' ; break;
			case 34 : return 'อุบลราชธานี' ; break;
			case 35 : return 'อุดรธานี' ; break;
			case 36 : return 'ยโสธร' ; break;
			case 37 : return 'กรุงเทพมหานคร' ; break;
			case 38 : return 'นนทบุรี' ; break;
			case 39 : return 'ปทุมธานี' ; break;
			case 40 : return 'นครนายก' ; break;
			case 41 : return 'ปราจีนบุรี' ; break;
			case 42 : return 'สระแก้ว' ; break;
			case 43 : return 'ฉะเชิงเทรา' ; break;
			case 44 : return 'พระนครศรีอยุธยา' ; break;
			case 45 : return 'ลพบุรี' ; break;
			case 46 : return 'สระบุรี' ; break;
			case 47 : return 'สิงห์บุรี' ; break;
			case 48 : return 'อ่างทอง' ; break;
			case 49 : return 'ชัยนาท' ; break;
			case 50 : return 'สมุทรปราการ' ; break;
			case 51 : return 'สมุทรสาคร' ; break;
			case 52 : return 'สมุทรสงคราม' ; break;
			case 53 : return 'นครปฐม' ; break;
			case 54 : return 'สุพรรณบุรี' ; break;
			case 55 : return 'ราชบุรี' ; break;
			case 56 : return 'กาญจนบุรี' ; break;
			case 57 : return 'เพชรบุรี' ; break;
			case 58 : return 'ประจวบคิรีขันธ์' ; break;
			case 59 : return 'ชลบุรี' ; break;
			case 60 : return 'ระยอง' ; break;
			case 61 : return 'จันทบุรี' ; break;
			case 62 : return 'ตราด' ; break;
			case 63 : return 'ชุมพร' ; break;
			case 64 : return 'ระนอง' ; break;
			case 65 : return 'สุราษฎร์ธานี' ; break;
			case 66 : return 'พังงา' ; break;
			case 67 : return 'ภูเก็ต' ; break;
			case 68 : return 'กระบี่' ; break;
			case 69 : return 'นครศรีธรรมราช' ; break;
			case 70 : return 'ตรัง' ; break;
			case 71 : return 'พัทลุง' ; break;
			case 72 : return 'สงขลา' ; break;
			case 73 : return 'สตูล' ; break;
			case 74 : return 'ปัตตานี' ; break;
			case 75 : return 'ยะลา' ; break;
			case 76 : return 'นราธิวาส' ; break;
			}//switch
}//function get province

//---------------------------------------------------
//get_item_list 
//USE TO get list of item data that need to display for display item list 
//INPUT category_id
//OUT PUT list of item data
 
function get_item_list($category_id){

$item_sql1 = new item_sql;
$item_list = $item_sql1->item_list($category_id);
return $item_list;


}// end get_item_list
//---------------------------------------------------
function get_bid_data($item_id){
 $item1  = new item_sql;
 $bid_data = $item1->get_bid_data($item_id);
 return $bid_data;	
} // get_bid_data
//----------------------------------------------------
//return name of each data_id
//input auction type,payment ,shipment,province,category
//output all name
function
get_post_preview_data($auctiontype,$payment,$shipment,$province,$category){

$item1	= new item_sql;
$post_preview_data =
$item1->get_post_preview_data($auctiontype,$payment,$shipment,$province,$category);

return $post_preview_data;

}// end get_post_preview_data

//----------------------------------------------------
//input $item_id
function close_normal_auction($item_id)
{
	//1 update close column in item
	//2 get highest_bidder email,owner email,final price
	//3 mail to highest bidder with link to item_detail page and owner email 	
	//4 mail to owner with link to item_detail page and bidder email
	
	//1 and //2
	$item1 = new item_sql;
	$close_data = $item1->normal_close($item_id);
	$close_data['item_id'] = $item_id;
	
	//1.1 if item is sell
	$mail1 = new normal_close_mail;
	if ($close_data['sell'])	
	{	
	//3
	$mail1->to_owner(
			$close_data['owner_email'],
			$close_data['owner_name'],
			$close_data['bidder_email'],
			$close_data['bidder_name'],
			$close_data['item_id'],
			$close_data['price']); 
	$mail1->to_bidder(
			$close_data['owner_email'],
			$close_data['owner_name'],
			$close_data['bidder_email'],
			$close_data['bidder_name'],
			$close_data['item_id'],
			$close_data['price']); 
	//save sell data
	$item2	= new save_sell_data;
	$item2->save_normal($item_id,$close_data);

	}
	else	// item is not sell
	{
	$mail1->not_sell($close_data['owner_email'],
			$close_data['owner_name'],
			$close_data['item_id']);
	}	// end item is not sell
}// end close_normal_auction
//----------------------------------------------------
 function normal_bid($nickname,$item_id,$bid_price,$quantity){

//1 bid for item 
//2 mail to confirm bidder
//3 mail to owner
//4 mail to underbid

	
	//1 bid for item 
	$item1 = new item_sql;
	$bid_return_data = $item1->normal_bid($nickname,$item_id,$bid_price,$quantity); 	
	//pre 2 check if update database if commplete
	if ($bid_return_data['bid_complete'])
	{
	//pre 2 for prepare data
	$owner_name 	= $bid_return_data['owner_nickname'];
	$owner_email	= $bid_return_data['owner_email'];
	$bidder_name	= $nickname;
	$bidder_email	= $bid_return_data['bidder_email'];	
	$underbid_name	= $bid_return_data['underbid_nickname']	;
	$underbid_email	= $bid_return_data['underbid_email'];	
	$reserve	= $bid_return_data['reserve'];
	$met_reserve	= $bid_return_data['met_reserve'];

	if (!$reserve) // not reserve price bid
	 {
		//2,3,4 mail to confirm bidder and tell owner
		$item1 = new normal_bid_mail;
		$item1->to_owner($owner_email,$owner_name,
			$item_id,$bid_price,$bidder_name);
		$item1->to_bidder($bidder_email,$bidder_name,
			$item_id,$bid_price); 
		$item1->to_underbid($underbid_email,
			$underbid_name,$item_id);
 	 } // end not reserve bid
	else // reserve price bid
	 {
		//2,3,4 mail to confirm bidder and tell owner
		$item1 = new reserve_bid_mail;	
		if ($met_reserve)
			{
				$item1->to_met_reserve_owner
				($owner_email,$owner_name,
				$item_id,$bid_price,$bidder_name);
				
				$item1->to_met_reserve_bidder
				($bidder_email,$bidder_name,
				$item_id,$bid_price);
				
				$item1->to_underbid($underbid_email,
				$underbid_name,$item_id);
				
			}	
		else
			{
				$item1->to_not_met_reserve_owner
				($owner_email,$owner_name,
				$item_id,$bid_price,$bidder_name);
				
				$item1->to_not_met_reserve_bidder
				($bidder_email,$bidder_name,
				$item_id,$bid_price);
				
				$item1->to_underbid($underbid_email,
				$underbid_name,$item_id);
			}
 	 }
	return $bid_return_data; 	
	}
	else  return $bid_return_data;	
	

}// end normal_bid
//----------------------------------------------------
// use with individual 
 function check_auction_close($item_id){
	$item1 = new item_sql;
	$dutch_item1 = new dutch_item;
	$check_result = $item1->check_auction_close($item_id);

	if ($check_result['close'])
		{
			if($check_result['auction_type'] == 1)
				{
				$this->close_normal_auction($item_id);
				echo " in item_class item ".$item_id." is
				close<br>";
  				}
			elseif($check_result['auction_type'] == 2)
				{
				$this->close_reserve_price_auction($item_id);
				echo " in item_class item ".$item_id." is
				close<br>";

				}
			elseif($check_result['auction_type'] == 3)
				{

				$dutch_item1->dutch_auction_close($item_id);
				echo" in item_class ".$item_id." is dutch
				close<br>";
				}
		}  
	//else echo " item is no close";
	
}// end check_auction_close
//----------------------------------------------------
function check_group_close(){
 // use to check and close appropriate auction for each item 
 //1 check time table if next check_time < current time
 //2 get item_id and auction type
 //3 close item

 //1 check time table if next check_time < current time
     $time1	= new time_sql;

 //2 get item_id and auction type
     if ($time1->next_close())
 	{
		$item1	= new item_sql; 
		$dutch_item1 = new dutch_item;	
		$item_list = $item1->get_close_list();
 //3 close item
		$length = $item_list[0]['id'];
		for ($i=1;$i<=$length;$i++)
		{
			if ($item_list[$i]['auction_type'] == 1) 
			{
			     $this->close_normal_auction($item_list[$i]['id']);    	 	 
			   //echo "normal close item".$item_list[$i]['id']."<br>";
    			}
  			elseif ($item_list[$i]['auction_type'] == 2) 
			{ 					
				$this->close_reserve_price_auction($item_list[$i]['id']);  	 
			}  
 			elseif ($item_list[$i]['auction_type'] == 3)
  			{ 
			//echo " dutch close is not support now<br>"; 
			 //	echo "item =".$item_list[$i]['id']."<br>";	
			$dutch_item1->dutch_auction_close($item_list[$i]['id']); 	  		 	
			}  
	 	 	 	 	 			  
	       		}//end for length       	 
	} //end if check time
}// end check_group_close
//----------------------------------------------------
//input $item_id
function close_reserve_price_auction($item_id)
{
	//1 update close column in item
	//2 check if final price met reserve price
	//3 get highest_bidder email,owner email,final price
	//4 mail to highest bidder with link to item_detail page and owner email  	 	
	//5 mail to owner with link to item_detail page and bidder email

	//1 update close column in item
	$item1 = new item_sql;
	$close_data = $item1->reserve_close($item_id);
	$close_data['item_id'] = $item_id;
	
	//2 check if final price met reserve price
	if ($close_data['sell'])
	{
	//3,4,5
	$mail1 = new normal_close_mail;
	$mail1->to_owner(
			$close_data['owner_email'],
			$close_data['owner_name'],
			$close_data['bidder_email'],
			$close_data['bidder_name'],
			$close_data['item_id'],
			$close_data['price']); 
	$mail1->to_bidder(
			$close_data['owner_email'],
			$close_data['owner_name'],
			$close_data['bidder_email'],
			$close_data['bidder_name'],
			$close_data['item_id'],
			$close_data['price']); 

	$item2	= new save_sell_data;
	$item2->save_normal($item_id,$close_data);
	
	}// end can sell
	else	// item not sell
	{
		if ($close_data['bid_num'] > 0 )	  		 
		{
			//2.2.1 mail to tell seller that final price is not met
			$mail1 = new reserve_close_mail;
			$mail1->price_not_met(	
					$close_data['owner_email'],
					$close_data['owner_name'],
					$close_data['reserve_price'],
					$close_data['now_price'],
					$close_data['item_id']);
  		}// end price not met
		else	//no one bid
		{
			$mail1 = new normal_close_mail;
			$mail1->not_sell($close_data['owner_email'],
					$close_data['owner_name'],
					$close_data['item_id']);
		}	//end no one bid 	
	}// end item not sell
}//end close_reserve_price_auction
//----------------------------------------------------

}//item class
?>

































