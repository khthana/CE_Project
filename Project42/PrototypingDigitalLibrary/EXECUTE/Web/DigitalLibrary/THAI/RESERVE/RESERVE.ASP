<%@ Language=VBScript %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
</HEAD>
<BODY bgcolor="#FFFFFF" background="../../pic/kmittkik.jpg">
<%
	'check update reserve 
	'if not repeat update then register reserve 
	'if repeat update in  a journal then no update


	'get input 
	namereserve_T =Request.Form ("namereserve")
	emailreserve_T=Request.Form ("emailreserve")
	ISSN_T		=Request.Form ("ISSN")

	
	
	'--call nameJournal -> output = namejournal ->display---
	sql ="Select * From TblISSN where ISSN = '" &ISSN_T&"'"
	Set conn = Server.CreateObject("ADODB.Connection")
	conn.open "Digital library","",""

	set rs = conn.Execute(sql)
	On Error Resume Next
	Thaijournal =rs("Thaijournal")
	Engjournal  =rs("Engjournal")
	
	rs.Close 
	Conn.Close				
	
	
	
	'--connect DB reserve
	Set conn = Server.CreateObject("ADODB.Connection")
	conn.open "reserve","",""
	
	'check email to repeat a journal
	sql = "select namereserve from reserve_journal where emailreserve='"&emailreserve_T&"' and ISSN ='"&ISSN_T&"'  "
	set rs1 = conn.Execute(sql)
	On Error Resume Next
		
	'rs.MoveFirst 
	
	
	if rs1("namereserve") = "" then
				
		rs1.Close		
		'-----Update row reserve-----
		sql = "SELECT * FROM reserve_journal"
		Set rs = Server.CreateObject("ADODB.Recordset")
		rs.Open sql, conn, 3, 3
		On Error Resume Next
			
			rs.Addnew
			rs("namereserve")=namereserve_T
			rs("emailreserve")=emailreserve_T
			rs("issn")=ISSN_T
			rs.Update
	
		rs.Close 
		Conn.Close 


	%> <! *******Display updat sucess*******> 
<h3>&nbsp; </h3>
<h3 align="center">&nbsp; </h3>
<h2 align="center"><font color="#3333FF">ขอบคุณ คุณ<%=namereserve_T%> (<%=emailreserve_T%>)</font></h2>
<h2 align="center">ที่ใช้บริการแจ้งวารสาร</h2>
<h2 align="center"><%=Thaijournal%></h2>
<h2 align="center">(<%=Engjournal%>)</h2>
<h2 align="center"> ของสำนักหอสมุดกลาง สจล.</h2>
<%		



	else 
	rs1.Close	
	%>
	
		
<p>&nbsp;</p>
<p>&nbsp;</p>
<h2 align="center"> <font color="#FF0000">ไม่สามารถลงทะเบียนได้</font><br>
  เนื่องจากเคยลงทะเบียน<br>
  วารสาร : <%=Thaijournal%> (<%=Engjournal%>) ไว้แล้ว </h2>




<%
	
	Conn.Close	
	end if
	
%> 
</BODY>
</HTML>
