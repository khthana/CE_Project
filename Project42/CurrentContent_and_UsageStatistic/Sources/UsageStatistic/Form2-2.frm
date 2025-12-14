VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form form2 
   Caption         =   "Form2"
   ClientHeight    =   6930
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7095
   LinkTopic       =   "Form2"
   ScaleHeight     =   462
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   473
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "Form2-2.frx":0000
      Height          =   4275
      Left            =   840
      OleObjectBlob   =   "Form2-2.frx":0019
      TabIndex        =   25
      Top             =   3840
      Width           =   11295
   End
   Begin VB.TextBox Text7 
      Height          =   495
      Left            =   360
      TabIndex        =   32
      Top             =   480
      Width           =   735
   End
   Begin VB.TextBox Text6 
      Height          =   375
      Left            =   2040
      TabIndex        =   30
      Top             =   2520
      Width           =   2895
   End
   Begin VB.TextBox Text11 
      Height          =   375
      Left            =   10200
      TabIndex        =   26
      Top             =   3120
      Width           =   1575
   End
   Begin VB.Data Datadetail 
      Caption         =   " "
      Connect         =   "Access"
      DatabaseName    =   "D:\Project_duck\Project\order1.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   405
      Left            =   4200
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   840
      Visible         =   0   'False
      Width           =   1140
   End
   Begin VB.TextBox Text10 
      Height          =   360
      Left            =   2040
      TabIndex        =   24
      Top             =   2160
      Width           =   5175
   End
   Begin VB.TextBox Text9 
      Height          =   375
      Left            =   10200
      TabIndex        =   22
      Top             =   2400
      Width           =   1575
   End
   Begin VB.TextBox Text5 
      Height          =   360
      Left            =   2040
      TabIndex        =   20
      Top             =   1800
      Width           =   2415
   End
   Begin VB.TextBox Text4 
      Height          =   375
      Left            =   2040
      TabIndex        =   18
      Top             =   3240
      Width           =   2175
   End
   Begin VB.TextBox Text3 
      Height          =   375
      Left            =   2040
      TabIndex        =   16
      Top             =   2880
      Width           =   2175
   End
   Begin VB.TextBox Text2 
      Height          =   495
      Left            =   2040
      TabIndex        =   14
      Top             =   1320
      Width           =   8055
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   2040
      TabIndex        =   12
      Top             =   960
      Width           =   1695
   End
   Begin VB.CommandButton Command11 
      Caption         =   "ออกจากรายละเอียดวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   10200
      TabIndex        =   10
      Top             =   120
      Width           =   1455
   End
   Begin VB.CommandButton Command10 
      Caption         =   ">>"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   9000
      TabIndex        =   9
      Top             =   120
      Width           =   975
   End
   Begin VB.CommandButton Command9 
      Caption         =   ">"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   8160
      TabIndex        =   8
      Top             =   120
      Width           =   855
   End
   Begin VB.CommandButton Command8 
      Caption         =   "<"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   7320
      TabIndex        =   7
      Top             =   120
      Width           =   855
   End
   Begin VB.CommandButton Command7 
      Caption         =   "<<"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   6480
      TabIndex        =   6
      Top             =   120
      Width           =   855
   End
   Begin VB.CommandButton Command6 
      Caption         =   "ยกเลิก"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   5400
      TabIndex        =   5
      Top             =   120
      Width           =   855
   End
   Begin VB.CommandButton Command5 
      Caption         =   "บันทึก"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   4440
      TabIndex        =   4
      Top             =   120
      Width           =   975
   End
   Begin VB.CommandButton Command4 
      Caption         =   "ค้นหา"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   10320
      TabIndex        =   3
      Top             =   1080
      Width           =   1095
   End
   Begin VB.CommandButton Command3 
      Caption         =   "ลบ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   3360
      TabIndex        =   2
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton Command2 
      Caption         =   "แก้ไข"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   2520
      TabIndex        =   1
      Top             =   120
      Width           =   855
   End
   Begin VB.CommandButton Command1 
      Caption         =   "เพิ่ม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   1680
      TabIndex        =   0
      Top             =   120
      Width           =   855
   End
   Begin VB.Label Label7 
      Caption         =   "ข้อมูลล่าสุด"
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
      Left            =   240
      TabIndex        =   33
      Top             =   120
      Width           =   1335
   End
   Begin VB.Label Label6 
      Caption         =   "กำหนดออก"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   31
      Top             =   2520
      Width           =   1335
   End
   Begin VB.Label Label12 
      Caption         =   "วัน/เดือน/ปี"
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
      Left            =   10440
      TabIndex        =   29
      Top             =   2880
      Width           =   1215
   End
   Begin VB.Label Label11 
      Caption         =   "วัน/เดือน/ปี"
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
      Left            =   10440
      TabIndex        =   28
      Top             =   2160
      Width           =   1215
   End
   Begin VB.Label Label13 
      Caption         =   "วันที่สิ้นสุดการให้บริการ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   7320
      TabIndex        =   27
      Top             =   3120
      Width           =   2895
   End
   Begin VB.Label Label10 
      Caption         =   "สำนักพิมพ์"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   23
      Top             =   2160
      Width           =   1575
   End
   Begin VB.Label Label9 
      Caption         =   "วันที่เริ่มให้บริการ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   7800
      TabIndex        =   21
      Top             =   2400
      Width           =   2535
   End
   Begin VB.Label Label5 
      Caption         =   "หมายเลข ISSN"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   19
      Top             =   1800
      Width           =   2055
   End
   Begin VB.Label Label4 
      Caption         =   "ปีที่พิมพ์"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   17
      Top             =   2880
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "ฉบับที่"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   15
      Top             =   3240
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "ชื่อวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   13
      Top             =   1440
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "ID#"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   11
      Top             =   1080
      Width           =   495
   End
