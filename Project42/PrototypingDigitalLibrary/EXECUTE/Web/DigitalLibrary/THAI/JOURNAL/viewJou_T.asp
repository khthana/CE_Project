<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
</head>

<body bgcolor="#FFFFFF">
<% ' get input form DetilJou (detail Journal)

Journal=Request.QueryString("Journal") 
Volume =Request.QueryString("Volume") 
Number =Request.QueryString("Number") 
MonthLocal   =Request.QueryString("Month") 
YearLocal=Request.QueryString("Year") 

rem Editor =Request.QueryString("Editor") 

	'get input from itself
PageNO=Request.QueryString ("PageNO")
sql=Request.QueryString ("sql")

%> 
<H2> <font color="#000099"><%
	'----------- choose comand Sql------------------
' if sql = "" then  'check commnad Sql have from previous file? but if problem syntax ",' in get
	sql = "SELECT  Idjournal,volume,number,month,year,editor,periodicity,j.issn,thaijournal,engjournal from  TblJournal J,TblIssn I where j.issn=i.issn  and "
			
	if Journal="ALL" and VoLume ="" and Number ="" and MonthLocal ="ALL" and YearLocal="ALL"  then
		rem and Editor ="ALL"
		rem sql = "select * from TblDetailJournal"
		
	else
		'display declare Attribute 
		rem sql = "select * from TblDetailJournal Where "
		Response.Write ("คำที่ใช้ในการค้นหา :<br>")
			
		if Journal <> "ALL" then
		sql = sql&"ThaiJournal = '"&Journal&"' and "
		Response.Write ("วารสาร : "&Journal&"<br> ")
		end if
		
		rem if  Editor <>"ALL" then
		rem sql = sql&"Editor = '"&Editor&"' and "
		rem Response.Write ("บรรณาธิการ:"&Editor&"<br> ")
		rem end if
		
		if Volume <> "" then 
		sql = sql&"Volume = '"&Volume&"' and "
		Response.Write ("ปีที่ : "&Volume&"<br> ")
		end if
	
		if Number <> "" then
		sql = sql&"Number = '"&Number&"' and "
		Response.Write ("ฉบัยที่ : "&Number&"<br> ")
		end if
		
		if MonthLocal <>"ALL" then
		sql = sql&"Month = '"&MonthLocal&"' and "
		Response.Write ("เดือน : "&MonthLocal&"<br> ")
		end if
		
		if YearLocal <>"ALL" then
		sql = sql&"Year = "&YearLocal&" and "
		Response.Write ("ปี : "&YearLocal&"<br> ")
		end if
				
		rem Response.write(Sql&"<br>")
	end if ' end choose sql
	' output is command sql but inculde "and" is much
		lengthSql = Len (sql)
		lengthSql = lengthSql - 4 'delete "and+space"
		sql = Left(sql,lengthSql)
		
	'sort by volume, No
		order = " order by Year desc,Volume desc ,number desc "
		sql = sql&order
		
' end if   ' End    check commnad Sql have?
%></font></H2>


<%
'connect DB
	Set conn = Server.CreateObject("ADODB.Connection")
	conn.open "Digital Library","",""
%>

	<!****** intitial rs and display page is 10 page********>
	<!--#include file ="int_rs.asp"-->
	<!br>
<h3>
<% 'check found search in DB 

if Totalrows <> 0 then 
	'found search%>
