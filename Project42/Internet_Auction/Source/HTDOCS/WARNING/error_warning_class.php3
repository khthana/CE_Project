<?php
include('/www/htdocs/auction1/message.php3');
include('/www/htdocs/interface/rectang_interface_class.php3');

class error_warning {
function regis_warning($error_number) {
	
	$message1 = new message;
	$rectang1 = new rectang_interface;

	$array_long = count($error_number[]);
	$message="<font color='#6600FF'><br><h2>กรุณาป้อน :</h2><h3>";
	  if 	 ($error_number[1] == 1) //empty nick_name
		{ $message=$message.$message1->empty_nickname."<br>";
		} 	  
	  
	  if ($error_number[2] == 1 ) //empty name
		{ $message=$message.$message1->empty_firstname."<br>";}

	  if ($error_number[3] == 1 ) //empty sur
		{ $message=$message.$message1->empty_lastname."<br>";}

	  if ($error_number[4] == 1 ) //empty email
		{ $message=$message.$message1->empty_email."<br>";}

	  if ($error_number[5] == 1 ) //empty address
		{ $message=$message.$message1->empty_address."<br>";}

	  if ($error_number[6] == 1 ) //empty bound
		{ $message=$message.$message1->empty_bound."<br>";}

	  if ($error_number[7] == 1 ) //empty province
		{ $message=$message.$message1->empty_postal."<br>";}
	
	  if ($error_number[9] == 1 ) //empty province
		{ $message=$message.$message1->incorrect_password."<br>";}
  	  
	  if	($error_number[8] == 1 ) //empty pass 		
		{ $message=$message.$message1->empty_password."<br>";}
        $message=$message."</h3></font>";    
	$rectang1->simple_reg($message);

}//fn regis_warning
//--------------------------------------------------------
//--function post warning
//--INPUT array of error number 6
//--OUTPUT warning message
function post_warning($error_number) {
	$message1 = new post_message;
	$rectang1 = new rectang_interface;


	$message="<font color='#6600FF'><br><h2>กรุณาป้อน :</h2><br><h3>";
	  if 	 ($error_number[1] == 1) //empty nick_name
		{ $message=$message.$message1->empty_nickname."<br>";}
	  if ($error_number[2] == 1 ) //empty password
		{ $message=$message.$message1->empty_password."<br>";}

	  if ($error_number[3] == 1 ) //empty title
		{ $message=$message.$message1->empty_title."<br>";}

	  if ($error_number[4] == 1 ) //empty quantity
		{ $message=$message.$message1->empty_quantity."<br>";}

	  if ($error_number[5] == 1 ) //empty startprice
		{  $message=$message.$message1->empty_startprice."<br>";}

	  if ($error_number[6] == 1 ) //empty minprice
		{  $message=$message.$message1->empty_minprice."<br>";}
	
	if ($error_number[7] == 1 ) //empty category
		{  $message=$message.$message1->empty_category."<br>";}
        
	$message=$message."</h3></font>";    
	$rectang1->simple_reg($message);


}//end post warning
//--------------------------------------------------------
//--------------------------------------------------------
//--function bid warning
//--INPUT array of error number 5
//--OUTPUT warning message
function bid_warning($error_number) {
	$message1 = new bid_message;
	$rectang1 = new rectang_interface;


	$message="<font color='#6600FF'><br><h2>กรุณาป้อน :</h2><h3>";
	  if 	 ($error_number['nickname'] == 1) //empty nick_name
		{ $message=$message.$message1->empty_nickname."<br>";}
	  if ($error_number['password'] == 1 ) //empty password
		{ $message=$message.$message1->empty_password."<br>";}

	  if ($error_number['quantity'] == 1 ) //empty quantity
		{ $message=$message.$message1->empty_quantity."<br>";}

	  if ($error_number['bid_price'] == 1 ) //empty startprice
		{  $message=$message.$message1->empty_bid_price."<br>";}
	$message=$message."</h3></font>";
	$rectang1->simple_reg($message);


}//end post warning
//--------------------------------------------------------
}//class error_warning

?>
