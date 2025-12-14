VERSION 5.00
Object = "{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}#1.1#0"; "SHDOCVW.DLL"
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Begin VB.Form SearchList 
   BackColor       =   &H0000FF00&
   Caption         =   "SearchHeaderList"
   ClientHeight    =   4125
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   4125
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cmdclose 
      Caption         =   "เลิกการค้นหา"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   120
      TabIndex        =   12
      Top             =   6120
      Width           =   2415
   End
   Begin VB.CommandButton Command2 
      Caption         =   "เก็บข้อมูลลงในMARC sheet"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   11
      Top             =   7800
      Width           =   2415
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   240
      TabIndex        =   9
      Top             =   7200
      Width           =   2175
   End
   Begin VB.TextBox Headerlisttxt 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3015
      Left            =   2640
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   7
      Top             =   5280
      Width           =   9135
   End
   Begin VB.CommandButton Command1 
      Caption         =   "เพิ่มเลขหัวเรื่องเข้า List >>"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   120
      TabIndex        =   6
      Top             =   5400
      Width           =   2415
   End
   Begin VB.CommandButton CmdForward 
      Caption         =   "Forward"
      Height          =   375
      Left            =   8880
      TabIndex        =   5
      Top             =   240
      Width           =   855
   End
   Begin VB.CommandButton CmdBack 
      Caption         =   "Back"
      Height          =   375
      Left            =   7800
      TabIndex        =   4
      Top             =   240
      Width           =   855
   End
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   11160
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin VB.ComboBox Chooseweb 
      Height          =   330
      ItemData        =   "Searchweb.frx":0000
      Left            =   2400
      List            =   "Searchweb.frx":000D
      TabIndex        =   3
      Text            =   "http://alice.library.ohiou.edu/search/t"
      Top             =   240
      Width           =   4215
   End
   Begin VB.CommandButton CmdGo 
      Caption         =   "GO!"
      Height          =   375
      Left            =   6840
      TabIndex        =   1
      Top             =   240
      Width           =   735
   End
   Begin SHDocVwCtl.WebBrowser WebBrowser1 
      Height          =   3615
      Left            =   360
      TabIndex        =   0
      Top             =   960
      Width           =   11415
      ExtentX         =   20135
      ExtentY         =   6376
      ViewMode        =   0
      Offline         =   0
      Silent          =   0
      RegisterAsBrowser=   0
      RegisterAsDropTarget=   1
      AutoArrange     =   0   'False
      NoClientEdge    =   0   'False
      AlignLeft       =   0   'False
      ViewID          =   "{0057D0E0-3573-11CF-AE69-08002B2E1262}"
      Location        =   ""
   End
   Begin VB.Label Label3 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหัวเรื่องที่ต้องการ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   10
      Top             =   6720
      Width           =   2295
   End
   Begin VB.Label Label2 
      BackColor       =   &H0000FF00&
      Caption         =   "List  Header Code From Web Ohiou:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   360
      TabIndex        =   8
      Top             =   4680
      Width           =   5175
   End
   Begin VB.Label Label1 
      BackColor       =   &H0000FF00&
      Caption         =   "กรุณาเลือกWeb ที่ต้องการ"
      Height          =   375
      Left            =   360
      TabIndex        =   2
      Top             =   360
      Width           =   2055
   End
End
Attribute VB_Name = "SearchList"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim fwd As Integer
Dim bck As Integer
Dim Maxcheck As Integer
Dim MaxBol As Boolean
Dim objFSO As New FileSystemObject
Dim objtxt  As TextStream
Dim objFile As File
Dim strBuffer As String
Dim strBuffer1 As String
Dim strList As String
Dim Checkweb As String
Dim strbuff As String
Private Sub CmdBack_Click()
bck = bck + 1
fwd = fwd - 2
MaxBol = False
WebBrowser1.GoBack
End Sub

Private Sub cmdclose_Click()
Unload SearchList
End Sub
Private Sub CmdForward_Click()
WebBrowser1.GoForward
End Sub
Private Sub CmdGo_Click()
Dim Strwebpage As String
Strwebpage = Chooseweb.Text
WebBrowser1.Navigate Strwebpage
End Sub
Private Sub Command1_Click()
Dim strAddlist As String
Dim strTemp As String
Dim strText As String
Dim strURL As String
Dim strCall As String
Dim strAuthor As String
Dim strCoauthor As String
Dim strTitle As String
Dim strEdition As String
Dim strImprint As String
Dim strSubject As String
Dim pos As Long
Dim pos1 As Long

