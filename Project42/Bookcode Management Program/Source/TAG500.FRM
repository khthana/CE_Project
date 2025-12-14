VERSION 5.00
Begin VB.Form tag500 
   Caption         =   "tag500"
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
      TabIndex        =   50
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
      TabIndex        =   49
      Top             =   7440
      Width           =   735
   End
   Begin VB.CommandButton tag500_s 
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
      TabIndex        =   48
      Top             =   7440
      Width           =   1455
   End
   Begin VB.CommandButton tag500_q 
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
      TabIndex        =   47
      Top             =   7440
      Width           =   1455
   End
   Begin VB.TextBox tag586_1 
      Height          =   315
      Left            =   8520
      TabIndex        =   46
      Top             =   5400
      Width           =   2775
   End
   Begin VB.TextBox tag546_1 
      Height          =   315
      Left            =   8520
      TabIndex        =   45
      Top             =   4440
      Width           =   2775
   End
   Begin VB.TextBox tag536_4 
      Height          =   315
      Left            =   8520
      TabIndex        =   44
      Top             =   3480
      Width           =   2775
   End
   Begin VB.TextBox tag536_3 
      Height          =   315
      Left            =   8520
      TabIndex        =   43
      Top             =   3120
      Width           =   2775
   End
   Begin VB.TextBox tag536_2 
      Height          =   315
      Left            =   8520
      TabIndex        =   42
      Top             =   2760
      Width           =   2775
   End
   Begin VB.TextBox tag536_1 
      Height          =   315
      Left            =   8520
      TabIndex        =   41
      Top             =   2400
      Width           =   2775
   End
   Begin VB.TextBox tag520_3 
      Height          =   315
      Left            =   8520
      TabIndex        =   40
      Top             =   1440
      Width           =   2775
   End
   Begin VB.TextBox tag520_2 
      Height          =   315
      Left            =   8520
      TabIndex        =   39
      Top             =   1080
      Width           =   2775
   End
   Begin VB.TextBox tag520_1 
      Height          =   315
      Left            =   8520
      TabIndex        =   38
      Top             =   720
      Width           =   2775
   End
   Begin VB.TextBox tag510_4 
      Height          =   315
      Left            =   2760
      TabIndex        =   37
      Top             =   6360
      Width           =   2775
   End
   Begin VB.TextBox tag510_3 
      Height          =   315
      Left            =   2760
      TabIndex        =   36
      Top             =   6000
      Width           =   2775
   End
   Begin VB.TextBox tag510_2 
      Height          =   315
      Left            =   2760
      TabIndex        =   35
      Top             =   5640
      Width           =   2775
   End
   Begin VB.TextBox tag510_1 
      Height          =   315
      Left            =   2760
      TabIndex        =   34
      Top             =   5280
      Width           =   2775
   End
   Begin VB.TextBox tag505_3 
      Height          =   315
      Left            =   2640
      TabIndex        =   33
      Top             =   4320
      Width           =   2775
   End
   Begin VB.TextBox tag505_2 
      Height          =   315
      Left            =   2640
      TabIndex        =   32
      Top             =   3960
      Width           =   2775
   End
   Begin VB.TextBox tag505_1 
      Height          =   315
      Left            =   2640
      TabIndex        =   31
      Top             =   3600
      Width           =   2775
   End
   Begin VB.TextBox tag502_1 
      Height          =   315
      Left            =   2640
      TabIndex        =   30
      Top             =   2640
      Width           =   2775
   End
   Begin VB.TextBox tag501_1 
      Height          =   315
      Left            =   2640
      TabIndex        =   29
      Top             =   1680
      Width           =   2775
   End
   Begin VB.TextBox tag500_1 
      Height          =   315
      Left            =   2640
      TabIndex        =   0
      Top             =   720
      Width           =   2775
   End
   Begin VB.Label Label26 
      Caption         =   "หมายเหตุภาษา"
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
      TabIndex        =   28
      Top             =   4440
      Width           =   2295
   End
   Begin VB.Label Label25 
      Caption         =   "หมายเหตุรางวัล"
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
      TabIndex        =   27
      Top             =   5400
      Width           =   2295
   End
   Begin VB.Label Label24 
      Caption         =   "หมายเลขโครงการ"
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
      TabIndex        =   26
      Top             =   3480
      Width           =   2295
   End
   Begin VB.Label Label23 
      Caption         =   "หมายเลขเอกสารหน่วยงาน"
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
      TabIndex        =   25
      Top             =   3120
      Width           =   2535
   End
   Begin VB.Label Label22 
      Caption         =   "หมายเลขหนังสือสัญญา"
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
      TabIndex        =   24
      Top             =   2760
      Width           =   2415
   End
   Begin VB.Label Label21 
      Caption         =   "หมายเหตุ"
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
      Top             =   2400
      Width           =   1695
   End
   Begin VB.Label Label20 
      Caption         =   "ระบุลักษณะวัสดุ"
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
      Top             =   1440
      Width           =   2295
   End
   Begin VB.Label Label19 
      Caption         =   "การขยายเรื่องย่อ"
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
      Top             =   1080
      Width           =   2415
   End
   Begin VB.Label Label18 
      Caption         =   "เรื่องย่อ"
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
      Top             =   720
      Width           =   1695
   End
   Begin VB.Label Label17 
      Caption         =   "เลขมาตรฐาน ISSN"
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
      TabIndex        =   19
      Top             =   6360
      Width           =   2175
   End
   Begin VB.Label Label16 
      Caption         =   "ตำแหน่งของแหล่งข้อมูล"
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
      TabIndex        =   18
      Top             =   6000
      Width           =   2295
   End
   Begin VB.Label Label15 
      Caption         =   "วันที่บันทึกครั้งที่ของชื่อชุด"
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
      TabIndex        =   17
      Top             =   5640
      Width           =   2415
   End
   Begin VB.Label Label14 
      Caption         =   "ชื่อแหล่งข้อมูล"
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
      Top             =   5280
      Width           =   1695
   End
   Begin VB.Label Label13 
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
      Left            =   240
      TabIndex        =   15
      Top             =   4320
      Width           =   2295
   End
   Begin VB.Label Label12 
      Caption         =   "ข้อมูลอื่นๆ"
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
      Top             =   3960
      Width           =   1695
   End
   Begin VB.Label Label11 
      Caption         =   "หมายเหตุสารบัญ"
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
      Top             =   3600
      Width           =   1695
   End
   Begin VB.Label Label10 
      Caption         =   "หมายเหตุวิทยานิพนธ์"
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
      Top             =   2640
      Width           =   2175
   End
   Begin VB.Label Label9 
      Caption         =   "หมายเหตุ ""พร้อมด้วย"""
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
      Top             =   1680
      Width           =   2295
   End
   Begin VB.Label Label8 
      Caption         =   "586 หมายเหตุรางวัล"
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
      TabIndex        =   10
      Top             =   5040
      Width           =   3615
   End
   Begin VB.Label Label7 
      Caption         =   "546 หมายเหตุภาษา"
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
      TabIndex        =   9
      Top             =   4080
      Width           =   3615
   End
   Begin VB.Label Label6 
      Caption         =   "536 หมายเหตุชื่อทุนที่ให้การสนับสนุน"
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
      TabIndex        =   8
      Top             =   2040
      Width           =   4455
   End
   Begin VB.Label Label5 
      Caption         =   "520 หมายเหตุสรุป"
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
      TabIndex        =   7
      Top             =   360
      Width           =   3615
   End
   Begin VB.Label Label4 
      Caption         =   "510 หมายเหตุอ้างอิง"
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
      TabIndex        =   6
      Top             =   4920
      Width           =   3615
   End
   Begin VB.Label Label3 
      Caption         =   "505 หมายเหตุสารบัญ"
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
      TabIndex        =   5
      Top             =   3240
      Width           =   3615
   End
   Begin VB.Label Label2 
      Caption         =   "502 หมายเหตุวิทยานิพนธ์"
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
      TabIndex        =   4
      Top             =   2280
      Width           =   3615
   End
   Begin VB.Label Label1 
      Caption         =   "501 หมายเหตุพร้อมด้วย"
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
      TabIndex        =   3
      Top             =   1320
      Width           =   3615
   End
   Begin VB.Label Label43 
      Caption         =   "500 หมายเหตุ"
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
      TabIndex        =   2
      Top             =   360
      Width           =   3615
   End
   Begin VB.Label Label71 
      Caption         =   "หมายเหตุทั่วไป"
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
      TabIndex        =   1
      Top             =   720
      Width           =   1695
   End
End
Attribute VB_Name = "tag500"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
tag600.Show
End Sub

Private Sub Command2_Click()
tag250.Show
End Sub

Private Sub tag500_q_Click()
mainmenu.quitting
End Sub

Private Sub tag500_s_Click()
mainmenu.saving
End Sub
