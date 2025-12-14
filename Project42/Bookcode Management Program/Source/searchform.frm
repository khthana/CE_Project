VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form searchform 
   Caption         =   "searchform"
   ClientHeight    =   8595
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   11880
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   Moveable        =   0   'False
   ScaleHeight     =   8595
   ScaleWidth      =   11880
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton quit 
      Caption         =   "Quit"
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
      Left            =   4920
      TabIndex        =   6
      Top             =   7680
      Width           =   2175
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   495
      Left            =   8160
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   7560
      Visible         =   0   'False
      Width           =   1935
   End
   Begin MSDBGrid.DBGrid DBGrid1 
      Bindings        =   "searchform.frx":0000
      Height          =   4455
      Left            =   1680
      OleObjectBlob   =   "searchform.frx":0014
      TabIndex        =   5
      Top             =   2760
      Width           =   9495
   End
   Begin VB.CommandButton go 
      Caption         =   "แสดงข้อมูลในฐานข้อมูล"
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
      Left            =   7800
      TabIndex        =   4
      Top             =   1680
      Width           =   2055
   End
   Begin VB.TextBox containtext 
      Height          =   315
      Left            =   4560
      TabIndex        =   3
      Top             =   1800
      Width           =   2655
   End
   Begin VB.ComboBox orderby 
      Height          =   315
      ItemData        =   "searchform.frx":09E7
      Left            =   2160
      List            =   "searchform.frx":09F1
      TabIndex        =   0
      Text            =   "ชื่อหนังสือ"
      Top             =   1800
      Width           =   1935
   End
   Begin VB.Label Label3 
      Caption         =   "ค้นหาข้อมูล"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   5040
      TabIndex        =   7
      Top             =   600
      Width           =   2295
   End
   Begin VB.Label Label2 
      Caption         =   "ชื่อหนังสือ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4560
      TabIndex        =   2
      Top             =   1320
      Width           =   1935
   End
   Begin VB.Label Label1 
      Caption         =   "เรียงลำดับโดย"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   2160
      TabIndex        =   1
      Top             =   1320
      Width           =   2295
   End
End
Attribute VB_Name = "searchform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public marcws2 As Workspace
Public marcset2 As Recordset
Public marcdb2 As Database

Private Sub Form_Load()
On Error GoTo HandleError
Set marcws2 = DBEngine.Workspaces(0)
Set marcdb2 = marcws2.OpenDatabase("marcsheetdb.mdb", False, False)
Exit Sub
HandleError:
MsgBox Error(Err.Number)
End Sub

Private Sub go_Click()
If orderby.Text = "ชื่อหนังสือ" Then
 sqlcommand = "SELECT  *  FROM tagdata1"
 sqlcommand = sqlcommand & " WHERE  t130_1  LIKE  "
 sqlcommand = sqlcommand & "'*" & containtext.Text & "*' "
 sqlcommand = sqlcommand & " Order by t130_1"
 Set marcset2 = marcdb2.OpenRecordset(sqlcommand, dbOpenSnapshot)
 Set Data1.Recordset = marcset2
Else
If orderby.Text = "ชื่อผู้แต่ง" Then
 sqlcommand = "Select * FROM tagdata1"
 sqlcommand = sqlcommand & " WHERE t130_1 LIKE  "
 sqlcommand = sqlcommand & " '*" & containtext.Text & "*' "
  sqlcommand = sqlcommand & " Order by t100_1"
 Set marcset2 = marcdb2.OpenRecordset(sqlcommand, dbOpenSnapshot)
 Set Data1.Recordset = marcset2
Else
 MsgBox "กรุณาเลือกว่าจะค้นหาด้วยอะไร", vbOKOnly
End If
End If
End Sub



Private Sub quit_Click()
Unload Me
End Sub
