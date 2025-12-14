<?php
include ('/www/htdocs/admin/admin_sql_class.php3');
include ('/www/htdocs/interface/rectang_interface_class.php3');

$sql = new admin_sql;
$result=$sql->credit($member_id,$nickname,$credit);

$rec = new rectang_interface;

if ($result==1)
{
	$message="<h2>Update complete</h2>";
}
else 
{
	$message="<h2>Sorry!</h2>Please check your data again.";
}

echo"
<html>
<body bgcolor=white>";
        $rec->simple_reg($message);
?>
