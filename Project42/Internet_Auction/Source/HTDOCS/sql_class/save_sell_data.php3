<?php
class save_sell_data
{
function save_dutch($item_id,$close_data){
 $conn = ocinlogon("bonn","bonn79","bk");
 $price = $close_data[0]['bid_price'];
 for ($i=1;$i<=$close_data[0]['count'];$i++)
 {	
 //1 get bidder id	
	$name = $close_data[$i]['bidder_name'];
	$stmt = ociparse($conn,"select 	member_id
				from 	member
				where 	nick_name='$name'");

	ociexecute($stmt,oci_defautl);
	ocifetch($stmt);
	$member_id = ociresult($stmt,1);

 //2 insert into sell 	

	$quantity = $close_data[$i]['bid_quantity'];
    	$stmt =ociparse($conn," insert into			
				sell_item(item_id,vendee,price,amount) 	
	 			values($item_id,
				       $member_id,
				       $price,
				       $quantity)");

	ociexecute($stmt,OCI_COMMIT_ON_SUCCESS);
	
  }	// end for
  ocilogoff($conn);			
}// end save dutch
//---------------------------------------------------------------------
function save_normal($item_id,$close_data)
{
	$conn	= ocinlogon("bonn","bonn79","bk");
 //1 get bidder id	
	$name = $close_data['bidder_name'];
	$stmt = ociparse($conn,"select 	member_id
				from 	member
				where 	nick_name='$name'");

	ociexecute($stmt,oci_defautl);
	ocifetch($stmt);
	$member_id = ociresult($stmt,1);

 //2 insert into sell 	
	$quantity = $close_data['quantity'];
	$price	  = 	$close_data['price'];
    	$stmt =ociparse($conn," insert into			
				sell_item(item_id,vendee,price,amount) 	
	 			values($item_id,
				       $member_id,
				       $price,
				       $quantity)");

	ociexecute($stmt,OCI_COMMIT_ON_SUCCESS);
	ocilogoff($conn);			
	

}
//---------------------------------------------------------------------

}// end save sell data
?>
