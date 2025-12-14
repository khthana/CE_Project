<?php
include('/www/htdocs/warning/error_warning_class.php3');
include('/www/htdocs/auction1/member_class.php3');
include('/www/htdocs/auction1/item_class.php3');

class bid_checker{
 function normal_bid_checker($nickname,$password,$quantity,$bid_price,$item_id)
 {
$rect = new rectang_interface; 

$warning1 	= new error_warning;
$member1 	= new member;
$item1		= new item;

//rule
// 1 check empty data
// 2 check nickname and password
// 3 not allow owner of item to bid item
// 4 bidder must give higher price than current price
// 5 bidder must have rating > 0
// 6 item is not closed ;
// 7 bid quantity must <= item quantity

// 1 check empty data
  $data	= $this->check_null($nickname,$password,$quantity,$bid_price);
	if ( $data['have_null'] == 1 ) 
		{ 
		
		//$message2 = $message1->get_error_mesage($data);
		//$error1->print_error($message2);
		$warning1->bid_warning($data);		
		return false;
		}

// pre 2 get member_data that require for bidding
	/*	$member_data['member_id'] 	
		$member_data['rating'] 		
		$member_data['credit'] 		*/
   $member_data = $member1->get_bid_data($nickname,$password);	
	
// 2 check nickname and password

  if ( $member_data['member_id'] == "") 	
		{ 
		$message= "<font
color='#6600FF'> ชื่อเล่นหรือรหัสผ่านไม่ถูกต้อง
<br>กรุณาป้อนใหม่<br>";
$rect->simple_reg($message); 
		return false;
		}

// pre 3 get item_data that require for bidding

/*	$item_data['owner']
	$item_data['now_price']	
	$item_data['close']
	$item_data['quantity']
*/
	$item_data = $item1->get_bid_data($item_id);
	

// 3 not allow owner of item to bid item
   if ($item_data['owner'] == $nickname)	
		{
		 $message="<br><font
color='#6600FF'>
เจ้าของสินค้าไม่สามารถจะประมูลสินค้าของตนเองได้<br>";
$rect->simple_reg($message);     
		 return false;
		}

//5 bidder must have rating > 0
   if ( $member_data['rating'] < 0 )
		{
 $message="<br><font
color='#6600FF'> ค่า Rating ต่ำกว่าที่กำหนด
คุณไม่สามารถประมูลสินค้าได้<br>";
$rect->simple_reg($message); 
		return false;  		
		}
// 6 item is not closed 
   if ( $item_data['close'] == "" )
		{
$message="<br><font
color='#6600FF'>สินค้าได้ปิดประมูลแล้ว";
$rect->simple_reg($message); 
			return false;	
		}
// 7 bid quantity must <= item quantity
   if ($quantity > $item_data['quantity'] )	
	{
$message="<br><font
color='#6600FF'>    
จำนวนสินค้าที่คุณต้องการมากกว่าจำนวนสินค้าที่มี";
$rect->simple_reg($message); 
			return false;
		}
 return true;
	   }// end normal_bid_checker function
//---------------------------------------------------- 
function check_null($nickname,$password,$quantity,$bid_price)  {
	if     	($nickname  	== "")  { $empty['nickname']= 1;} else{$empty['nickname']= 0;}
 	if 	($password  	== "")  { $empty['password']= 1;} else{$empty['password']= 0;}
   	if 	(($quantity 	== "")or($quantity == 0))  { $empty['quantity']= 1;} else{$empty['quantity']= 0;}
 	if      ($bid_price	== "")  {$empty['bid_price'] = 1;} else{$empty['bid_price']=0;}

	$empty['have_null'] = $empty['nickname']  | $empty['password']|
			       $empty['quantity'] | $empty['bid_price'];
	return $empty;  
} 

//------------------------------------------------------
function check_proxy_null($proxy,$proxy_price)
{
	if($proxy == 1)
	{
		if($proxy_price == "") return false; // null
		else return true;// not null
	}

}// end check_proxy_null
}// end bid_checker_class ?>
