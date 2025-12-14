<html>
<head>
<script language="vbscript" runat="server">
Function hilight(txt)
	n=1
	Do While n<> 0
		n=instr(ucase(txt),ucase(TA))
		if n<>0 then 
			msg = msg & left(txt,n-1)& "<font color = red><big><big>" & mid(txt,n,len(TA)) & "</big></big></font>"
			txt = right( txt,len(txt)- (n-1+len(TA)) )
		end if
	loop
	hilight=msg&txt
End Function
</script>
<title>Show all Title</title></head>
<body bgColor=#CCCCFF background="note.gif">
<%
Select_TA = Request.Form("sel_ta")
TA = Request.form("Ta")
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Current","",""
sql = "Select * from Journal"
If select_TA ="Title" then
sql = sql & " Where TITLE like '%" & TA & "%'"
%> 
<h2 align=center>บทความที่มีคำว่า <%=TA%></h2>
<%
Elseif select_TA = "Author" then
sql = sql & " Where AUTHOR like '%" & TA & "%'"
%>
<h2 align=center>ผู้แต่งชื่อ <%=TA%> </h2>
<%
End if
Set Rs = Server.CreateObject("ADODB.Recordset")
rs.open sql, conn, 1, 3

On Error Resume Next
TotalRecords = RS.RecordCount
RS.PageSize = 20
PageSize = RS.PageSize 
TotalPages = RS.PageCount
RS.MoveFirst
count=0
If select_TA ="Title" then
Do While Not RS.EOF count = count+1
%>
<br><%=count%>. <a href = 'result.asp?Your_Author=<%=RS("AUTHOR")%>&Your_Month=<%=RS("Month")%>&Your_title=<%=RS("TITLE")%>'><%=hilight(RS("TITLE"))%></a></br>
<%
RS.MoveNext
Loop
	if count=0 then%>
	<%heading = "ไม่พบคำว่า"%>
	<%=heading&" "&TA%>
	<%end if%>

<%Elseif select_TA ="Author" then
Do While Not RS.EOF count = count+1
%>
<br><%=count%>. <a href = 'result.asp?Your_Author=<%=RS("Author")%>&Your_Month=<%=RS("Month")%>&Your_title=<%=RS("TITLE")%>'><%=RS("TITLE")%></a></br>
<%
RS.MoveNext
Loop
if count=0 then%>
<%heading = "ไม่มีคนแต่งชื่อ"%>
<%=heading&" "&TA%>
<%End if%>
<%End if%>
<%
RS.Close
Conn.Close
%>
<hr>
</body>
</html>
