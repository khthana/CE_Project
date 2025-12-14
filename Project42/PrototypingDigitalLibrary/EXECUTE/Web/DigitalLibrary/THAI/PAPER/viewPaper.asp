<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
<% ' get input form DetilJou (detail Journal)

STitle		=Request.QueryString ("STitle")
Journal		=Request.QueryString ("Journal")
Stype		=Request.QueryString ("SType")
AuthorA		=Request.QueryString ("AuthorA")
AuthorB		=Request.QueryString ("AuthorB")
BoAuthor	=Request.QueryString ("BoAuthor")
KeywordA	=Request.QueryString ("KeywordA")
KeywordB	=Request.QueryString ("KeywordB")
BoKey		=Request.QueryString ("BoKey")
%>
<! view get input >
title : <%=STitle%> <BR>
Journal : <%=Journal%> <BR>
Stype   :<%=Stype%> <br>
AuthorA :<%=AuthorA%> <br>
AuthorB :<%=AuthorB%> <br>
BoAuthor:<%=BoAuthor%> <br>
KeywordA:<%=KeywordA%> <br>
KeywordB:<%=KeywordB%> <br>
BoKey   :<%=BoKey%> <br>
<P>&nbsp;</P>

</BODY>
</HTML>