If Chooseweb.ListIndex = -1 Then
' Create Text file for write source code from Web
objFSO.CreateTextFile ("test.txt")
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForWriting)
strBuffer1 = WebBrowser1.LocationURL
strBuffer = Inet1.OpenURL(strBuffer1)
objtxt.Write strBuffer
objtxt.Close

'OpenText file for read
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForReading)
strTemp = ""
Do Until objtxt.AtEndOfStream
strTemp = strTemp & objtxt.ReadLine & " "
Loop
'Call Function at module which is cut "<Data > "from source code"
Call Cuttag(strTemp)
objtxt.Close

'Cut for Call #
pos = InStr(strTemp, "Call #")
pos1 = InStr(strTemp, "Author")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Corp auth")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Title")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "Edition")
            If pos1 = 0 Then
                pos1 = InStr(strTemp, "Imprint")
                If pos1 = 0 Then
                pos1 = InStr(strTemp, "LOCATION")
                End If
            End If
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strCall = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
'Cut for Author
pos = InStr(strTemp, "Author")
pos1 = InStr(strTemp, "Corp auth")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Title")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "Imprint")
            If pos1 = 0 Then
                pos1 = InStr(strTemp, "LOCATION")
            End If
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strAuthor = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
' cut for Coauthor
pos = InStr(strTemp, "Corp auth")
pos1 = InStr(strTemp, "Title")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "LOCATION")
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strCoauthor = Mid(strTemp, pos + 9, pos1 - pos - 9)
End If
'Cut  for Title
pos = InStr(strTemp, "Title")
pos1 = InStr(strTemp, "Edition")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strTitle = Mid(strTemp, pos + 5, pos1 - pos - 5)
End If
'Cut  for Edition
pos = InStr(strTemp, "Edition")
pos1 = InStr(strTemp, "Imprint")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strEdition = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Imprint
pos = InStr(strTemp, "Imprint")
pos1 = InStr(strTemp, "LOCATION")
If (pos <> 0) And (pos1 <> 0) Then
strImprint = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Subject
pos = InStr(strTemp, "Subject")
pos1 = InStr(strTemp, "Alt author")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "OCLC #")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strSubject = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
End If

'******************chula***************
If Chooseweb.ListIndex = 0 Then
' Create Text file for write source code from Web
objFSO.CreateTextFile ("test.txt")
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForWriting)
strBuffer1 = WebBrowser1.LocationURL
strBuffer = Inet1.OpenURL(strBuffer1)
objtxt.Write strBuffer
objtxt.Close

'OpenText file for read
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForReading)
strTemp = ""
Do Until objtxt.AtEndOfStream
strTemp = strTemp & objtxt.ReadLine & " "
Loop
objtxt.Close
pos = InStr(strTemp, "<frame src=")
pos1 = InStr(strTemp, "</frame>")
strText = Mid(strTemp, pos + 11, pos1 + 1000)
pos = InStr(strText, "<frame src=")
pos1 = InStr(strText, "name=")
strTemp = Mid(strText, pos + 11, pos1 + 1000)
pos = InStr(strTemp, "<frame src=")
pos1 = InStr(strTemp, "</frame>")
strText = Mid(strTemp, pos + 11, pos1 - 5)
strTemp = "http://library.car.chula.ac.th"
strURL = strTemp & strText
'****************************************
' Create Text file for write source code from Web
objFSO.CreateTextFile ("test.txt")
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForWriting)
strBuffer = Inet1.OpenURL(strURL)
objtxt.Write strBuffer
objtxt.Close

'OpenText file for read
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForReading)
strTemp = ""
Do Until objtxt.AtEndOfStream
strTemp = strTemp & objtxt.ReadLine & " "
Loop
'Call Function at module which is cut "<Data > "from source code"
Call Cuttag(strTemp)
objtxt.Close
'Cut for Call #
pos = InStr(strTemp, "&nbsp;")
pos1 = InStr(strTemp, "&nbsp;&nbsp;")
If (pos <> 0) And (pos1 <> 0) Then
strText = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
pos = InStr(strText, "&nbsp;")
strbuff = Mid(strText, pos + 6)
pos = InStr(strbuff, "&nbsp;")
strCall = Mid(strbuff, pos + 1)

