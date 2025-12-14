<?php
class item_sql{
//-----------------------------------
//--function insert all-------------
//--use to insert item data into database item table
//--INPUT  $title,$category,$description,$quantity,
//--$auctiontype,$startprice,$minprice,$period,$payment,$shipment,$userfile
//--OUTPUT item_id,item owner email
function insert_all($member_id,$title,$category,$description,$quantity,
$auctiontype,$startprice,$minprice,$period,$payment,$shipment,
$userfile,$location){

//	echo"userfile in item in sql_class".$userfile;
	$column_name ="ITEM_ID,TITLE,CATEGORY,DESCRIPTION,PICTURE_URL,QUANTITY,
	       	 
      	MINIMUM_BID,RESERVE_PRICE,AUCTION_TYPE,START_DATE,PERIOD,OWNER
	,PAYMENT#,SHIPMENT,STOP_DATE,NOW_PRI,ITEM_LOCATION";


	$conn=OCINlogon("bonn","bonn79","bk");
	$stmt1=ociparse($conn,"insert into item($column_name)
values(item_id.nextval,'$title','$category','$description','$userfile',$quantity,
$startprice,$minprice,$auctiontype,SYSDATE,$period,$member_id,$payment,$shipment,
SYSDATE+$period,$startprice,$location)");  	

	$insert_result = @ociexecute($stmt1,oci_default);  	 	 
	if($insert_result != "")
	{// no insert error 
	$stmt2 = ociparse($conn,"
				select item_id,e_mail 
				from member,item 
				where item_id in 
				(select  max(item_id) from item) 
				and member_id = owner
	 	 				
				");
	 $select_result = $select_result =ociexecute($stmt2,oci_default);
	 ocifetch($stmt2);
	
		$post_result['item_id'] = ociresult($stmt2,1);
		$post_result['e-mail']  = ociresult($stmt2,2);
		$post_result['message'] = "<font color='#6600FF'><br><h2>การนำสินค้าเข้ารับการประมูล
					</h2><br><h3>สามารถทำได้เรียบร้อย</h3>"; 		
		$post_result['complete'] = true;
		
	//ocirollback($conn);			
	ocicommit($conn); 
	}//end no insert error
	else
	{//insert error
		ocirollback($conn);
		$error1 = ocierror($stmt1);
		if(($error1['code']== 917 )or ($error1['code']== 984 ))
		$post_result['message']='<h1>ท่านใส่ข้อมูลผิดประเภท
		</H1><BR><H2>กรุณาป้อนข้ อมูล ราคาสินค้า หรือจำนวนสินค้าใหม่</h2>';   
	else $post_result['message'] ="<font
			color='#6600FF'><br><h2>ขออภัยครับ
</h2><br><h3>คุณป้อนข้อมูลผิดประเภท</h3>" ; 	 
		$post_result['complete'] =false;

	}
	ocilogoff($conn);
	return $post_result;
} //end insert_all

//-----------------------------------
// for show
//	where (item_id=$item_id) and (province_id = item_location)
//	and (shipment_id = shipment) and (payment_id = payment#)

function select_all($item_id){

        $column_name =
	"item.ITEM_ID,item.TITLE,category.CATEGORY_NAME,item.DESCRIPTION,
	item.PICTURE_URL,item.QUANTITY,
        item.MINIMUM_BID,auction_type.AUCTION_TYPE_NAME,
	TO_CHAR(START_DATE,'DD-MON-YYYY HH24:MI:SS'),
	TO_CHAR(STOP_DATE,'DD-MON-YYYY HH24:MI:SS'),
	NICK_NAME,
	payment.PAYMENT_TYPE,shipment.SHIPMENT_TYPE,item.NOW_PRI,
	item.BID_NUM,province.PROVINCE_NAME,member.RATING,
	item.HIGHEST_BIDDER,member.e_mail";

        $conn = OCINlogon("bonn","bonn79","bk");
        $stmt = ociparse($conn,"
	select $column_name 
	from item,province,payment,shipment,member,auction_type,category
	where item_id=$item_id  and province_id = item_location
		and payment_id = payment# and shipment_id = shipment
		and member_id = owner and
		item.auction_type=auction_type.auction_type_id
		and category_id = category
	");
        ociexecute($stmt,oci_default);
	while (ocifetch($stmt))
                {
                        $item_data['id']            = ociresult($stmt,1);
                        $item_data['title']         = ociresult($stmt,2);
                        $item_data['category']      = ociresult($stmt,3);
                        $item_data['description']   = ociresult($stmt,4);
                        $item_data['picture']       = ociresult($stmt,5);
                        $item_data['quantity']      = ociresult($stmt,6);
                        $item_data['start_bid']     = ociresult($stmt,7);
                        $item_data['auction_type']  = ociresult($stmt,8);
                        $item_data['start_date']    = ociresult($stmt,9);
                        $item_data['stop_date']     = ociresult($stmt,10);
                        $item_data['owner']         = ociresult($stmt,11);
                        $item_data['payment']       = ociresult($stmt,12);
                        $item_data['shipping']      = ociresult($stmt,13);
                        $item_data['now_price']     = ociresult($stmt,14);
                	$item_data['num_bid']       = ociresult($stmt,15);
			$item_data['location']	    = ociresult($stmt,16);
			$item_data['rating']	    = ociresult($stmt,17);
 			$item_data['highest_bidder']= ociresult($stmt,18);
                        $item_data['e_mail']	    = ociresult($stmt,19);  
	
		}
	$highest = $item_data['highest_bidder'];
        $stmt = ociparse($conn,"
	select nick_name 
	from member
	where member_id = $highest");
        ociexecute($stmt,oci_default);
	while (ocifetch($stmt))
                {
                        $item_data['highest_bidder']= ociresult($stmt,1);
	  	}

        ocilogoff($conn);
/*	return array($id,$title,$category,$description,$picture,$quantity,
	$start_bid,$auction_type,$start_date,$stop_date,$owner,$payment,
	$shipping,$now_price,$num_bid,$location);*/
	return $item_data;
} //end select_all  for show    
//-------------------------------------------------------------
//select_item_list($category_id)
//INPUT $category_id
//OUTPUT  array of item_id,title,current price,number of bid ,stop
//	  date,picture_url

function item_list($category_id){
$column_name =
		"ITEM_ID,TITLE,NOW_PRI,BID_NUM,
		TO_CHAR(STOP_DATE,'DD-MON-YYYY HH24:MI:SS'),
		PICTURE_URL"; 
$row_count = 1;
$line_number = 30;// line_number isuse for number of item info that will 		  
//display per page


        $conn = OCINlogon("bonn","bonn79","bk");
        $stmt = ociparse($conn,"
	select $column_name 
	from item 
	where CATEGORY like('$category_id%') and close = 0
	ORDER BY ITEM_ID");         
	ociexecute($stmt,oci_default);
	while ((ocifetch($stmt)) and ($row_count < $line_number))
 	{
               $item_data[$row_count]['item_id']	= ociresult($stmt,1); 
               $item_data[$row_count]['title']         	= ociresult($stmt,2);
	       $item_data[$row_count]['now_price']     	= ociresult($stmt,3);
               $item_data[$row_count]['bid_num']   	= ociresult($stmt,4);
	       $item_data[$row_count]['stop_date']   	= ociresult($stmt,5);
       	       $item_data[$row_count]['picture_url']	= ociresult($stmt,6);
	       
	       $row_count++;	 	 	
	}
	$item_data[0]['num']=$row_count-1;
	ocilogoff($conn);	
	return $item_data;
}//end item_list
//-------------------------------------------------------------------------
// use normal_bid to bid item for normal bidding
// input $nickname of bidder ,$item_id,$bid_price
// out put item owner nick_name,owner email

	//1 first select for update item table
	// bid_num,bidder_id,reserve_price,auction_type,now_pri
	//2 check if bid price > now_pri
	//3 update item  table for new bid information
	//4 update bid  table for new bid information
	//5 release row lock of item_id
	//6 get current under price bidder
	//7 get item owner and email
	//8 for reserve price auction


 function normal_bid($nickname,$item_id,$bid_price,$quantity){

	//1 first select for update item table
	//  bid_num,bidder_id,reserve_price,auction_type,now_pri

	 $column = 'bid_num,MEMBER_ID,reserve_price,
		    auction_type,now_pri';
		
	 $conn = ocinlogon("bonn","bonn79","bk");
	 $stmt = ociparse($conn," 
				select bid_num,MEMBER_ID,reserve_price,
					auction_type,now_pri
 				from item,member 
				where nick_name='$nickname' 
				and item_id =$item_id
 				for update of item.auction_type");
 
	$result = @ociexecute($stmt,oci_default); 
	ocifetch($stmt);
		$bid_num 				= ociresult($stmt,1);
		$member_id 				= ociresult($stmt,2);
		$bid_return_data['reserve_price']	= ociresult($stmt,3);
		$bid_return_data['auction_type']	= ociresult($stmt,4);
		$now_pri				= ociresult($stmt,5);
		
	//2 check if bid price > now_pri
	$next_price = $this->get_next_price($now_pri);
	if ($bid_price >= $next_price)
	{
	//3 update item  table for new bid information

  	$stmt1 = ociparse($conn,"
        			update item  
				set   
				now_pri = $bid_price, 	
				bid_num = $bid_num+1, 	
				highest_bidder = 
						(select member_id 
						from member 
						where nick_name ='$nickname')
				where item_id= $item_id ");
	
     	$result1 = @ociexecute($stmt1,oci_default);    
	
	//4 update bid  table for new bid information
	$stmt2 = ociparse($conn,"
		insert into bid(item_id,bidder,bid_time,price,quantity)
		values($item_id,$member_id,SYSDATE,$bid_price,$quantity)");
	$result2 = @ociexecute($stmt2,oci_default);

	//5 release row lock of item_id
	//ocicommit($conn);		

	//6 get current under price bidder
	$stmt3 = ociparse($conn,"
		select nick_name,e_mail
		from bid,member
		where member_id = bidder 
		and   price = 
		(
			select max(price)
			from bid
			where price <
					(
					select max(price) 
					from bid 
					where item_id = $item_id
					)  
			and item_id = $item_id		
 		)
		and item_id = $item_id
		");
	$result3 = @ociexecute($stmt3,oci_default);
	ocifetch($stmt3);
	$bid_return_data['underbid_nickname']	=	ociresult($stmt3,1);
	$bid_return_data['underbid_email']	=	ociresult($stmt3,2);
	
	//5 release row lock of item_id
	//ocicommit($conn);		

	
	//7 get item owner and email
	$stmt4 = ociparse($conn,"
			  select  t1.nick_name,t1.e_mail,t2.e_mail
			  from 	  member t1,member t2,item
			  where  t1.member_id = owner
			  and	  t2.nick_name = '$nickname'
			  and     item_id = $item_id");   
	
	$result4 = @ociexecute($stmt4,OCI_DEFUALT);
	ocifetch($stmt4);
	$bid_return_data['owner_nickname']	=	ociresult($stmt4,1);
	$bid_return_data['owner_email']		=	ociresult($stmt4,2);
	$bid_return_data['bidder_email']	=	ociresult($stmt4,3);
	$bid_return_data['bid_complete']	=	true;		

	//8for reserve price auction******************************
	if ($bid_return_data['auction_type'] == 2) 
		{
		  $bid_return_data['reserve']	= 	true;
	   	  if ($bid_price >= $bid_return_data['reserve_price']) 
		      $bid_return_data['met_reserve']  =  true;
		  else $bid_return_data['met_reserve'] =  false;
			
 		}
	else	
		{
		  $bid_return_data['reserve']	= 	false;
		}
	//******************************
	if(($result == "") or ($result1== "")
	    or ($result2 == "") or ($result3 == "")
	    or ($result4 == ""))
	{//error occur
		ocirollback($conn);
		$bid_return_data['bid_complete']	=	false;
		if(($result1 == "") or ($result2 == ""))
		{
			$update_result = ocierror($stmt1);
			$insert_result = ocierror($stmt2);

			if(($update_result['code'] == 904) or
			   ($update_result['code'] == 933) or	
			   ($insert_result['code'] == 984) or
			   ($insert_result['code'] == 917))
			$bid_return_data['message'] = 'ป้อนข้อมูลผิดประเภท'; 			
		}
		else $bid_return_data['message'] ='เกิดปัญหากับระบบเครือข่าย';
 	}
	// commit and release lock
	ocicommit($conn);
	ocilogoff($conn); 	 	 	
	return $bid_return_data;
	} // end if bid_price > now_price
	else 
	{
	ocirollback($conn);
	$bid_return_data['bid_complete']	=	false;		
	ocilogoff($conn); 	 	 	
	return $bid_return_data;
	} // end else
 }// end normal_bid

//-------------------------------------------------------------------------
//function get_bid_data create 1/2/2000
//input item_id
//output $owner,current bid price
 function get_bid_data($item_id){

 $conn = ocinlogon("bonn","bonn79","bk");
 $stmt = ociparse($conn,"select nick_name,now_pri ,stop_date,quantity
			from item,member 
			where item_id = $item_id
			and 	member_id = owner
			and 	stop_date > sysdate");
 ociexecute($stmt,oci_default);
 while (ocifetch($stmt)) 
	{
	$item_data['owner'] 	= ociresult($stmt,1);
	$item_data['now_price'] = ociresult($stmt,2);
	$item_data['close']	= ociresult($stmt,3);
	$item_data['quantity']	= ociresult($stmt,4);
	}

 ocilogoff($conn);
 return $item_data;


 
 }// end get_bid_data
//-------------------------------------------------------------------------
//return name of each data_id
//input auction type,payment ,shipment,province,category
//output all name
function
get_post_preview_data($auctiontype,$payment,$shipment,$province,$category){
 	
 $column ='AUCTION_TYPE_NAME,PAYMENT_TYPE,SHIPMENT_TYPE,PROVINCE_NAME,CATEGORY_NAME';	 
 
 $conn = ocinlogon("bonn","bonn79","bk");  
 $stmt = ociparse($conn,"
	 select  $column
	 from auction_type,payment,shipment,province,category
	 where  auction_type_id	= $auctiontype 	and
	        payment_id	= $payment 	and
		shipment_id	= $shipment 	and
		province_id	= $province 	and
		category_id	= '$category'	");
  ociexecute($stmt,oci_default);    
  while (ocifetch($stmt))
	{
	$post_preview_data['auction_type']	= ociresult($stmt,1);
	$post_preview_data['payment']		= ociresult($stmt,2);
	$post_preview_data['shipment']		= ociresult($stmt,3);
	$post_preview_data['province']		= ociresult($stmt,4);
	$post_preview_data['category']		= ociresult($stmt,5);
	}

 ocilogoff($conn);
 return $post_preview_data;	

} //end get_post_preview_data
//-------------------------------------------------------------------------
function normal_close($id){
	 $conn = ocinlogon("bonn","bonn79","bk");  

		
	//1.1 check if item is sell
	$stmt = ociparse($conn,"select nick_name,e_mail,bid_num,quantity
				from item,member
				where item_id = $id
				and   member_id = owner");
	ociexecute($stmt,oci_defualt);
	ocifetch($stmt);
		$close_data['owner_name']	= ociresult($stmt,1);
		$close_data['owner_email'] 	= ociresult($stmt,2);
		$close_data['bid_num']		= ociresult($stmt,3);
		$close_data['quantity']		= ociresult($stmt,4);

	if ($close_data['bid_num']>0)	//mean item is sold
	{
	//2 get associative data
	// bidder nickname ,email , now price
	 $column ='nick_name,e_mail,now_pri';
	 $stmt1= ociparse($conn," select $column 		
	  			  from   ITEM,MEMBER
		 		  where  member_id = highest_bidder
				  and  	 item_id = $id");	  
	ociexecute($stmt1,OCI_DEFUALT);
	while (ocifetch($stmt1))
		{
		$close_data['bidder_name']	= ociresult($stmt1,1);
		$close_data['bidder_email']	= ociresult($stmt1,2);
		$close_data['price']		= ociresult($stmt1,3);
		}
	ocilogoff($conn);
	$close_data['sell'] = true;
	return $close_data;
	}// item is sold
	else	// item is not sold
	{
	ocilogoff($conn);
	$close_data['sell'] = false;
	return $close_data;
	
	}
 }// end normal_close
//-----------------------------------------------------------------------
function check_auction_close($item_id){
	 $conn = ocinlogon("bonn","bonn79","bk");  
	 $stmt = ociparse($conn,"select item_id,auction_type 
				 from 	item
				 where item_id = $item_id
				 and stop_date <= sysdate
				 and close = 0
				 for update");
	 ociexecute($stmt,OCI_DEFUALT);
	 ocifetch($stmt);
	 $check_result['close'] 	= ociresult($stmt,1);
	 $check_result['auction_type'] 	= ociresult($stmt,2);

//	ocilogoff($conn);
	if ($check_result['close']>0) 
		{
			$check_result['close']	= true;
//*************************************************************	 
	$stmt = ociparse($conn,"update item set close = 1
				where item_id = $item_id");  	
	ociexecute($stmt,OCI_COMMIT_ON_SUCCESS);
	ocicommit($conn);
//*************************************************************	 

		}
	else
		{
			ocicommit($conn);
			$check_result['close']	= false;
		}
	ocilogoff($conn);
	return $check_result;
		
}// end check_auction_close
//-----------------------------------------------------------------------
function get_close_list(){
	 $conn = ocinlogon("bonn","bonn79","bk");  
	 $stmt = ociparse($conn,"select item_id,auction_type
				 from item
				 where stop_date < sysdate
				 and   close = 0
				 for update ");
	ociexecute($stmt,oci_defualt);
	$count  = 1;
	while(ocifetch($stmt))
		{
		  $item_list[$count]['id'] 		= ociresult($stmt,1);
		  $item_list[$count]['auction_type'] 	= ociresult($stmt,2);
		  $count++;	
		}
		  $item_list[0]['id']	= --$count;
//*************************************************************	 
	//0 update column close in item set it to 1 to indicate auction is
	//  closed 	  	
	//1 because of select for update
	for ($i=1;$i<=$count;$i++)
		{
		$item_id = $item_list[$i]['id'];
		$stmt = ociparse($conn,"update item 
				set close = 1
				where item_id = $item_id");  	
		ociexecute($stmt,OCI_COMMIT_ON_SUCCESS);
		}
	ocicommit($conn);
//*************************************************************	 
	ocilogoff($conn);
	return $item_list;
		
}// end get_close_list
//-----------------------------------------------------------------------
function reserve_close($id){

	//1 check if final price met reserve price
 	//1.11 if item is not sold
	//1.13 get owner nick_name and e_mail ,reserve price,final price
	//1.21 if item is sold
	//1.22 normal close

	 $conn = ocinlogon("bonn","bonn79","bk");  
	

	//1 check if final price met reserve price
	 $column = 'nick_name,e_mail,reserve_price,now_pri,bid_num,quantity';
	 $stmt = ociparse($conn,"select $column
	     			from item,member
				where item_id = $id
				and    member_id = owner");

	 ociexecute($stmt,oci_defualt);
	 ocifetch($stmt);
	 $close_data['owner_name']		= 	ociresult($stmt,1); 
  	 $close_data['owner_email'] 		= 	ociresult($stmt,2);
	 $close_data['reserve_price']		= 	ociresult($stmt,3);
	 $close_data['now_price']		= 	ociresult($stmt,4);
	 $close_data['bid_num']			= 	ociresult($stmt,5);
	 $close_data['quantity']		=  	ociresult($stmt,6);
  	if (($close_data['reserve_price'] > $close_data['now_price'])or 
	   ($close_data['bid_num'] == 0 ))
		{
		 	//1.11 means item is not sold
			$close_data['sell']	= 	false;
		ocilogoff($conn);
		return $close_data; 
		} 	
	else
		{
	//1.21 mean item is sold
	//1.24 get associative data
		// owner,bidder nickname ,email , now price
 	
	//1.24 get associative data
	 $column ='nick_name,e_mail,now_pri';
	 $stmt1= ociparse($conn," select $column 		
	  			  from   ITEM,MEMBER
		 		  where  member_id = highest_bidder
				  and  	 item_id = $id");	  
	ociexecute($stmt1,OCI_DEFUALT);
	while (ocifetch($stmt1))
		{
		$close_data['bidder_name']	= ociresult($stmt1,1);
		$close_data['bidder_email']	= ociresult($stmt1,2);
		$close_data['price']		= ociresult($stmt1,3);
		}
	ocilogoff($conn);
	$close_data['sell'] = true;
	return $close_data;
		}// end item is sold

}// end reserve_close
//-----------------------------------------------------------------------
function get_next_price($now_price){
	if (($now_price>0)&&($now_price<50))
	{
		$minprice = $now_price+5;
	}
	elseif (($now_price>49)&&($now_price<300))
	{
                $minprice = $now_price+10;
	}
	elseif (($now_price>299)&&($now_price<1000))
	{
                $minprice = $now_price+50;
	}
	elseif ($now_price>999)
	{
                $minprice = $now_price+100;
	}
	
	return $minprice;
}// end get_next_price

}//end item_sql


?>
