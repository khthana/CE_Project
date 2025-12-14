VERSION 5.00
Begin VB.Form deleteform 
   Caption         =   "deleteform"
   ClientHeight    =   6630
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7395
   LinkTopic       =   "Form1"
   ScaleHeight     =   6630
   ScaleWidth      =   7395
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command2 
      Caption         =   "Cancel"
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
      Left            =   7320
      TabIndex        =   4
      Top             =   1560
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Delete"
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
      Left            =   5880
      TabIndex        =   1
      Top             =   1560
      Width           =   1215
   End
   Begin VB.ComboBox cmbIDdel 
      Height          =   315
      Left            =   3000
      TabIndex        =   0
      Top             =   1560
      Width           =   2655
   End
   Begin VB.Label Label3 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   6000
      TabIndex        =   5
      Top             =   3120
      Width           =   2415
   End
   Begin VB.Label Label1 
      Caption         =   "โปรดเลือกรหัสหนังสือที่ท่านต้องลบ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   4080
      TabIndex        =   3
      Top             =   720
      Width           =   4095
   End
   Begin VB.Label Label2 
      Caption         =   "ชื่อหนังสือ :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   3600
      TabIndex        =   2
      Top             =   3120
      Width           =   1815
   End
End
Attribute VB_Name = "deleteform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public marcdbdel As Database
Public marcwsdel As Workspace
Public Rectagdatadel1 As Recordset
Public Rectagdatadel2 As Recordset
Public idsnapdel As Recordset

Private Sub cmbIDdel_click()
Set Rectagdatadel1 = marcdbdel.OpenRecordset("select * from tagdata1", dbOpenDynaset)
Rectagdatadel1.MoveFirst
Do While Rectagdatadel1.Fields("t020_1") <> cmbIDdel.Text
  Rectagdatadel1.MoveNext
Loop
Label3.Caption = (Rectagdatadel1.Fields("t130_1"))
End Sub

Private Sub Command1_Click()
Set Rectagdatadel1 = marcdbdel.OpenRecordset("Select * from tagdata1", dbOpenDynaset)
Set Rectagdatadel2 = marcdbdel.OpenRecordset("Select * from tagdata2", dbOpenDynaset)
Rectagdatadel1.MoveFirst
Rectagdatadel2.MoveFirst
Do While Rectagdatadel1.Fields("t020_1") <> cmbIDdel.Text
  Rectagdatadel1.MoveNext
Loop
Do While Rectagdatadel2.Fields("t020_1") <> cmbIDdel.Text
  Rectagdatadel2.MoveNext
Loop
If MsgBox("Are you sure ?", vbOKCancel) = vbOK Then
   Rectagdatadel1.Delete
   Rectagdatadel2.Delete
  Form_Load
Else
End If
End Sub

Private Sub Command2_Click()
Unload Me
End Sub

Private Sub Form_Load()
Set marcwsdel = DBEngine.Workspaces(0)
Set marcdbdel = marcwsdel.OpenDatabase("marcsheetdb", False, False)
'Openrecordset for select from combo box
Set idsnapdel = marcdbdel.OpenRecordset("Select t020_1 from tagdata1 Order by t020_1", dbOpenSnapshot)
'checking for null database
If idsnapdel.EOF Then
   MsgBox ("ไม่มีข้อมูลบนฐานข้อมูลแล้ว")
   Command1.Visible = False
   cmbIDdel.Clear
Else
Command1.Visible = True
'Add item in the combo box
idsnapdel.MoveFirst
cmbIDdel.Clear
Do While Not idsnapdel.EOF
   cmbIDdel.AddItem (idsnapdel.Fields("t020_1"))
    idsnapdel.MoveNext
Loop
End If
End Sub
