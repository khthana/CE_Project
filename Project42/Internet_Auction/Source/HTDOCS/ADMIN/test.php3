<?php
			$conn = ociNlogon("bonn","bonn79","bk");
                        $stmt = ociparse($conn,
                                "select grade_id from grade
                                 where grade_id=1

                                ");
                        ociexecute($stmt,oci_default);
                        $return = ocierror($stmt); 
                        ocifetch($stmt);
                        $rat=ociresult($stmt,1);
echo "rating=".$rat;
echo "<br> finish";
                     //   $return = ocierror($stmt);
echo $return['message'];
                        if ($return['message']=='')   
	{echo "not error";}
	else {echo "have error";} 
	ocilogoff($conn);
?>
