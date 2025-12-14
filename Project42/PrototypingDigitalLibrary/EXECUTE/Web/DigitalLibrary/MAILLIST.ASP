<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY bgcolor="#FFFFFF" background="pic/kmittkik.jpg">
<P>&nbsp;</P>
<h2 align="center"><font color="#0000FF">แจ้งวารสารฉบับใหม่</font> <br>
  <%
'input 
'ISSN ="0125-1724"
ISSN = Request.QueryString ("ISSN")
ThaiJournal = Request.QueryString ("ThaiJournal")

Set conn = Server.CreateObject("ADODB.Connection")
conn.open "reserve","",""
	
' ----- search  ISSN NO. ---<begin>---	
sql = "SELECT * FROM  reserve_journal where issn='"&ISSN&"'"
Set rs = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn,1,3
' 3, 3

member_reserve=rs.RecordCount
if member_reserve <> 0 then
	'Response.Write ("member in this journal :"&member_reserve)
%> จำนวนผู้จองวารสาร : <%=Thaijournal%> </h2>
<h2 align="center"><font color="#FF0000"><%=member_reserve%> ราย</font> <%
	set o = Server.CreateObject("ADISCON.SimpleMail.1") 'create mailer!
	o.MailServer = "161.246.4.3"
	'o.Sender = "e-journal in KMITL library"
	o.Subject = "วารสารใหม่ของสถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง"

	'-----mail to list ------
	Do while not rs.EOF
		o.Recipient = rs("emailreserve")
		o.MessageText = "ถึง คุณ"+rs("namereserve") + "," +	Chr(13) + Chr(10) + "    มีวารสาร :"+ThaiJournal+Chr(13) + Chr(10) +"     เชิญเข้ามาชมได้ที่ www.lib.kmitl.ac.th"
		call o.Send
		rs.Movenext
	loop
	set o = Nothing

	'----delete list special ------
	rs.movefirst
	Do while not rs.EOF
		rs.delete
		rs.movenext
	loop
	
else
	'not member in list
%> <font color="#CC3300">ไม่มีผู้จองวารสาร : <%=Thaijournal%> </font><%
end if

	rs.close
	Conn.Close 

%> </h2>
</BODY>
</HTML>
