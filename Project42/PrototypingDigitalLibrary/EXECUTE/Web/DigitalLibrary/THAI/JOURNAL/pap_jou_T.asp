<%@ Language=VBScript %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
</HEAD>
<BODY bgcolor="#FFFFFF">


<%	'get input 
	Idjournal=Request.QueryString ("Idjournal")
	PageNO=Request.QueryString ("PageNO")
	
	'set path paper 
	PathPaper = "/digitallibrary/Paper/"
	
	'connect DB
	Set conn = Server.CreateObject("ADODB.Connection")
	conn.open "Digital Library","",""
	
	rem  ------ view  papers in this journal ---<begin>---
	sql = "SELECT * FROM  Tblpaper where Idjournal ="&Idjournal&";"
	%>
	
	<!****** intitial rs and display page is 10 page********>
	<!--#include file ="int_rs.asp"-->
	<br>
<% rem if totalrows <> 0 then
	rem Response.Write ("จำนวนบทความที่พบ = "&Totalrows)
	rem end if
	%> <% '---check found search---------------
if Totalrows <>0 then 

%> <! *************  display a Papers in Journal   ***************> 
<h3>รายการบทความที่พบ<font color="#FF0033"> <%=Totalrows%></font> บทความ</h3>
  
<table width="165%" border="1" style="BORDER-BOTTOM-COLOR: black" bordercolor="#CCCCCC">
  <tr> 
    <td bgcolor="#CCCCFF" width="5%" height="19"><font color="#000099">ลำดับ</font></td>
    <td bgcolor="#fffff0" width="42%" height="19"> 
      <div align="center"><font color="#000099">ชื่อบทความ</font></div>
    </td>
    <td width="27%" height="19" bgcolor="#CCFFCC"> 
      <div align="center"><font color="#000099">ผู้แต่ง</font></div>
    </td>
    <td width="26%" height="19" bgcolor="#CCCCCC"> 
      <div align="center"><font color="#000099">รายละเอียด</font></div>
    </td>
  </tr>
  <% ' special display is not declare Attribute
  Rowcount =1 'compare 10 items is list
  Do while not rs.EOF and Rowcount<= rs.PageSize %> 
  <tr> 
    <td bgcolor="#CCCCFF" height="52" width="5%" > 
      <div align="center"><i><%=(((PageNo-1)*rs.PageSize)+RowCount)%></i></div>
    </td>
    <td bgcolor="#fffff0" height="52" width="42%" > 
      <div align="left"><a href="<%=PathPaper%><%=rs("Filepaper")%>"><%=rs("ThaiTitle")%></a></div>
    </td>
    <td height="52" width="27%" bgcolor="#CCFFCC"> <%
			
			for I = 1 to 5
			if rs("Author"&I)<>"" then %> <a href='/digitallibrary/thai/paper/viewPaper_T.asp?Journal=ALL&AuthorA=<%=rs("Author"&I)%>'><%=rs("Author"&I)%> 
      </a> <%'check insert comma 
				if rs("Author"&I+1)<>"" then Response.Write (",") end if%> <% 
			end if
			next
			%> </td>
    <td height="52" width="26%" bgcolor="#CCCCCC"> 
      <div align="left">
        <p>ประเภทของวรสาร: <%=rs("TypePaper")%> เริ่มหน้าที่: <%=rs("StartPage")%>จบหน้าที่ 
          :<%=rs("FinalPage")%> </p>
        </div>
    </td>
  </tr>
  <%
			Rowcount = Rowcount + 1
			rs.MoveNext
		loop %> 
</table>	
		<! *************End  display a Papers in Journal   ***************>	






<!*** create link Page other************* >
<% Call DisplayPage(Idjournal,PageNO,TotalPages,"pap_jou_T.asp")
					'(Idjournal,PageNO,TotalPages,Filename)%>

<% 
else 
	'Not found search
	Response.Write ("<h2>ยังไม่มีบทความ</h2>")

end if 
%>

<%	
rs.Close
rem  ------ papers in Journal  ---<end>---
conn.Close
%> 


</BODY>
</HTML>

<Script Language = "VBScript" RunAT="Server">
Sub DisplayPage (Idjournal,PageNO,TotalPages,Filename)

	'display List link Page (check if pages >1)
	if TotalPages > 1 then
	
	'***** Action PageNO such as Previous  1|2|3|.. Next****
		
		'**** previous page 
		if Cint (PageNO) <> 1 then Response.Write ("<a href='"&Filename&"?Idjournal="&Idjournal&"&PageNO="&PageNO-1&"'>กลับไปหน้าก่อน</a>&nbsp;") end if

		
		'**** Action PageNO view goto want page 1|2|3|....
		'*** {not check line isn't over 10
		for PageTemp = 1 to TotalPages 
				if PageTemp = Cint(PageNO) then 
				Response.Write("<font color=red size=5><i>"&PageNO&"</i></font>&nbsp;|&nbsp;")
				else
				Response.Write ("<a href='"&Filename&"?Idjournal="&Idjournal&"&PageNO="&PageTemp&"'>"&PageTemp&"</a>&nbsp;|&nbsp;") 
		
				end if
		next
		Response.Write ("&nbsp;")
	
		'** Next page ***
		if Cint (PageNO) <> TotalPages then Response.Write ("<a href='"&Filename&"?Idjournal="&Idjournal&"&PageNO="&PageNO+1&"'>หน้าถัดไป</a>&nbsp;") end if
	
		'**End Action PageNO such as Previous  1|2|3|.. Next*****>	
	
	end if 'end if page >1
	
end Sub

</Script>
