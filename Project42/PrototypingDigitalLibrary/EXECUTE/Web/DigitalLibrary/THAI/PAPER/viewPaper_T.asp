<%@ Language=VBScript %>
<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
</HEAD>
<BODY bgcolor="#FFFFFF">
<% ' get input form DetilJou (detail Journal)

STitle		=Request.QueryString ("STitle")
Journal		=Request.QueryString ("Journal")
PageNO		=Request.QueryString ("PageNO")
selectsearch =Request.QueryString ("selectsearch") 'keywords,abstracts
rem Response.Write (selectsearch)
' input author 1-5 
dim AuthorSearch(6)
AuthorSearch(1)	=Request.QueryString ("AuthorSearch1")
AuthorSearch(2)	=Request.QueryString ("AuthorSearch2")
AuthorSearch(3)	=Request.QueryString ("AuthorSearch3")
AuthorSearch(4)	=Request.QueryString ("AuthorSearch4")
AuthorSearch(5)	=Request.QueryString ("AuthorSearch5")

'input BoAuthor 1-4
dim BoAuthor(5)
BoAuthor(1)		=Request.QueryString ("BoAuthor1")
BoAuthor(2)		=Request.QueryString ("BoAuthor2")
BoAuthor(3)		=Request.QueryString ("BoAuthor3")
BoAuthor(4)		=Request.QueryString ("BoAuthor4")


'declare parameter found before keysearch and author
dim BeforeKeySearch 
BeforeKeySearch = false
dim BeforeAuthorSearch 
BeforeAuthorSearch = false

' input keysearch 1-5 
dim KeySearch(6)
KeySearch(1)	=Request.QueryString ("KeySearch1")
KeySearch(2)	=Request.QueryString ("KeySearch2")
KeySearch(3)	=Request.QueryString ("KeySearch3")
KeySearch(4)	=Request.QueryString ("KeySearch4")
KeySearch(5)	=Request.QueryString ("KeySearch5")

'input Bokey 1-4
dim BoKey(5)
BoKey(1)		=Request.QueryString ("BoKey1")
BoKey(2)		=Request.QueryString ("BoKey2")
BoKey(3)		=Request.QueryString ("BoKey3")
BoKey(4)		=Request.QueryString ("BoKey4")

rem 'view input keysearch
 rem for I=1 to 5
	rem Response.Write ("test get input ")
	rem Response.Write (Authorsearch(I))
	rem Response.Write (BoAuthor(I)&"<br>")
 rem next

%> <! view get input > 
<!title : <%rem =STitle%> <BR>
<!Journal :<%rem =Journal%> <BR>
<!Stype   :<%rem =Stype%> <br>
<!AuthorA :<%rem =AuthorA%> <br>
<!AuthorB :<%rem =AuthorB%> <br>
<!BoAuthor:<%rem =BoAuthor%> <br>
<!keysearch1 : <%rem =keysearch(1)%> >
<!KeywordB:<%rem =KeywordB%> <br>
<!BoKey   :<%rem =BoKey%> <br>


<h2>
 <font color="#000099"><%
'insert default SQL command
sql = "SELECT  ThaiTitle, EngTitle,TypePaper,Author1,Author2,Author3,Author4,Author5,Keyword1,Keyword2,Keyword3,Keyword4,Keyword5,StartPage,FinalPage,FilePaper,I.ThaiJournal,P.IdJournal,Volume,Number,Month,Year,Editor from TblPaper P ,TblIssn I,TblJournal J   where I.Issn = J.Issn and P.IdJournal = J.IdJournal and "


'if parameter are not default -> insert "where" in sql
'display เงื่อนไข ใน การ search
if STitle <> "" or Journal <>"ALL" or AuthorSearch(1) <> "" or AuthorSearch(2) <> "" or AuthorSearch(3) <> "" or AuthorSearch(4) <> "" or AuthorSearch(5) <> "" or KeySearch(1) <>"" or KeySearch(2) <> "" or KeySearch(3) <> "" or KeySearch(4) <> "" or KeySearch(5) <> "" then
	rem 'insert "where "
	rem sql =sql&"where       "
	Response.Write ("คำที่ใช้ในการค้นหา :<br>")
	if STitle <> "" then
		sql = sql & "ThaiTitle  like '"&STitle&"%'  and "   
		Response.Write ("ชื่อบทความ : "&STitle&"<br> ")
	end if 'STitle

	if Journal <> "ALL" then
		sql = sql&"'"&Journal&"'"&"=I.ThaiJournal   and "
		Response.Write ("วารสาร : "&Journal&"<br> ")
	end if 'Journal
	
			rem if Stype <>"ALL" then
				rem sql = sql&"TypePaper = '"&SType&"' and "
				rem Response.Write ("ชนิดบทความ :"&Journal&"<br> ")
			rem end if 'Stype
	
	

