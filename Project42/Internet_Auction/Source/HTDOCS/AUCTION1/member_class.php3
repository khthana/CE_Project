<?php
include ('/www/htdocs/auction1/mail_class.php3');
include ('/www/htdocs/data_check/regis_data_check.php3');
include ('/www/htdocs/sql_class/member.php3');
include ('/www/htdocs/interface/data_display_class.php3');
class member {


function
registration_member($nickname,$password,$title,$firstname,$lastname,
		    $birth,$email,$address,$bound,$province,$postal,
	            $phone,$page,$fax){ 
		
	$member_sql1 = new member_sql;
 	$data_check1 = new registration_data_checker;
	$xmail= new mail_class;
	$display1 = new data_display; 

	//$check_result[];
	list($check_result[1],$check_result[2],$check_result[3]) =
	$data_check1->regis_check($nickname,$email);  	
	if ( $check_result[1] == 1 ) {
	
	$result=$member_sql1->insert_all(
	$nickname,$password,$title,$firstname,$lastname,
	$birth,$email,$address,$bound,$province,$postal,
	$phone,$page,$fax);
	// $member_sql1->select('NICK_NAME');
	
	if ($result==true)
{
	$xmail->regis_mail($email,$nickname,$password);
	$display1->regis_ok();
}
	else 
{
	$display1->regis_notok();
}

	}
	elseif(($check_result[2] ==0) && ($check_result[3] == 0))
	{
		$display1->exist_name_email();
	}
	elseif($check_result[2] == 0) $display1->exist_name();
        elseif($check_result[3] == 0) $display1->exist_email();       
   

}	//function registration_member


function
update_info_member($nickname,$password,$title,$firstname,$lastname,
                    $birth,$email,$address,$bound,$province,$postal,
                    $phone,$page,$fax,$id){

        $member_sql1 = new member_sql;
        $data_check1 = new registration_data_checker;
        $display1 = new data_display;
     
 
        list($check_result[1],$check_result[2],$check_result[3]) =
        $data_check1->update_check($id,$nickname,$email);
        if ( $check_result[1] == 1 ) {

        $member_sql1->update_all(
        $nickname,$password,$title,$firstname,$lastname,
        $birth,$email,$address,$bound,$province,$postal,
        $phone,$page,$fax,$id);
        $display1->update_ok();
        }
        elseif(($check_result[2] ==0) && ($check_result[3] == 0))
        {
                $display1->exist_name_email();
        }
       
        elseif($check_result[2] == 0) $display1->exist_name();
        elseif($check_result[3] == 0) $display1->exist_email();


}       //function update_info_member 
//----------------------------------------------------------------
function get_member_id($nickname,$password){

	$member1 = new member_sql;
        $member_id = $member1->check($nickname,$password);
	return $member_id;



}	//function get_member_id
//----------------------------------------------------------------
function get_bid_data($nickname,$password){
	$member1 = new member_sql;
	$member_data = $member1->get_bid_data($nickname,$password);
	return $member_data; 
}
//----------------------------------------------------------------
}       //class member  
?>
