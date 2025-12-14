VERSION 5.00
Begin VB.Form SearchHeader_DB 
   BackColor       =   &H0000FF00&
   Caption         =   "SearchHeaderDB"
   ClientHeight    =   4140
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5280
   LinkTopic       =   "Form1"
   ScaleHeight     =   4140
   ScaleWidth      =   5280
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.CommandButton cmdcloseHDB 
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
      Height          =   375
      Left            =   3720
      TabIndex        =   5
      Top             =   1680
      Width           =   1215
   End
   Begin VB.TextBox Searchhit 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   3975
      Left            =   1920
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   4
      Top             =   3000
      Width           =   9855
   End
   Begin VB.CommandButton CmdSearch 
      Caption         =   "ค้นหา"
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
      Left            =   1920
      TabIndex        =   3
      Top             =   1680
      Width           =   1335
   End
   Begin VB.TextBox TxtSearch 
      Height          =   375
      Left            =   1920
      TabIndex        =   1
      Top             =   720
      Width           =   3015
   End
   Begin VB.Label Label1 
      BackColor       =   &H0000FF00&
      Caption         =   "หัวเรื่องที่ต้องการค้น:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Width           =   1695
   End
   Begin VB.Label Show 
      BackColor       =   &H0000FF00&
      Caption         =   "หัวเรื่องที่ค้นหาพบ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   3120
      Width           =   1455
   End
End
Attribute VB_Name = "SearchHeader_DB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public OrderWs     As Workspace
Public OrderDb     As Database
Public Opendyna  As Recordset
Public sqlcommand  As String
Public Searchtext  As String
Public Searchfind As String
Public Numcount As Integer
Private Sub cmdcloseHDB_Click()
Unload SearchHeader_DB
End Sub
Private Sub cmdSearch_Click()
Dim Searchtext As String
Dim Searchfind As String
Searchtext = TxtSearch.Text
 If Searchtext <> "" Then
sqlcommand = " SELECT * FROM tblMain "
sqlcommand = sqlcommand & "WHERE Header LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Searchfind = ""
Do Until Opendyna.EOF
Numcount = 1
Searchfind = Searchfind & "หัวเรื่อง=" & Opendyna.Fields("Header")
If Opendyna.Fields("TranEng") <> "" Then
Searchfind = Searchfind & vbCrLf & "คำแปลภาษาอังกฤษ=" & Opendyna.Fields("TranEng") & "     "
End If
If Opendyna.Fields("Descript") <> "" Then
Searchfind = Searchfind & "รายละเอียด=" & Opendyna.Fields("Descript")
End If
If Opendyna.Fields("DEWEY_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_5")
End If
Numcount = 1
If Opendyna.Fields("LC_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_5")
End If
If Opendyna.Fields("SeeAdd") <> "" Then
Searchfind = Searchfind & vbCrLf & "ดูเพิ่มเติม=" & Opendyna.Fields("SeeAdd") & "     "
End If
Searchfind = Searchfind & vbCrLf & vbCrLf
Opendyna.MoveNext
Loop
sqlcommand = " SELECT * FROM tblSub1 "
sqlcommand = sqlcommand & "WHERE Subheader_1 LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
Numcount = 1
Searchfind = Searchfind & "หัวเรื่อง=" & Opendyna.Fields("Subheader_1")
If Opendyna.Fields("TranEng") <> "" Then
Searchfind = Searchfind & vbCrLf & "คำแปลภาษาอังกฤษ=" & Opendyna.Fields("TranEng") & "     "
End If
If Opendyna.Fields("Descript") <> "" Then
Searchfind = Searchfind & "รายละเอียด=" & Opendyna.Fields("Descript")
End If
If Opendyna.Fields("DEWEY_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_5")
End If
Numcount = 1
If Opendyna.Fields("LC_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_5")
End If
If Opendyna.Fields("SeeAdd") <> "" Then
Searchfind = Searchfind & vbCrLf & "ดูเพิ่มเติม=" & Opendyna.Fields("SeeAdd") & "     "
End If
Searchfind = Searchfind & vbCrLf & vbCrLf
Opendyna.MoveNext
Loop
sqlcommand = " SELECT * FROM tblSub2 "
sqlcommand = sqlcommand & "WHERE Subheader_2 LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
Numcount = 1
Searchfind = Searchfind & "หัวเรื่อง=" & Opendyna.Fields("Subheader_2")
If Opendyna.Fields("TranEng") <> "" Then
Searchfind = Searchfind & vbCrLf & "คำแปลภาษาอังกฤษ=" & Opendyna.Fields("TranEng") & "     "
End If
If Opendyna.Fields("Descript") <> "" Then
Searchfind = Searchfind & "รายละเอียด=" & Opendyna.Fields("Descript")
End If
If Opendyna.Fields("DEWEY_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_5")
End If
Numcount = 1
If Opendyna.Fields("LC_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_5")
End If
If Opendyna.Fields("SeeAdd") <> "" Then
Searchfind = Searchfind & vbCrLf & "ดูเพิ่มเติม=" & Opendyna.Fields("SeeAdd") & "     "
End If
Searchfind = Searchfind & vbCrLf & vbCrLf
Opendyna.MoveNext
Loop
sqlcommand = " SELECT * FROM tblSub3 "
sqlcommand = sqlcommand & "WHERE Subheader_3 LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
Numcount = 1
Searchfind = Searchfind & "หัวเรื่อง=" & Opendyna.Fields("Subheader_3")
If Opendyna.Fields("TranEng") <> "" Then
Searchfind = Searchfind & vbCrLf & "คำแปลภาษาอังกฤษ=" & Opendyna.Fields("TranEng") & "     "
End If
If Opendyna.Fields("Descript") <> "" Then
Searchfind = Searchfind & "รายละเอียด=" & Opendyna.Fields("Descript")
End If
If Opendyna.Fields("DEWEY_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่DEWEY" & Numcount & "=" & Opendyna.Fields("DEWEY_5")
End If
Numcount = 1
If Opendyna.Fields("LC_1") <> "" Then
Searchfind = Searchfind & vbCrLf & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_1") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_2") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_2") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_3") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_3") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_4") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_4") & "     "
Numcount = Numcount + 1
End If
If Opendyna.Fields("LC_5") <> "" Then
Searchfind = Searchfind & "เลขหมู่LC" & Numcount & "=" & Opendyna.Fields("LC_5")
End If
If Opendyna.Fields("SeeAdd") <> "" Then
Searchfind = Searchfind & vbCrLf & "ดูเพิ่มเติม=" & Opendyna.Fields("SeeAdd") & "     "
End If
Searchfind = Searchfind & vbCrLf & vbCrLf
Opendyna.MoveNext
Loop

Searchhit.Text = Searchfind
TxtSearch.Text = ""
TxtSearch.SetFocus
 If Searchhit.Text = "" Then
   MsgBox "ไม่พบข้อมูลที่ต้องการ"
End If
Else
MsgBox ("กรุณาใส่หัวเรื่องที่ต้องการค้นหา")
TxtSearch.SetFocus
End If
End Sub
Private Sub Form_Load()
Set OrderWs = DBEngine.Workspaces(0)
 Set OrderDb = OrderWs.OpenDatabase("HeaderDB.mdb", False, False)
End Sub
Private Sub TxtSearch_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn Then
Call cmdSearch_Click
End If
End Sub
