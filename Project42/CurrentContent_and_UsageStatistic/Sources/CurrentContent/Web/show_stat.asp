<html>
<head>
<title>Statistic</title>
</head>
<body background="note.gif">
<%day1 = request.form("day1")
day2 = request.form("day2")
if day1 <>"" and day2 <>"" then
	if isdate(day1) = True and isdate(day2) = True then
	day1= cdate(day1)
	day2 = cdate(day2)
		set conn=server.CreateObject("ADODB.Connection")
		conn.Open  "statist","",""
		SQL = "SELECT S.[ID#] as id, MIN(D.TILTLE) as title,MIN(D.VOLUME) as volume, MIN(D.NUMBER) as numbers, COUNT(S.TIME) as counting"
		SQL = SQL & " FROM STATISTIC S, DETAIL2 D"
		SQL = SQL & " WHERE S.[ID#] = D.[ID#] and S.DATE >= #" & day1 & "# and S.DATE <=  #" & day2 & "# GROUP BY S.[ID#] ORDER BY min(d.tiltle) asc"
		set RS = Server.CreateObject("ADODB.Recordset")
		RS.Open SQL, conn, 1, 3
		On Error Resume Next
		rs.movefirst
%> <table border =1> 
<tr>
  <td align = "center"><font size="+2">รหัสหนังสือ</font></td>
  <td align= "center"><font size="+2">ชื่อหนังสือ</font></td>
  <td align ="center"><font size="+2">ฉบับที่</font></td>
  <td align ="center"><font size="+2">ปีที่</font></td>
  <td align ="center"><font size="+2">จำนวนการใช้</font></td>
</tr>
<%Do while not rs.eof%>
<tr>
<td align ="center"><%=RS("ID")%></td>
<td><%=RS("TITLE")%></td>
<td align ="center"><%=RS("VOLUME")%></td>
<td align ="center"><%=RS("NUMBERS")%></td>
<td align ="center"><%=RS("COUNTING")%></td>
</tr>
<%
rs.movenext
loop
rs.close
conn.Close
else
%>
<p><font size="+3">Not Correct! Type Date Again.</font><font size="+4"> <%end if%> 
  <%else%> </font></p>
<p><font size="+3">Not Correct!It's not a date format Again.</font><font size="+4"> 
  <%end if%> </font> </p>
</body>
</html>

