<html> 
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"> 
<title>ASP Sample Mailer</title> 
</head> 
<body> 
<% set o = Server.CreateObject("ADISCON.SimpleMail.1") ' create mailer! 
o.MailServer = "161.246.10.21" 
o.Sender = "Nattawath_u@hotmail.com" 
o.Recipient = "t0013250@diamond.ce.kmitl.ac.th" 
o.Subject = "·´ÅÍ§Êè§¨´ËÁÒÂÍÔàÅç¡·ÃÍ¹Ô¡Êì" 
o.MessageText = "¢éÍ¤ÇÒÁºÃÃ·Ñ´·Õè1" + Chr(13) + Chr(10) + "¢éÍ¤ÇÒÁºÃÃ·Ñ´·Õè 2" 
call o.Send 
set o = Nothing %>
 </body> 
</html> 
