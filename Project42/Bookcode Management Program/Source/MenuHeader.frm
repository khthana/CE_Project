VERSION 5.00
Begin VB.Form MenuHeader 
   BackColor       =   &H00C0FFC0&
   Caption         =   "Form1"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0FFC0&
      Caption         =   "MENU HEADER CODE PROGRAM"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   8175
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   11415
      Begin VB.CommandButton Command4 
         Caption         =   "จบการทำงานของโปรแกรม"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   2400
         TabIndex        =   4
         Top             =   5280
         Width           =   6495
      End
      Begin VB.CommandButton Command3 
         Caption         =   "โปรแกรมช่วยค้นหาข้อมูลเลขหัวเรื่องจาก WEB "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   2400
         TabIndex        =   3
         Top             =   3960
         Width           =   6495
      End
      Begin VB.CommandButton Command2 
         Caption         =   "โปรแกรมช่วยค้นหาข้อมูลเลขหัวเรื่องจากฐานข้อมูล"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   2400
         TabIndex        =   2
         Top             =   2640
         Width           =   6495
      End
      Begin VB.CommandButton Command1 
         Caption         =   "โปรแกรมการกรอกข้อมูลเลขหัวเรื่อง"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   975
         Left            =   2400
         TabIndex        =   1
         Top             =   1320
         Width           =   6495
      End
   End
End
Attribute VB_Name = "MenuHeader"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
HeaderMain.Show
End Sub

Private Sub Command2_Click()
SearchHeader_DB.Show
End Sub

Private Sub Command3_Click()
SearchList.Show
End Sub

Private Sub Command4_Click()
Unload Me
End Sub
