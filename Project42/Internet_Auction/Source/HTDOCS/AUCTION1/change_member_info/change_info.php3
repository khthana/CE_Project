<?php
include('/www/htdocs/interface/ver.php3');
include ('/www/htdocs/interface/data_display_class.php3');

	$sql = new member_sql;
	$num=$sql->check($nickname,$password);

if ($num>0)
{
	$ver=new VERIFY_INTERFACE;
	$ver->verify($num);
}
else
{
	$display1 = new data_display;
	$display1->notmember();
}

?>
