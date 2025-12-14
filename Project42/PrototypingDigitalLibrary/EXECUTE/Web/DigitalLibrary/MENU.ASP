<html>
<head>
<title>menu</title>
<meta http-equiv="Content-Type" content="text/html; charset=Windows-874">
<script language="JavaScript">
<!--
function MM_displayStatusMsg(msgStr) { //v1.0
  status=msgStr;
  document.MM_returnValue = true;
}
//-->
</script>
</head>

<body bgcolor="#FFFFFF" background="pic/powerpoint.jpg" leftmargin="60">
<div align="center"> 
  <p align="right"><img src="pic/kmit4.gif" width="50" height="68" border="0"> 
    <a href="abstract.html" target="main"><img src="pic/ejournal.jpg" width="141" height="58" border="0" alt="Electronic Journal"></a></p>
  <p align="right"><a href="thai/journal/name_jou_T.asp" target="main" onMouseOver="MM_displayStatusMsg('ดูรายการชื่อวารสารของสถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง');return document.MM_returnValue" onMouseOut="MM_displayStatusMsg('วารสารอิเลคทรอนิกส์ ( Electronic Journal )');return document.MM_returnValue"><img src="pic/View.gif" width="138" height="56" border="0" alt="ดูรายการ" name="ดูรายการ"></a><a href="thai/select_search.html" target="main" onMouseOver="MM_displayStatusMsg('สืบค้นวารสารและบทความ');return document.MM_returnValue" onMouseOut="MM_displayStatusMsg('วารสารอิเลคทรอนิกส์ ( Electronic Journal )');return document.MM_returnValue"><img src="pic/Search.gif" width="138" height="56" border="0" alt="สืบค้น"></a><a href="thai/reserve/detailres.asp" target="main" onMouseOver="MM_displayStatusMsg('บริการ Email ถึงคุณ เมือ่มีวารสารให้เข้ามาในฐานข้อมูล ');return document.MM_returnValue" onMouseOut="MM_displayStatusMsg('วารสารอิเลคทรอนิกส์ ( Electronic Journal )');return document.MM_returnValue"><img src="pic/hold.gif" width="138" height="56" border="0" alt="แจ้งวารสารใหม่"></a></p>
  <p align="right">visitor:<I><B><font color="#FF3333"><%gcount=Counter()%> <%=gcount%> 
    </font></B></I> 
</div>
</body>
</html>

<Script Language = "VBscript" RunAT="Server">
Function Counter()
	ForReading=1 
	set fs = Createobject("Scripting.FileSystemObject")
	textfile =server.MapPath ("\digitallibrary\counter\pagecount.txt")
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