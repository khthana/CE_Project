<html>
<head><title>Show Usage Statistic on Web</title></head>
<body bgcolor="#FFFFFF">
<%
Sel_1 = request.form("Sel_1")
day1 = request.form("day1")
day2 = request.form("day2")
if day1 <> "" and day2 <> "" then
	if isdate(day1) = true and isdate(day2) = true then
		day1 = cdate(day1)
		day2 = cdate(day2)
		set conn = Server.CreateObject("ADODB.Connection")
		Conn.Open "Current","",""
		if Sel_1 = "Searching" then
			Sql = "Select Journal_Name, Count(Timing) as timig"
			Sql = Sql & " FROM Countg"		
			Sql = Sql & " WHERE day_from >= #" & day1 & "# and day_from <= #" & day2 & "# GROUP BY Journal_name ORDER BY Journal_name;"
			set rs = conn.Execute(sql)
			RS.movefirst
%> 
<table border =1>
<tr><td>
      <div align="center"><b>หนังสือชื่อ</b></div>
    </td><td>
      <div align="center"><b>จำนวนการเลือก</b></div>
    </td></tr>
<%Do While not rs.eof%>
<tr>
<td><%=RS("Journal_name")%></td>
<td align="center"><%=RS("Timig")%></td>
</tr>
<%
rs.movenext
loop
rs.close
conn.close
		elseif Sel_1 = "Deleting" then
			CSQL = "Delete FROM Countg Where day_from >= #" & day1 & "# and day_from <= #" & day2 & "#;"
			set recset = conn.Execute(CSQL)
%>
			<hr>
			<h1 align = center>DATABASE HAVE BEEN DELETED</h1>
			<hr>
				
<%		
		End if
Else
%>
	Not Found 
<% 
End if
Else%>
	Not Found 
<%
End if
%>
		
</table>
</body>
</html>
