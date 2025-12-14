<html>
<head><title>Result</title></head>

<%
Jo_name = Request.Form("Jo_name")
Year_show = request.form("Year_show")
Month_Show = request.form("Month_show")
%>
<body bgcolor="#FFFFFF">
<h2 align= center><%=Jo_name & " ประจำเดือน " & Month_Show & " ปี " & Year_Show%></h2>
<hr>
<br>
<%
If year_show <> "" or month_show <> "" then
	set Conn = server.createobject("ADODB.connection")
	Conn.open "Current","",""
	Sql = "Select * From Journal where J_name like '" & Jo_name &  "%' and Year like '" & Year_Show & "%' and Month like  '"  & Month_Show & "%'"
	Set RS =  Server.CreateObject("ADODB.Recordset")
	Rs.open sql, conn, 1, 3
On error Resume next
count = 0
Rs.Movefirst
%>
<table border = 1>
  <tr>
    <Td width="414"> 
      <div align="center"><b>บทความ</b></div>
    </td>
    <Td width="279"> 
      <div align="center"><b>ผู้แต่ง</b></div>
    </td>
    <td width="60"> 
      <div align="center"><b>หน้า</b></div>
    </td>
<%
Do While Not RS.EOF count =count +1
%>
<tr>
    <td width="414"><%=count%>.<%=RS("Title")%></td>
    <td width="279"><%=RS("Author")%></td>
    <td width="60"><%=RS("Page")%></td>
</tr>
<%
RS.movenext
loop
rs.close
conn.close
else
%>
</table>
     
<b>กรุณาใส่ข้อมูลใหม่</b> <% end if %> 