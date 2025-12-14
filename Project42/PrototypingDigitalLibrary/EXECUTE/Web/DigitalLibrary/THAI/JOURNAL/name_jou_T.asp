<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
</HEAD>

<BODY bgcolor="#FFFFFF" background="../../pic/Gear.jpg" BGPROPERTIES=FIXED>
<table width="89%" border="0" height="38">
  <tr> 
    <td width="22%">&nbsp;</td>
    <td width="78%"> 
      <h1><font color="#3333FF">รายการชื่อวารสารทั้งหมด</font></h1>
    </td>
  </tr>
</table>
<h1 align="left"><%  Set conn = Server.CreateObject("ADODB.Connection")
	conn.open "Digital Library","",""	
	ColumnList="ThaiJournal"

	sql = "SELECT distinct("&ColumnList&") FROM  TblIssn I "
	set rs = conn.Execute(sql)

	Do while not rs.EOF
			DisplayColumnList =rs(ColumnList)		
%> </h1>
<table width="89%" border="0" height="38">
  <tr> 
    <td width="22%">&nbsp;</td>
    <td width="78%"> 
      <h2 align="left"> <img src="Light%20Bulb.gif" width="22" height="37" align="absmiddle"><a href='viewJou_T.asp?Journal=<%=DisplayColumnList%>&Year=ALL&Month=ALL'> 
        <b><%=DisplayColumnList%></b></a></h2>
    </td>
  </tr>
</table>
 <%
			rs.MoveNext
			loop

	rs.Close
%>
</BODY>
</HTML>

