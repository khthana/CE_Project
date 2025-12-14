VERSION 5.00
Begin VB.Form tag090 
   Caption         =   "tag090"
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
   Begin VB.ComboBox ComboAuthorCode 
      Height          =   315
      Left            =   10320
      TabIndex        =   19
      Text            =   "เลขผู้แต่งหนังสือ"
      Top             =   4320
      Width           =   1455
   End
   Begin VB.ComboBox ComboHeaderCode 
      Height          =   315
      Left            =   8640
      TabIndex        =   18
      Text            =   "เลขหัวเรื่องหนังสือ"
      Top             =   4320
      Width           =   1575
   End
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
      TabIndex        =   17
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
      TabIndex        =   16
      Top             =   7440
      Width           =   735
   End
   Begin VB.CommandButton tag090_s 
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
      TabIndex        =   15
      Top             =   7440
      Width           =   1455
   End
   Begin VB.CommandButton tag090_q 
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
      TabIndex        =   14
      Top             =   7440
      Width           =   1455
   End
   Begin VB.TextBox tag090_1 
      Height          =   375
      Left            =   7200
      TabIndex        =   5
      Top             =   1920
      Width           =   1215
   End
   Begin VB.TextBox tag099_1 
      Height          =   375
      Left            =   7200
      TabIndex        =   4
      Top             =   4320
      Width           =   1215
   End
   Begin VB.TextBox tag090_3 
      Height          =   375
      Left            =   7200
      TabIndex        =   3
      Top             =   2880
      Width           =   1215
   End
   Begin VB.TextBox tag090_2 
      Height          =   375
      Left            =   7200
      TabIndex        =   2
      Top             =   2400
      Width           =   1215
   End
   Begin VB.TextBox tag099_3 
      Height          =   375
      Left            =   7200
      TabIndex        =   1
      Top             =   5280
      Width           =   1215
   End
   Begin VB.TextBox tag099_2 
      Height          =   375
      Left            =   7200
      TabIndex        =   0
      Top             =   4800
      Width           =   1215
   End
   Begin VB.Label Label33 
      Caption         =   "เลขเรียกหนังสือห้องสมุดกำหนดเอง"
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
      Left            =   2760
      TabIndex        =   13
      Top             =   4320
      Width           =   3615
   End
   Begin VB.Label Label34 
      Caption         =   "เลขเรียกหนังสือระบบหอสมุดรัฐสภาอเมริกัน"
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
      Left            =   2760
      TabIndex        =   12
      Top             =   1920
      Width           =   4215
   End
   Begin VB.Label Label32 
      Caption         =   "090 เลขเรียกหนังสือระบบหอสมุดรัฐสภาอเมริกัน"
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
      Left            =   2760
      TabIndex        =   11
      Top             =   1560
      Width           =   5295
   End
   Begin VB.Label Label35 
      Caption         =   "ปีพิมพ์"
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
      Left            =   2760
      TabIndex        =   10
      Top             =   2880
      Width           =   2535
   End
   Begin VB.Label Label36 
      Caption         =   "เลขเรียกหนังสือ"
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
      Left            =   2760
      TabIndex        =   9
      Top             =   2400
      Width           =   1815
   End
   Begin VB.Label Label66 
      Caption         =   "099 เลขเรียกหนังสือห้องสมุดกำหนดเอง"
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
      Left            =   2760
      TabIndex        =   8
      Top             =   3960
      Width           =   4335
   End
   Begin VB.Label Label67 
      Caption         =   "ปีพิมพ์"
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
      Left            =   2760
      TabIndex        =   7
      Top             =   5280
      Width           =   2535
   End
   Begin VB.Label Label68 
      Caption         =   "เลขเรียกหนังสือ"
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
      Left            =   2760
      TabIndex        =   6
      Top             =   4800
      Width           =   1815
   End
End
Attribute VB_Name = "tag090"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False




Private Sub ComboAuthorCode_Click()
tag099_1.Text = ComboHeaderCode.Text & ComboAuthorCode.Text
End Sub

Private Sub ComboHeaderCode_Click()
tag099_1.Text = ComboHeaderCode.Text & ComboAuthorCode.Text
End Sub

Private Sub Command1_Click()
tag020.Show
End Sub

Private Sub Command3_Click()
tag100.Show
End Sub

Private Sub tag090_q_Click()
mainmenu.quitting
End Sub

Private Sub tag090_s_Click()
mainmenu.saving
End Sub


