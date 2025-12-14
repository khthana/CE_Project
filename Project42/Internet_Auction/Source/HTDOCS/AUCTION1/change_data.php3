<?php
class change_class
{
function change_regis($nickname,$password,$firstname,$lastname,$birth,
		      $email,$address,$bound,$postal,$phone,$page,$fax)
{
$nickname=str_replace("\'","'",$nickname);
$password=str_replace("\'","'",$password);
$firstname=str_replace("\'","'",$firstname);
$lastname=str_replace("\'","'",$lastname);
$birth=str_replace("\'","'",$birth);
$email=str_replace("\'","'",$email);
$address=str_replace("\'","'",$address);
$bound=str_replace("\'","'",$bound);
$postal=str_replace("\'","'",$postal);
$phone=str_replace("\'","'",$phone);
$page=str_replace("\'","'",$page);
$fax=str_replace("\'","'",$fax);  
return  array($nickname,$password,$firstname,$lastname,$birth,
	$email,$address,$bound,$postal,$phone,$page,$fax);
}

}

?>
