<?php
class comment
{
function keep_comment($sender,$e_mail,$detail)
{
        $conn = OCINlogon("bonn","bonn79","bk");
        $stmt = ociparse($conn,"
        insert into bk_comment
	values ('$sender','$e_mail','$detail',sysdate)
	");
        $result =@ociexecute($stmt,oci_default); 
	if ($result==1)
	{
	ocicommit($conn);
	$message="<h4>เราจะรับพิจารณาในสิ่งที่คุณแนะนำ
	</h4><br><h3>ขอบคุณ</h3>"; 
	}
	else 
	{
	$message="<h3>ขออภัยครับ</h3><br>
		มีบางอย่างผิดพลาด";
	ocirollback($conn);
	}
	ocilogoff($conn);
	return $message;
}//function keep_comment

function display_comment()
{
        $conn = OCINlogon("bonn","bonn79","bk");
        $stmt = ociparse($conn,"
        select sender,e_mail,details,
	to_char(comment_time,'dd-mon-yyyy hh:mi:ss') 
	from bk_comment order by comment_time desc
        ");
        $result=@ociexecute($stmt,oci_default);
        if ($result==1)
        {
	$i=1;
        while (@ocifetch($stmt))
		{
		$ans['name'][$i]=ociresult($stmt,1);
                $ans['e_mail'][$i]=ociresult($stmt,2);
                $ans['detial'][$i]=ociresult($stmt,3);
                $ans['date'][$i]=ociresult($stmt,4);
		$i++;
		}
	$ans['num'][0]=$i-1;
        }
        else $message="<h3>ขออภัยครับ</h3><br>
                มีบางอย่างผิดพลาด";
	ocilogoff($conn);
	return $ans;
}//function keep_comment   
}//class
?>
