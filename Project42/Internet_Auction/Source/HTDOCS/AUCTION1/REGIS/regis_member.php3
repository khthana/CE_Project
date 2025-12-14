<?php
include('/www/htdocs/auction1/member_class.php3');

$newmember = new member ;

$newmember->registration_member(
			$nickname,$password,$title,$firstname,$lastname, 
			$birth,$email,$address,$bound,$province,$postal, 
			$phone,$page,$fax); 
?>
