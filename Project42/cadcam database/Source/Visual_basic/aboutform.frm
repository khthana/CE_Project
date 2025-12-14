VERSION 5.00
Begin VB.Form aboutform 
   BackColor       =   &H80000004&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "About"
   ClientHeight    =   4440
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4950
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4440
   ScaleWidth      =   4950
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command1 
      Caption         =   "Exit about"
      Height          =   375
      Left            =   1920
      TabIndex        =   6
      Top             =   3840
      Width           =   1215
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      Caption         =   "King Mongkut  Institute  of Technology  Ladkrabang"
      Height          =   375
      Left            =   600
      TabIndex        =   5
      Top             =   3360
      Width           =   3735
   End
   Begin VB.Label Label5 
      Alignment       =   2  'Center
      Caption         =   "ภาควิชา  วิศวกรรมคอมพิวเตอร์  คณะวิศวกรรมศาสตร์"
      Height          =   495
      Left            =   600
      TabIndex        =   4
      Top             =   2760
      Width           =   3735
   End
   Begin VB.Label Label4 
      Caption         =   "นางสาวทอรุ้ง  กลิ่นศรีสุข"
      Height          =   375
      Left            =   1800
      TabIndex        =   3
      Top             =   2280
      Width           =   1815
   End
   Begin VB.Label Label3 
      Caption         =   "ผู้จัดทำ :      นายปรีชา  ชิณราด"
      Height          =   255
      Left            =   960
      TabIndex        =   2
      Top             =   1920
      Width           =   3255
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      Caption         =   "อาจารย์ที่ปรึกษา  :  รศ.ดร. ศุภมิตร จิตตะยโศธร"
      Height          =   255
      Left            =   600
      TabIndex        =   1
      Top             =   1320
      Width           =   3855
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H80000004&
      Caption         =   "Logic Simulator"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   1080
      TabIndex        =   0
      Top             =   360
      Width           =   2775
   End
End
Attribute VB_Name = "aboutform"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
    aboutform.Hide
End Sub

Private Sub Form_Load()
    aboutform.Left = (Screen.Width - aboutform.Width) / 2
    aboutform.Top = (Screen.Height - aboutform.Height) / 2
End Sub

