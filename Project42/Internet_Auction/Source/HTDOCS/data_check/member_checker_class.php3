<?php
include('/www/htdocs/sql_class/member.php3');
class member_checker{
//-------------------------------------------------
//--function check_nick_pass--
//--use to verify nickname and password
//--INPUT nick_name and password
//--OUTPUT return member_id if correct else return null

function check_nick_pass($nickname,$password){
	$member1 = new member_sql;
	$member_id = $member1->check($nickname,$password);
//	if ($member_id <> "" ) { return  true;}
//	else return false;
	return $member_id;
}// end function check_nick_pass
//----------------------------------------------------
function check_member($nickname,$password){

	$member1 = new member_sql;
	$member_id = $member1->check($nickname,$password);
	if ($member_id <> "" ) { return  true;}
	else return false;

} // end check_member

//----------------------------------------------------

}// end member_checker
?>
