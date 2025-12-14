<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<P>&nbsp;</P>
testinto tt
<%		' sql = "insert into reserve_journal (Namereserve,Emailreserve,ISSN) values ('ta','bad','194');"
	sql = "select * from Tblissn"
	'reserve_journal"
	set conn =Server.CreateObject ("ADODB.Connection")
	conn.open "digital library","",""
	'conn.open "reserve","",""
	
	Set rs = Server.CreateObject("ADODB.Recordset")
		'set rs = conn.execute(sql)
	rs.Open sql, conn, 3, 3
	On Error Resume Next
	

'	rs.Addnew
'
'	rs("NameReserve")="bajita"
'	rs("EmailReserve")="Hagfrom"
'	rs("ISSN")="12345"
'
'	rs.Update
%>

<%=rs("ISSN")%>

<%	
	rs.close
	conn.Close 
%>
</BODY>
</HTML>
