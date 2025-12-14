<?php
include('/www/htdocs/interface/frame_category_item_class.php3');
include('/www/htdocs/auction1/item_class.php3');

// 1 check for all item for close auction
$item1 = new item;
$item1->check_group_close();

// 2 create valid item list
$frame1 = new frame_category_item;
$frame1->print_frame($id);
?>
