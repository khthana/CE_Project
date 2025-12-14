<?php
include('/www/htdocs/sql_class/dutch_item.php3');
include('/www/htdocs/sql_class/save_sell_data.php3');
//include('/www/htdocs/mail/normal_close_mail.php3');

class dutch_item{
function dutch_auction_close($item_id)
{
	// 1 close item and get 
	//   owner,bidder,email,number of item,price
	
	$dutch_item1	=	new dutch_item_sql;
	$close_data	=	$dutch_item1->dutch_close($item_id);

	 //1.1 if item is sell
	$mail1 = new dutch_close_mail;
	$save_sell1 = new save_sell_data;

	if ($close_data[0]['sell'])	
	{	
	for ($i=1;$i<=$close_data[0]['count'];$i++)
	 {

	 $mail1->to_bidder(
			$close_data[0]['owner_email'],
			$close_data[0]['owner_name'],
			$close_data[$i]['bidder_email'],
			$close_data[$i]['bidder_name'],
			$item_id,
			$close_data[0]['bid_price'],
			$close_data[$i]['bid_quantity']); 
			$details =
			$details.$close_data[$i]['bidder_name']." ".
			$close_data[$i]['bidder_email']." got ".
			$close_data[$i]['bid_quantity']."\n";
	
		 }//end for
	//save sell data to sell_item table
	$save_sell1->save_dutch($item_id,$close_data);

 			$mail1->to_owner(
			$close_data[0]['owner_email'],
			$close_data[0]['owner_name'],
			$item_id,
			$close_data[0]['bid_price'],
			$close_data[0]['remain_item'],
			$details); 

	}// end if item is sell
	else	// item is not sell
	{
	$mail1->not_sell($close_data[0]['owner_email'],
			$close_data[0]['owner_name'],
			$item_id);
	}	// end item is not sell

	
}// end dutch_auction_close
}// end dutch_item
?>
