<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>

<P>&nbsp;</P>
hello Simple mail
<%

set o = Server.CreateObject("ADISCON.SimpleMail.1") ' create mailer!

o.MailServer = "161.246.4.3"
o.Sender = "nattawath_u@hotmail.com"
o.Recipient = "t0013250@diamond.ce.kmitl.ac.th"
o.Subject = "My first SimpleMail mail tttt"
o.MessageText = "ha ha zzz" + Chr(13) + Chr(10) + "Line 2 gogog2"
' of course, this could also be somethig like this:</FONT></FONT>

' o.MessageText = Request("strMessage")

call o.Send


o.Recipient = "s0013250@kmitl.ac.th"
call o.Send

set o = Nothing
%>


</BODY>
</HTML>
