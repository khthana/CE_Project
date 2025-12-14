<?php
class proxy_bid_mail
{
 function send_mail($proxy_data,$bid_data,$list_length,$item_id)
 {
	$conn = ocinlogon("bonn","bonn79","bk");

	$under_data=$this->manage_data($proxy_data,$bid_data,$list_length);
	$owner_data = $this->get_owner($item_id,$conn);
	$this->to_owner($owner_data['e_mail'],
			$owner_data['nick_name'],
			$item_id,
			$bid_data[$list_length]['bid_price'],
			$under_data[$list_length]['nick_name'],
			$bid_data[$list_length]['quantity']);

	$this->to_new_high($under_data[$list_length]['e_mail'],
			   $under_data[$list_length]['nick_name'],
			   $item_id,
			   $bid_data[$list_length]['bid_price'],
			   $bid_data[$list_length]['quantity']	
			    );
  
$this->to_new_under($under_data,$list_length,$item_id);

	$old_data =
$this->get_nick_name($proxy_data[1]['highest_bidder'],$conn);  
$this->to_old_bidder($old_data['e_mail'], 		     
$old_data['nick_name'],$item_id);

	ocilogoff($conn);

	}//end send mail
//------------------------------------------------------------ 
function
to_new_high($bidder_email,$bidder_name,$item_id,$price,$quantity)  { 
	mail($bidder_email,"Confirm bid item $item_id :BK-auction", 	
"Hello $bidder_name .
 	 This mail is to confirm you bid for item $item_id  by proxy bidding.
 	 Your bid price is $price baht .Quantity = $quantity.
  	 You can track  this item at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id
			happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end 		
//-------------------------------------------
function to_new_under($under_data,$list_length,$item_id)
{
	$count = $list_length - 1;
	for($k=1;$k<=$count;$k++)
	{
	$this->	to_under(
		$under_data[$k]['e_mail'] ,
		$under_data[$k]['nick_name'], 
		$item_id,
		$under_data[$k]['bid_price'],
		$under_data[$k]['quantity']
		);
	}
}
//-------------------------------------------
function to_old_bidder($underbid_email,$underbid_name,$item_id) 
{
	mail($underbid_email,"Your bid for item $item_id is out of bid now!:BK-auction", 	
	"Hello $underbid_name . 	 
	 This mail is to tell you that you bid for item $item_id is out of bid now!.   	 
	 There is someone has gave higher price for item $item_id than you price .
    	 You can check the current price at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id
	 		happy to serve you 
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
}//end to old bidder
//------------------------------------------------
function bidder_data($nick_name,$conn)
{
	$conn = ocinlogon("bonn","bonn79","bk");
	$stmt = ociparse($conn,"select nick_name,e_mail 
				from member
				where nick_name ='$nick_name'");
	ociexecute($stmt);
	ocifetch($stmt);
	$nick_name = ociresult($stmt,1);
	$e_mail = ociresult($stmt,2);
	return $e_mail;

}//end get old
//--------------------------------------------------
function manage_data($proxy_data,$bid_data,$list_length)
{
	$k = 1;

	for($i=1;$i<=$list_length;$i++)
	{
	$j = 1;
	$found = false;
		while(!$found and ($j<=$proxy_data[0]['count']))
		{
		 	if ($proxy_data[$j]['member_id'] == $bid_data[$i]['member_id'])
 		 	{
		$under_data[$k]['nick_name']=$proxy_data[$j]['nick_name']; 
		$under_data[$k]['e_mail'] =$proxy_data[$j]['e_mail']; 
		$under_data[$k]['bid_price']=$bid_data[$j]['bid_price'];
		$under_data[$k]['quantity']=$bid_data[$j]['quantity']; 
				$k++;
				$found = true;
		     	}
			$j++;
		
		}
	}
	return $under_data;
}

//--------------------------------------------------
function to_under($underbid_email,$underbid_name,$item_id,$price,$quantity)
{
	mail($underbid_email,"Your bid for item $item_id is out of bid now!:BK-auction", 	
	"Hello $underbid_name . 	 
	 This mail is to tell you that you've bid for item $item_id by proxy
	bidding system.And quantity = $quantity .With price = $price.
	But your bid is out of bid now! by another proxy system.
  	 There is someone has gave higher price for item $item_id than you price . 
     	  You can check the current price at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id
	 		happy to serve you 
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;

}
//-------------------------------------------------------
function
 to_owner($owner_email,$owner_name,$item_id,$price,$bidder_name,$quantity)
{ 	
	mail($owner_email,"Your item $item_id is bid : BK-auction",
	"Hello $owner_name
	 Now the auction for your item $item_id is keep going.
	 Current highest bidder is $bidder_name .
	 Current price is $price baht .
	 Quantity = $quantity .
    	  You can check the current price at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id
	 		happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to owner

//-------------------------------------------------------
function get_owner($item_id,$conn)
{
	$stmt = ociparse($conn,"select nick_name,e_mail
			        from item,member
				where member_id = owner
				and   item_id = $item_id");
	ociexecute($stmt,oci_default);
	ocifetch($stmt);
	$owner_data['nick_name'] = ociresult($stmt,1);
	$owner_data['e_mail'] 	= ociresult($stmt,2);
	return $owner_data;
}
//-------------------------------------------------------
function confirm_proxy($nick_name,$item_id,$bid_quantity,$proxy_price)
{
	$conn = ocinlogon("bonn","bonn79","bk");
	$e_mail = $this->bidder_data($nick_name,$conn);

mail($e_mail,"Confirm using proxy biding for item $item_id :BK-auction",
	 "Hello $nick_name .
 	 This mail is to confirm your proxy_biding for item $item_id  
	 Your maximum proxy bid price is $proxy_price baht .Quantity =$bid_quantity.
    	 You can track  this item at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id
			happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
		

}// confirm_proxy
//-------------------------------------------------------
function get_nick_name($member_id,$conn)
{
	$stmt = ociparse($conn,"select nick_name,e_mail
				from member
				where member_id = $member_id");
	ociexecute($stmt,oci_default);
	ocifetch($stmt);
	$old_data['nick_name'] = ociresult($stmt,1);
	$old_data['e_mail']	= ociresult($stmt,2);
	return $old_data;
	
}//end get nick_name
//-------------------------------------------------------
}// end proxy_bid_mail
//-------------------------------------------------------

?>
