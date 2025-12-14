VERSION 5.00
Begin VB.Form tag008 
   Caption         =   "tag008"
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
   Begin VB.CommandButton tag008_q 
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
      TabIndex        =   27
      Top             =   7440
      Width           =   1455
   End
   Begin VB.CommandButton tag008_s 
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
      TabIndex        =   26
      Top             =   7440
      Width           =   1455
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
      Left            =   6720
      TabIndex        =   25
      Top             =   7440
      Width           =   1455
   End
   Begin VB.TextBox tag008_1 
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "a"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1054
         SubFormatType   =   0
      EndProperty
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   24
      Top             =   1200
      Width           =   255
   End
   Begin VB.TextBox tag008_2 
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   23
      Top             =   1605
      Width           =   255
   End
   Begin VB.TextBox tag008_3 
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   22
      Top             =   1995
      Width           =   255
   End
   Begin VB.TextBox tag008_4 
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   21
      Top             =   2400
      Width           =   255
   End
   Begin VB.TextBox tag008_6 
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   20
      Top             =   3195
      Width           =   255
   End
   Begin VB.TextBox tag008_7 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "yy/MM/dd"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1054
         SubFormatType   =   3
      EndProperty
      Height          =   375
      Left            =   4920
      MaxLength       =   8
      TabIndex        =   19
      Top             =   3600
      Width           =   855
   End
   Begin VB.TextBox tag008_9 
      Height          =   375
      Left            =   4920
      MaxLength       =   8
      TabIndex        =   18
      Text            =   "date"
      Top             =   4395
      Width           =   855
   End
   Begin VB.TextBox tag008_10 
      Height          =   375
      Left            =   4920
      MaxLength       =   8
      TabIndex        =   17
      Text            =   "date"
      Top             =   4800
      Width           =   855
   End
   Begin VB.TextBox tag008_11 
      Height          =   375
      Left            =   4920
      MaxLength       =   3
      TabIndex        =   16
      Top             =   5205
      Width           =   495
   End
   Begin VB.TextBox tag008_12 
      Height          =   375
      Left            =   4920
      MaxLength       =   4
      TabIndex        =   15
      Top             =   5595
      Width           =   630
   End
   Begin VB.TextBox tag008_25 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   14
      Top             =   5595
      Width           =   255
   End
   Begin VB.TextBox tag008_24 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   13
      Top             =   5205
      Width           =   255
   End
   Begin VB.TextBox tag008_22 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   12
      Top             =   4395
      Width           =   255
   End
   Begin VB.TextBox tag008_21 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   11
      Top             =   4005
      Width           =   255
   End
   Begin VB.TextBox tag008_20 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   10
      Top             =   3600
      Width           =   255
   End
   Begin VB.TextBox tag008_19 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   9
      Top             =   3195
      Width           =   255
   End
   Begin VB.TextBox tag008_18 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   8
      Top             =   2805
      Width           =   255
   End
   Begin VB.TextBox tag008_17 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   7
      Top             =   2400
      Width           =   255
   End
   Begin VB.TextBox tag008_16 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   6
      Top             =   1995
      Width           =   255
   End
   Begin VB.TextBox tag008_15 
      Height          =   375
      Left            =   10920
      MaxLength       =   4
      TabIndex        =   5
      Top             =   1605
      Width           =   630
   End
   Begin VB.TextBox tag008_14 
      Height          =   375
      Left            =   10920
      MaxLength       =   1
      TabIndex        =   4
      Top             =   1200
      Width           =   255
   End
   Begin VB.TextBox tag008_5 
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   3
      Top             =   2760
      Width           =   255
   End
   Begin VB.TextBox tag008_8 
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   2
      Top             =   4005
      Width           =   255
   End
   Begin VB.TextBox tag008_13 
      Height          =   375
      Left            =   4920
      MaxLength       =   1
      TabIndex        =   1
      Top             =   6000
      Width           =   255
   End
   Begin VB.ComboBox tag008_23 
      Height          =   330
      ItemData        =   "tag008.frx":0000
      Left            =   10920
      List            =   "tag008.frx":000A
      TabIndex        =   0
      Text            =   "THA"
      Top             =   4830
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "01 สถานะระเบียน  (REC  STAT)"
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
      TabIndex        =   52
      Top             =   1200
      Width           =   3615
   End
   Begin VB.Label Label2 
      Caption         =   "02 ประเภทของระเบียน  (REC  TYPE)"
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
      TabIndex        =   51
      Top             =   1605
      Width           =   3615
   End
   Begin VB.Label Label3 
      Caption         =   "03 ระดับบรรณานุกรม  (BIB  LEVL)"
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
      TabIndex        =   50
      Top             =   2040
      Width           =   3615
   End
   Begin VB.Label Label4 
      Caption         =   "04 (ENC  LEVL)"
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
      TabIndex        =   49
      Top             =   2400
      Width           =   3615
   End
   Begin VB.Label Label5 
      Caption         =   "05 (CAT  FORM)"
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
      TabIndex        =   48
      Top             =   2805
      Width           =   3615
   End
   Begin VB.Label Label6 
      Caption         =   "06 (ARC  CTRL)"
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
      TabIndex        =   47
      Top             =   3195
      Width           =   3615
   End
   Begin VB.Label Label7 
      Caption         =   "07 วันที่สร้างระเบียน  (DATE  ENT)"
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
      TabIndex        =   46
      Top             =   3600
      Width           =   3615
   End
   Begin VB.Label Label8 
      Caption         =   "08 ประเภทปีพิมพ์/สถานะการพิมพ์  (DATE  TYPE)  "
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
      TabIndex        =   45
      Top             =   4005
      Width           =   4935
   End
   Begin VB.Label Label9 
      Caption         =   "09 ปีพิมพ์ 1/ปีเริ่มพิมพ์  (DATE  ONE)"
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
      TabIndex        =   44
      Top             =   4395
      Width           =   4095
   End
   Begin VB.Label Label10 
      Caption         =   "10 ปีพิมพ์ 2/ปีเริ่มพิมพ์  (DATE  TWO)"
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
      TabIndex        =   43
      Top             =   4800
      Width           =   4095
   End
   Begin VB.Label Label11 
      Caption         =   "11 สถานที่พิมพ์  (COUNTRY)"
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
      TabIndex        =   42
      Top             =   5205
      Width           =   3735
   End
   Begin VB.Label Label12 
      Caption         =   "12 ภาพประกอบ  (ILLUSTR)"
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
      TabIndex        =   41
      Top             =   5595
      Width           =   3615
   End
   Begin VB.Label Label13 
      Caption         =   "13 ระดับผู้ใช้  (AUDIENCE)"
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
      TabIndex        =   40
      Top             =   6000
      Width           =   3615
   End
   Begin VB.Label Label16 
      Caption         =   "25 แหล่งรายการข้อมูล  ( CAT  SRCE )"
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
      Left            =   6120
      TabIndex        =   39
      Top             =   5595
      Width           =   3855
   End
   Begin VB.Label Label17 
      Caption         =   "24 ระเบียนที่ดัดแปลงแก้ไข  ( MODIFIED )"
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
      Left            =   6120
      TabIndex        =   38
      Top             =   5205
      Width           =   4455
   End
   Begin VB.Label Label18 
      Caption         =   "23 ภาษา  ( LANGUAGE )"
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
      Left            =   6120
      TabIndex        =   37
      Top             =   4800
      Width           =   4095
   End
   Begin VB.Label Label19 
      Caption         =   "22 ชีวประวัติ  ( BIOG )"
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
      Left            =   6120
      TabIndex        =   36
      Top             =   4395
      Width           =   4095
   End
   Begin VB.Label Label20 
      Caption         =   "21 นวนิยาย  ( FICTION )   "
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
      Left            =   6120
      TabIndex        =   35
      Top             =   4005
      Width           =   4935
   End
   Begin VB.Label Label21 
      Caption         =   "20 เว้นว่าง  ( UNDEFINE )"
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
      Left            =   6120
      TabIndex        =   34
      Top             =   3600
      Width           =   3615
   End
   Begin VB.Label Label22 
      Caption         =   "19 ดรรขนี  ( INDEX )"
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
      Left            =   6120
      TabIndex        =   33
      Top             =   3195
      Width           =   3615
   End
   Begin VB.Label Label23 
      Caption         =   "18 หนังสือที่ระลึก  ( FESTSCH )"
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
      Left            =   6120
      TabIndex        =   32
      Top             =   2805
      Width           =   3615
   End
   Begin VB.Label Label24 
      Caption         =   "17 สิ่งพิมพ์จากการประชุม  ( CONF  PUB )"
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
      Left            =   6120
      TabIndex        =   31
      Top             =   2400
      Width           =   4215
   End
   Begin VB.Label Label25 
      Caption         =   "16 สิ่งพิมพ์รัฐบาล ( GOVT  PUB )  "
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
      Left            =   6120
      TabIndex        =   30
      Top             =   1995
      Width           =   3615
   End
   Begin VB.Label Label27 
      Caption         =   "14 รูปแบบของสิ่งพิมพ์  ( FORM  ITM )"
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
      Left            =   6120
      TabIndex        =   29
      Top             =   1200
      Width           =   3735
   End
   Begin VB.Label Label26 
      Caption         =   "15 ลักษณะเนื้อหา  ( CONTENTS )"
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
      Left            =   6120
      TabIndex        =   28
      Top             =   1605
      Width           =   3615
   End
End
Attribute VB_Name = "tag008"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub tag008_122_Change()

End Sub

Private Sub Command3_Click()
tag020.Show
End Sub

Private Sub tag008_q_Click()
mainmenu.quitting
End Sub

Private Sub tag008_s_Click()
mainmenu.saving
End Sub

Private Sub Form_Load()
' กำหนดค่าเริ่มต้นให้กับข้อมูลเรื่องวันที่
'*******************************
tempyy = Year(Date)
tempyy = tempyy - 2000
If tempyy <= 9 Then yy = "0" + CStr(tempyy)
mm = Month(Date)
dd = Day(Date)
tag008_7.Text = yy & "/" & mm & "/" & dd
'*******************************
End Sub

