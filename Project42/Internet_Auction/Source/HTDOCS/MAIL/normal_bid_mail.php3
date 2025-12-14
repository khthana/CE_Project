<?php

class normal_bid_mail{

//---------------------------------------
function
 to_owner($owner_email,$owner_name,$item_id,$price,$bidder_name)
{ 	
	mail($owner_email,"Your item $item_id is bid : BK-auction",
	"Hello $owner_name
	 Now the auction for your item $item_id is keep going.
	 Current highest bidder is $bidder_name .
	 Current price is $price baht .
	You can check the current price at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id	
 			happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to owner

//---------------------------------------
function 
to_bidder($bidder_email,$bidder_name,$item_id,$price) 
{
	mail($bidder_email,"Confirm bid item $item_id :BK-auction",
	"Hello $bidder_name .
	 This mail is to confirm you bid for item $item_id .
	 Your bid price is $price baht . 
	You can check the current price at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id
			happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to_bidder		

//---------------------------------------
function 
to_underbid($underbid_email,$underbid_name,$item_id) 
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
} //end to_bidder		

//---------------------------------------


}// end normal_close_mail_class
//---------------------------------------
class reserve_bid_mail extends normal_bid_mail{

function to_met_reserve_bidder($bidder_email,$bidder_name,$item_id,$price) 
{
	mail($bidder_email,"Confirm bid item $item_id :BK-auction",
	"Hello $bidder_name .
	 This mail is to confirm you bid for item $item_id .
	 Your bid price is $price baht . 
	And you bid price has been met reserve price already.
			happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to_reserve_bidder
//---------------------------------------
function to_not_met_reserve_bidder($bidder_email,$bidder_name,$item_id,$price) 
{
	mail($bidder_email,"Confirm bid item $item_id :BK-auction",
	"Hello $bidder_name .
	 This mail is to confirm you bid for item $item_id .
	 Your bid price is $price baht . 
	How ever you bid price is not met reserve price yet.
	Please try to give the higher bid price.
			happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to_reserve_bidder
//---------------------------------------
function
 to_met_reserve_owner($owner_email,$owner_name,$item_id,$price,$bidder_name)
{ 	
	mail($owner_email,"Your item $item_id is bid : BK-auction",
	"Hello $owner_name
	 Now the auction for your item $item_id is keep going.
	 Current highest bidder is $bidder_name .
	 Current price is $price baht .
	And his bid price has been met your reserve price already.
	 		happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to met owner

//---------------------------------------
function
	to_not_met_reserve_owner($owner_email,$owner_name,
	$item_id,$price,$bidder_name)
 { 	
	mail($owner_email,"Your item $item_id is bid : BK-auction",
	"Hello $owner_name
	 Now the auction for your item $item_id is keep going.
	 Current highest bidder is $bidder_name .
	 Current price is $price baht .
	However his bid price is not met your reserve price yet.
	 		happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to not met owner
//---------------------------------------

}// end reserve_close_mail class

?>
