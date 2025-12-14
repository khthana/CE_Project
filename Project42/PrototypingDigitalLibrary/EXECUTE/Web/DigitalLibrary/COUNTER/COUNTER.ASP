<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
count :
<%gcount=Counter()%>
<%=gcount%>
<P>&nbsp;</P>

</BODY>
</HTML>
<Script Language = "VBscript" RunAT="Server">
Function Counter()
	ForReading=1 
	set fs = Createobject("Scripting.FileSystemObject")
	textfile =server.MapPath ("\dl\counter\pagecount.txt")
	set a = fs.opentextfile(textfile,ForReading,0)
	
	if a.AtEndofStream then
		count = 0
	else
		count = a.readline()
	end if
	count =count+1
	Set a = fs.CreateTextFile(textfile)
	a.writeline(count)
	a.close
	Counter=count
end function

		
</Script>