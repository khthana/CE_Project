<HTML><head>
  <Title>Statistic</title>
</head>
<body bgcolor="#FFFFFF">
<%password = request.Form("passwd")%> <%if password = "" then %> 
<p align="center"> <b>please back and give the password again </b><a href ="password.html"><b>Back</b></a> 
  <%elseif password = "lbmTbri" then%><a href="date.asp"><img src="Shelf.gif" width="776" height="200" border="0"></a><a href="admin_web.html"><img src="Web.gif" width="519" height="131" align="middle" border="0"></a> 
</p>
<p>  <%else%> </p>
<hr>
<b><font face="Times New Roman, Times, serif" size="4">Not Correct!!!</font></b> 
<%end if%> 
</BODY>
</HTML>
