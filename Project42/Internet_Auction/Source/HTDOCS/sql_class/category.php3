<?php
class category
{
function get_category_name($category_id)
{
	$i=1; 
	$conn=ocinlogon("bonn","bonn79","bk");
	$stmt=ociparse($conn,"select * from category
			where category_id like '${category_id}__' ");
	ociexecute($stmt,oci_default);
	while (ocifetch($stmt))
	{
		$category[$i]['id'] = ociresult($stmt,1);
		$category[$i]['name'] = ociresult($stmt,2);
		$i++;		
	}
	$category[0]['num'] = $i-1;
	if ($category[0]['num']== 0)
	{
		$stmt=ociparse($conn,"select category_id,category_name 
			      from category
			      where category_id = '$category_id'");
		ociexecute($stmt,oci_default);
		while (ocifetch($stmt))
		{
			$category[1]['id'] = ociresult($stmt,1);
			$category[1]['name'] = ociresult($stmt,2);
					
		}// end while
	$category[0]['num'] = 1;
	}// end if
	ocilogoff($conn);
	return $category;
}//end function get_category_name
}//end class category
?>
