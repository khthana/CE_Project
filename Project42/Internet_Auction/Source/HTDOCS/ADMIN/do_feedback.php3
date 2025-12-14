<?php
include ('/www/htdocs/admin/admin_sql_class.php3');
include ('/www/htdocs/interface/rectang_interface_class.php3');

$sql = new admin_sql;
$result=$sql->feedback($sender,$receiver1,$item_id);

$rec = new rectang_interface;
echo"<br>";
        $rec->simple_reg($result);   
?>
