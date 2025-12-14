<?php
include('/www/htdocs/auction1/'); 
$item_list1 = new item;

$item_list = $item_list1->get_item_list($category_id);
for ($j=1;$j<=count($item_list);$j++)
{
for ($i=1;$i<6;$i++)
	{
	echo "item_datail ".$item_list[$j][$i]."<br>";
	}
	echo"<br>";
}

?>
