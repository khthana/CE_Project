<?php
include('/www/htdocs/interface/category/computer_category_interface.php3');
include('/www/htdocs/interface/header_interface_class.php3');
 
$computer_interface1 = new computer_category_interface;
$header1 =new header_interface;

$header1->print_head();
$computer_interface1->print_category();
$header1->print_buttle();
?>
