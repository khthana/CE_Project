<?php
class dutch_item_sql{
function dutch_close($item_id){

//   check if item is sell
// 1 get item_quantity,highest_bidder,bid_price,bid_quantity,e_mail
// 2 get seller e_mail
// 3 while remain item
// 4 get next highest bidder 

	
// 1 check if item is sell
	$conn = ocinlogon("bonn","bonn79","bk"); 
	$stmt = ociparse($conn,"select 	nick_name,e_mail,bid_num,quantity
				from 	item,member
				where 	item_id = $item_id
				and   	member_id = owner");
	ociexecute($stmt,OCI_DEFAULT);
	ocifetch($stmt);

		$close_data[0]['owner_name']	= ociresult($stmt,1);
		$close_data[0]['owner_email'] 	= ociresult($stmt,2);
		$bid_num			= ociresult($stmt,3);
		$quantity			= ociresult($stmt,4);

	if ($bid_num>0)	//mean item is sold
	 {
		$close_data[0]['sell'] 		= true;
		//2 get associative data
		$column = 'nick_name,e_mail,
		   	   bid.price,bid.quantity';

//		$conn = ocinlogon("bonn","bonn79","bk"); 
		$stmt = ociparse($conn,"select  $column
					from 	member,bid
					where	item_id = $item_id
					and	price 	= ( select max(price)
							    from   bid
							    where item_id = $item_id)
					and	member_id = bidder");
		ociexecute($stmt,oci_default);
		ocifetch($stmt);
		$close_data[1]['bidder_name']	= 	ociresult($stmt,1); 
  	 	$close_data[1]['bidder_email'] 	=  	ociresult($stmt,2);
		$close_data[1]['bid_price']	= 	ociresult($stmt,3); 
  	 	$close_data[1]['bid_quantity'] 	=  	ociresult($stmt,4);
		
		$bid_price	= $close_data[1]['bid_price'];
		$remain_bidder 	= true;
		$remain_item 	= $quantity - $close_data[1]['bid_quantity'];
		$count		= 1;


		if ($remain_item > 0)	//means remain item
		{

		$column ='nick_name,e_mail,bid.price,bid.quantity';	 
	 	  while (($remain_item > 0 ) and ($remain_bidder))  //get nextbidder      	  	  
			{ 		 
			$count++;
			$stmt	= ociparse($conn,"select $column 	
	 	  			  from   member,bid
	 	 	  		  where	 price = ( 	
	 	 					select max(price)
	 	 	 				from bid 	
	 						where price < $bid_price  						
							and item_id = $item_id 	  						  
						         ) 		
		 			  and 	member_id = bidder
	 	 	 		  and 	item_id = $item_id");

			 ociexecute($stmt,oci_default);
			 ocifetch($stmt);

		$close_data[$count]['bidder_name'] 	= ociresult($stmt,1);
    	 	$close_data[$count]['bidder_email']     = ociresult($stmt,2); 
  		$close_data[$count]['bid_price']	= ociresult($stmt,3);     	 	 	 	
		$close_data[$count]['bid_quantity']	=  ociresult($stmt,4); 

			$name = $close_data[$count]['bidder_name'];
			$same_bidder = false;
			for($i = 1;$i<$count;$i++) // check for same bidder
			{
				if ($name == $close_data[$i]['bidder_name'])
 				{

					$bid_price   = $close_data[$count]['bid_price'];
					$i = $count;
					$count--;
					$same_bidder = true;	
	 			}
			}
		     if (!$same_bidder)	// regis data
			{	
			$remainx = $remain_item - $close_data[$count]['bid_quantity'];
  			if ( $name =="")	//no more bidder
  	  			{
				$remain_bidder	= false;
				$close_data[0]['count'] = $count-1;
//				$close_data[0]['bid_price'] = $close_data[$count-1]['bid_price']; 

				$close_data[0]['bid_price'] = $bid_price;
				$close_data[0]['remain_item'] = $remain_item;
			 	 ocilogoff($conn);
 	 	  	 	return $close_data;
	  	 	 	}   	
	 		elseif ($remainx <= 0) // if no more item to sell
  			{ 	
			$close_data[$count]['bid_quantity'] = $remain_item;
	 		$remain_bidder	= false;
	 		$close_data[0]['count'] = $count; 		
			$close_data[0]['bid_price'] = $close_data[$count]['bid_price']; 		
			$close_data[0]['remain_item'] = 0;
 		 	ocilogoff($conn);
	               	return $close_data;	  	 	

	  		 }// end if no more item to sell
			else	// have remain item
			 {
				$remain_item = $remainx;	
				$bid_price   = $close_data[$count]['bid_price'];
 	 		 } // end have remain
			}  // end regis data			
  		 }// end while
 		}// end if $remain_item > 0 		
		else //no remain item
		{ 
		 ocilogoff($conn);
		 $close_data[0]['count'] = 1;
		$close_data[0]['bid_price'] = $close_data[1]['bid_price'];
		 return $close_data;	  	 			
		}// end else
    	 }// end item is sold
	 	else	// item is not sold
	 {
	 	ocilogoff($conn);
		$close_data[0]['sell'] = false;
		return $close_data;

	 }// end item is not sold

}// end close_dutch_auction
}// end class dutch_item

?>