'Cut for Author
pos = InStr(strTemp, "Author")
pos1 = InStr(strTemp, "Corp auth")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Title")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "Edition")
            If pos1 = 0 Then
                pos1 = InStr(strTemp, "LOCATION")
            End If
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strAuthor = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
' cut for Coauthor
pos = InStr(strTemp, "Corp auth")
pos1 = InStr(strTemp, "Title")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "LOCATION")
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strCoauthor = Mid(strTemp, pos + 9, pos1 - pos - 9)
End If
'Cut  for Title
pos = InStr(strTemp, "Title")
pos1 = InStr(strTemp, "Imprint")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strTitle = Mid(strTemp, pos + 5, pos1 - pos - 5)
End If
'Cut  for Imprint
pos = InStr(strTemp, "Imprint")
pos1 = InStr(strTemp, "Edition")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strImprint = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Edition
pos = InStr(strTemp, "Edition")
pos1 = InStr(strTemp, "LOCATION")
If (pos <> 0) And (pos1 <> 0) Then
strEdition = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Subject
pos = InStr(strTemp, "Subject")
pos1 = InStr(strTemp, "Alt author")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "OCLC #")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strSubject = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
End If
'*****************KU**************
If Chooseweb.ListIndex = 1 Then
' Create Text file for write source code from Web
objFSO.CreateTextFile ("test.txt")
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForWriting)
strBuffer1 = WebBrowser1.LocationURL
strBuffer = Inet1.OpenURL(strBuffer1)
objtxt.Write strBuffer
objtxt.Close

'OpenText file for read
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForReading)
strTemp = ""
Do Until objtxt.AtEndOfStream
strTemp = strTemp & objtxt.ReadLine & " "
Loop
objtxt.Close
pos = InStr(strTemp, "<frame src=")
pos1 = InStr(strTemp, "</frame>")
strText = Mid(strTemp, pos + 11, pos1 + 1000)
pos = InStr(strText, "<frame src=")
pos1 = InStr(strText, "name=")
strTemp = Mid(strText, pos + 11, pos1 + 1000)
pos = InStr(strTemp, "<frame src=")
pos1 = InStr(strTemp, "</frame>")
strText = Mid(strTemp, pos + 11, pos1 - 5)
strTemp = "http://intanin.lib.ku.ac.th"
strURL = strTemp & strText
'******************
' Create Text file for write source code from Web
objFSO.CreateTextFile ("test.txt")
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForWriting)
strBuffer = Inet1.OpenURL(strURL)
objtxt.Write strBuffer
objtxt.Close

'OpenText file for read
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForReading)
strTemp = ""
Do Until objtxt.AtEndOfStream
strTemp = strTemp & objtxt.ReadLine & " "
Loop
'Call Function at module which is cut "<Data > "from source code"
Call Cuttag(strTemp)
objtxt.Close

'Cut for Call #
pos = InStr(strTemp, "&nbsp;")
pos1 = InStr(strTemp, "&nbsp;&nbsp;")
If (pos <> 0) And (pos1 <> 0) Then
strText = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
pos = InStr(strText, "&nbsp")
strbuff = Mid(strText, pos + 6)
pos = InStr(strbuff, "&nbsp;")
strCall = Mid(strbuff, pos + 1)

'Cut for Author
pos = InStr(strTemp, "Author")
pos1 = InStr(strTemp, "Corp auth")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Title")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "Edition")
            If pos1 = 0 Then
                pos1 = InStr(strTemp, "LOCATION")
            End If
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strAuthor = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
' cut for Coauthor
pos = InStr(strTemp, "Corp auth")
pos1 = InStr(strTemp, "Title")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "LOCATION")
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strCoauthor = Mid(strTemp, pos + 9, pos1 - pos - 9)
End If
'Cut  for Title
pos = InStr(strTemp, "Title")
pos1 = InStr(strTemp, "Imprint")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strTitle = Mid(strTemp, pos + 5, pos1 - pos - 5)
End If
'Cut  for Imprint
pos = InStr(strTemp, "Imprint")
pos1 = InStr(strTemp, "Edition")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strImprint = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Edition
pos = InStr(strTemp, "Edition")
pos1 = InStr(strTemp, "LOCATION")
If (pos <> 0) And (pos1 <> 0) Then
strEdition = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Subject
pos = InStr(strTemp, "Subject")
pos1 = InStr(strTemp, "Alt author")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "OCLC #")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strSubject = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
End If
'********************Ohio***************
If Chooseweb.ListIndex = 2 Then
' Create Text file for write source code from Web
objFSO.CreateTextFile ("test.txt")
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForWriting)
strBuffer1 = WebBrowser1.LocationURL
strBuffer = Inet1.OpenURL(strBuffer1)
objtxt.Write strBuffer
objtxt.Close

