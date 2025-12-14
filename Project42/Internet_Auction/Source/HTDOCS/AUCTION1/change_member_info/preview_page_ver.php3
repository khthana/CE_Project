<?php

include('/www/htdocs/data_check/regis_data_check.php3');
include('/www/htdocs/warning/error_warning_class.php3');
include('/www/htdocs/interface/preview_interface_class.php3');
	
	$regis_check = new registration_data_checker;
	$error1	     = new error_warning;  	
	$preview1    = new preview_interface;
	
	
list($result[1],$result[2],$result[3],$result[4],$result[5],$result[6],$result[7],$result[8],
 	      $result[9],) = $regis_check->check_member_data(
	 $nickname,$password,$title,$firstname,$lastname,
	$birth,$email,$address,$bound,$province,$postal,
	$repassword);
	
	
	if (($result[1] == 0 )&&($result[2] == 0 )&&($result[3] ==0)&&($result[4] == 0 )&&
 	     ($result[5] == 0 )&&($result[6] == 0)&&($result[7] == 0 )&&($result[8] == 0 )&&
		($result[9] == 0 ))	
	{ 	


$preview1->print_preview($nickname,$password,$title,$firstname,$lastname,
		    $birth,$email,$address,$bound,$province,$postal,
	            $phone,$page,$fax);

echo " 	
<form action
='http://161.246.5.146/auction1/change_member_info/ver_info_member.php3'
method = post>

 		
	<INPUT TYPE = hidden NAME = title value=$title  > 
	<INPUT TYPE = hidden NAME = id value=$id  > 
	<INPUT TYPE = hidden NAME = nickname value=$nickname  > 
	<INPUT TYPE = hidden NAME = firstname value=$firstname  > 
	<INPUT TYPE = hidden NAME = lastname value=$lastname  > 
	<INPUT TYPE = hidden NAME = password value=$password  > 
	<INPUT TYPE = hidden NAME = birth value=$birth  > 
	<INPUT TYPE = hidden NAME = email value=$email  > 
	<INPUT TYPE = hidden NAME = address value='$address'  > 
	<INPUT TYPE = hidden NAME = bound value=$bound  > 
	<INPUT TYPE = hidden NAME = province value=$province > 
	<INPUT TYPE = hidden NAME = postal value=$postal  > 
	<INPUT TYPE = hidden NAME = phone value=$phone  > 
	<INPUT TYPE = hidden NAME = page value=$page  > 
	<INPUT TYPE = hidden NAME = fax value=$fax  > 


	<br><input type= 'submit' value= NEXT>	
	</form>
	</CENTER>";

	} // if

	else
	{
		echo "<body  bgcolor='white'>";
		$error1->regis_warning($result);
	}
?>
