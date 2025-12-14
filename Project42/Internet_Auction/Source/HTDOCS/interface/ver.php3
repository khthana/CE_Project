<?PHP
include('/www/htdocs/sql_class/member.php3');

CLASS VERIFY_INTERFACE
{
	FUNCTION verify($id)
	{
ECHO "
<HTML> 
  <HEAD> 
	 <TITLE>Verify.</TITLE> 
  </HEAD>";
  
$sql = new member_sql;
list($nickname,$password,$title,$name,$surname,$birthdate,$email,$address,$bound,$province,$postalcode,$phone,$fax,$page)=$sql->selectall($id); 	
 
ECHO "
	<body bgcolor='white'>
	 <P><FONT SIZE='+2' COLOR='#339900'><U><B><FONT
SIZE='+3'>แก้ไขข้อมูลสมาชิก
		</FONT></B></U><FONT COLOR='#FF0000'></FONT></FONT></P> 
	 <FORM action
='http://161.246.5.146/auction1/change_member_info/preview_page_ver.php3'
               method=post> 
	<input type=hidden name=id value=$id>	
	<input type = hidden name=title value='$title'>
	<input type = hidden name=province value='$province'>
	<TABLE WIDTH='481' BORDER='1'> 


	  <TR> 
			 <TD WIDTH='471'> 
				<CENTER> <BR> 
				  <TABLE WIDTH='444' BORDER='0' BGCOLOR='#66CCff'> 
					 <TR> 
						<TD WIDTH='434'> 
						  <TABLE WIDTH='50%' BORDER='0'> 
							 <TR> 
					<TD VALIGN='MIDDLE'>
<INPUT TYPE='RADIO' NAME='title' VALUE='นาย'>นาย</TD>		
<TD> <INPUT TYPE='RADIO' NAME='title' VALUE='นางสาว'>นางสาว</TD> 
<TD> <INPUT TYPE='RADIO'NAME='title' VALUE='นาง'>นาง</TD>
   						 </TR>
 	 				  </TABLE>  			
		  <TABLE WIDTH='97%' BORDER='0'>  		
				 <TR>  				
			<TD HEIGHT='40' WIDTH='95'>ชื่อเล่น :</TD>  
							<TD HEIGHT='40'
WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 				
			  NAME='nickname' VALUE='$nickname' maxlength=25>
<FONT
COLOR='#FF0000'>*</FONT><FONT 					
		  COLOR='#FF0000'></FONT></TD>  		
				 </TR>  			
			 <TR>  					
		<TD HEIGHT='40' WIDTH='95'>ชื่อ :</TD>  	
						<TD HEIGHT='40'
WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 				
			  NAME='firstname' SIZE='30' VALUE='$name'
maxlength=50> <FONT
								 
COLOR='#FF0000'>*</FONT></TD>  					
	 </TR>  							 <TR> 
								<TD
HEIGHT='40' WIDTH='95'>นามสกุล :</TD>  			
				<TD HEIGHT='40' WIDTH='319'>&nbsp;<INPUT
TYPE='TEXT' 								 
NAME='lastname' SIZE='30' VALUE='$surname' maxlength=50> <FONT 		 
				  COLOR='#FF0000'>*</FONT></TD>  
						 </TR>   	
				 <TR>  	 		
			<TD HEIGHT='40' WIDTH='95'>วันเกิด :</TD>  
				 		<TD HEIGHT='40'
WIDTH='319'>&nbsp;<INPUT TYPE='TEXT'  				
		  NAME='birth' VALUE='$birthdate' maxlength=20></TD>  	
			 	 </TR>  			
		  </TABLE> </TD>   				 </TR> 
		 	  </TABLE> <BR>  				 
<TABLE WIDTH='444' BORDER='0' BGCOLOR='#66CCCC'>  		
		 <TR>  						<TD
WIDTH='434'>   					  <TABLE WIDTH='97%'
BORDER='0'>  							 <TR>  
							<TD HEIGHT='40'
WIDTH='95'>ที่อยู่อีเมล์ :</TD>  				 
		<TD HEIGHT='40' WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 
							  NAME='email'
SIZE='30' VALUE='$email' maxlength=50> <FONT COLOR='#FF0000'>*</FONT></TD>   
					 </TR>  	 	
			 <TR>  		 		
		<TD HEIGHT='40' WIDTH='95'>ที่อยู่ :</TD>  	
						<TD HEIGHT='40'
WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 		 		
		  NAME='address' SIZE='30' VALUE='$address' maxlength=80>
<FONT
COLOR='#FF0000'>*</FONT></TD>  	 			
	 </TR>  		 				 <TR> 
			 				<TD HEIGHT='40'
WIDTH='95'>อำเภอ/เขต :</TD>  					
		<TD HEIGHT='40' WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 
	 					  NAME='bound'
VALUE='$bound' maxlength=50>
<FONT COLOR='#FF0000'>*</FONT></TD>  				 
	 </TR>  					 	 <TR> 
						 	<TD HEIGHT='40'
WIDTH='95'>จังหวัด :</TD>  		 			
	<TD HEIGHT='40' WIDTH='319'>&nbsp;  			
				  <SELECT NAME='province1' SIZE='1' >  	
			<option value=1>เชียงใหม่</option>
			<option value=2>เชียงราย</option>
			<option value=3>กำแพงเพชร</option>
			<option value=4>ลำปาง</option>
			<option value=5>ลำพูน</option>
			<option value=6>แม่ฮ่องสอน</option>
			<option value=7>นครสวรรค์</option>
			<option value=8>น่าน</option>
			<option value=9>พะเยา</option>
			<option value=10>เพชรบูรณ์</option>
			<option value=11>พิจิตร</option>
			<option value=12>พิษณุโลก</option>
			<option value=13>แพร่</option>
			<option value=14>สุโขทัย</option>
			<option value=15>ตาก</option>
			<option value=16>อุทัยธานี</option>
			<option value=17>อุตรดิตถ์</option>
			<option value=18>อำนาจเจริญ</option>
			<option value=19>บุรีรัมย์</option>
			<option value=20>ชัยภูมิ</option>
			<option value=21>กาฬสินธุ์</option>
			<option value=22>ขอนแก่น</option>
			<option value=23>แลย</option>
			<option value=24>มหาสารคาม</option>
			<option value=25>มุกดาหาร</option>
			<option value=26>นครราชสีมา</option>
			<option value=27>นครพนม</option>
			<option value=28>หนองบัวลำภู</option>
			<option value=29>หนองคาย</option>
			<option value=30>ร้อยเอ็ด</option>
			<option value=31>สกลนคร</option>
			<option value=32>ศรีสะเกษ</option>
			<option value=33>สุรินทร์</option>
			<option value=34>อุบลราชธานี</option>
			<option value=35>อุดรธานี</option>
			<option value=36>ยโสธร</option>
			<option value=37>กรุงเทพมหานคร</option>
			<option value=38>นนทบุรี</option>
			<option value=39>ปทุมธานี</option>
			<option value=40>นครนายก</option>
			<option value=41>ปราจีนบุรี</option>
			<option value=42>สระแก้ว</option>
			<option value=43>ฉะเชิงเทรา</option>
			<option value=44>พระนครศรีอยุธยา</option>
			<option value=45>ลพบุรี</option>
			<option value=46>สระบุรี</option>
			<option value=47>สิงห์บุรี</option>
			<option value=48>อ่างทอง</option>
			<option value=49>ชัยนาท</option>
			<option value=50>สมุทรปราการ</option>
			<option value=51>สมุทรสาคร</option>
			<option value=52>สมุทรสงคราม</option>
			<option value=53>นครปฐม</option>
			<option value=54>สุพรรณบุรี</option>
			<option value=55>ราชบุรี</option>
			<option value=56>กาญจนบุรี</option>
			<option value=57>เพชรบุรี</option>
			<option value=58>ประจวบคิรีขันธ์</option>
			<option value=59>ชลบุรี</option>
			<option value=60>ระยอง</option>
			<option value=61>จันทบุรี</option>
			<option value=62>ตราด</option>
			<option value=63>ชุมพร</option>
			<option value=64>ระนอง</option>
			<option value=65>สุราษฎร์ธานี</option>
			<option value=66>พังงา</option>
			<option value=67>ภูเก็ต</option>
			<option value=68>กระบี่</option>
			<option value=69>นครศรีธรรมราช</option>
			<option value=70>ตรัง</option>
			<option value=71>พัทลุง</option>
			<option value=72>สงขลา</option>
			<option value=73>สตูล</option>
			<option value=74>ปัตตานี</option>
			<option value=75>ยะลา</option>
			<option value=76>นราธิวาส</option>	 		
				  </SELECT> </TD>  	 	
			 </TR>  		 		
	 <TR>  			 				<TD
HEIGHT='40' WIDTH='95'>รหัสไปรษณีย์ :</TD>  			
				<TD HEIGHT='40' WIDTH='319'>&nbsp;<INPUT
TYPE='TEXT' 		 					 
NAME='postal' VALUE='$postalcode' maxlength=5> <FONT
COLOR='#FF0000'>&nbsp;*</FONT></TD> 
				 		 </TR>  	
				  </TABLE></TD>  		
		 </TR>   			  </TABLE> <BR>  
			  <TABLE WIDTH='444' BORDER='0' BGCOLOR='#66CCFF'> 
		 		 <TR>  			
		<TD WIDTH='434'>  				
	  <TABLE WIDTH='97%' BORDER='0'>  			
			 <TR>  					
		<TD HEIGHT='40' WIDTH='95'>โทรศัพท์ :</TD>  
		 				<TD HEIGHT='40'
WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 				
			  NAME='phone' VALUE='$phone' maxlength=10></TD>
</TR>
  						 <TR>  	 
					<TD HEIGHT='40' WIDTH='95'>แฟกซ์ 
:</TD>
 								<TD
HEIGHT='40' WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 		 
				  NAME='fax' VALUE='$fax'
maxlength=10></TD>  
						 </TR>   	
				 <TR>  	 		
			<TD HEIGHT='40' WIDTH='95'>เพจ :</TD> 
				 			<TD HEIGHT='40'
WIDTH='319'>&nbsp;<INPUT TYPE='TEXT' 				
			  NAME='page' VALUE='$page' maxlength=12> </TD>  	
					 </TR>  		
			  </TABLE></TD>   				 </TR>
 				  </TABLE><BR>  		
	  <TABLE WIDTH='444' BORDER='0' BGCOLOR='#66cccc'>  	
			 <TR>   					<TD
WIDTH='434'>  	 				  <TABLE WIDTH='97%'
BORDER='0'>   						 <TR>  	
						<TD HEIGHT='40'
WIDTH='95'>รหัสผ่าน :</TD>  					 
	<TD HEIGHT='40' WIDTH='319'>&nbsp;<INPUT TYPE='password'  
						  NAME='password'
VALUE='$password' MAXLENGTH='25'> <FONT 			 
			  COLOR='#FF0033'>*</FONT></TD>   	
				 </TR>  	 		
		 <TR>  		 			
	<TD HEIGHT='40' WIDTH='95'>รหัสผ่าน (ซ้ำ) :</TD>  	
						<TD HEIGHT='40'
WIDTH='319'>&nbsp;<INPUT TYPE='password' 		 	
			  NAME='repassword' MAXLENGTH='25'> <FONT
COLOR='#FF0033'>&nbsp;*</FONT></TD>  				 
	 </TR>  						 
</TABLE></TD>  					 </TR>   
		  </TABLE><BR>  				  <P><INPUT
TYPE='SUBMIT' NAME='Preview' VALUE='ตกลง'> 	 	
	 <INPUT TYPE='RESET' NAME='  Clear  ' VALUE='ลบข้อมูล'></P>
</CENTER></TD>  		  </TR>  		</TABLE> </FORM>";


ECHO "
</BODY>
</HTML>";
	}	//FUCNTION VERIFY
}	//CLASS VERIFY
?>          
