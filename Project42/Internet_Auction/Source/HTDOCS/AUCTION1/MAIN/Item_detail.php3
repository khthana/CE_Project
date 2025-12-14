<?php

include('/www/htdocs/auction1/item_class.php3'); 
include('/www/htdocs/interface/bid_interface_class.php3');

$item1 = new item;  
//$item1->check_auction_close($item_id);

$data = new item_sql;
$item_data = $data->select_all($item_id);                                                                             

			$id 		= 	$item_data['id'];
                        $title		=	$item_data['title']         ;
                        $category	=	$item_data['category']   ;
   			$description    =	$item_data['description'];
			$picture        =	$item_data['picture'];
			$quantity       =	$item_data['quantity'];      
			$start_bid      =       $item_data['start_bid'];
			$auction_type   =	$item_data['auction_type']  ;
			$start_date     =	$item_data['start_date'];
			$stop_date      =	$item_data['stop_date']  ;   
			$owner		=	$item_data['owner'];
	           	$payment        =	$item_data['payment'];        
             		$shipping       =	$item_data['shipping'];    
			$now_price      =	$item_data['now_price'];     
			$num_bid        =       $item_data['num_bid']   ;     
			$location   	=	$item_data['location']	 ;    
			$rating 	= 	$item_data['rating']	  ;   
			$highest_bidder =	$item_data['highest_bidder'];
			$e_mail		=	$item_data['e_mail'];

			$description = nl2br($description);
			
$bid_interface = new bid_item;
$bid_interface->display_detail($id,$title,$category,$description,$picture,$quantity,
        $start_bid,$auction_type,$start_date,$stop_date,$owner,$payment,
	$shipping,$now_price,$num_bid,$location,$rating,$highest_bidder
	,$e_mail);
			
echo"
</body>
</html>";

?>
