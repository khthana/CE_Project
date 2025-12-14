<?php

class registration_data_checker{
//------------------------------------------------------------
function check_nick_name($con1,$nicknames){


//	$con1=ocilogon("bonn","bonn79","bk");
	$stmt3=ociparse($con1,"select MEMBER_ID from member where
	NICK_NAME='$nicknames'"); 
	@ociexecute($stmt3,oci_default);
	$fetch =@ ocifetch($stmt3);

	if ($fetch>=1) 
	{$result = 0;}
	else {$result = 1;};
	
//	ocilogoff($conn1);
	return $result;		
	} //function

//------------------------------------------------------------
function check_email($con1,$email){


//	$con1=ocilogon("bonn","bonn79","bk");
	$stmt3=ociparse($con1,"select MEMBER_ID from member where
	E_MAIL='$email'"); 
	@ociexecute($stmt3,oci_default);
	$fetch = @ocifetch($stmt3);

	if ($fetch>=1) 
	{$result = 0;}
	else {$result = 1;};
	
//	ocilogoff($conn1);
	return $result;		
	} //function

//------------------------------------------------------------
//--this function is used to check exist NICK_NAME and E_MAIL
//--INPUT = NICK_NAME , E_MAIL from registration page
//--OUTPUT
//--------IF EXIST RETURN 0 ELSE RETURN 1;

function regis_check($nickname,$email){

	$con1=ocinlogon("bonn","bonn79","bk");
	
	$name_exist  = $this->check_nick_name($con1,$nickname);
	$email_exist = $this->check_email($con1,$email);
	ocilogoff($conn1);

	return array($name_exist&&$email_exist,$name_exist,$email_exist);
	

}//regis_check

//------------------------------------------------------------
function check_member_data(
	 $nickname,$password,$title,$firstname,$lastname,
	$birth,$email,$address,$bound,$province,$postal,
	$repassword){
	
	if     	($nickname  == "")  { $enn= 1;} else { $enn= 0;}
	if     	($firstname == "")  { $efn= 1;}	else { $efn= 0;}
	if 	($lastname  == "")  { $eln= 1;}	else { $eln= 0;}
	if 	($email     == "")  { $eem= 1;}	else { $eem= 0;}
 	if 	($address   == "")  { $ead= 1;}	else { $ead= 0;}
	if 	($bound     == "")  { $ebn= 1;}	else { $ebn= 0;}
	if 	($postal    == "")  { $ept= 1;}	else { $ept= 0;}
	if 	($password  == "")  { $epw= 1;}	else { $epw= 0;}
	if 	($password  != $repassword)  { $epws= 1;} else { $epws= 0;}
 	
	return array($enn,$efn,$eln,$eem,$ead,$ebn,$ept,$epw,$epws);	

}// check_member_data function
//------------------------------------------------------------
//------------------------------------------------------------
//--this function is used to check update NICK_NAME and E_MAIL
//--INPUT = NICK_NAME , E_MAIL from member_class.php3
//--OUTPUT
//--------IF EXIST RETURN 0 ELSE RETURN 1;

function update_check($member_id,$nickname,$email){

	$con1=ocinlogon("bonn","bonn79","bk");
	
$name_exist  = $this->check_nick_name_update($member_id,$con1,$nickname);
$email_exist = $this->check_email_update($member_id,$con1,$email); 
ocilogoff($conn1);

	return array($name_exist&&$email_exist,$name_exist,$email_exist);
	

}//regis_check


//------------------------------------------------------------
function check_nick_name_update($member_id,$con1,$nicknames){


//	$con1=ocilogon("bonn","bonn79","bk");
	$stmt3=ociparse($con1,"select MEMBER_ID from member where
	NICK_NAME='$nicknames' and MEMBER_ID <> $member_id"); 
	@ociexecute($stmt3,oci_default);
	$fetch = @ocifetch($stmt3);

	if ($fetch>=1) 
	{$result = 0;}
	else {$result = 1;};
	
//	ocilogoff($conn1);
	return $result;		
	} //function

//------------------------------------------------------------
//------------------------------------------------------------
function check_email_update($member_id,$con1,$email){


//	$con1=ocilogon("bonn","bonn79","bk");
	$stmt3=ociparse($con1,"select MEMBER_ID from member where
	(E_MAIL='$email' and MEMBER_ID <> $member_id)"); 
	@ociexecute($stmt3,oci_default);
	$fetch = @ocifetch($stmt3);

	if ($fetch>=1) 
	{$result = 0;}
	else {$result = 1;};
	
//	ocilogoff($conn1);
	return $result;		
	} //function

//------------------------------------------------------------

}	//class

?>
