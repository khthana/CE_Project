<?php
class member_sql {
//-------------------------------------------------------------------
function select($column) {
	
	$conn=ocilogon("bonn","bonn79","bk");
	$stmt=ociparse($conn,"select $column from member");
	@ociexecute($stmt,oci_default);
	echo "<br><br>List of member's nickname before insert";
	while (@ocifetch($stmt))
		{echo "<br>".ociresult($stmt,1);}
	ocilogoff($conn);	

}//function select
//-------------------------------------------------------------------
function get_member_number() {
	
	$conn=ocilogon("bonn","bonn79","bk");
	$stmt=ociparse($conn,"select count(*) from member ");
 	@ociexecute($stmt,oci_default);
	@ocifetch($stmt);
	$num=ociresult($stmt,1);
	return $num;
	ocilogoff($conn);	
	
}//function get_row
//-------------------------------------------------------------------
function

	insert_all(
	$nickname,$password,$title,$firstname,$lastname,
	$birth,$mail,$address,$bound,$province,$postal,
	$phone,$pager,$fax) { 	

	$column_name ="MEMBER_ID,NICK_NAME,PASSWORD,TITLE,NAME,SUR_NAME,
	               BIRTH_DATE ,E_MAIL,ADDRESS,BOUND,PROVINCE,POSTAL_CODE,
		       PHONE,FAX,PAGE";
//	$num = $this->get_member_number();

	
	$conn=OCINlogon("bonn","bonn79","bk");
	$stmt1=ociparse($conn,"insert into member($column_name)  	

values(member_id.nextval,'$nickname','$password','$title','$firstname',
	'$lastname','$birth','$mail','$address','$bound',$province,
	'$postal','$phone','$fax','$pager')"); 
	
	


	$result=ociexecute($stmt1,oci_default);  	 	 
		
	ocilogoff($conn);
	if ($result!=1) {$result=false;}
	else {$result=true;}
	return $result;
	
}//function insert
//-------------------------------------------------------------------
function insert($column,$data) {

	$conn=ocilogon("bonn","bonn79","bk");
	$num = $this->get_member_number();
	$stmt1=ociparse($conn,"insert into member(MEMBER_ID,$column)
	values(MEMBER_ID.NEXTVAL,'$data')"); 	
	ociexecute($stmt1,oci_default); 
 	ocilogoff($conn);

}
//-------------------------------------------------------------------
function update($column,$nickname,$data){
	$conn=ocilogon("bonn","bonn79","bk");
	$stmt = ociparse($conn,
         "update member set $column = '$data' where NICK_NAME ='$nickname'");
	 ociexecute($stmt,oci_default);
 	ocilogoff($conn);

}
//-------------------------------------------------------------------
function selectall($id)
{
	$conn=ocilogon("bonn","bonn79","bk");
	$stmt=ociparse($conn,"select * from member where MEMBER_ID='$id'");
   	ociexecute($stmt,oci_default); 	while (ocifetch($stmt))
		{ 
			$nickname = ociresult($stmt,2);
			$password = ociresult($stmt,3);
			$title    = ociresult($stmt,4);
			$name     = ociresult($stmt,5);
			$surname  = ociresult($stmt,6);
			$birthdate  = ociresult($stmt,7);
			$email    = ociresult($stmt,8);
			$address  = ociresult($stmt,9);
			$bound    = ociresult($stmt,10);
			$province = ociresult($stmt,11);
			$postalcode = ociresult($stmt,12);
			$phone    = ociresult($stmt,13);
			$fax      = ociresult($stmt,14);
			$page     = ociresult($stmt,17);
		}
	ocilogoff($conn);	

	return
array($nickname,$password,$title,$name,$surname,$birthdate,$email,$address,$bound,$province,$postalcode,$phone,$fax,$page);

}

function check($nname,$password)
{
	$conn=ocilogon("bonn","bonn79","bk");
	$stmt=ociparse($conn,"select MEMBER_ID from member where
NICK_NAME='$nname' and PASSWORD='$password' ");  
	ociexecute($stmt,oci_default);
	ocifetch($stmt);
	$num=ociresult($stmt,1);
	ocilogoff($conn);
	return $num;
}

function

        update_all(
        $nickname,$password,$title,$firstname,$lastname,
        $birth,$mail,$address,$bound,$province,$postal,
        $phone,$pager,$fax,$id) {  

        $conn=OCINlogon("bonn","bonn79","bk");
        $stmt1=ociparse($conn,"update member set 
NICK_NAME='$nickname',PASSWORD='$password',TITLE='$title',NAME='$firstname',
SUR_NAME='$lastname',BIRTH_DATE='$birth',E_MAIL='$mail',ADDRESS='$address',
BOUND='$bound',PROVINCE='$province',POSTAL_CODE='$postal',PHONE='$phone',
FAX='$fax',PAGE='$pager' where MEMBER_ID=$id ");  


        ociexecute($stmt1,oci_default);

        ocilogoff($conn);

}//function update      
//---------------------------------------------------------------------
function get_bid_data($nickname,$password){

	$conn=ocilogon("bonn","bonn79","bk");
	$stmt=ociparse($conn,"select MEMBER_ID,RATING,CREDIT from member where
NICK_NAME='$nickname' and PASSWORD='$password' ");  
	ociexecute($stmt,oci_default);
	while (ocifetch($stmt))
	 {
		$member_data['member_id'] 	= ociresult($stmt,1);
		$member_data['rating'] 		= ociresult($stmt,2);
		$member_data['credit'] 		= ociresult($stmt,3);
	
	 }
	
	ocilogoff($conn);
	return $member_data;


} //end get_bid_data

//---------------------------------------------------------------------
}//class member_sql
?>
