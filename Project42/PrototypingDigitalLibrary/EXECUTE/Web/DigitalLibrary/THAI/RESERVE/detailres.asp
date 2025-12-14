<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
<STYLE TYPE="text/css">
         .over {color:yellow; background:navy}
         .down {color:yellow; background:navy; font-style:italic}
</STYLE>
</head>

<body bgcolor="#FFFFFF" background="../../pic/kmittkik.jpg" BGPROPERTIES=FIXED >
<%   Set conn = Server.CreateObject("ADODB.Connection")
	 conn.open "Digital Library","",""
	rem conn.open "reserve","",""
%> 
<table width="99%" height="361">
  <tr>
    <td nowrap height="338" width="12%">&nbsp;</td>
    <td nowrap height="338" width="88%"> 
      <h1><font color="#0000FF">บริการแจ้ง</font><font color="#FF3333">วารสารฉบับใหม่</font><font color="#0000FF">ที่กำลังจะออก</font></h1>
      <h3>
        <form method="post" action="reserve.asp">
          <p>ชื่อ :&nbsp;&nbsp;&nbsp; 
            <input type="text" name="namereserve">
          </p>
          <p>E-mail : 
            <input type="text" name="emailreserve" size="40">
          </p>
          <p>ชื่อวารสาร : 
            <select name="ISSN">
              <%Call ComboListISSN("Issn","ThaiJournal")%> 
            </select>
          </p>
          <p> 
            <input type="submit" name="Submit" value="ตกลง"
     onMouseOver="this.className = 'over';" 
     onMouseOut="this.className = '';" 
     onMouseDown="this.className = 'down';" 
     onMouseUp="this.className = 'over';">
            <input type="reset" name="reset" value="ยกเลิก"
     onMouseOver="this.className = 'over';" 
     onMouseOut="this.className = '';" 
     onMouseDown="this.className = 'down';" 
     onMouseUp="this.className = 'over';">

          </p>
        </form>
        <p></p>
      </h3>
    </td>
  </tr>
</table>

  <p>&nbsp; </p>
  <% Conn.Close%> 
</body>
</html>

<Script Language = "VBScript" RunAT="Server">
Sub ComboListISSN(ColumnList1,ColumnList2) 'issn,thaijournal
	sql = "SELECT * FROM  TblISSN;"
	set rs = conn.Execute(sql)

	Do while not rs.EOF
			DisplayColumnList1 =rs(ColumnList1)
			DisplayColumnList2 =rs(ColumnList2)					
			Response.Write ("<option value='"&DisplayColumnList1&"' >"&DisplayColumnList2&"</option>")
			rs.MoveNext
			loop

	rs.Close
end Sub

</Script>
