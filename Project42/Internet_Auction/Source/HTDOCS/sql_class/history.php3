<?php
class history_class
{
function display_history($item_id)
{
 	
        $conn=ocilogon("bonn","bonn79","bk");

	$stmt=ociparse($conn,
		"select close from item where item_id=$item_id
		");
	ociexecute($stmt,oci_default);
	ocifetch($stmt);
	$close=ociresult($stmt,1);

if ($close==0)
{
        $stmt=ociparse($conn,
                "select max(nick_name),
			min(to_char(bid_time,'dd-mon-yy hh:mi:ss')),
                        min(e_mail)
                 from bid,member
                 where member_id=bidder and
                       item_id=$item_id
                 group by bidder
		 
                ");
        ociexecute($stmt,oci_default);  	
        $i=1;
        while (ocifetch($stmt))
        {
                $result[$i]['nickname']=ociresult($stmt,1);
                $result[$i]['time']=ociresult($stmt,2);
                $result[$i]['price']="*";
                $result[$i]['quantity']="*";
                $result[$i]['type']="*";
                $result[$i]['e_mail']=ociresult($stmt,3);
                $i++;
        }
}           
       
else 
{
        $stmt=ociparse($conn,
		"select nick_name,to_char(bid_time,'dd-mon-yy hh:mi:ss'),
			price,quantity,bid_type,e_mail
                 from bid,member
                 where member_id=bidder and
		       item_id=$item_id
		 order by price desc
                ");
        @ociexecute($stmt,oci_default);
        $i=1;
	while (@ocifetch($stmt))
        {
                $result[$i]['nickname']=ociresult($stmt,1);
                $result[$i]['time']=ociresult($stmt,2);
                $result[$i]['price']=ociresult($stmt,3);
                $result[$i]['quantity']=ociresult($stmt,4);
                $result[$i]['type']=ociresult($stmt,5);
                $result[$i]['e_mail']=ociresult($stmt,6); 
                $i++;
	}    
}
	$result[0]['num']=$i-1;
	ocilogoff($conn);
	return $result;

}//fucntion 
}//class
?>
