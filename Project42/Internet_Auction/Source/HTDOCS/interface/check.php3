<?PHP

ECHO " 
<HTML>  
  <HEAD>  
	 <TITLE>Verify.</TITLE>  
  </HEAD>  
  <BODY bgcolor='white'> 
	 <P><FONT SIZE='+2' COLOR='#339900'><U><B><FONT
SIZE='+2'>ป้อนชื่อเล่นและรหัสผ่าน</FONT></B></U><br><br> <FONT
COLOR='#FF0000'></FONT></FONT></P>  	 <P> </P> 
	 <FORM action =
'http://161.246.5.146/auction1/change_member_info/change_info.php3' 
	         method = post >   		<TABLE WIDTH='481'
BORDER='1' align=center> 
		  <TR> 
			 <TD WIDTH='471'> 
				<CENTER><BR> 
				  <TABLE WIDTH='444' BORDER='0' BGCOLOR='#FFCCFF'> 
					 <TR> 
						<TD WIDTH='434'> 
						  <TABLE WIDTH='97%' BORDER='0'> 
							 <TR> 
								<TD
HEIGHT='40' WIDTH='95'>ชื่อเล่น :</TD> 
								<TD HEIGHT='40' WIDTH='319'><INPUT TYPE='TEXT'
								  NAME='nickname'> </TD> 
							 </TR> 
							 <TR> 
								<TD
HEIGHT='40' WIDTH='95'>รหัสผ่าน :</TD> 
								<TD HEIGHT='40' WIDTH='319'><INPUT
								  TYPE='PASSWORD' NAME='password' MAXLENGTH='15'> </TD> 
							 </TR> 
						  </TABLE> </TD> 
					 </TR> 
				  </TABLE> 
				  <P><INPUT TYPE='SUBMIT' NAME='Next'
VALUE='ตกลง'>
					 <INPUT TYPE='RESET' NAME='  Clear
' VALUE='ลบข้อมูล'></P> </CENTER></TD> 
		  </TR> 
		</TABLE> </FORM>
</BODY>
</HTML>";
?>
