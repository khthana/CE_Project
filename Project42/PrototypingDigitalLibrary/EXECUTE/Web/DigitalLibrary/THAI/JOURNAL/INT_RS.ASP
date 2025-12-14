<%
	'Create Record 
	'check page is dispaly
	'A page have 10 row
	
	
	
	set rs = Server.CreateObject("ADODB.Recordset")
	rs.Open sql,conn,1,3
	
	On Error Resume Next 
		
	'-- intitial page 
	Totalrows	= rs.RecordCount
	rs.PageSize = 10 
	Totalpages	= rs.PageCount
	
	'-- check state Select PageNO
	if PageNO = "" or Cint(PageNO) < 1	then PageNO =1 end if
	if Cint(PageNO) > Totalpages		then  PageNO = Totalpages end if 
	
	
	%>
		
	<%rs.AbsolutePage = PageNO %>
