<html>
<head>
<title>Detail Papers</title>
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
<h1 align="center"><font color="#3333FF">สืบค้นจากบทความ </font></h1>
<form method="get" action="viewPaper_T.asp" name="DetailPaper">
  <table width="102%" border="0" height="237">
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"><font size="5" color="#009900">ชื่อบทความ</font></div>
      </td>
      <td> 
        <div align="left"> 
          <input type="text" name="STitle">
        </div>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"><font size="5" color="#009900">ผู้แต่ง</font> </div>
      </td>
      <td> 
        <div align="left"> 
          <input type="text"  name="AuthorSearch1">
        </div>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"> 
          <select name="BoAuthor1" >
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td> 
        <input type="text"  name="AuthorSearch2">
      </td>
    </tr>
    <tr> 
      <td height="33">&nbsp;</td>
      <td height="33"> 
        <div align="right"> 
          <select name="BoAuthor2" >
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td height="33"> 
        <input type="text"  name="AuthorSearch3">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"> 
          <select name="BoAuthor3" >
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td> 
        <input type="text"  name="AuthorSearch4">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"> 
          <select name="BoAuthor4" >
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td> 
        <input type="text"  name="AuthorSearch5">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"><font size="5" color="#009900">ชื่อวารสาร</font> </div>
      </td>
      <td> <!*** Combo Journal ***********> 
        <select name="Journal" >
          <option value="ALL">ทั้งหมด</option>
          <%Call ComboTblDetailJournal("ThaiJournal")%> 
        </select>
      </td>
    </tr>
    <tr> 
      <td height="21"><font size="5" color="#009900"></font></td>
      <td height="21"> 
        <div align="right"><font size="5" color="#009900"> 
          <input type="radio" name="selectsearch" value="keywords" checked>
          ค้นจากคำค้น </font></div>
      </td>
      <td height="21"> <font size="5" color="#009900"> 
        <input type="radio" name="selectsearch" value="abstracts">
        ค้นจากบทคัดย่อ </font></td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"><font size="5" color="#009900">คำที่กำหนด</font></div>
      </td>
      <td> 
        <div align="left"> 
          <input type="text" name="Keysearch1">
        </div>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"> 
          <select name="BoKey1">
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td> 
        <input type="text" name="Keysearch2">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"> 
          <select name="BoKey2">
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td> 
        <input type="text" name="Keysearch3">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"> 
          <select name="BoKey3">
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td> 
        <input type="text" name="Keysearch4">
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
      <td> 
        <div align="right"> 
          <select name="BoKey4">
            <option value="or">หรือ</option>
            <option value="and">และ</option>
            <option value="not">ไม่</option>
          </select>
        </div>
      </td>
      <td> 
        <input type="text" name="Keysearch5">
      </td>
    </tr>
    <tr> 
      <td width="8%" height="31">&nbsp;</td>
      <td width="22%" height="31"> 
        <div align="right"><font size="4"><font size="1"><font size="6"><font size="+5"><font size="5"><font size="5"><b><font color="#00CC33"><font color="#009900"></font></font></b></font></font></font></font></font></font></div>
      </td>
      <td width="70%" height="31"> 
        <div align="left"> 
          <input type="submit" name="Submit" value="ตกลง"
     onMouseOver="this.className = 'over';" 
     onMouseOut="this.className = '';" 
     onMouseDown="this.className = 'down';" 
     onMouseUp="this.className = 'over';">
          <input type="reset" name="Submit2" value="ยกเลิก"
     onMouseOver="this.className = 'over';" 
     onMouseOut="this.className = '';" 
     onMouseDown="this.className = 'down';" 
     onMouseUp="this.className = 'over';">
        </div>
      </td>
    </tr>
  </table>
  </form>
<p align="right"><img src="../../pic/books.gif" width="47" height="72"></p>

<% Conn.Close%>


</body>
</html>
<Script Language = "VBScript" RunAT="Server">
Sub ComboTblDetailJournal(ColumnList)

	sql = "SELECT distinct("&ColumnList&") FROM  TblIssn;"
	set rs = conn.Execute(sql)

	Do while not rs.EOF
			DisplayColumnList =rs(ColumnList)		
			Response.Write ("<option value='"&DisplayColumnList&"' >"&DisplayColumnList&"</option>")
			rs.MoveNext
			loop

	rs.Close
end Sub

Sub ComboTblPaper(ColumnList)

	sql = "SELECT distinct("&ColumnList&") FROM  TblPaper;"
	set rs = conn.Execute(sql)

	Do while not rs.EOF
			DisplayColumnList =rs(ColumnList)		
			Response.Write ("<option value='"&DisplayColumnList&"' >"&DisplayColumnList&"</option>")
			rs.MoveNext
			loop

	rs.Close
end Sub

</Script>
