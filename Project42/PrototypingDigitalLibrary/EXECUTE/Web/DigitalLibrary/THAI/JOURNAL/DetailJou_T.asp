<html>
<head>
<title>Detail Journal</title>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
<STYLE TYPE="text/css">
         .over {color:yellow; background:navy}
         .down {color:yellow; background:navy; font-style:italic}
</STYLE>

</head>

<body bgcolor="#FFFFFF" background="../../pic/borderbook2.gif">
<%   Set conn = Server.CreateObject("ADODB.Connection")
   conn.open "Digital Library","",""

%> 
<p>&nbsp;</p><h1 align="center"><font color="#3333FF">สืบค้นจากชื่อวารสาร</font> </h1>
<form method="get" action="viewJou_T.asp">
  <table width="83%" border="0">
    <tr> 
      <td width="32%">&nbsp;</td>
      <td width="26%"> 
        <div align="right"><font size="5" color="#009900">ชื่อวารสาร</font></div>
      </td>
      <td width="42%"> <!*** Combo Journal ***********> 
        <select name="Journal">
          <option value="ALL">ทั้งหมด</option>
          <%Call ComboList("ThaiJournal")%> 
        </select>
      </td>
    </tr>
    <tr> 
      <td width="32%">&nbsp;</td>
      <td width="26%"> 
        <div align="right"><font size="5" color="#009900">ปีที่</font></div>
      </td>
      <td width="42%"> 
        <input type="text" name="volume" size="5" 
        ONKEYPRESS="if ((event.keyCode < 48) || (event.keyCode > 57)) event.returnValue = false;">
        <!** input integer only *** > </td>
    </tr>
    <tr> 
      <td width="32%">&nbsp;</td>
      <td width="26%"> 
        <div align="right"><font size="5" color="#009900">ฉบับที่</font></div>
      </td>
      <td width="42%"> 
        <input type="text" name="number" size="5"
        ONKEYPRESS="if ((event.keyCode < 48) || (event.keyCode > 57)) event.returnValue = false;">
        <!** input integer only *** > </td>
    </tr>
    <tr> 
      <td width="32%">&nbsp;</td>
      <td width="26%"> 
        <div align="right"><font size="5" color="#009900">เดือน</font></div>
      </td>
      <td width="42%"> 
        <select name="Month" size="1">
          <option value="ALL">ทั้งหมด</option>
          <option value="มกราคม">มกราคม</option>
          <option value="กุมภาพันธ์">กุมภาพันธ์</option>
          <option value="มีนาคม">มีนาคม</option>
          <option value="เมษายน">เมษายน</option>
          <option value="พฤษภาคม">พฤษภาคม</option>
          <option value="มิถุนายน">มิถุนายน</option>
          <option value="กรกฎาคม">กรกฎาคม</option>
          <option value="สิงหาคม">สิงหาคม</option>
          <option value="กันยายน">กันยายน</option>
          <option value="ตุลาคม">ตุลาคม</option>
          <option value="พฤศจิกายน">พฤศจิกายน</option>
          <option value="ธันวาคม">ธันวาคม</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="32%">&nbsp;</td>
      <td width="26%"> 
        <div align="right"><font size="5" color="#009900">ปี</font></div>
      </td>
      <td width="42%"><!*** Combo Year *****> 
        <select name="Year">
          <option value="ALL">ทั้งหมด</option>
          <%Call ComboList("Year")%> 
        </select>
      </td>
    </tr>
    <tr> 
      <td width="32%">&nbsp;</td>
      <td width="26%"> 
        <div align="right"><font color="#009900"> </font></div>
      </td>
      <td width="42%"> <font color="#009900"> 
        <input type="submit" name="Submit" value="ตกลง"
     onMouseOver="this.className = 'over';" 
     onMouseOut="this.className = '';" 
     onMouseDown="this.className = 'down';" 
     onMouseUp="this.className = 'over';">
        &nbsp;&nbsp; 
        <input type="reset" name="reset" value="ยกเลิก"
     onMouseOver="this.className = 'over';" 
     onMouseOut="this.className = '';" 
     onMouseDown="this.className = 'down';" 
     onMouseUp="this.className = 'over';">
        </font> </td>
    </tr>
  </table>
  </form>
<p align="right"><img src="../../pic/books.gif" width="42" height="63"></p>

<% Conn.Close%>


</body>
</html>

<Script Language = "VBScript" RunAT="Server">
Sub ComboList(ColumnList)

	sql = "SELECT distinct("&ColumnList&") FROM  TblJournal J,TblIssn I where J.issn=I.Issn ;"
	set rs = conn.Execute(sql)

	Do while not rs.EOF
			DisplayColumnList =rs(ColumnList)		
			Response.Write ("<option value='"&DisplayColumnList&"' >"&DisplayColumnList&"</option>")
			rs.MoveNext
			loop

	rs.Close
end Sub

</Script>
