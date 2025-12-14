<html>
<Head><Title>Please specify year &amp; month</Title></Head>
<%header = "วารสารชื่อ "%>
<%Alpha=Request.Querystring("Journal")%>
<%
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.open  "Current"," "," "
%>
<BODY bgcolor="#FFFFFF">
<h2 align = center><%= header & Alpha%></h2>
<%counting(Alpha)%>

<Form Action="Book.asp" method="post">
  <table width="75%" border="0">
    <tr>
      <td>
        <p><font color="#000000"><b>Year :&nbsp;&nbsp;</b></font></p>
      </td>
      <td><font color="#000000">
        <select name="Year_Show" style="HEIGHT: 22px; WIDTH: 145px">
          <option selected> <%Comb_Year(Alpha)%> 
        </select>
        </font></td>
    </tr>
    <tr>
      <td><font color="#000000"><b>Month :&nbsp;</b> </font></td>
      <td><font color="#000000"> 
        <select name="Month_Show" style="HEIGHT: 22px; WIDTH: 145px">
          <option  selected> <%Comb_Month(Alpha)%> 
        </select>
        <font size=7>
        <input id=submit1 name=submit1 type=submit value=Submit>
        </font></font></td>
    </tr>
  </table>
  <p align="center"><font color="#000000"><font size=7> </font></font><font color="#000000"><font face=AngsanaUPC size=8> 
    </font><font color="#000000"><font face=AngsanaUPC size=8> 
    <input name= "jo_name" type="HIDDEN" value="<%=alpha%>">
    </font></font></font><font face=AngsanaUPC size=8> </font> </p>
  </Form>
<br>
<hr>
</BODY>
</HTML>

<script language="vbscript"  Runat = "Server">
Sub Comb_Year(Name)
	Csql = "Select Distinct(Year) from Journal Where J_name like '" & Name & "%'"
	set rs= conn.execute(Csql)
	rs.movefirst
	Do while Not Rs.Eof
		showyear = Rs("Year")
		response.write ("<Option value = " & showyear & ">" & showyear)
		rs.movenext
	loop
End Sub

Sub Comb_Month(Name)
	Csql = "Select Distinct(Month) from Journal Where J_name like '" & Name & "%'"
	set rs= conn.execute(Csql)
	rs.movefirst
	Do while Not Rs.Eof
		showmonth = Rs("Month")
		response.write ("<Option value = " & showmonth & ">" & showmonth)
		rs.movenext
	loop
	RS.close
	conn.close
End Sub

Sub Counting(txt)
	Jname = txt
	gdate = date
	gtime = time
	sql = "insert into countg (Journal_Name, day_from , timing)" 
	sql = sql & " values ('" & Jname & "', '" & gdate & "', '" & gtime & "')"
	set Recset = conn.Execute(sql)
End Sub	
</script>	
