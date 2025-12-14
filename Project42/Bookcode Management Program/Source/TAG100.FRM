VERSION 5.00
Begin VB.Form tag100 
   Caption         =   "tag100"
   ClientHeight    =   7860
   ClientLeft      =   60
   ClientTop       =   1080
   ClientWidth     =   11880
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   Moveable        =   0   'False
   ScaleHeight     =   7860
   ScaleWidth      =   11880
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command1 
      Caption         =   "BACK"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   6720
      TabIndex        =   57
      Top             =   7440
      Width           =   735
   End
   Begin VB.CommandButton Command3 
      Caption         =   "NEXT"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   7560
      TabIndex        =   56
      Top             =   7440
      Width           =   735
   End
   Begin VB.TextBox tag130_7 
      Height          =   315
      Left            =   9840
      TabIndex        =   52
      Top             =   6240
      Width           =   2055
   End
   Begin VB.TextBox tag130_8 
      Height          =   315
      Left            =   9840
      TabIndex        =   51
      Top             =   6600
      Width           =   2055
   End
   Begin VB.TextBox tag130_6 
      Height          =   315
      Left            =   9840
      TabIndex        =   50
      Top             =   5880
      Width           =   2055
   End
   Begin VB.CommandButton tag100_s 
      Caption         =   "SAVE"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   5160
      TabIndex        =   49
      Top             =   7440
      Width           =   1455
   End
   Begin VB.CommandButton tag100_q 
      Caption         =   "QUIT"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   350
      Left            =   3600
      TabIndex        =   48
      Top             =   7440
      Width           =   1455
   End
   Begin VB.TextBox tag100_2 
      Height          =   315
      Left            =   3360
      TabIndex        =   21
      Top             =   1800
      Width           =   2055
   End
   Begin VB.TextBox tag100_3 
      Height          =   315
      Left            =   3360
      TabIndex        =   20
      Top             =   2160
      Width           =   2055
   End
   Begin VB.TextBox tag100_1 
      Height          =   315
      Left            =   3360
      TabIndex        =   19
      Top             =   1440
      Width           =   2055
   End
   Begin VB.TextBox tag100_5 
      Height          =   315
      Left            =   3360
      TabIndex        =   18
      Top             =   2880
      Width           =   2055
   End
   Begin VB.TextBox tag100_4 
      Height          =   315
      Left            =   3360
      TabIndex        =   17
      Top             =   2520
      Width           =   2055
   End
   Begin VB.TextBox tag130_2 
      Height          =   315
      Left            =   9840
      TabIndex        =   16
      Top             =   4440
      Width           =   2055
   End
   Begin VB.TextBox tag130_3 
      Height          =   315
      Left            =   9840
      TabIndex        =   15
      Top             =   4800
      Width           =   2055
   End
   Begin VB.TextBox tag130_1 
      Height          =   315
      Left            =   9840
      TabIndex        =   14
      Top             =   4080
      Width           =   2055
   End
   Begin VB.TextBox tag130_5 
      Height          =   315
      Left            =   9840
      TabIndex        =   13
      Top             =   5520
      Width           =   2055
   End
   Begin VB.TextBox tag130_4 
      Height          =   315
      Left            =   9840
      TabIndex        =   12
      Top             =   5160
      Width           =   2055
   End
   Begin VB.TextBox tag110_2 
      Height          =   315
      Left            =   3360
      TabIndex        =   11
      Top             =   4920
      Width           =   2055
   End
   Begin VB.TextBox tag110_3 
      Height          =   315
      Left            =   3360
      TabIndex        =   10
      Top             =   5280
      Width           =   2055
   End
   Begin VB.TextBox tag110_1 
      Height          =   315
      Left            =   3360
      TabIndex        =   9
      Top             =   4560
      Width           =   2055
   End
   Begin VB.TextBox tag110_5 
      Height          =   315
      Left            =   3360
      TabIndex        =   8
      Top             =   6000
      Width           =   2055
   End
   Begin VB.TextBox tag110_4 
      Height          =   315
      Left            =   3360
      TabIndex        =   7
      Top             =   5640
      Width           =   2055
   End
   Begin VB.TextBox tag110_6 
      Height          =   315
      Left            =   3360
      TabIndex        =   6
      Top             =   6360
      Width           =   2055
   End
   Begin VB.TextBox tag111_2 
      Height          =   315
      Left            =   9840
      TabIndex        =   5
      Top             =   1800
      Width           =   2055
   End
   Begin VB.TextBox tag111_3 
      Height          =   315
      Left            =   9840
      TabIndex        =   4
      Top             =   2160
      Width           =   2055
   End
   Begin VB.TextBox tag111_1 
      Height          =   315
      Left            =   9840
      TabIndex        =   3
      Top             =   1440
      Width           =   2055
   End
   Begin VB.TextBox tag111_5 
      Height          =   315
      Left            =   9840
      TabIndex        =   2
      Top             =   2880
      Width           =   2055
   End
   Begin VB.TextBox tag111_4 
      Height          =   315
      Left            =   9840
      TabIndex        =   1
      Top             =   2520
      Width           =   2055
   End
   Begin VB.TextBox tag111_6 
      Height          =   315
      Left            =   9840
      TabIndex        =   0
      Top             =   3240
      Width           =   2055
   End
   Begin VB.Label Label3 
      Caption         =   "หมายเลขตอน/ส่วนของชื่อเรื่องแบบฉบับ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   55
      Top             =   5880
      Width           =   4215
   End
   Begin VB.Label Label2 
      Caption         =   "ชื่อตอน/ส่วนของชื่อเรื่องแบบฉบับ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   54
      Top             =   6240
      Width           =   4215
   End
   Begin VB.Label Label1 
      Caption         =   "ฉบับ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   53
      Top             =   6600
      Width           =   4215
   End
   Begin VB.Label Label50 
      Caption         =   "100 รายการหลักชื่อบุคคล"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   47
      Top             =   1080
      Width           =   2895
   End
   Begin VB.Label Label51 
      Caption         =   "111 รายการหลักชื่อการประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   46
      Top             =   1080
      Width           =   3495
   End
   Begin VB.Label Label54 
      Caption         =   "130 รายการหลักชื่อเรื่องแบบฉบับ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   45
      Top             =   3720
      Width           =   3735
   End
   Begin VB.Label Label56 
      Caption         =   "110 รายการหลักนิติบุคคล"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   44
      Top             =   4200
      Width           =   2895
   End
   Begin VB.Label Label57 
      Caption         =   "ชื่อบุคคล"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   43
      Top             =   1440
      Width           =   4215
   End
   Begin VB.Label Label37 
      Caption         =   "ตัวเลขโรมันที่ตามหลังชื่อต้น"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   42
      Top             =   1800
      Width           =   4215
   End
   Begin VB.Label Label40 
      Caption         =   "ตำแหน่ง  ยศ  บรรดาศักดิ์"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   41
      Top             =   2160
      Width           =   4215
   End
   Begin VB.Label Label59 
      Caption         =   "ปีเกิด-ปีตาย"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   40
      Top             =   2520
      Width           =   4215
   End
   Begin VB.Label Label60 
      Caption         =   "ชื่อเต็ม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   39
      Top             =   2880
      Width           =   4215
   End
   Begin VB.Label Label81 
      Caption         =   "ชื่อนิติบุคคล"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   38
      Top             =   4560
      Width           =   4215
   End
   Begin VB.Label Label82 
      Caption         =   "ชื่อหน่วยงานรอง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   37
      Top             =   4920
      Width           =   4215
   End
   Begin VB.Label Label83 
      Caption         =   "ครั้งที่ของการประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   36
      Top             =   6360
      Width           =   4215
   End
   Begin VB.Label Label84 
      Caption         =   "รายละเอียดอื่นๆ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   35
      Top             =   6000
      Width           =   4215
   End
   Begin VB.Label Label85 
      Caption         =   "ปีที่จัดประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   34
      Top             =   5640
      Width           =   4215
   End
   Begin VB.Label Label86 
      Caption         =   "สถานที่จัดประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   360
      TabIndex        =   33
      Top             =   5280
      Width           =   4215
   End
   Begin VB.Label Label87 
      Caption         =   "รายการรองที่ลงรายการภายใต้ชื่อการประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   32
      Top             =   2520
      Width           =   4215
   End
   Begin VB.Label Label88 
      Caption         =   "ปีที่จัดประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   31
      Top             =   2160
      Width           =   4215
   End
   Begin VB.Label Label89 
      Caption         =   "ชื่อการประชุมตามหลังชื่อตามกฎหมาย"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   30
      Top             =   3240
      Width           =   4215
   End
   Begin VB.Label Label90 
      Caption         =   "ครั้งที่ของการประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   29
      Top             =   2880
      Width           =   4215
   End
   Begin VB.Label Label91 
      Caption         =   "สถานที่จัดประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   28
      Top             =   1800
      Width           =   4215
   End
   Begin VB.Label Label92 
      Caption         =   "ชื่อการประชุม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   27
      Top             =   1440
      Width           =   4215
   End
   Begin VB.Label Label93 
      Caption         =   "ภาษาของงาน"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   26
      Top             =   5520
      Width           =   4215
   End
   Begin VB.Label Label94 
      Caption         =   "การแบ่งย่อยตามรูปแบบของวัสดุ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   25
      Top             =   5160
      Width           =   4215
   End
   Begin VB.Label Label95 
      Caption         =   "ปีของงาน"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   24
      Top             =   4800
      Width           =   4215
   End
   Begin VB.Label Label96 
      Caption         =   "ปีที่ลงนามในสนธิสัญญา"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   23
      Top             =   4440
      Width           =   4215
   End
   Begin VB.Label Label97 
      Caption         =   "ชื่อเรื่องแบบฉบับ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   5760
      TabIndex        =   22
      Top             =   4080
      Width           =   4215
   End
