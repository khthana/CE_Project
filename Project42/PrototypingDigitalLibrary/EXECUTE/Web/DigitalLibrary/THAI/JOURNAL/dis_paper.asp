Papers in Journal

<table border=1 width="88%" >
  <tr> 
    <td bgcolor="#ffffff"> 
      <div align="center">Thai title </div>
    </td>
    <td bgcolor="#fffff0"> 
      <div align="center">description</div>
    </td>
  </tr>
  <%Do while not rs.EOF%> 
  <tr> 
    <td bgcolor="#ffffff"><%=rs("ThaiTitle")%> 
      <div align="center"></div>
    </td>
    <td bgcolor="#fffff0"> 
      <div align="center">TypePaper: <%=rs("TypePaper")%>       ,Author :<%
      for I = 1 to 5
			
		if rs("Author"&I)<>"" then %>
		
		<%=rs("Author"&I)%>       ,
				
	  <% end if
      next
      %>
      
             StartPage :<%=rs("StartPage")%>              , FinalPage :<%=rs("FinalPage")%></div>
    </td>
  </tr>
  <%rs.MoveNext
	loop %>

</table>