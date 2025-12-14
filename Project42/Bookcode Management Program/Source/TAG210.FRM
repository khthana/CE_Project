VERSION 5.00
Begin VB.Form tag210 
   Caption         =   "tag210"
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
      TabIndex        =   68
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
      TabIndex        =   67
      Top             =   7440
      Width           =   735
   End
   Begin VB.CommandButton tag210_s 
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
      TabIndex        =   66
      Top             =   7440
      Width           =   1455
   End
   Begin VB.CommandButton tag210_q 
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
      TabIndex        =   65
      Top             =   7440
      Width           =   1455
   End
   Begin VB.TextBox tag246_6 
      Height          =   315
      Left            =   9000
      TabIndex        =   64
      Top             =   6000
      Width           =   2775
   End
   Begin VB.TextBox tag246_7 
      Height          =   315
      Left            =   9000
      TabIndex        =   63
      Top             =   6360
      Width           =   2775
   End
   Begin VB.TextBox tag246_5 
      Height          =   315
      Left            =   9000
      TabIndex        =   62
      Top             =   5640
      Width           =   2775
   End
   Begin VB.TextBox tag245_5 
      Height          =   315
      Left            =   9000
      TabIndex        =   61
      Top             =   4320
      Width           =   2775
   End
   Begin VB.TextBox tag245_6 
      Height          =   315
      Left            =   9000
      TabIndex        =   60
      Top             =   4680
      Width           =   2775
   End
   Begin VB.TextBox tag245_3 
      Height          =   315
      Left            =   9000
      TabIndex        =   59
      Top             =   3600
      Width           =   2775
   End
   Begin VB.TextBox tag245_4 
      Height          =   315
      Left            =   9000
      TabIndex        =   58
      Top             =   3960
      Width           =   2775
   End
   Begin VB.TextBox tag245_1 
      Height          =   315
      Left            =   9000
      TabIndex        =   57
      Top             =   2880
      Width           =   2775
   End
   Begin VB.TextBox tag245_2 
      Height          =   315
      Left            =   9000
      TabIndex        =   56
      Top             =   3240
      Width           =   2775
   End
   Begin VB.TextBox tag242_5 
      Height          =   315
      Left            =   9000
      TabIndex        =   55
      Top             =   1800
      Width           =   2775
   End
   Begin VB.TextBox tag242_6 
      Height          =   315
      Left            =   9000
      TabIndex        =   54
      Top             =   2160
      Width           =   2775
   End
   Begin VB.TextBox tag242_3 
      Height          =   315
      Left            =   9000
      TabIndex        =   53
      Top             =   1080
      Width           =   2775
   End
   Begin VB.TextBox tag242_4 
      Height          =   315
      Left            =   9000
      TabIndex        =   52
      Top             =   1440
      Width           =   2775
   End
   Begin VB.TextBox tag242_1 
      Height          =   315
      Left            =   9000
      TabIndex        =   51
      Top             =   360
      Width           =   2775
   End
   Begin VB.TextBox tag242_2 
      Height          =   315
      Left            =   9000
      TabIndex        =   50
      Top             =   720
      Width           =   2775
   End
   Begin VB.TextBox tag246_3 
      Height          =   315
      Left            =   3000
      TabIndex        =   49
      Top             =   6360
      Width           =   2775
   End
   Begin VB.TextBox tag246_4 
      Height          =   315
      Left            =   3000
      TabIndex        =   48
      Top             =   6720
      Width           =   2775
   End
   Begin VB.TextBox tag246_1 
      Height          =   315
      Left            =   3000
      TabIndex        =   47
      Top             =   5640
      Width           =   2775
   End
   Begin VB.TextBox tag246_2 
      Height          =   315
      Left            =   3000
      TabIndex        =   46
      Top             =   6000
      Width           =   2775
   End
   Begin VB.TextBox tag210_1 
      Height          =   315
      Left            =   3000
      TabIndex        =   10
      Top             =   360
      Width           =   2775
   End
   Begin VB.TextBox tag210_2 
      Height          =   315
      Left            =   3000
      TabIndex        =   9
      Top             =   720
      Width           =   2775
   End
   Begin VB.TextBox tag240_2 
      Height          =   315
      Left            =   3000
      TabIndex        =   8
      Top             =   2280
      Width           =   2775
   End
   Begin VB.TextBox tag240_1 
      Height          =   315
      Left            =   3000
      TabIndex        =   7
      Top             =   1920
      Width           =   2775
   End
   Begin VB.TextBox tag240_4 
      Height          =   315
      Left            =   3000
      TabIndex        =   6
      Top             =   3000
      Width           =   2775
   End
   Begin VB.TextBox tag240_3 
      Height          =   315
      Left            =   3000
      TabIndex        =   5
      Top             =   2640
      Width           =   2775
   End
   Begin VB.TextBox tag240_6 
      Height          =   315
      Left            =   3000
      TabIndex        =   4
      Top             =   3720
      Width           =   2775
   End
   Begin VB.TextBox tag240_5 
      Height          =   315
      Left            =   3000
      TabIndex        =   3
      Top             =   3360
      Width           =   2775
   End
   Begin VB.TextBox tag240_8 
      Height          =   315
      Left            =   3000
      TabIndex        =   2
      Top             =   4440
      Width           =   2775
   End
   Begin VB.TextBox tag240_7 
      Height          =   315
      Left            =   3000
      TabIndex        =   1
      Top             =   4080
      Width           =   2775
   End
   Begin VB.TextBox tag240_9 
      Height          =   315
      Left            =   3000
      TabIndex        =   0
      Top             =   4800
      Width           =   2775
   End
   Begin VB.Label Label1 
      Caption         =   "ชื่อตอน/ส่วนของชื่อเรื่องของงาน"
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
      Left            =   6000
      TabIndex        =   45
      Top             =   6360
      Width           =   3255
   End
   Begin VB.Label Label45 
      Caption         =   "245 ชื่อเรื่องและการแจ้งความรับผิดชอบ"
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
      Left            =   6000
      TabIndex        =   44
      Top             =   2520
      Width           =   4695
   End
   Begin VB.Label Label44 
      Caption         =   "246 ชื่อเรื่องที่แตกต่าง"
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
      Left            =   4680
      TabIndex        =   43
      Top             =   5280
      Width           =   2535
   End
   Begin VB.Label Label41 
      Caption         =   "242 ชื่อเรื่องที่แปลโดยหน่วยราชการ"
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
      Left            =   6000
      TabIndex        =   42
      Top             =   0
      Width           =   4335
   End
   Begin VB.Label Label39 
      Caption         =   "210 ชื่อเรื่องย่อ"
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
      Left            =   120
      TabIndex        =   41
      Top             =   0
      Width           =   3615
   End
   Begin VB.Label Label38 
      Caption         =   "240 ชื่อเรื่องแบบฉบับ"
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
      Left            =   120
      TabIndex        =   40
      Top             =   1560
      Width           =   3615
   End
   Begin VB.Label Label28 
      Caption         =   "ชื่อเรื่องย่อ"
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
      Left            =   120
      TabIndex        =   39
      Top             =   360
      Width           =   1695
   End
   Begin VB.Label Label69 
      Caption         =   "ข้อมูลส่วนขยายความชื่อเรื่อง"
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
      Left            =   120
      TabIndex        =   38
      Top             =   720
      Width           =   2655
   End
   Begin VB.Label Label70 
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
      Left            =   120
      TabIndex        =   37
      Top             =   2280
      Width           =   2535
   End
   Begin VB.Label Label71 
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
      Left            =   120
      TabIndex        =   36
      Top             =   1920
      Width           =   1695
   End
   Begin VB.Label Label72 
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
      Left            =   120
      TabIndex        =   35
      Top             =   3000
      Width           =   2055
   End
   Begin VB.Label Label73 
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
      Left            =   120
      TabIndex        =   34
      Top             =   2640
      Width           =   1695
   End
   Begin VB.Label Label74 
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
      Left            =   120
      TabIndex        =   33
      Top             =   3720
      Width           =   2055
   End
   Begin VB.Label Label75 
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
      Left            =   120
      TabIndex        =   32
      Top             =   3360
      Width           =   2895
   End
   Begin VB.Label Label76 
      Caption         =   "ชื่อตอน"
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
      Left            =   120
      TabIndex        =   31
      Top             =   4440
      Width           =   2535
   End
   Begin VB.Label Label77 
      Caption         =   "หมายเลขตอน"
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
      Left            =   120
      TabIndex        =   30
      Top             =   4080
      Width           =   2895
   End
   Begin VB.Label Label79 
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
      Left            =   120
      TabIndex        =   29
      Top             =   4800
      Width           =   1695
   End
   Begin VB.Label Label48 
      Caption         =   "ชื่อเรื่อง"
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
      Left            =   6000
      TabIndex        =   28
      Top             =   360
      Width           =   1695
   End
   Begin VB.Label Label98 
      Caption         =   "ชื่อตอน/ส่วนของงาน"
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
      Left            =   6000
      TabIndex        =   27
      Top             =   1800
      Width           =   2175
   End
   Begin VB.Label Label99 
      Caption         =   "เลขลำดับตอน/ส่วนของงาน"
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
      Left            =   6000
      TabIndex        =   26
      Top             =   1440
      Width           =   2415
   End
   Begin VB.Label Label100 
      Caption         =   "การแจ้งความรับผิดชอบ"
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
      Left            =   6000
      TabIndex        =   25
      Top             =   1080
      Width           =   2295
   End
   Begin VB.Label Label101 
      Caption         =   "ข้อมูลอื่นๆเกี่ยวกับชื่อเรื่อง"
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
      Left            =   6000
      TabIndex        =   24
      Top             =   720
      Width           =   2655
   End
   Begin VB.Label Label102 
      Caption         =   "รหัสภาษาของชื่อเรื่องที่แปล"
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
      Left            =   6000
      TabIndex        =   23
      Top             =   2160
      Width           =   2775
   End
   Begin VB.Label Label103 
      Caption         =   "ชื่อเรื่องจริง"
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
      Left            =   6000
      TabIndex        =   22
      Top             =   2880
      Width           =   1695
   End
   Begin VB.Label Label104 
      Caption         =   "ชื่อตอน/ส่วนของชื่อเรื่อง"
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
      Left            =   6000
      TabIndex        =   21
      Top             =   4320
      Width           =   2175
   End
   Begin VB.Label Label105 
      Caption         =   "หมายเลขตอน/ส่วนของชื่อเรื่อง"
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
      Left            =   6000
      TabIndex        =   20
      Top             =   3960
      Width           =   2775
   End
   Begin VB.Label Label106 
      Caption         =   "แจ้งความรับผิดชอบของงานแรก"
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
      Left            =   6000
      TabIndex        =   19
      Top             =   3600
      Width           =   4695
   End
   Begin VB.Label Label107 
      Caption         =   "ข้อมูลอื่นๆเกื่ยวกับชื่อเรื่อง"
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
      Left            =   6000
      TabIndex        =   18
      Top             =   3240
      Width           =   2415
   End
   Begin VB.Label Label108 
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
      Left            =   6000
      TabIndex        =   17
      Top             =   4680
      Width           =   1695
   End
   Begin VB.Line Line1 
      X1              =   480
      X2              =   4440
      Y1              =   5400
      Y2              =   5400
   End
   Begin VB.Line Line2 
      X1              =   7320
      X2              =   11280
      Y1              =   5400
      Y2              =   5400
   End
   Begin VB.Label Label110 
      Caption         =   "ชื่อเรื่อง"
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
      Left            =   120
      TabIndex        =   16
      Top             =   5640
      Width           =   1695
   End
   Begin VB.Label Label111 
      Caption         =   "ข้อมูลอื่นๆเกี่ยวกับชื่อเรื่อง"
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
      Left            =   120
      TabIndex        =   15
      Top             =   6000
      Width           =   2655
   End
   Begin VB.Label Label112 
      Caption         =   "การระบุเลขประจำฉบับ"
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
      Left            =   120
      TabIndex        =   14
      Top             =   6360
      Width           =   3495
   End
   Begin VB.Label Label113 
      Caption         =   "หมายเลขตอน/ส่วนของชื่อเรื่อง"
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
      Left            =   6000
      TabIndex        =   13
      Top             =   6000
      Width           =   2895
   End
   Begin VB.Label Label114 
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
      Left            =   120
      TabIndex        =   12
      Top             =   6720
      Width           =   1695
   End
   Begin VB.Label Label115 
      Caption         =   "ลักษณะของวัสดุ"
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
      Left            =   6000
      TabIndex        =   11
      Top             =   5640
      Width           =   1695
   End
End
Attribute VB_Name = "tag210"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
tag250.Show
End Sub

Private Sub Command2_Click()
tag100.Show
End Sub

Private Sub tag210_q_Click()
mainmenu.quitting
End Sub

Private Sub tag210_s_Click()
mainmenu.saving
End Sub

