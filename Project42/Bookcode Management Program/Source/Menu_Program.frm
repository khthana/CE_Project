VERSION 5.00
Begin VB.Form Menu_Program 
   BackColor       =   &H00FF8080&
   Caption         =   "Manu_Program"
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
      BackColor       =   &H00FF8080&
      Caption         =   "MENU  PROGRAM"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   8535
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   11775
      Begin VB.CommandButton cmdCloseMain 
         Caption         =   "ออกจากการทำงานของโปรแกรม"
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
         Left            =   3000
         TabIndex        =   4
         Top             =   5400
         Width           =   5895
      End
      Begin VB.CommandButton cmdMARCsheet 
         Caption         =   "โปรแกรมการจัดการข้อมูลตามระบบMARC format"
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
         Left            =   3000
         TabIndex        =   3
         Top             =   4200
         Width           =   5895
      End
      Begin VB.CommandButton cmdHeader 
         Caption         =   "โปรแกรมการจัดการเลขหัวเรื่องหนังสือ"
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
         Left            =   3000
         TabIndex        =   2
         Top             =   3000
         Width           =   5895
      End
      Begin VB.CommandButton cmdAuthor 
         Caption         =   "โปรแกรมการจัดการเลขผู้แต่งหนังสือ"
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
         Left            =   3000
         MaskColor       =   &H8000000F&
         TabIndex        =   1
         Top             =   1800
         Width           =   5895
      End
   End
End
Attribute VB_Name = "Menu_Program"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdAuthor_Click()
Author_code.Show
End Sub

Private Sub cmdCloseMain_Click()
Unload Me
End Sub

Private Sub cmdHeader_Click()
MenuHeader.Show
End Sub

Private Sub cmdMARCsheet_Click()
mainmenu.Show
End Sub
