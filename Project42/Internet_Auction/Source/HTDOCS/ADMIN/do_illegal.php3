<?php
include ('/www/htdocs/admin/admin_sql_class.php3');
include ('/www/htdocs/interface/rectang_interface_class.php3');

$sql = new admin_sql;
$result=$sql->illegal($item_id,$type1);

$rec = new rectang_interface;
echo"<br>";
        $rec->simple_reg($result);
?> 
