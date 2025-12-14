Attribute VB_Name = "Module"
Public ComboHeaderCode As ComboBox
Public ComboAuthorCode As ComboBox
Public Back1 As Boolean
Public Back2 As Boolean
Public Back3 As Boolean
Public Function Cuttag(strText As String)
Dim pos As Long
pos = InStr(strText, "<")
Do
strText = strText & Left(strText, pos - 1)
pos = InStr(strText, ">")
If pos = 0 Then Exit Do
strText = Mid(strText, pos + 1)
pos = InStr(strText, "<")
If pos = 0 Then Exit Do
Loop While True
End Function