End
Attribute VB_Name = "form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public ORDERWS As Workspace
Public ORDERDB As Database
Public DetailDYN As Recordset
Dim flag As Boolean
Dim flagedit As Boolean
Private Sub Command1_Click()
On Error GoTo error1
Dim detailsnap As Recordset
Set detailsnap = ORDERDB.OpenRecordset("select max(int(detail2.[id#])) as maxid from detail2 ", dbOpenSnapshot)
Text7.Text = detailsnap.Fields("maxid")
detailsnap.Close
Call enableoperationbutton(False)
Call ENABLESAVECANCELBOTTON(True)
Call cleardata
Text1.SetFocus
DetailDYN.AddNew
error1:
End Sub

Private Sub cleardata()
On Error GoTo error1
Text1.Text = ""
Text2.Text = ""
Text3.Text = ""
Text4.Text = ""
Text6.Text = ""
Text10.Text = ""
Text5.Text = ""
Text9.Text = ""
Text11.Text = ""
error1:
End Sub
Private Sub enableoperationbutton(enableflag As Boolean)
On Error GoTo error1
    Command1.Enabled = enableflag
    Command2.Enabled = enableflag
    Command3.Enabled = enableflag
    Command4.Enabled = enableflag
error1:
End Sub

Private Sub Command10_Click()
On Error GoTo error1
If DetailDYN.RecordCount > 0 Then
DetailDYN.MoveLast
Call DISPLAYFIELDS
Command7.Enabled = True
Command8.Enabled = True
Command9.Enabled = False
Command10.Enabled = False
End If
error1:
End Sub

Private Sub Command11_Click()
On Error GoTo error1
DetailDYN.Close
ORDERDB.Close
Unload Me
Form1.Show
error1:
End Sub

Private Sub Command2_Click()
On Error GoTo error1
If DetailDYN.RecordCount > 0 Then
If Not DetailDYN.EOF And Not DetailDYN.BOF Then
Call enableoperationbutton(False)
Call ENABLESAVECANCELBOTTON(True)
Text1.SetFocus
DetailDYN.Edit
End If
End If
error1:
End Sub

Private Sub Command3_Click()
On Error GoTo error1
If DetailDYN.RecordCount > 0 Then
If Not (DetailDYN.EOF) And Not (DetailDYN.BOF) Then
    If MsgBox("คุณจะลบข้อมูล , คุณแน่ใจแล้วหรือยัง?", [vbYesNo]) = vbYes Then
    DetailDYN.Delete
    Call Command7_Click
    End If
End If
 End If
error1:
End Sub

Private Sub Command4_Click()
Dim strsearch As Variant
Dim VARBOOKMARK As Variant
Dim TEMPID As Variant
Dim SQLCOMMAND As String
Dim detailsnap As Recordset
On Error GoTo error1
Call ENABLESAVECANCELBOTTON(False)
Call enableoperationbutton(False)
'If Option2.Value = False Then
'Call enableoperationbutton(True)
'End If
'If Option2.Value = True Then
strsearch = InputBox("กรุณาใส่ชื่อวารสาร(Tiltle) ที่ต้องการค้นหา")
If strsearch <> "" Then
    SQLCOMMAND = "SELECT * FROM [DETAIL2] Where [Tiltle] ='" & strsearch & "'"
    Set detailsnap = ORDERDB.OpenRecordset(SQLCOMMAND, dbOpenSnapshot)
    flag = True
    If detailsnap.RecordCount <> 0 Then
     Set Datadetail.Recordset = detailsnap
     Call enableoperationbutton(True)
     Else
     MsgBox "ไม่พบข้อมูลที่คุณต้องการค้นหา "
     Call enableoperationbutton(True)
    End If
