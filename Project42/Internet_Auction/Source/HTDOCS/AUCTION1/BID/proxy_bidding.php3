<?php
include('/www/htdocs/auction1/bid/next_price_class.php3');
include('/www/htdocs/mail/proxy_bid_mail.php3');


class proxy_bidder{
function proxy_bid($item_id){
// 1 get proxy data from proxy table and lock item for update


//1
	$conn	= ocinlogon("bonn","bonn79","bk");
/*	$column ='member_id,nick_name,e_mail,max_price,now_pri,
		  highest_bidder,proxy_bid.quantity,
		  to_char(proxy_time,'yymmddhh24miss') as bid_time;  */
	 	 	$stmt =ociparse($conn,"select 
 					member_id,nick_name,e_mail,
					max_price,now_pri,highest_bidder,
					proxy_bid.quantity,
					to_char(proxy_time,'yymmddhh24miss'),
					bid_num
					as bid_time
   					from  
					proxy_bid,item,member
  				where  proxy_bid.item_id   = $item_id 
 				and    item.item_id	   = $item_id
				and    member_id 	   = bidder
				and    max_price > now_pri
				and    credit > 0
				and    rating > 0		
				and    proxy_time in (select max(proxy_time)
						     from   proxy_bid
						     where  item_id = $item_id
						     group by bidder)   
	 			order by max_price asc,proxy_time asc
				for    update of  item.item_id");
	ociexecute($stmt,oci_default);
	$error1 = ocierror($stmt);
	
	if ( $error1['code'] == "") // no select error
	{
		$i = 0;
		while (ocifetch($stmt))
		{
			$i++;
			$proxy_data[$i]['member_id'] 	= ociresult($stmt,1);
			$proxy_data[$i]['nick_name'] 	= ociresult($stmt,2);
			$proxy_data[$i]['e_mail'] 	= ociresult($stmt,3);
			$proxy_data[$i]['max_price'] 	= ociresult($stmt,4);
			$proxy_data[$i]['now_price'] 	= ociresult($stmt,5);
			$proxy_data[$i]['highest_bidder'] = ociresult($stmt,6);
			$proxy_data[$i]['quantity'] 	= ociresult($stmt,7);
			$proxy_data[$i]['bid_time'] 	= ociresult($stmt,8);
			$bid_num			= ociresult($stmt,9);
  			
		}
			//$i--;
			$proxy_data[0]['count'] = $i;
			if ($i == 0) // no proxy avalable for item
			{
				$this->do_tx_true($conn);
				$proxy_data[0]['do_bid'] = false;
				return $proxy_data;
			}
			elseif ($i > 1) // do proxy
			{
	  $bid_complete =$this->do_proxy_bid($proxy_data,$conn,$item_id,$bid_num);  	
			if($bid_complete)   				
					{
					$proxy_data[0]['do_bid'] = true;
					$proxy_data[0]['bid_complete'] = true; 					 			
					return $proxy_data; 	
				 	}  			
			else 
					{
					$proxy_data[0]['do_bid'] = true;
					$proxy_data[0]['bid_complete'] = false;
					return $proxy_data; 			
					}
	 		}	    // do proxy	
			elseif ($i == 1) // proxy number = 1
			{
			if ( $proxy_data[1]['highest_bidder'] != $proxy_data[1]['member_id']) 				 	 
				{// do bidding 				 
		
 	
$bid_complete=$this->do_proxy_bid($proxy_data,$conn,$item_id,$bid_num);    
		if ($bid_complete)  		   	 	 
		{  	 				 	        
			$proxy_data[0]['do_bid'] = true; 	 	
	 		$proxy_data[0]['bid_complete'] = true;  
	 	        return $proxy_data;    			
		}
	 		else   	{
				 $proxy_data[0]['do_bid'] = true;
				 $proxy_data[0]['bid_complete'] = false; 					 			      
         			 return $proxy_data; 		
				} 	   		 	
				} // do bidding	
				else //no need to bid 		
				{
					$this->do_tx_true($conn);
 					$proxy_data[0]['do_bid'] = false;
	 			        return $proxy_data; 				
				}
 			}// proxy number = 1
			
	}// no select error
	else // select error
	{
		ocirollback($conn); // end item lock
		ocilogoff($conn);
	
		return(false);
	}// select error

}// end proxy_bid function
//---------------------------------------------------------
function do_proxy_bid($proxy_data,$conn,$item_id,$bid_num)
{
	//0 get first bid price
	//1 get bidding list
	//2 update item with highest bidder
	//3 insert into bid table
	
	//0 get bid price
		
	$price1 = new next_price;
	$next_price = 
		     $price1->get_next_price($proxy_data[1]['now_price']);
	 //1 get bid list
	$list_length = 0;
	$bid_number = $proxy_data[0]['count'];
	if($bid_number > 1)
	{
	for($i = 1;$i<=$bid_number;$i++)
	{
		if( $proxy_data[$i]['max_price'] >= $next_price)
		{//can make bid
		$list_length++; 
		$bid_data[$list_length]['member_id'] = $proxy_data[$i]['member_id']; 
		$bid_data[$list_length]['bid_price'] = $proxy_data[$i]['max_price']; 		 		
		$bid_data[$list_length]['bid_time'] = $proxy_data[$i]['bid_time'];  
		$bid_data[$list_length]['quantity'] = $proxy_data[$i]['quantity']; 	    

    		$next_price =
	 		$price1->get_next_price($proxy_data[$i]['max_price']);
   	    	// adjust max bid price
 		if($i == $bid_number)
		 {
			$bid_data[$i]['bid_price'] = $price1->get_next_price($bid_data[$i-1]['bid_price']); 		 
		 }
  		}//end can make bid 	 
			else 	
			{//can not make new bid list,update old bid list
			$use_first = false;
			$j = $list_length;
			$new_bidder = $proxy_data[$i]['member_id'];
			$new_time   = $proxy_data[$i]['bid_time'];
			$quantity = $proxy_data[$i]['quantity'];
			$tmp_data['time'] = $new_time;
			while($j > 0)
			{
				if($use_first) // proxy_data is use already
				{
				$new_bidder = $tmp_data['member_id'];
				$new_time   = $tmp_data['time'];
				$quantity   = $tmp_data['quantity'];
				}// end if proxy data is used already
				$tmp1 = $tmp_data['time'];
				$tmp2 = $bid_data[$j]['bid_time'];
				if($tmp1 < $tmp2)
 				 // if data in list is new for recent data 
  				{ 	
				
				$tmp_data['member_id'] =$bid_data[$j]['member_id']; 
 				$tmp_data['time'] =$bid_data[$j]['bid_time']; 
 				$tmp_data['quantity']=$bid_data[$j]['quantity'];  			 	 	 
				$bid_data[$j]['member_id'] = $new_bidder;
	 			$bid_data[$j]['bid_time']   = $new_time;  
				$bid_data[$j]['quantity']  = $quantity;
   	 	 	 	$use_first = true;   
	 	   	 	}// end if
		  	 	$j--;   	
		}//end while   		
	}// end else 	
	}//end get bid list
	
	}// end bid_number > 1
	else
	{
		if( $proxy_data[1]['max_price'] >= $next_price)
		{//can make bid
			$bid_data[1]['member_id']=$proxy_data[1]['member_id']; 	 		
			$bid_data[1]['bid_price'] =$next_price;  	 
			$bid_data[1]['bid_time'] =$proxy_data[1]['bid_time'];
		  	$bid_data[1]['quantity'] =$proxy_data[1]['quantity'];
	   	 	$next_price =$price1->get_next_price($next_price);  
		 	$list_length++;
  		}//end can make bid
		
	}
	if($list_length > 0)
	{// have to bid
	//1 update item with highest bidder and bid_num+$list_length
	$high_bidder = $bid_data[$list_length]['member_id'];
	$next_price  =  $bid_data[$list_length]['bid_price'];
		$stmt1 = ociparse($conn,"update item
			  set	 now_pri = $next_price,
			  	 highest_bidder = $high_bidder,
				 bid_num = $bid_num+$list_length
				 where item_id = $item_id"); 	
		ociexecute($stmt1,oci_default);  	 				
		$update_result = ocierror($stmt1);

	//2 insert into bid table
//	echo "length = ".$list_length."<BR>";
	for($i=1;$i<=$list_length;$i++)
	{
	
	$member_id = $bid_data[$i]['member_id'];
	$quantity = $bid_data[$i]['quantity'];
	$bid_price = $bid_data[$i]['bid_price'];
	
//	echo "member = ".$member_id." quantity = ".$quantity." bid p = ".
//			$bid_price."<BR>";

  	$stmt2 = ociparse($conn,"insert into
			bid(item_id,bidder,bid_time,price,quantity,bid_type)
 		values($item_id,
		$member_id,
		SYSDATE,
		$bid_price,
		$quantity,
		2)"); 	
	@ociexecute($stmt2,oci_default);
	$insert_result = ocierror($stmt2);
	if($insert_result['code'] !=""){$i=$list_length+1;}
	}
	}// end have to do bid
	if (($update_result['code'] == "") and ($insert_result['code']==""))
	{			 
		$this->do_tx_true($conn);
//*************************************
	//send mail
	$mail1 = new proxy_bid_mail;
	$mail1->send_mail($proxy_data,$bid_data,$list_length,$item_id);

//*************************************		
		 return true;
	}
	else 
	{
	 $this->do_tx_false($conn);
	 return false;
	}
	 
	

}// end do_proxy_bid
//---------------------------------------------------------
function do_tx_true($conn)
{
		ocicommit($conn); // end item lock
		ocilogoff($conn);

}
//---------------------------------------------------------
function do_tx_false($conn)
{
		ocirollback($conn); // end item lock
		ocilogoff($conn);
		echo "error occur";

}
//---------------------------------------------------------
function save_proxy_data($nick_name,$item_id,$bid_quantity,$proxy_price)
{
	$conn = ocinlogon("bonn","bonn79","bk");
	//1 get member_id
	$stmt = ociparse($conn,"select member_id 
				from member 
				where nick_name = '$nick_name'");
	$result = @ociexecute($stmt,oci_default);
	ocifetch($stmt);
	$member_id  = ociresult($stmt,1);

	//2 insert into proxy_bid table
	$stmt1 = ociparse($conn,"insert into
	proxy_bid(item_id,bidder,max_price,quantity)
	values($item_id,$member_id,$proxy_price,$bid_quantity)");
	$result1 = ociexecute($stmt1,oci_default);
	
	if(($result == 1 ) and ($result1 == 1))
	{
		$save_result['complete']= true;
	}
	else
	{
		$error1 = ocierror($stmt1);
		if(($error1['code'] == 984) or($error1['code'] == 917))
			$save_result['message'] ='ข้อมูลราคาที่ยอมรับได้ผิดประเภท';
 		else
$save_result['message'] = 'Connection error';  	
$save_result['complete']= false; 	}
	$save_result['conn']	= $conn;
	return $save_result;

}// end save_proxy_data
}// end proxy_bidder class
?>
