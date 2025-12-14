<?php
//include('/www/htdocs/sql_class/item.php3');  

// ***********************
class search
{

// ****************
function search_id($id)
{
$column_name =
                "ITEM_ID,TITLE,NOW_PRI,BID_NUM,
                TO_CHAR(STOP_DATE,'DD-MON-YYYY HH24:MI:SS'),
                PICTURE_URL";
$row_count = 1;
$line_number = 30;// line_number isuse for number of item info that will
//display per page 

        $conn = OCINlogon("bonn","bonn79","bk");
        $stmt = ociparse($conn,"
        select $column_name
        from item
        where item_id = $id " );
        @ociexecute($stmt,oci_default);
        while (@ocifetch($stmt))
        {
               $item_data[$row_count]['item_id']        =
ociresult($stmt,1);
               $item_data[$row_count]['title']          =
ociresult($stmt,2);
               $item_data[$row_count]['now_price']      =
ociresult($stmt,3);
               $item_data[$row_count]['bid_num']        =
ociresult($stmt,4);
               $item_data[$row_count]['stop_date']      =
ociresult($stmt,5);
               $item_data[$row_count]['picture_url']    =
ociresult($stmt,6);

               $row_count++;
        }
        $item_data[0]['num']=$row_count-1;
	ocilogoff($conn);   
        return $item_data; 
}//function search_id

// ****************
function
search_seller($nickname,$status,$category,$auction_type,$sort1,$sort2)
{
$column_name =
                "ITEM_ID,TITLE,NOW_PRI,BID_NUM,
                TO_CHAR(STOP_DATE,'DD-MON-YYYY HH24:MI:SS'),
                PICTURE_URL";
$row_count = 1;
$line_number = 30;// line_number isuse for number of item info that will
//display per page

        if ($auction_type == '0') {$auction_type = '' ;}
        elseif ($auction_type == '1') {$auction_type = 'and
auction_type=1'
;}
        elseif ($auction_type == '2') {$auction_type = 'and
auction_type=2'
;}
        elseif ($auction_type == '3') {$auction_type = 'and
auction_type=3'
;}   

	if ($status == 0) {$status = '' ;}
	elseif ($status == 1) {$status = 'and close=0' ;}
        elseif ($status == 2) {$status = 'and trunc(sysdate-1) =
		trunc(stop_date) and close=1' ;}
        elseif ($status == 3) {$status = 'and trunc(sysdate-2) <=
                trunc(stop_date) and close=1' ;} 
        elseif ($status == 4) {$status = 'and trunc(sysdate-7) <=
                trunc(stop_date) and close=1' ;} 
        elseif ($status == 5) {$status = 'and trunc(sysdate-14) <=
                trunc(stop_date) and close=1' ;} 
  
        $conn = OCINlogon("bonn","bonn79","bk");  
        $stmt = ociparse($conn,"
        select $column_name
        from item
        where owner = (
		     select member_id 
		     from member 
		     where nick_name='$nickname' ) 
		and category like '${category}%'
		$status
		$auction_type
	order by $sort1 $sort2
	" );

        @ociexecute($stmt,oci_default);
        while (@ocifetch($stmt))
        {
               $item_data[$row_count]['item_id']        =
ociresult($stmt,1);
               $item_data[$row_count]['title']          = 
ociresult($stmt,2);
               $item_data[$row_count]['now_price']      =
ociresult($stmt,3);
               $item_data[$row_count]['bid_num']        =
ociresult($stmt,4);
               $item_data[$row_count]['stop_date']      =
ociresult($stmt,5);
               $item_data[$row_count]['picture_url']    =
ociresult($stmt,6);   

               $row_count++;
        }
        $item_data[0]['num']=$row_count-1;
        ocilogoff($conn);
        return $item_data;
}//function search_seller  


// ****************
function
search_title($title,$description,$status,$category,$auction_type,$sort1,$sort2,$nimprice,$maxprice)
{
$column_name =
                "ITEM_ID,TITLE,NOW_PRI,BID_NUM,
                TO_CHAR(STOP_DATE,'DD-MON-YYYY HH24:MI:SS'),
                PICTURE_URL";
$row_count = 1;
$line_number = 30;// line_number isuse for number of item info that will
//display per page

	if ($auction_type == '0') {$auction_type = '' ;}
        elseif ($auction_type == '1') {$auction_type = 'and
auction_type=1'
;}
        elseif ($auction_type == '2') {$auction_type = 'and
auction_type=2'
;}
        elseif ($auction_type == '3') {$auction_type = 'and
auction_type=3'
;}

        if ($status == 0) {$status = '' ;}
        elseif ($status == 1) {$status = 'and close=0' ;}
        elseif ($status == 2) {$status = 'and trunc(sysdate-1) =
                trunc(stop_date) and close=1' ;}
        elseif ($status == 3) {$status = 'and trunc(sysdate-2) <=
                trunc(stop_date) and close=1' ;}
        elseif ($status == 4) {$status = 'and trunc(sysdate-7) <=
                trunc(stop_date) and close=1' ;}
        elseif ($status == 5) {$status = 'and trunc(sysdate-14) <=
                trunc(stop_date) and close=1' ;}    

        if ($description == 1)
        {
                $sql_where = "((lower(title) like lower('%${title}%'))
                       or (lower(description) like lower('%${title}%')))"
;
        }
        else
        {
                $sql_where =" lower(title) like lower('%${title}%') "  ;
        }    

        $conn = OCINlogon("bonn","bonn79","bk");
 
       $stmt = ociparse($conn,"
        select $column_name
        from item
        where $sql_where 
              and category like '${category}%'
              and now_pri between $nimprice and $maxprice
	      $status
	      $auction_type
        order by $sort1 $sort2
        " );      
	
	@ociexecute($stmt,oci_default);
        while (@ocifetch($stmt))
        {          
               $item_data[$row_count]['item_id']        =
ociresult($stmt,1);
               $item_data[$row_count]['title']          =
ociresult($stmt,2);
               $item_data[$row_count]['now_price']      =
ociresult($stmt,3);
               $item_data[$row_count]['bid_num']        =
ociresult($stmt,4);
               $item_data[$row_count]['stop_date']      =
ociresult($stmt,5);
               $item_data[$row_count]['picture_url']    =
ociresult($stmt,6);

               $row_count++;
        }
        $item_data[0]['num']=$row_count-1;
        ocilogoff($conn);
        return $item_data;
}//function search_title  

}//class search
?>
