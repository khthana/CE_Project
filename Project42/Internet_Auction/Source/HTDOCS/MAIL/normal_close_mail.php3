<?php

class normal_close_mail{

//---------------------------------------
function
 to_owner($owner_email,$owner_name,$bidder_email,$bidder_name,$item_id,$price)
{ 	
	mail($owner_email,"Auction for Item $item_id is close",
	"Hello $owner_name
	 Now the auction for your item $item_id is close .
	 Highest bidder is $bidder_name .
	 You can contact him with this e-mail $bidder_email .
	 Final price is $price baht .
	You can see another details at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id .
	",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to owner

//---------------------------------------
function 
to_bidder($owner_email,$owner_name,$bidder_email,$bidder_name,$item_id,$price) 
{
	mail($bidder_email,"Auction for Item $item_id is close",
	"Hello $bidder_name Congratulation!
	 Now auction for item  $item_id is close .
	 And You win the auction .
	 Item owner is $owner_name .
	 You can contact him with this e-mail $owner_email .
	 Final price is $price baht .
	You can see another details at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id .

	",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
} //end to_bidder		

//---------------------------------------
function
not_sell($owner_email,$owner_name,$item_id){

	mail($owner_email,"Auction for Item $item_id is close",
	"Hello $owner_name .
 	 Now the auction for  your item $item_id is close .	 
	 But there is no one bid for you item.
	 You can try it again with lower start price.
			Happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;


} // end not_sell
//---------------------------------------


}// end normal_close_mail_class
//---------------------------------------
class reserve_close_mail extends normal_close_mail{
function
price_not_met($owner_email,$owner_name,$reserve_price,$final_price,$item_id)
{
	mail($owner_email,"Auction for Item $item_id is close",
	"Hello $owner_name
 	 Now the auction for your item $item_id is close .	 
	 But the final price is not met your reserve price.
		Your reserve price 	= $reserve_price .
		Your final item price 	= $final_price .
	 You can try it again with lower reserve price.
			Happy to serve you
				BK-auction",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;
}//end price_not_met
//---------------------------------------
}// end reserve_close_mail
//---------------------------------------
class	dutch_close_mail extends normal_close_mail{

function
to_owner($owner_email,$owner_name,$item_id,$price,$remain,$details)
{
	mail($owner_email,"Dutch Auction for Item $item_id is close",
	"Hello $owner_name
	 Now the auction for your item $item_id is close
	 Final price is $price baht .
	Remain item (not sold) = $remain item .
	And detail is
	$details
	You can see another details at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id .

			Happy to serve you",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;

} 


function
to_bidder($owner_email,$owner_name,$bidder_email,
	$bidder_name,$item_id,$price,$quantity) 
{
	mail($bidder_email,"Dutch Auction for Item $item_id is close",
	"Hello $bidder_name Congratulation
	 Now auction for item  $item_id is close
	 And You are the one of winner.
	 Item owner is $owner_name
	 You can contact him with this e-mail $owner_email
	 Final price is $price baht .
	And you get $quantity item(s).
	You can see another details at 
         http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id .
			Happy to serve you",
	 "from:webmaster@esl19.ce.kmitl.ac.th")  ;

}


//---------------------------------------
}// end dutch_close_mail

?>
