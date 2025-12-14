Attribute VB_Name = "Module1"
Public Sub Inter_Main()
  MsgBox "This is a Windows CGI program."
End Sub
 
Public Sub CGI_Main()
  Send ("Content-type: text/html")
  Send ("")
  Send ("<html>")
  Send ("<head>")
  Send (" <title>The Jrobot battle field!!!</title>")
  Send ("</head>")
  Send ("<body>")
  Send ("<h3>Jrobot battle Field</h3>")
  'Send ("<applet code=http://161.246.6.93/jrobot/demo/normi/Demo.class width=700 height=450>")
  'Send ("</applet>")
  Send ("</body>")
  Send ("</html>")
End Sub