End
Attribute VB_Name = "tag100"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public OrderWs     As Workspace
Public OrderDb     As Database
Public Opendyna  As Recordset
Public sqlcommand  As String
Public Searchtext  As String
Public ComboHeaderCode As ComboBox
Public ComboAuthorCode As ComboBox
Private Sub Command1_Click()
tag090.Show
End Sub

Private Sub Command3_Click()
tag210.Show
End Sub

Private Sub tag100_1_Change()
tag090.ComboAuthorCode.Clear
tag090.ComboAuthorCode.Text = "เลขผู้แต่งหนังสือ"
Set OrderWs = DBEngine.Workspaces(0)
 Set OrderDb = OrderWs.OpenDatabase("ThaiAuthor.mdb", False, False)
Searchtext = tag100_1.Text
'*****************ThaiAuthor************
If Searchtext <> "" Then
sqlcommand = " SELECT * FROM ThaiAuthor "
sqlcommand = sqlcommand & "WHERE TAuthorname LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
If Opendyna.Fields("Tauthorcode") <> "" Then
tag090.ComboAuthorCode.AddItem Opendyna.Fields("Tauthorcode")
End If
Opendyna.MoveNext
Loop
End If
'*****************EngAuthor************
Set OrderWs = DBEngine.Workspaces(0)
 Set OrderDb = OrderWs.OpenDatabase("EngAuthor.mdb", False, False)
