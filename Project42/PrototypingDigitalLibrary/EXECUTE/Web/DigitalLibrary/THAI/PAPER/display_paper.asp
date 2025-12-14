<%'set path paper 
PathPaper = "/digitallibrary/Paper/" %>

<h3>รายการบทความที่พบ<font color="#FF0033"> <%=Totalrows%></font> บทความ</h3>
<table width=165%  border="1" style="BORDER-BOTTOM-COLOR: black" bordercolor="#CCCCCC">
  <tr> 
    <td bgcolor="#CCCCFF" width=5% height="20"> 
      <div align="center"><font color="#000099">ลำดับ</font></div>
    </td>
    <td bgcolor="#FFFFCC" width=39% height="20"> 
      <div align=center><font color="#000099">ชื่อบทความ</font></div>
    </td>
    <td width=27% bgcolor="#CCFFCC" height="20"> 
      <div align=center><font color="#000099">ผู้แต่ง</font></div>
    </td>
    <td width=29% bgcolor="#CCCCCC" height="20"> 
      <div align=center><font color="#000099">รายละเอียด</font></div>
    </td>
  </tr>
  <% ' special display is not declare Attribute
  Rowcount =1 'compare 10 items is list
  Do while not rs.EOF and Rowcount<= rs.PageSize %> 
  <tr> 
    <td  bgcolor="#CCCCFF" width="5%"  > 
      <div align=center><I><%=(((PageNo-1)*rs.PageSize)+RowCount)%></I></div>
    </td>
    <td  bgcolor="#FFFFCC" width="39%" >     
      <div align=left><a href="<%=PathPaper%><%=rs("Filepaper")%>"><%=rs("ThaiTitle")%></a></div>
    </td>
    <td width="27%" bgcolor="#CCFFCC"  > 
      <div align=left> <%
			
			for I = 1 to 5
			if rs("Author"&I)<>"" then %> <a href='viewPaper_T.asp?Journal=ALL&AuthorA=<%=rs("Author"&I)%>' > 
        <%=rs("Author"&I)%> </a> <%'check insert comma 
				if rs("Author"&I+1)<>"" then Response.Write (",") end if%> <% 
			end if
			next
			%> </div>
    </td>
    <td width="29%" bgcolor="#CCCCCC"  > 
      <div align=left> <%=rs("ThaiJournal")%> ประเภท<%=rs("TypePaper")%> 
        <br>
			ปีที่<%=rs("Volume")%> ฉบับที่<%=rs("Number")%> 
        <%'write month year
            Response.Write (" "&rs("Month")&" "&rs("Year")&" ")
            %>             
			หน้า<%=rs("StartPage")%>-<%=rs("FinalPage")%>
        </div>
    </td>
  </tr>
  <%
	Rowcount = Rowcount + 1
	rs.MoveNext
	loop %> 
</table>