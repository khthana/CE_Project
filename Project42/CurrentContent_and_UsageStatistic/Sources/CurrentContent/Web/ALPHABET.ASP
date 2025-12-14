<html><title>Alphabet</title>
<%header = "วารสารที่ขึ้นต้นด้วย "%>
<%Alpha=Request.Querystring("Alpha")%>
<body bgcolor="#FFFFFF">
<h2 align=center><%=header & " " & Alpha%></h2>
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Current"," "," "
sql = "Select J_name FROM Journal where J_Name like '"& Alpha & "%' Group by J_Name Order by J_name asc"
Set RS = Server.CreateObject("ADODB.Recordset")
RS.Open sql, conn, 1, 3
On Error Resume Next
total = RS.RecordCount
RS.MoveFirst
%>
<hr>
<b><%if total=0 then%>สำนักหอสมุดกลางยังไม่ได้บอกรับวารสารที่ขึ้นต้นด้วยตัวอักษร </b> <big><big><big><%=alpha%></big></big></big> 
<%End if%> <%
Do While not RS.EOF
p1 = RS("J_Name")
url1 = server.urlencode(p1)
%> <br>
<a href= 'Test.asp?Journal=<%=url1%>'><%=RS("J_name")%></a> <%
RS.Movenext
Loop
RS.Close
Conn.Close
%> 
<hr>
</html>

