<?php
include ('/www/htdocs/interface/rectang_interface_class.php3');
include('/www/htdocs/interface/main_admin_class.php3');   

	if (($name=='bonnkhing')&&
		($password1=='khing')&&
		($password2=='bonn'))
{
	$frame1 = new frame_auction;
	$frame1->print_frame();
}

	else 
{
	$message="<h2>Sorry!</h2>Name or Password is not correct.";
	$rec = new rectang_interface;
	
	echo "
	<html>
	<body bgcolor=white><br><br>";
	$rec->simple_reg($message);
}
?>
