<?php
include ('/www/htdocs/sql_class/category.php3');

$category1=new category;
echo "
	<html>
<body bgcolor='white' link='#0077ff' alink='#22aa22' vlink='#0077ff'
text='#800040' > ";
$category = $category1->get_category_name($id);
for($i=1;$i<=$category[0]['num'];$i++)
	{
	$x=$category[$i]['id'];
	$y=$category[$i]['name'];
//if ( $category[0]['num']>0)
//{
	echo "<a
	href='http://161.246.5.146/auction1/main/main4.php3?id=$x'

onClick=window.self.location='http://161.246.5.146/auction1/category.php3?id=$x'
target='right_frame'>
	$y</a><br>"; 
//}//end if
//else
//{
//	echo"$y";	
//} 

}
echo "
	</body>
	</html> ";
?>