'------------check Author1-5-----------------------
	
	'insert " (" and check blank Authorsearch1
	if AuthorSearch(1)<>"" or AuthorSearch(2)<>"" or AuthorSearch(3)<>"" or AuthorSearch(4)<>"" or AuthorSearch(5)<>"" then 
			
			sql = sql & " ( " 
			Response.Write ("ผู้แต่ง : ")
	end if
	
	for I=1 to 5
		if Authorsearch(I) <>"" then
						
			'----check insert "link first sentence" it is not insert boolean -----
			rem if I = 1 then BeforeAuthorSearch = true end if
			
			if I > 1 and BeforeAuthorSearch = false then 	
			
			for countbefore = 1 to (I-1) 
				if Authorsearch(Countbefore) <> "" then BeforeAuthorSearch = true end if
			next
						
			end if
			
			rem debug 
			rem Response.Write ("<br>I:"&I&"before"&BeforeAuthorSearch)
			
			'-----end check insert link first sentence----
			
			
								
			'insert command each order
			if BoAuthor(I-1) = "not" then HaveAuthorSearch = "  (Author1 not like '"&Authorsearch(I)&"%' and Author2 not like '"&Authorsearch(I)&"%' and Author3 not like '"&Authorsearch(I)&"%' and Author4 not like '"&Authorsearch(I)&"%' and Author5 not like '"&Authorsearch(I)&"%')   " else HaveAuthorSearch = "  (Author1 like '"&Authorsearch(I)&"%' or Author2 like '"&Authorsearch(I)&"%' or Author3 like '"&Authorsearch(I)&"%' or Author4 like '"&Authorsearch(I)&"%' or Author5 like '"&Authorsearch(I)&"%')  " end if
			rem Response.Write (HaveAuthorSearch)
			
			
			
						
			'-----link sentence sql-----
			if BeforeAuthorSearch = true then

				'display
				Select Case BoAuthor(I-1)
					Case "and"
						Response.Write (" และ"&AuthorSearch(I))
					Case "or"
						Response.Write (" หรือ"&AuthorSearch(I))
					Case "not"
						Response.Write (" ไม่ใช่"&AuthorSearch(I))
					Case Else 
						Response.Write (AuthorSearch(I))
				end Select			
				
				if BoAuthor(I-1)="or" then sql = sql & "  or "  & HaveAuthorSearch  else sql = sql & " and " & HaveAuthorSearch   end if		
			
			
			else rem BeforeAuthorSearch = false
				'display first order
				if BoAuthor(I-1)="not" then Response.Write (" ไม่ใช่"&AuthorSearch(I)) else Response.Write (AuthorSearch(I)) end if
				
				sql = sql & "   "  & HaveAuthorSearch
				
			end if
			'end-----link sentence sql-----						


		else 
		'Authorserch =""
		end if 
		
	next 'end for I=5
	
	
		
		if AuthorSearch(1)<>"" or AuthorSearch(2)<>"" or AuthorSearch(3)<>"" or AuthorSearch(4)<>"" or AuthorSearch(5)<>"" then 
				'insert ")"
				sql = sql & " )     and "
				Response.Write ("<br>")
		end if
		'newline
		rem Response.Write (sql)
		
'end------------check Author1-5-----------------------


