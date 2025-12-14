<?php
class data_arranger{
function add_br($data)
// use with data that retrieve from database
{
	$data = str_replace("\n","<br>",$data);
	return $data;
}// end add_br

function add_quote($data) 
// use with data that is post from page have  ' and will insert to database
{
	$data = str_replace("\'","''",$data);
	
	return $data;

}// end add_quote
}// end add_br
?>