'OpenText file for read
Set objFile = objFSO.GetFile("test.txt")
Set objtxt = objFile.OpenAsTextStream(ForReading)
strTemp = ""
Do Until objtxt.AtEndOfStream
strTemp = strTemp & objtxt.ReadLine & " "
Loop
'Call Function at module which is cut "<Data > "from source code"
Call Cuttag(strTemp)
objtxt.Close

'Cut for Call #
pos = InStr(strTemp, "Call #")
pos1 = InStr(strTemp, "Author")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Corp auth")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Title")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "Edition")
            If pos1 = 0 Then
                pos1 = InStr(strTemp, "Imprint")
                If pos1 = 0 Then
                pos1 = InStr(strTemp, "LOCATION")
                End If
            End If
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strCall = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
'Cut for Author
pos = InStr(strTemp, "Author")
pos1 = InStr(strTemp, "Corp auth")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Title")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "Imprint")
            If pos1 = 0 Then
                pos1 = InStr(strTemp, "LOCATION")
            End If
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strAuthor = Mid(strTemp, pos + 6, pos1 - pos - 6)
End If
' cut for Coauthor
pos = InStr(strTemp, "Corp auth")
pos1 = InStr(strTemp, "Title")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Edition")
    If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
        If pos1 = 0 Then
            pos1 = InStr(strTemp, "LOCATION")
        End If
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strCoauthor = Mid(strTemp, pos + 9, pos1 - pos - 9)
End If
'Cut  for Title
pos = InStr(strTemp, "Title")
pos1 = InStr(strTemp, "Edition")
If pos1 = 0 Then
    pos1 = InStr(strTemp, "Imprint")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
End If
If (pos <> 0) And (pos1 <> 0) Then
strTitle = Mid(strTemp, pos + 5, pos1 - pos - 5)
End If
'Cut  for Edition
pos = InStr(strTemp, "Edition")
pos1 = InStr(strTemp, "Imprint")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "LOCATION")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strEdition = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Imprint
pos = InStr(strTemp, "Imprint")
pos1 = InStr(strTemp, "LOCATION")
If (pos <> 0) And (pos1 <> 0) Then
strImprint = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
'Cut for Subject
pos = InStr(strTemp, "Subject")
pos1 = InStr(strTemp, "Alt author")
    If pos1 = 0 Then
        pos1 = InStr(strTemp, "OCLC #")
    End If
If (pos <> 0) And (pos1 <> 0) Then
strSubject = Mid(strTemp, pos + 7, pos1 - pos - 7)
End If
End If

'Show out put
Headerlisttxt.ForeColor = QBColor(1)
strAddlist = "Header code:" & strCall & vbCrLf & "Author: " & strAuthor & vbCrLf & "Corp Author: " & strCoauthor & vbCrLf & "Title: " & strTitle & vbCrLf & "Edition: " & strEdition & vbCrLf & "Imprint: " & strImprint & vbCrLf & "Subject: " & strSubject & vbCrLf
strList = strList & strAddlist & vbCrLf
Headerlisttxt.Text = strList
End Sub
Private Sub Form_Load()
strList = ""
Call CmdGo_Click
MaxBol = True
bck = 0
fwd = 1
Maxcheck = 1
CmdBack.Enabled = False
CmdForward.Enabled = False
End Sub

Private Sub URLtxt_Change()

End Sub
Private Sub WebBrowser1_BeforeNavigate2(ByVal pDisp As Object, URL As Variant, Flags As Variant, TargetFrameName As Variant, PostData As Variant, Headers As Variant, Cancel As Boolean)
fwd = fwd + 1
If fwd <> 1 Then
CmdBack.Enabled = True
Else
CmdBack.Enabled = False
End If

If fwd < Maxcheck - 1 Then
CmdForward.Enabled = True
Else
CmdForward.Enabled = False
MaxBol = True
bck = 0
End If
If CmdForward.Enabled = False And MaxBol = True Then
Maxcheck = Maxcheck + 1
End If
If bck = 1 Then
Maxcheck = Maxcheck - 1
End If
End Sub

