<?php

include('/www/htdocs/sql_class/member.php3');

class feedback_class
{

function
feedback_sell_bid($nickname1,$password,$status,$nickname2,$itemid,
                         $grade,$description)
{

//check b-k's member ?
$sql_member = new member_sql;
$nickname1_id=$sql_member->check($nickname1,$password); 

           $conn=ocilogon("bonn","bonn79","bk"); 
           $stmt1=ociparse($conn,
                  "select member_id
                   from member
                   where nick_name = '$nickname2'
                  ");
           @ociexecute($stmt1,oci_default);
           @ocifetch($stmt1);
$nickname2_id = ociresult($stmt1,1); 
ocilogoff($conn);

if ($nickname1_id != '') 	
// Yes
{
  if ($nickname2_id != '')
  {

    $conn=ocilogon("bonn","bonn79","bk");

    //check status of nickname1

    if ($status == 2)	
    //***************Buyer feedback to seller**********************
    {
	$stmt=ociparse($conn,
	       "select item_id
		from sell_item
		where vendee = $nickname1_id
		      and item_id = $itemid
	       ");
	@ociexecute($stmt,oci_default);
        @ocifetch($stmt);
        $num=ociresult($stmt,1); 	

	//check Is nickname1 vendee?	
	if ($num == '' ) 
	//NO
	{ 
  	   $message = 'ขออภัยครับ<br> กรุณาตรวจสอบหมายเลขสินค้าใหม่<br>';
	   ocilogoff($conn);
        }

	else
	//nickname1 is vendee. 
	{
	   $stmt2=ociparse($conn,
		  "select item_id
		   from item
		   where owner = $nickname2_id
			 and item_id = $num
		   ");
           @ociexecute($stmt2,oci_default);
           @ocifetch($stmt2);
           $num1=ociresult($stmt2,1);

	   //Is nickname2 vender?
           if ($num1 == '')
	   //No 
	   { 
		$message = "ขออภัยครับ
<br>กรุณาตรวจสอบชื่อเล่นของเจ้าของสินค้าใหม่ หรือ<br>
ตรวจสอบหมายเลขสินค้านั้นใหม่อีกครั้ง";
                ocilogoff($conn);   
	   }
           else
	   //Yes
	   {
	   //update data to feedback tabel
		if ($status==1) {$status=2;}
		else {$status=1;}

		$stmt3=ociparse($conn,
		       "insert into feedback 
		        values($nickname1_id,$nickname2_id,$itemid,
		        $status,$grade,'$description',sysdate)
		       ");
		@ociexecute($stmt3,oci_default);

		$return = ocierror($stmt3);   	
                if ($return['message']=='')
		{

//get value of feedback
	                $stmt4=ociparse($conn,
                               "select grade_value,rating 
				from grade,member 
				where grade_id = $grade and
				      member_id=$nickname2_id 
	 	               ");            
               		@ociexecute($stmt4,oci_default);
 			@ocifetch($stmt4);

			$value=ociresult($stmt4,1);
			$rating=ociresult($stmt4,2);

//update receiver's credit
	                $stmt5=ociparse($conn,
                               "update member set rating = $rating+$value 
				where member_id = $nickname2_id
                               ");   
                        @ociexecute($stmt5,oci_default);	
			$message = "ขอบคุณครับ สำหรับ feedback.<br> 
				    สำหรับ feedback
ครั้งนี้จะเป็นประโยชน์กับสมาชิกท่านอื่น ๆ" ;
		}   

		else 
		{
			$message = "ขออภัยครับ !<br>คุณสามารถ Feedback
ให้คู่ค้าได้เพียงครั้งเดียวเท่านั้น";
		}
	
                ocilogoff($conn); 
	   }
	}		
    }


//**************** vender feedback to vendee ********************
    else
    //nickname1 is vender
	 
    {
        $stmt=ociparse($conn,
		"select item_id
		 from item
		 where owner = $nickname1_id
		       and item_id = $itemid
		       		 
		");
        @ociexecute($stmt,oci_default);
        @ocifetch($stmt);
        $num=ociresult($stmt,1);

        //check Is nickname1 vender?
        if ($num == '' )
        //NO
        {
           $message = 'ขออภัยครับ<br> ช่วยตรวจสอบหมายเลขสินค้าของคุณใหม่';
           ocilogoff($conn);
        }

        else
        //nickname1 is vender.
        {                     
           $stmt2=ociparse($conn,  
                  "select item_id
                   from sell_item
                   where vendee = $nickname2_id 	  
                         and item_id = $num
                   ");
           @ociexecute($stmt2,oci_default);
           @ocifetch($stmt2);
           $num1=ociresult($stmt2,1);

           //Is nickname2 vendee?        
           if ($num1 == '')
           //No
           {
                $message = "ขออภัยครับ <br>
ตรวจสอบชื่อคู่ค้าคุณใหม่อีกครั้ง หรือ ตรวจสอบหมายเลขสินค้าใหม่";
                ocilogoff($conn);
           }
           else
           //Yes    
           {
           //update data to feedback tabel
                if ($status==1) {$status=2;}
                else {$status=1;}

                $stmt3=ociparse($conn,
                       "insert into feedback
                        values($nickname1_id,$nickname2_id,$itemid,
                        $status,$grade,'$description',sysdate)
                       ");   
                @ociexecute($stmt3,oci_default);

		$return = ocierror($stmt3);   	
                if ($return['message']=='')
		{

//get value of feedback
	                $stmt4=ociparse($conn,
                               "select grade_value,rating 
				from grade,member 
				where grade_id = $grade and
				      member_id=$nickname2_id 
	 	               ");            
               		@ociexecute($stmt4,oci_default);
 			@ocifetch($stmt4);

			$value=ociresult($stmt4,1);
			$credit=ociresult($stmt4,2);

//update receiver's credit
	                $stmt5=ociparse($conn,
                               "update member set rating = $rating+$value 
				where member_id = $nickname2_id
                               ");   
                        @ociexecute($stmt5,oci_default);	
			$message = "ขอบคุณครับ สำหรับ Feedback<br>เพราะ 
Feedback ครั้งนี้ จะเป็นประโยชน์สำหรับสมาชิกท่านอื่น ๆ ";	
		}   
		else 
		{ 
			$message = "ขออภัยครับ <br> คุณสามารถ Feedback
ให้คู่ค้าของคุณได้เพียงครั้งเดียวเท่านั้น ";
		}

                ocilogoff($conn);
           }
        }
    }       
   } // nickname 2 is not member
   else 
   {
      $message = "ขออภัยครับ ! <br> $nickname2 ไม่ใช่สมาชิกของ b-k
auction ";  
   }
}
	
//**********nickname1 is not member*****************
else 	// not member
{
	$message = "ขออภัยครับ ! <br> $nickname1 ไม่ใช่สมาชิกของ b-k
auction";
}	

return $message;

}	//end function feedback_sell_bid
//*****************************************************

//******************************************************
function display_feedback($nickname,$status)
{

	$conn=ocilogon("bonn","bonn79","bk");
	$stmt=ociparse($conn,"
			      select member_id
			      from member
			      where nick_name='$nickname'
			     ");
	ociexecute($stmt,oci_default);
        ocifetch($stmt); 
	$member_id=ociresult($stmt,1);

        $stmt1=ociparse($conn,"
                              select count(*)
                              from feedback
                              where receiver=$member_id
				    and grade=1
                                    and status=$status
                             ");
        ociexecute($stmt1,oci_default);
        ocifetch($stmt1); 
	$result1['good']=ociresult($stmt1,1);
	
        $stmt2=ociparse($conn,"
                              select count(*)
                              from feedback
                              where receiver=$member_id
                                    and grade=2
                                    and status=$status 
                             ");
        ociexecute($stmt2,oci_default);
        ocifetch($stmt2); 
        $result1['normal']=ociresult($stmt2,1);     

        $stmt3=ociparse($conn,"
                              select count(*)
                              from feedback
                              where receiver=$member_id
                                    and grade=3
				    and status=$status
                             ");
        ociexecute($stmt3,oci_default);
        ocifetch($stmt3); 
        $result1['bad']=ociresult($stmt3,1);     

$result1['num']=$result1['good']+$result1['normal']+$result1['bad'];

        $stmt4=ociparse($conn,"
                              select a.item_id,a.description,b.nick_name,
				     a.time,a.grade	
                              from feedback a,member b
                              where a.receiver = $member_id
                                    and a.status = $status
				    and b.member_id = a.sender
				    and a.description is not null
			      order by a.time desc
                             ");
        ociexecute($stmt4,oci_default);
	$i=1;
        while (ocifetch($stmt4))                                   
	{
		$result[$i]['item_id']=ociresult($stmt4,1);
                $result[$i]['description']=ociresult($stmt4,2); 
                $result[$i]['sender']=ociresult($stmt4,3);
                $result[$i]['time']=ociresult($stmt4,4);
                $result[$i]['grade']=ociresult($stmt4,5);         
		$i++;
	}

        $result[0]['num']=$i-1;

	ocilogoff($conn);

	if ($status==1) {$result1['status']='Seller';}
	else {$result1['status']='Buyer';}

	$back[1]=$result1;
	$back[2]=$result;
	return $back;
}//end display_feedback

}	//end class feedback
?>
