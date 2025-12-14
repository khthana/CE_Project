<?php
include('/www/htdocs/sql_class/feedback.php3');
include('/www/htdocs/interface/rectang_interface_class.php3');

$feed = new feedback_class;

if (($nickname1 != '')&&($nickname2 != '')
   &&($password != '')&&($itemid != ''))
{
$message=$feed->feedback_sell_bid($nickname1,$password,$status,$nickname2,
			 $itemid,$grade,$description);
}
else 
{
$message="Enter data for working";
}

echo "
<html>
<body bgcolor = 'white'>
<br>";
$rectang1=new rectang_interface;
$rectang1->simple_reg($message);
echo"
</body>
</html>";
?>
