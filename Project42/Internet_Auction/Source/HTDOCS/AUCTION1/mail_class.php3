<?php
include('/www/htdocs/auction1/mail_message_class.php3');

class mail_class{
function sendmessage($email,$subject,$message){
	mail($email,$subject,$message,"from:webmaster@esl19.ce.kmitl.ac.th");
	}

//---------------------------------------
function regis_mail($email,$nickname,$password)
{
	$message1 = new mail_message;
	

	mail($email,"welcome to BK-auction",
	"To ".$nickname."\n".
	$message1->regis_message.
  	"\nNICKNAME =".$nickname.
 	"\nPASSWORD = ".$password .
	"\nBK-auction:http://161.246.5.146/auction1/b-k.php3
	 happy to serve you.
		BK-Auciton"
	,"from:webmaster@esl19.ce.kmitl.ac.th")  ;
}

//---------------------------------------
function post_mail($email,$nickname,$item_id)
{
	mail($email,"BK-auction_Post complete",
		    "Welcome to BK-auction 
		     Post item is complete 
		     Item id = $item_id
		     you can track your item at
		 http://161.246.5.146/interface/bid_frame.php3?item_id=$item_id
			Happy to serve you
			BK-Auction ",
		     "from:webmaster@esl19.ce.kmitl.ac.th");

} //end post_mail		

//---------------------------------------


}// end mail_class
?>