If Searchtext <> "" Then
sqlcommand = " SELECT * FROM EngAuthor "
sqlcommand = sqlcommand & "WHERE EAuthorname LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
If Opendyna.Fields("Eauthorcode") <> "" Then
tag090.ComboAuthorCode.AddItem Opendyna.Fields("Eauthorcode")
End If
Opendyna.MoveNext
Loop
End If
End Sub

Private Sub tag100_q_Click()
mainmenu.quitting
End Sub

Private Sub tag100_s_Click()
mainmenu.saving
End Sub

Private Sub tag130_1_Change()
tag090.ComboHeaderCode.Clear
tag090.ComboHeaderCode.Text = "เลขหัวเรื่องหนังสือ"
Set OrderWs = DBEngine.Workspaces(0)
 Set OrderDb = OrderWs.OpenDatabase("HeaderDB.mdb", False, False)
Searchtext = tag130_1.Text
 '*******************search tblMain******
 If Searchtext <> "" Then
sqlcommand = " SELECT * FROM tblMain "
sqlcommand = sqlcommand & "WHERE Header LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
If Opendyna.Fields("DEWEY_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_1")
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_2")
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_3")
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_4")
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_5")
End If
If Opendyna.Fields("LC_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_1")
End If
If Opendyna.Fields("LC_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_2")
End If
If Opendyna.Fields("LC_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_3")
End If
If Opendyna.Fields("LC_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_4")
End If
If Opendyna.Fields("LC_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_5")
End If
Opendyna.MoveNext
Loop
End If
'*******************search tblsub1******
If Searchtext <> "" Then
sqlcommand = " SELECT * FROM tblSub1 "
sqlcommand = sqlcommand & "WHERE Subheader_1 LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
If Opendyna.Fields("DEWEY_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_1")
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_2")
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_3")
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_4")
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_5")
End If
If Opendyna.Fields("LC_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_1")
End If
If Opendyna.Fields("LC_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_2")
End If
If Opendyna.Fields("LC_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_3")
End If
If Opendyna.Fields("LC_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_4")
End If
If Opendyna.Fields("LC_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_5")
End If
Opendyna.MoveNext
Loop
End If
'*******************search tblsub2******
If Searchtext <> "" Then
sqlcommand = " SELECT * FROM tblSub2 "
sqlcommand = sqlcommand & "WHERE Subheader_2 LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
If Opendyna.Fields("DEWEY_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_1")
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_2")
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_3")
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_4")
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_5")
End If
If Opendyna.Fields("LC_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_1")
End If
If Opendyna.Fields("LC_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_2")
End If
If Opendyna.Fields("LC_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_3")
End If
If Opendyna.Fields("LC_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_4")
End If
If Opendyna.Fields("LC_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_5")
End If
Opendyna.MoveNext
Loop
End If
'*******************search tblsub3******
If Searchtext <> "" Then
sqlcommand = " SELECT * FROM tblSub3 "
sqlcommand = sqlcommand & "WHERE Subheader_3 LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set Opendyna = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
Do Until Opendyna.EOF
If Opendyna.Fields("DEWEY_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_1")
End If
If Opendyna.Fields("DEWEY_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_2")
End If
If Opendyna.Fields("DEWEY_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_3")
End If
If Opendyna.Fields("DEWEY_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_4")
End If
If Opendyna.Fields("DEWEY_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("DEWEY_5")
End If
If Opendyna.Fields("LC_1") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_1")
End If
If Opendyna.Fields("LC_2") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_2")
End If
If Opendyna.Fields("LC_3") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_3")
End If
If Opendyna.Fields("LC_4") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_4")
End If
If Opendyna.Fields("LC_5") <> "" Then
tag090.ComboHeaderCode.AddItem Opendyna.Fields("LC_5")
End If
Opendyna.MoveNext
Loop
End If
End Sub
