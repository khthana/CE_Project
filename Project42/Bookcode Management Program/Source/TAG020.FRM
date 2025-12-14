VERSION 5.00
Begin VB.Form tag020 
   Caption         =   "tag020"
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
   Begin VB.CommandButton tag020_s 
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
   Begin VB.CommandButton tag020_q 
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
   Begin VB.TextBox tag022_1 
      Height          =   375
      Left            =   7920
      TabIndex        =   5
      Top             =   4200
      Width           =   1215
   End
   Begin VB.TextBox tag020_1 
      Height          =   375
      Left            =   7920
      TabIndex        =   4
      Top             =   2040
      Width           =   1215
   End
   Begin VB.TextBox tag020_2 
      Height          =   375
      Left            =   7920
      TabIndex        =   3
      Top             =   2520
      Width           =   1215
   End
   Begin VB.TextBox tag020_3 
      Height          =   375
      Left            =   7920
      TabIndex        =   2
      Top             =   3000
      Width           =   1215
   End
   Begin VB.TextBox tag022_3 
      Height          =   375
      Left            =   7920
      TabIndex        =   1
      Top             =   5160
      Width           =   1215
   End
   Begin VB.TextBox tag022_2 
      Height          =   375
      Left            =   7920
      TabIndex        =   0
      Top             =   4680
      Width           =   1215
   End
   Begin VB.Label Label30 
      Caption         =   "เลขมาตรฐานสากลประจำหนังสือ"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2760
      TabIndex        =   13
      Top             =   2040
      Width           =   3615
   End
   Begin VB.Label Label29 
      Caption         =   "ISSN"
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
      Top             =   4200
      Width           =   3615
   End
   Begin VB.Label Label15 
      Caption         =   "ข้อความที่บ่งถึงการได้มา"
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
      TabIndex        =   11
      Top             =   2520
      Width           =   2775
   End
   Begin VB.Label Label61 
      Caption         =   "เลขมาตรฐานสากลประจำหนังสือที่ถูกยกเลิก/ไม่ถูกต้อง"
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
      Top             =   3000
      Width           =   5055
   End
   Begin VB.Label Label62 
      Caption         =   "Canceled  ISSN"
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
      Top             =   5160
      Width           =   2415
   End
   Begin VB.Label Label63 
      Caption         =   "Incorrect  ISSN"
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
      TabIndex        =   8
      Top             =   4680
      Width           =   2175
   End
   Begin VB.Label Label64 
      Caption         =   "Tag 020 เลขมาตรฐานสากลประจำหนังสือ"
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
      TabIndex        =   7
      Top             =   1680
      Width           =   4695
   End
   Begin VB.Label Label65 
      Caption         =   "Tag 022 ISSN"
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
      TabIndex        =   6
      Top             =   3840
      Width           =   4695
   End
End
Attribute VB_Name = "tag020"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
tag008.Show
End Sub

Private Sub Command3_Click()
tag090.Show
End Sub

Private Sub tag020_q_Click()
mainmenu.quitting
End Sub



Private Sub tag020_s_Click()
mainmenu.saving
End Sub
