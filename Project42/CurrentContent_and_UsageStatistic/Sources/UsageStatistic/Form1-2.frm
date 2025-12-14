VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   5370
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7575
   LinkTopic       =   "Form1"
   ScaleHeight     =   5370
   ScaleWidth      =   7575
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.CommandButton Command5 
      Caption         =   "ออกจากโปรแกรม"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   8040
      TabIndex        =   4
      Top             =   3360
      Width           =   2295
   End
   Begin VB.CommandButton Command4 
      Caption         =   "แสดงรายงาน"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   4800
      TabIndex        =   3
      Top             =   3360
      Width           =   2895
   End
   Begin VB.CommandButton Command3 
      Caption         =   "สถิติวารสาร  และ ติดต่อฮาร์ดแวร์"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   1680
      TabIndex        =   2
      Top             =   3360
      Width           =   2775
   End
   Begin VB.CommandButton Command2 
      Caption         =   "วารสารฉบับปัจจุบัน"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Left            =   6480
      TabIndex        =   1
      Top             =   1320
      Width           =   3615
   End
   Begin VB.CommandButton Command1 
      Caption         =   "รายการบรรณานุกรมวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1695
      Index           =   0
      Left            =   2520
      TabIndex        =   0
      Top             =   1320
      Width           =   3495
   End
   Begin VB.Frame Frame1 
      Caption         =   "ระบบจัดเก็บสถิติวารสาร"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   24
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   5175
      Left            =   1320
      TabIndex        =   5
      Top             =   480
      Width           =   9615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command1_Click(Index As Integer)
form2.Show
Form1.Hide
End Sub

Private Sub Command2_Click()
Form3.Show
Form1.Hide
End Sub

Private Sub Command3_Click()
Form4.Show
Form1.Hide
End Sub

Private Sub Command4_Click()
Form5.Show
Form1.Hide
End Sub

Private Sub Command5_Click()
Unload Me
End Sub