'------------check keyword1-5-----------------------
	
	'insert " (" and check blank keysearch1
	if KeySearch(1)<>"" or KeySearch(2)<>"" or KeySearch(3)<>"" or KeySearch(4)<>"" or KeySearch(5)<>"" then 
			
			sql = sql & " ( " 
			Response.Write ("คำค้น : ")
	end if
	
	for I=1 to 5
		if Keysearch(I) <>"" then
						
			'----check insert "link first sentence" it is not insert boolean -----
			rem if I = 1 then BeforeKeySearch = true end if
			
			if I > 1 and BeforeKeySearch = false then 	
			
			for countbefore = 1 to (I-1) 
				if Keysearch(Countbefore) <> "" then BeforeKeySearch = true end if
			next
						
			end if
			
			rem debug 
			rem Response.Write ("<br>I:"&I&"before"&BeforeKeySearch)
			
			'-----end check insert link first sentence----
			
			
								
			'insert command each order
			Select Case selectsearch
			case "keywords"
				if BoKey(I-1) = "not"  then HaveKeySearch = "  (Keyword1 not like '%"&Keysearch(I)&"%' and Keyword2 not like '%"&Keysearch(I)&"%' and Keyword3 not like '%"&Keysearch(I)&"%' and Keyword4 not like '%"&Keysearch(I)&"%' and Keyword5 not like '%"&Keysearch(I)&"%')   " else HaveKeySearch = "  (Keyword1 like '%"&Keysearch(I)&"%' or Keyword2 like '%"&Keysearch(I)&"%' or Keyword3 like '%"&Keysearch(I)&"%' or Keyword4 like '%"&Keysearch(I)&"%' or Keyword5 like '%"&Keysearch(I)&"%')  " end if
			case "abstracts"
				if BoKey(I-1) = "not"  then HaveKeySearch = "  (ThaiAbstract not like '%"&Keysearch(I)&"%' and EngAbstract not like '%"&Keysearch(I)&"%' )   " else HaveKeySearch = "  (ThaiAbstract  like '%"&Keysearch(I)&"%' or EngAbstract  like '%"&Keysearch(I)&"%' )   " end if
			end select
			rem Response.Write (HaveKeySearch)
			
			
			
						
			'-----link sentence sql-----
			if BeforeKeySearch = true then

				'display
				Select Case BoKey(I-1)
					Case "and"
						Response.Write (" และ"&KeySearch(I))
					Case "or"
						Response.Write (" หรือ"&KeySearch(I))
					Case "not"
						Response.Write (" ไม่ใช่"&KeySearch(I))
					Case Else 
						Response.Write (KeySearch(I))
				end Select			
				
				if BoKey(I-1)="or" then sql = sql & "  or "  & HaveKeySearch  else sql = sql & " and " & HaveKeySearch   end if		
			
			
			else rem BeforeKeySearch = false
				'display first order
				if BoKey(I-1)="not" then Response.Write (" ไม่ใช่"&KeySearch(I)) else Response.Write (KeySearch(I)) end if
				
				sql = sql & "   "  & HaveKeySearch
				
			end if
			'end-----link sentence sql-----						


		else 
		'keyserch =""
		end if 
		
	next 'end for I=5
	
	
		
		if KeySearch(1)<>"" or KeySearch(2)<>"" or KeySearch(3)<>"" or KeySearch(4)<>"" or KeySearch(5)<>"" then 
				'insert ")"
				sql = sql & " )      "
		end if
		'newline
		rem Response.Write (sql)
		Response.Write ("<br>")
'end------------check keyword1-5-----------------------

end if 'parameter are not default
		' output is command sql but inculde "and" is much
		lengthSql = Len (sql)
		lengthSql = lengthSql - 4 'delete "and+space"
		sql = Left(sql,lengthSql)	
		'order idpaper
		rem Response.Write (sql)	
		order = " order by Idpaper desc "
		sql = sql&order
	
%> </font> </h2>
<%
'connect DB
	Set conn = Server.CreateObject("ADODB.Connection")
	conn.open "Digital Library","",""
%>

	<!****** intitial rs and display page is 10 page********>
	<!--#include virtual ="/digitallibrary/thai/journal/int_rs.asp"-->
	<!br>
	
<% 'check found search in DB 

if Totalrows <> 0 then 
	'found search%>

<!** display Journal by sql**********>
<!--#include file ="display_paper.asp"-->


	
<!*** create link Page other************* >
<% Call DisplayPage(STitle,Journal,selectsearch,AuthorSearch(1),AuthorSearch(2),AuthorSearch(3),AuthorSearch(4),AuthorSearch(5),BoAuthor(1),BoAuthor(2),BoAuthor(3),BoAuthor(4),KeySearch(1),KeySearch(2),KeySearch(3),KeySearch(4),KeySearch(5),BoKey(1),BoKey(2),BoKey(3),BoKey(4),PageNo,TotalPages,"viewPaper_T.asp")
					%>
						

<% 
else 
	'not found
	Response.Write ("<br><H2>ไม่พบในฐานข้อมูล </H2>")

end if 'End check found search in DB 

	rs.close	
	Conn.Close 
%>


</BODY>
</HTML>

