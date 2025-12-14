<title>Show all attribute</title>
<body bgcolor="#FFFFFF">
<h1 align="center"><strong><img src="search_r.gif" width="361" height="82"></strong></h1>
<%
atitle=Request.Querystring("Your_title")
ajournal=Request.QueryString("Your_Journal")
aauthor=Request.QueryString("Your_author")
amonth=Request.QueryString("Your_month")
SQL="Select * from Journal where TITLE like '" & atitle &  "%' and Author like '" & aauthor & "%' and J_name like '" & aJournal & "%'and Month like '" & amonth &"%'"
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Current"," "," "
Set RS = Server.CreateObject("ADODB.Recordset")
rs.Open sql, conn, 1, 3
On error Resume next
rs.MoveFirst
Do While not RS.EOF
%>
<table border = "0" >
  <tr> 
    <td width="70"> 
      <div align="left"><b>Title :</b></div>
    </td>
    <td valign="baseline" align="left" width="22"><%=RS("J_Name")%></td>
  </tr>
  <tr> 
    <td width="70"> 
      <div align="left"><b>Article :</b></div>
    </td>
    <td valign="baseline" align="left" width="22"><%=RS("TITLE")%></td>
  </tr>
  <tr> 
    <td width="70"> 
      <div align="left"><b>Author :</b></div>
    </td>
    <td align="left" valign="baseline" width="22"><%=RS("AUTHOR")%></td>
  </tr>
  <tr> 
    <td width="70"> 
      <div align="left"><b>Date :</b></div>
    </td>
    <td align="left" valign="baseline" width="22"><%=RS("DATE")%></td>
  </tr>
  <tr> 
    <td width="70"> 
      <div align="left"><b>Month :</b></div>
    </td>
    <td align="left" valign="baseline" width="22"><%=RS("MONTH")%></td>
  </tr>
  <tr> 
    <td width="70"> 
      <div align="left"><b>Year :</b></div>
    </td>
    <td align="left" valign="baseline" width="22"><%=RS("Year")%></td>
  </tr>
  <tr> 
    <td width="70"> 
      <div align="left"><b>Volume :</b></div>
    </td>
    <td align="left" valign="baseline" width="22"><%=RS("Volume")%></td>
  </tr>
  <tr> 
    <td width="70"> 
      <div align="left"><b>Page :</b></div>
    </td>
    <td align="left" valign="baseline" width="22"><%=RS("PAGE")%></td>
  </tr>
</table>
<% 
RS.MoveNext
Loop
RS.Close
Conn.Close
%>

<hr>
</body>