Else
Call enableoperationbutton(True)
MsgBox "กรุณาใส่ชื่อวารสา(Tiltle) ที่ต้องการค้นหา"
End If
'End If
error1:
End Sub
Private Sub Command5_Click()
If Text1.Text = "" Then
    MsgBox "ใส่ข้อมูล ID# "
 ElseIf Text2.Text = "" Then
    MsgBox "ใส่ข้อมูล ชื่อวารสาร"
 ElseIf Text3.Text = "" Then
    MsgBox "ใส่ข้อมูล ฉบับที่"
 ElseIf Text4.Text = "" Then
    MsgBox "ใส่ข้อมูล ปีที่พิมพ์"
 ElseIf Text6.Text = "" Then
    MsgBox "ใ่ข้อมูลกำหนดออก"
 ElseIf Text10.Text = "" Then
    MsgBox "ใส่ข้อมูลสำนักพิมพ์"
  ElseIf Text5.Text = "" Then
    MsgBox "ใส่ข้อมูล ISSN#"
 ElseIf Text9.Text = "" Then
    MsgBox "ใส่ข้อมูล วันที่เริ่มให้บริการ "
 ElseIf Text11.Text = "" Then
    MsgBox "ใส่ข้อมูล วันที่สิ้นสุดการให้บริการ "
 Else
    On Error GoTo error1
    DetailDYN("ID#") = Text1.Text
    DetailDYN("Tiltle") = Text2.Text
    DetailDYN("VOLUME") = Text3.Text
    DetailDYN("Number") = Text4.Text
    DetailDYN("ISSN") = Text5.Text
    DetailDYN("Date_in") = Text9.Text
    DetailDYN("Publisher") = Text10.Text
    DetailDYN("Date_Out") = Text11.Text
    DetailDYN("Frequency") = Text6.Text
    DetailDYN.Update
    DetailDYN.Requery
    Call ENABLESAVECANCELBOTTON(False)
    Call enableoperationbutton(True)
    Call DISPLAYFIELDS


 End If
 GoTo end1
error1:
     MsgBox "ID# Same,กรุณาใส่ ID# ใหม่#"
end1:
End Sub

Private Sub Command6_Click()
On Error GoTo error1
Call cleardata
Call ENABLESAVECANCELBOTTON(False)
Call enableoperationbutton(True)
error1:
End Sub

Private Sub Command7_Click()
On Error GoTo error1
If DetailDYN.RecordCount > 0 Then
DetailDYN.MoveFirst
Call DISPLAYFIELDS
Command9.Enabled = True
Command10.Enabled = True

Command7.Enabled = False
Command8.Enabled = False
End If
error1:
End Sub

Private Sub Command8_Click()
On Error GoTo error1
If DetailDYN.RecordCount > 0 Then
DetailDYN.MovePrevious
If DetailDYN.BOF = False Then
    Call DISPLAYFIELDS
    
    Command9.Enabled = True
    Command10.Enabled = True
 Else
    Command7.Enabled = False
    Command8.Enabled = False
     Command9.Enabled = True
    Command10.Enabled = True
End If
End If
error1:
End Sub

Private Sub Command9_Click()
On Error GoTo error1
If (DetailDYN.RecordCount > 0) Then
   DetailDYN.MoveNext
If DetailDYN.EOF = False Then
    Call DISPLAYFIELDS
    Command7.Enabled = True
    Command8.Enabled = True
Else
    Command7.Enabled = True
    Command8.Enabled = True
    Command9.Enabled = False
    Command10.Enabled = False
End If
End If
error1:
End Sub

Private Sub Form_Load()
On Error GoTo error1
flag = False
Set ORDERWS = DBEngine.Workspaces(0)
Set ORDERDB = ORDERWS.OpenDatabase("C:\PROJECT\ORDER1.MDB", False, False)
Set DetailDYN = ORDERDB.OpenRecordset("select * from detail2 order by detail2.[Tiltle]", dbOpenDynaset)
If DetailDYN.RecordCount > 0 Then
Call DISPLAYFIELDS
End If
Command7.Enabled = False
Command8.Enabled = False
Call ENABLESAVECANCELBOTTON(False)
Text7.Enabled = False
error1:
End Sub
Private Sub ENABLESAVECANCELBOTTON(enableflag As Boolean)
On Error GoTo error1
Command5.Enabled = enableflag
Command6.Enabled = enableflag
error1:
End Sub
Private Sub DISPLAYFIELDS()
On Error GoTo error1
Text1.Text = DetailDYN.Fields("ID#")
Text2.Text = DetailDYN.Fields("Tiltle")
Text3.Text = DetailDYN.Fields("VOLUME")
Text4.Text = DetailDYN.Fields("Number")
Text10.Text = DetailDYN.Fields("Publisher")
Text5.Text = DetailDYN.Fields("ISSN")
Text9.Text = DetailDYN.Fields("Date_in")
Text11.Text = DetailDYN.Fields("Date_Out")
Text6.Text = DetailDYN.Fields("Frequency")
Set Datadetail.Recordset = DetailDYN
error1:
End Sub


Private Sub Option2_Click()

End Sub