</h3>
<!** display Journal by sql**********>
<h3>รายการวารสารที่พบ <font color="#FF0033"><%=Totalrows%> </font>ฉบับ</h3>
<table width="100%" border="1" style="BORDER-BOTTOM-COLOR: black" bordercolor="#CCCCCC">
  <tr> 
    <td width="2%"  bgcolor="#CCCCFF" ><font color="#000099">ลำดับ</font></td>
    <td width="29%"  bgcolor="#FFFFCC" > 
      <div align="center"><font color="#000099">ชื่อวารสาร</font></div>
    </td>
    <td width="53%" bgcolor="#CCFFCC"> 
      <div align="center"><font color="#000099">รายละเอียด</font></div>
    </td>
    <td width="16%" bgcolor="#CCCCCC" bordercolor="#CCCCCC"> 
      <div align="center"><font color="#000099">กำหนดออก</font></div>
    </td>
  </tr>
  <% ' special display is not declare Attribute
  Rowcount =1 'compare 10 items is list
  Do while not rs.EOF and Rowcount<= rs.PageSize %> 
  <tr> 
    <td width="2%"  bgcolor="#CCCCFF"> 
      <div align="center"><I><%=(((PageNo-1)*rs.PageSize)+RowCount)%></I></div>
    </td>
    <td width="29%"  bgcolor="#FFFFCC"> 
      <div align="center"> <a href="pap_jou_T.asp?Idjournal=<%=rs("IdJournal")%>"><%=rs("Thaijournal")%><br>
        (ISSN<%=rs("ISSN")%>)</a> </div>
    </td>
    <td width="53%" bgcolor="#CCFFCC"><% rem if Journal = "ALL" then
               rem Response.Write ("วารสาร"&rs("ThaiJournal")&"  ")
               rem end if
               rem Response.Write ("รหัสISSN:"&rs("ISSN")&" ")
               Response.Write ("บรรณาธิการ:"&rs("Editor")&" ")
               
               
               if Volume = "" then 
               Response.Write ("ปีที่:"&rs("Volume")&" ")
               end if
               
               if Number = "" then
               Response.Write ("ฉบับที่:"&rs("Number")&" ")
               end if
               
               if MonthLocal ="ALL" then
               Response.Write (" "&rs("Month")&" ")
               end if
               
               if YearLocal ="ALL" then
               Response.Write ("ปี "&rs("Year")&" ")
               end if 
               
               rem Response.Write ("ระยะเวลา:"&rs("Periodictity"))
               
               %> 
      <div align="center"></div>
    </td>
    <td width="16%" bgcolor="#CCCCCC" bordercolor="#CCCCCC"> 
      <div align="center"><%=rs("Periodicity")%> </div>
    </td>
  </tr>
  <%
	Rowcount = Rowcount + 1
	rs.MoveNext
	loop %> 
</table>
<!****End display Journal by sql**********>
	
<!*** create link Page other************* >
<% Call DisplayPage(Journal,Volume,Number,MonthLocal,YearLocal,PageNO,TotalPages,"viewJou_T.asp")
					'(Journal,Volume,Number,MonthLocal,YearLocal,Editor,PageNO,TotalPages,Filename)%>
						

<% 
else 
	'not found
	Response.Write ("<br><H2>ไม่พบในฐานข้อมูล </H2>")

end if 'End check found search in DB 

	rs.close	
	Conn.Close 
%>

	
</body>
</html>

<Script Language = "VBScript" RunAT="Server">
Sub DisplayPage (Journal,Volume,Number,MonthLocal,YearLocal,PageNO,TotalPages,Filename)

	'display List link Page (check if pages >1)
	if TotalPages > 1 then
	
	'***** Action PageNO such as Previous  1|2|3|.. Next****
		
		'**** previous page 
		if Cint (PageNO) <> 1 then Response.Write ("<a href='"&Filename&"?Journal="&Journal&"&Volume="&Volume&"&Number="&Number&"&Month="&MonthLocal&"&Year="&YearLocal&"&PageNO="&PageNO-1&"'>กลับไปหน้าก่อน</a>&nbsp;") end if

		
		'**** Action PageNO view goto want page 1|2|3|....
		'*** {not check line isn't over 10
		for PageTemp = 1 to TotalPages 
				if PageTemp = Cint(PageNO) and PageTemp =< 20 then 
				Response.Write("<font color=red size=5><i>"&PageNO&"</i></font>&nbsp;|&nbsp;")
				else
				Response.Write ("<a href='"&Filename&"?Journal="&Journal&"&Volume="&Volume&"&Number="&Number&"&Month="&MonthLocal&"&Year="&YearLocal&"&PageNO="&PageTemp&"'>"&PageTemp&"</a>&nbsp;|&nbsp;")
				'Response.Write ("<a href='"&Filename&"?Journal="&Journal&"&Volume="&Volume&"&Number="&Number&"&Month="&MonthLocal&"&Year="&YearLocal&"&Editor="&Editor&PageNO="&PageTemp&"'>"&PageTemp&"</a>&nbsp;|&nbsp;") 
		
				end if
		next
		Response.Write ("&nbsp;")
	
		'** Next page ***
		if Cint (PageNO) <> TotalPages then Response.Write ("<a href='"&Filename&"?Journal="&Journal&"&Volume="&Volume&"&Number="&Number&"&Month="&MonthLocal&"&Year="&YearLocal&"&PageNO="&PageNO+1&"'>หน้าถัดไป</a>&nbsp;") end if
			
		'**End Action PageNO such as Previous  1|2|3|.. Next*****>	
	
	end if 'end if page >1
	
end Sub

</Script>
