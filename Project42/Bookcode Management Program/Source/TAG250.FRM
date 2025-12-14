VERSION 5.00
Begin VB.Form tag250 
   Caption         =   "tag250"
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
   Begin VB.CommandButton Command2 
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
      TabIndex        =   47
      Top             =   7440
      Width           =   735
   End
   Begin VB.CommandButton Command1 
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
      TabIndex        =   46
      Top             =   7440
      Width           =   735
   End
   Begin VB.CommandButton tag250_s 
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
      TabIndex        =   45
      Top             =   7440
      Width           =   1455
   End
   Begin VB.CommandButton tag250_q 
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
      TabIndex        =   44
      Top             =   7440
      Width           =   1455
   End
   Begin VB.TextBox tag490_1 
      Height          =   315
      Left            =   9000
      TabIndex        =   43
      Top             =   2880
      Width           =   2775
   End
   Begin VB.TextBox tag490_2 
      Height          =   315
      Left            =   9000
      TabIndex        =   42
      Top             =   3240
      Width           =   2775
   End
   Begin VB.TextBox tag300_6 
      Height          =   315
      Left            =   2880
      TabIndex        =   41
      Top             =   5280
      Width           =   2775
   End
   Begin VB.TextBox tag300_7 
      Height          =   315
      Left            =   2880
      TabIndex        =   40
      Top             =   5640
      Width           =   2775
   End
   Begin VB.TextBox tag300_4 
      Height          =   315
      Left            =   2880
      TabIndex        =   39
      Top             =   4560
      Width           =   2775
   End
   Begin VB.TextBox tag300_5 
      Height          =   315
      Left            =   2880
      TabIndex        =   38
      Top             =   4920
      Width           =   2775
   End
   Begin VB.TextBox tag300_2 
      Height          =   315
      Left            =   2880
      TabIndex        =   37
      Top             =   3840
      Width           =   2775
   End
   Begin VB.TextBox tag300_3 
      Height          =   315
      Left            =   2880
      TabIndex        =   36
      Top             =   4200
      Width           =   2775
   End
   Begin VB.TextBox tag260_3 
      Height          =   315
      Left            =   2880
      TabIndex        =   35
      Top             =   2520
      Width           =   2775
   End
   Begin VB.TextBox tag300_1 
      Height          =   315
      Left            =   2880
      TabIndex        =   34
      Top             =   3480
      Width           =   2775
   End
   Begin VB.TextBox tag260_1 
      Height          =   315
      Left            =   2880
      TabIndex        =   33
      Top             =   1800
      Width           =   2775
   End
   Begin VB.TextBox tag260_2 
      Height          =   315
      Left            =   2880
      TabIndex        =   32
      Top             =   2160
      Width           =   2775
   End
   Begin VB.TextBox tag440_5 
      Height          =   315
      Left            =   9000
      TabIndex        =   31
      Top             =   1920
      Width           =   2775
   End
   Begin VB.TextBox tag440_6 
      Height          =   315
      Left            =   9000
      TabIndex        =   30
      Top             =   2280
      Width           =   2775
   End
   Begin VB.TextBox tag440_3 
      Height          =   315
      Left            =   9000
      TabIndex        =   29
      Top             =   1200
      Width           =   2775
   End
   Begin VB.TextBox tag440_4 
      Height          =   315
      Left            =   9000
      TabIndex        =   28
      Top             =   1560
      Width           =   2775
   End
   Begin VB.TextBox tag440_1 
      Height          =   315
      Left            =   9000
      TabIndex        =   27
      Top             =   480
      Width           =   2775
   End
   Begin VB.TextBox tag440_2 
      Height          =   315
      Left            =   9000
      TabIndex        =   26
      Top             =   840
      Width           =   2775
   End
   Begin VB.TextBox tag250_1 
      Height          =   315
      Left            =   2880
      TabIndex        =   25
      Top             =   480
      Width           =   2775
   End
   Begin VB.TextBox tag250_2 
      Height          =   315
      Left            =   2880
      TabIndex        =   24
      Top             =   840
      Width           =   2775
   End
   Begin VB.Label Label18 
      Caption         =   "หมายเลขชื่อชุด"
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
      Left            =   5880
      TabIndex        =   23
      Top             =   3240
      Width           =   3735
   End
   Begin VB.Label Label17 
      Caption         =   "ชื่อชุด"
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
      Left            =   5880
      TabIndex        =   22
      Top             =   2880
      Width           =   1695
   End
   Begin VB.Label Label16 
      Caption         =   "เลขมาตรฐานสากลประจำวารสาร"
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
      Left            =   5880
      TabIndex        =   21
      Top             =   1920
      Width           =   3015
   End
   Begin VB.Label Label15 
      Caption         =   "หมายเลขชื่อชุด"
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
      Left            =   5880
      TabIndex        =   20
      Top             =   1560
      Width           =   3735
   End
   Begin VB.Label Label14 
      Caption         =   "ชื่อตอน/ส่วนของชื่อชุด"
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
      Left            =   5880
      TabIndex        =   19
      Top             =   1200
      Width           =   3015
   End
   Begin VB.Label Label13 
      Caption         =   "หมายเลขตอน/ส่วนของชื่อชุด"
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
      Left            =   5880
      TabIndex        =   18
      Top             =   840
      Width           =   3735
   End
   Begin VB.Label Label12 
      Caption         =   "ชื่อชุด"
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
      Left            =   5880
      TabIndex        =   17
      Top             =   480
      Width           =   2055
   End
   Begin VB.Label Label11 
      Caption         =   "Material specified"
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
      Left            =   240
      TabIndex        =   16
      Top             =   5640
      Width           =   2055
   End
   Begin VB.Label Label10 
      Caption         =   "ขนาดประเภทของวัสดุ"
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
      Left            =   240
      TabIndex        =   15
      Top             =   5280
      Width           =   3015
   End
   Begin VB.Label Label9 
      Caption         =   "ประเภทของวัสดุ"
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
      Left            =   240
      TabIndex        =   14
      Top             =   4920
      Width           =   1695
   End
   Begin VB.Label Label8 
      Caption         =   "วัสดุประกอบสิ่งพิมพ์"
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
      Left            =   240
      TabIndex        =   13
      Top             =   4560
      Width           =   2655
   End
   Begin VB.Label Label7 
      Caption         =   "ขนาด"
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
      Left            =   240
      TabIndex        =   12
      Top             =   4200
      Width           =   2055
   End
   Begin VB.Label Label6 
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
      Left            =   240
      TabIndex        =   11
      Top             =   3840
      Width           =   2535
   End
   Begin VB.Label Label2 
      Caption         =   "จำนวนหน้า/แผ่น/เล่ม"
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
      Left            =   240
      TabIndex        =   10
      Top             =   3480
      Width           =   2055
   End
   Begin VB.Label Label5 
      Caption         =   "ปีที่พิมพ์"
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
      Left            =   240
      TabIndex        =   9
      Top             =   2520
      Width           =   1695
   End
   Begin VB.Label Label4 
      Caption         =   "ชื่อสำนักพิมพ์,ผู้จัดจำหน่าย"
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
      Left            =   240
      TabIndex        =   8
      Top             =   2160
      Width           =   3735
   End
   Begin VB.Label Label3 
      Caption         =   "สถานที่พิมพ์,ผู้จัดจำหน่าย"
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
      Left            =   240
      TabIndex        =   7
      Top             =   1800
      Width           =   3015
   End
   Begin VB.Label Label1 
      Caption         =   "ข้อมูลผู้รับผิดชอบการพิมพ์"
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
      Left            =   240
      TabIndex        =   6
      Top             =   840
      Width           =   3735
   End
   Begin VB.Label Label71 
      Caption         =   "การแจ้งครั้งที่พิมพ์"
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
      Left            =   240
      TabIndex        =   5
      Top             =   480
      Width           =   1695
   End
   Begin VB.Label Label49 
      Caption         =   "490 ชื่อชุด"
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
      Left            =   5880
      TabIndex        =   4
      Top             =   2520
      Width           =   2175
   End
   Begin VB.Label Label47 
      Caption         =   "300 ลักษณะรูปร่าง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Top             =   3120
      Width           =   2535
   End
   Begin VB.Label Label46 
      Caption         =   "440 การแจ้งรายการเพิ่ม"
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
      Left            =   5880
      TabIndex        =   2
      Top             =   120
      Width           =   3615
   End
   Begin VB.Label Label43 
      Caption         =   "250 แจ้งฉบับบพิมพ์"
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
      Left            =   240
      TabIndex        =   1
      Top             =   120
      Width           =   3615
   End
   Begin VB.Label Label42 
      Caption         =   "260 การพิมพ์จำหน่าย"
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
      Left            =   240
      TabIndex        =   0
      Top             =   1440
      Width           =   3615
   End
End
Attribute VB_Name = "tag250"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
tag500.Show
End Sub

Private Sub Command2_Click()
tag210.Show
End Sub

Private Sub tag250_q_Click()
mainmenu.quitting
End Sub

Private Sub tag250_s_Click()
mainmenu.saving
End Sub