<Script Language="VBScript" Runat="Server">
Sub DisplayPage(STitle,Journal,selectsearch,AuthorSearch1,AuthorSearch2,AuthorSearch3,AuthorSearch4,AuthorSearch5,BoAuthor1,BoAuthor2,BoAuthor3,BoAuthor4,KeySearch1,KeySearch2,KeySearch3,KeySearch4,KeySearch5,BoKey1,BoKey2,BoKey3,BoKey4,PageNo,TotalPages,Filename)
'Sub DisplayPage(STitle,Journal,selectsearch,AuthorSearch(1),AuthorSearch(2),AuthorSearch(3),AuthorSearch(4),AuthorSearch(5),BoAuthor(1),BoAuthor(2),BoAuthor(3),BoAuthor(4),KeySearch(1),KeySearch(2),KeySearch(3),KeySearch(4),KeySearch(5),BoKey(1),BoKey(2),BoKey(3),BoKey(4),PageNo,TotalPages,Filename)


	'display List link Page (check if pages >1)
	if TotalPages > 1 then
	
	'***** Action PageNO such as Previous  1|2|3|.. Next****
			
		'**** previous page 
		if Cint (PageNO) <> 1 then Response.Write ("<a href='"&Filename&"?STitle="&STitle&"&Journal="&Journal&"&selectsearch="&selectsearch&"&AuthorSearch1="&AuthorSearch1&"&AuthorSearch2="&AuthorSearch2&"&AuthorSearch3="&AuthorSearch3&"&AuthorSearch4="&AuthorSearch4&"&AuthorSearch5="&AuthorSearch5&"&BoAuthor1="&BoAuthor1&"&BoAuthor2="&BoAuthor2&"&BoAuthor3="&BoAuthor3&"&BoAuthor4="&BoAuthor4&"&KeySearch1="&KeySearch1&"&KeySearch2="&KeySearch2&"&KeySearch3="&KeySearch3&"&KeySearch4="&KeySearch4&"&KeySearch5="&KeySearch5&"&BoKey1="&BoKey1&"&BoKey2="&BoKey2&"&BoKey3="&BoKey3&"&BoKey4="&BoKey4&"&PageNO="&PageNO-1&"'>กลับไปหน้าก่อน</a>&nbsp;&nbsp;") end if
			
		
		'**** Action PageNO view goto want page 1|2|3|....
		'*** {not check line isn't over 10
		for PageTemp = 1 to TotalPages 
				
				if PageTemp = Cint(PageNO) and PageTemp =< 20 then 
					Response.Write("<font color=red size=5><i>"&PageNO&"</i></font>&nbsp;|&nbsp;") 	
				else	
					Response.Write ("<a href='"&Filename&"?STitle="&STitle&"&Journal="&Journal&"&selectsearch="&selectsearch&"&AuthorSearch1="&AuthorSearch1&"&AuthorSearch2="&AuthorSearch2&"&AuthorSearch3="&AuthorSearch3&"&AuthorSearch4="&AuthorSearch4&"&AuthorSearch5="&AuthorSearch5&"&BoAuthor1="&BoAuthor1&"&BoAuthor2="&BoAuthor2&"&BoAuthor3="&BoAuthor3&"&BoAuthor4="&BoAuthor4&"&KeySearch1="&KeySearch1&"&KeySearch2="&KeySearch2&"&KeySearch3="&KeySearch3&"&KeySearch4="&KeySearch4&"&KeySearch5="&KeySearch5&"&BoKey1="&BoKey1&"&BoKey2="&BoKey2&"&BoKey3="&BoKey3&"&BoKey4="&BoKey4&"&PageNO="&PageTemp&"'>"&PageTemp&"</a>&nbsp;")
				end if
		next
		
		Response.Write ("&nbsp;")
		
		'** Next page ***
		if Cint (PageNO) <> Cint (TotalPages) then 	Response.Write ("<a href='"&Filename&"?STitle="&STitle&"&Journal="&Journal&"&selectsearch="&selectsearch&"&AuthorSearch1="&AuthorSearch1&"&AuthorSearch2="&AuthorSearch2&"&AuthorSearch3="&AuthorSearch3&"&AuthorSearch4="&AuthorSearch4&"&AuthorSearch5="&AuthorSearch5&"&BoAuthor1="&BoAuthor1&"&BoAuthor2="&BoAuthor2&"&BoAuthor3="&BoAuthor3&"&BoAuthor4="&BoAuthor4&"&KeySearch1="&KeySearch1&"&KeySearch2="&KeySearch2&"&KeySearch3="&KeySearch3&"&KeySearch4="&KeySearch4&"&KeySearch5="&KeySearch5&"&BoKey1="&BoKey1&"&BoKey2="&BoKey2&"&BoKey3="&BoKey3&"&BoKey4="&BoKey4&"&PageNO="&PageNO+1&"'>ไปหน้าถัดไป</a>") end if
		
				
		'**End Action PageNO such as Previous  1|2|3|.. Next*****>	
	
	end if 'end if page >1
	
end Sub



</Script>