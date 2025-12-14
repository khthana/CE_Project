VERSION 5.00
Begin VB.Form Author_code 
   BackColor       =   &H0080C0FF&
   Caption         =   "Authorcode_Menu"
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
      BackColor       =   &H0080C0FF&
      Caption         =   "MENU AUTHOR CODE PROGRAM "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   8175
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   11535
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
         Left            =   3600
         TabIndex        =   4
         Top             =   5400
         Width           =   4815
      End
      Begin VB.CommandButton Command3 
         Caption         =   "แสดงฐานข้อมูลเลขผู้แต่งหนังสือ"
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
         Left            =   3600
         TabIndex        =   3
         Top             =   4080
         Width           =   4815
      End
      Begin VB.CommandButton Command2 
         Caption         =   "    โปรแกรมจัดการเลขผู้แต่งหนังสือ (อังกฤษ)"
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
         Left            =   3600
         TabIndex        =   2
         Top             =   2760
         Width           =   4815
      End
      Begin VB.CommandButton Command1 
         Caption         =   "โปรแกรมจัดการเลขผู้แต่งหนังสือ (ไทย)"
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
         Left            =   3600
         TabIndex        =   1
         Top             =   1440
         Width           =   4815
      End
   End
End
Attribute VB_Name = "Author_code"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
frmThaiAuthor.Show
End Sub

Private Sub Command2_Click()
frmEngAuthor.Show
End Sub

Private Sub Command3_Click()
Authorcode_show.Show
End Sub

Private Sub Command4_Click()
Unload Me
End Sub
