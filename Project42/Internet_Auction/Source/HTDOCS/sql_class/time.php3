<?php
class time_sql{
function next_close(){
	
	$conn = ocilogon("bonn","bonn79","bk");
	$stmt = ociparse($conn,"select next_time
			from time_table
			where next_time < sysdate");
	ociexecute($stmt,oci_defualt);
	ocifetch($stmt);
	$result = ociresult($stmt,1);

	if ( $result == "" )
	   {
	//   	echo "in time.php3 no need to check close<br>";
		return false;	
	   }
	else
	   {
	//	echo " in time .php3 item must be check close now<br>";
		// next check time = check time + 30 minite
		$stmt1 = ociparse($conn,"update time_table
					 set 	next_time = sysdate+0.020833");
		ociexecute($stmt1,OCI_COMMIT_ON_SUCCESS);
		return true;
 	   } 				 	 	

}// end check_next_close
}// end time_sql class
?>
