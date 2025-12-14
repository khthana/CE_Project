<P>ISSN :<%=rs("Issn")%></P>
<table width="88%" border="1" style="BORDER-BOTTOM-COLOR: black">
  <tr> 
    <td width="21%" height="36"> 
      <div align="center">Journal</div>
    </td>
    <td width="79%" height="36"> 
      <div align="center">Description</div>
    </td>
  </tr>
  <tr> 
    <td width="21%"> 
      <div align="center"><%=rs("ThaiJournal")%></div>
    </td>
    <td width="79%"> 
      <div align="center">Editor :<%=rs("Editor")%>,Vol: <%=rs("Volume")%>,Number :<%=rs("Number")%>,Month: 
        <%=rs("Month")%>,Year: <%=rs("Year")%>   ,Periodictity : <%=rs("Periodictity")%></div>
    </td>
  </tr>
</table>

<hr>
