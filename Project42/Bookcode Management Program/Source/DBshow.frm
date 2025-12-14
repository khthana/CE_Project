VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Authorcode_show 
   BackColor       =   &H000080FF&
   Caption         =   "AuthorcodeDB"
   ClientHeight    =   6285
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8280
   LinkTopic       =   "Form2"
   ScaleHeight     =   6285
   ScaleWidth      =   8280
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCloseSWA 
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
      Height          =   375
      Left            =   3360
      TabIndex        =   5
      Top             =   5520
      Width           =   2055
   End
   Begin MSDBGrid.DBGrid DBGridEng 
      Bindings        =   "DBshow.frx":0000
      Height          =   3615
      Left            =   1080
      OleObjectBlob   =   "DBshow.frx":0016
      TabIndex        =   4
      Top             =   1680
      Width           =   6255
   End
   Begin MSDBGrid.DBGrid DBGridThai 
      Bindings        =   "DBshow.frx":09EB
      Height          =   3615
      Left            =   1080
      OleObjectBlob   =   "DBshow.frx":0A02
      TabIndex        =   3
      Top             =   1680
      Width           =   6255
   End
   Begin VB.CommandButton Commandeng 
      Caption         =   "English"
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
      Left            =   4680
      TabIndex        =   1
      Top             =   1080
      Width           =   2055
   End
   Begin VB.Data Dataeng 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   "EngAuthor.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   4560
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "EngAuthor"
      Top             =   4080
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.Data Datathai 
      Caption         =   "Data2"
      Connect         =   "Access"
      DatabaseName    =   "ThaiAuthor.mdb"
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   375
      Left            =   1080
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   "ThaiAuthor"
      Top             =   4080
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.CommandButton Commandthai 
      Caption         =   "ไทย"
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
      Left            =   1800
      TabIndex        =   0
      Top             =   1080
      Width           =   2055
   End
   Begin VB.Label Label1 
      BackColor       =   &H000080FF&
      Caption         =   "โปรแกรมแสดงเลขผู้แต่ง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   495
      Left            =   2520
      TabIndex        =   2
      Top             =   240
      Width           =   3855
   End
End
Attribute VB_Name = "Authorcode_show"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub cmdCloseSWA_Click()
Unload Authorcode_show
End Sub

Private Sub Commandeng_Click()
DBGridEng.Visible = True
DBGridThai.Visible = False
End Sub

Private Sub Commandthai_Click()
DBGridEng.Visible = False
DBGridThai.Visible = True
End Sub

Private Sub Form_Load()
DBGridEng.Visible = False
DBGridThai.Visible = False
End Sub

