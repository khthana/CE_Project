<?php
class post_checker{
//------------------------------------------------------------
//--Use to check null of post data
//--Input nickname,password,title,quantity,auctiontype,start price,
//--minimum price 
//--Output array of error number;

function check_preview_data(
	 $nickname,$password,$title,$quantity,$auctiontype,$startprice,
	$minprice,$category){
	
	if     	($nickname  	== "")  { $enn= 1;} 	else { $enn= 0;}
	if 	($password  	== "")  { $epw= 1;}	else { $epw= 0;}
	if     	($title	    	== "")  { $ett= 1;}	else { $ett= 0;}
	if 	($quantity  	== "")  { $eqt= 1;}	else { $eqt= 0;}
	if 	($startprice    == "")  { $est= 1;}	else { $est= 0;}
	if	($category	== "")	{ $cat= 1;}	else { $cat=0;}
	  	
	if 	(($minprice  == "" ) and ($auctiontype == 2))  
		{$emp=1;}	 			
	else { $emp= 0;} 	 	
	

	
	return array($enn,$epw,$ett,$eqt,$est,$emp,$cat);	

}// check_preview_data function
//------------------------------------------------------------
}
?>
