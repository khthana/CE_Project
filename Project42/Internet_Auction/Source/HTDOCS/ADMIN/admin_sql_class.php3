<?php
class admin_sql{
function credit($member_id,$nickname,$credit)
{
	$ans=0;
        $conn=ocilogon("bonn","bonn79","bk");
        $stmt = ociparse($conn,
		"select credit from member 
		 where member_id = $member_id and
		       nick_name = '$nickname'
		");
	@ociexecute($stmt,oci_default);

		$return = ocierror($stmt);
                
	@ocifetch($stmt);
        $oldcredit=ociresult($stmt,1); 

	if (($oldcredit!='')&&($return['message']==''))
	{
	$stmt1 = ociparse($conn,
		"update member set credit=$oldcredit+$credit 
		 where member_id = $member_id
		");
        @ociexecute($stmt1,oci_default);

                $return = ocierror($stmt1);
                if ($return['message']=='')
                {  
			$ans=1; 
			ocicommit($conn);
		}
		else {ocirollback($conn);} 	
	}	
	else {ocirollback($conn);}

        ocilogoff($conn);  
	return $ans;
}//function

//*************************************************************

function feedback($sender,$receiver,$item_id)
{

        $ans=0;
        $conn=ocilogon("bonn","bonn79","bk");

//หา member_id ของผู้ส่งและผู้รับ
//หา grade ที่ผู้ส่งให้กับผู้รับ
	$stmt =ociparse($conn,
		"select member_id from member where nick_name='$receiver'
		");
	@ociexecute($stmt,oci_default);
	@ocifetch($stmt);
	$receiver1=ociresult($stmt,1);

        $stmt=ociparse($conn,
                "select member_id from member where nick_name='$sender'
                ");
        @ociexecute($stmt,oci_default);
        @ocifetch($stmt);
        $sender1=ociresult($stmt,1);     	 

        $stmt = ociparse($conn,
                "select grade from feedback
                 where receiver = $receiver1 and
                       sender = $sender1 and
		       item_id = $item_id	
                ");
        @ociexecute($stmt,oci_default);

                $return = ocierror($stmt);

        @ocifetch($stmt);
        $grade=ociresult($stmt,1);

//check error 
        if (($grade!='')&&($return['message']==''))
        {
//delete feedback from table
        $stmt1 = ociparse($conn,
                "delete feedback  
                 where receiver = $receiver1 and
                       sender = $sender1 and
                       item_id = $item_id          
                ");
        @ociexecute($stmt1,oci_default);
                   
                $return = ocierror($stmt1);
                if ($return['message']=='')
                {
//ทำการ update ค่า rating
			if ($grade==1) {$grade== -3;}
			elseif ($grade==2) {$grade == 0;}
			else {$grade == 3;}
			
			$stmt2 = ociparse($conn,
				"select rating from member
				 where nick_name='$receiver'
				 	 
				");
			@ociexecute($stmt2,oci_default);
                        $return = ocierror($stmt2);   
			@ocifetch($stmt2);
			$rat=ociresult($stmt2,1);
			$rate= $rat+$grade;

			if ($return['message']=='')
			{
				$stmt3 = ociparse($conn,
					"update member 
					 set rating=$rate
				 	 where nick_name='$receiver'
					");
                		@ociexecute($stmt3,oci_default);
                		$return = ocierror($stmt3);

                		if ($return['message']=='' )
                		{                           
                                        ocicommit($conn);
					$ans="<font color='#3300CC'
                                        	size=5>Delete 
						Complete</font></p>";   
				}
				else 
				{
					ocirollback($conn);
                                	$ans="<font color='#3300CC'
					size=5>ไม่สามารถ
                                        update ค่า rating ได้</font></p>";
       				}
			}
			else 
			{
				ocirollback($conn);
                        	$ans="<font color='#3300CC' size=5>ไม่สามารถ
                                	อ่านค่า rating ได้</font></p>";   	
			}
                }
		else 
        	{
                	ocirollback($conn);
                	$ans="<font color='#3300CC' size=5>ไม่สามารถลบ
				feedback ได้</font></p>";
	       	} 
        }
	else 
	{
		ocirollback($conn); 
		$ans="<font color='#3300CC' size=5>ไม่มีข้อมูลใน Data
base</font></p>
<p><font color='#336633' size=4>กรุณาเช็คชื่อของผู้รับ ผู้ส่ง
และหมายเลขสินค้าอีกครั้ง</font></p>";
	}

        ocilogoff($conn);  
        return $ans;
}//function

//***********************************************************

function illegal($item_id,$type1)
{
        $ans=0;
        $conn=ocilogon("bonn","bonn79","bk");
        $stmt = ociparse($conn,
                "select owner from item
                 where item_id = $item_id
                ");
        @ociexecute($stmt,oci_default);
        $return = ocierror($stmt);
        @ocifetch($stmt);
        $owner=ociresult($stmt,1);

        if (($owner!='')&&($return['message']==''))     
	{
		$stmt=ociparse($conn,
			"delete item where item_id=$item_id");
		@ociexecute($stmt,oci_default);
		$return = ocierror($stmt);
		if ($return['message']=='')
		{
			if ($type1==2)
			{
				$stmt=ociparse($conn,
					"update member set rating= -100
					 where member_id=$owner");
				@ociexecute($stmt,oci_default);
				$return=ocierror($stmt);
			}
			if ($return['message']=='')
			{
				ocicommit($conn);
				$ans="<p><font color='#3300cc' size=5>
				Delete Item complete</font></P>";
			}
			else
			{
                        ocirollback($conn);
                        $ans="<font color='#3300CC'
                        size=5>การทำงานผิดผลาด</font></p>
                        <p><font color='#336633' size=4>ไม่สามารถตัด
                        ค่า Rating ได้</font></p>";
                        }   
		}
		else
		{
                	ocirollback($conn);
                	$ans="<font color='#3300CC'
			size=5>การทำงานผิดผลาด</font></p>
                	<p><font color='#336633' size=4>ไม่สามารถลบสินค้า
                	นั้นได้</font></p>";  
		}
	}
	else 
	{
                ocirollback($conn);
                $ans="<font color='#3300CC' size=5>ไม่มีข้อมูลใน Data
		base</font></p>
		<p><font color='#336633' size=4>กรุณาเช็คหมายเลขสินค้า
		อีกครั้ง</font></p>";
        }

        ocilogoff($conn);
        return $ans;                  
}//function

//*************************************************************

function rating($nickname,$rating)
{
        $ans=0;
        $conn=ocilogon("bonn","bonn79","bk");

//หา rating
        $stmt =ociparse($conn,
                "select member_id from member where nick_name='$nickname'
                ");
        $return=ociexecute($stmt,oci_default);
        ocifetch($stmt);
        $member_id=ociresult($stmt,1);

//check error
        if (($member_id!='')&&($return==1))   
        {
//ทำการ update ค่า rating
              $stmt2 = ociparse($conn,
              "select rating from member 
               where nick_name='$nickname'
   	       for update
              ");
              $return=@ociexecute($stmt2,oci_default);
              @ocifetch($stmt2);
              $rat=ociresult($stmt2,1);
              $rate= $rat+$rating;

              if ($return==1)          
              {
                    $stmt3 = ociparse($conn,
                    "update member
                     set rating=$rate
                     where nick_name='$nickname'
                    ");
                    $return=@ociexecute($stmt3,oci_default);
                        
                    if ($return==1 )            
                    {
                         ocicommit($conn);
                         $ans="<font color='#3300CC'
                         size=5>แก้ไข Rating เรียบร้อย</font></p>";
                    }
                    else
                    {
                         ocirollback($conn);
                         $ans="<font color='#3300CC' 
                         size=5>ไม่สามารถ
                         update ค่า rating ได้</font></p>";
                    }
               }
               else
               {
                    ocirollback($conn);
                    $ans="<font color='#3300CC'
		    size=5>ไม่สามารถอ่านค่า rating ได้</font></p>";
               }                
}
else
{                         
    ocirollback($conn);
    $ans="<font color='#3300CC' size=5>ไม่มีข้อมูลใน Database<font></p>
    <p><font color='#336633' size=4>กรุณาเช็คชื่ออีกครั้ง</font></p>";
}        
ocilogoff($conn);
return $ans;
}//function            

//***************************************************
function num_old_item()
{
        $ans=0;
        $conn=ocilogon("bonn","bonn79","bk");

//หา rating
        $stmt =ociparse($conn,
                "select count(*) from item 
		where sysdate > stop_date+90
                ");
        $return=ociexecute($stmt,oci_default);
        ocifetch($stmt);
        $ans=ociresult($stmt,1);

//check error
        if (($ans!='')&&($return==1))
        {}
	else 
	{
    $ans="<font color='#3300CC' size=4>ไม่สามารถเข้าถึงข้อมูลใน
Database ได้<font></p>";
	}

ocilogoff($conn);
return $ans;                                     

}//function num_old_item

//***************************************************
function delete_old_item()
{
        $ans=0;
        $conn=ocinlogon("bonn","bonn79","bk");

//หา rating
        $stmt =ociparse($conn,
                "select item_id from item
                where sysdate > stop_date+90
		for update
                ");
        $return=ociexecute($stmt,oci_default);     

//check error
        if ($return==1)
        {
		$stmt1=ociparse($conn,
			"delete item where stop_date+90<sysdate");
		$return1=ociexecute($stmt1,oci_default);
		if ($return1==1)
		{
			ocicommit($conn);
			$ans="<font color='#3300CC'size=4>ข้อมูลใน
Database โดนลบเสร็จเรียบร้อย<font></p>";    
		}
		else
		{
			ocirollback($conn);
			$ans="<font color='#3300CC'size=4>
			มีปัญหาในการลบข้อมูลใน Database<font></p>";   
		}
        }
        else
        {            
    $ans="<font color='#3300CC' size=4>ไม่สามารถเข้าถึงข้อมูลใน
Database ได้<font></p>";
        }

ocilogoff($conn);
return $ans;

}//function delete_old_item           

}//class
?>
