VERSION 5.00
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Digital Library"
   ClientHeight    =   3600
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5760
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3600
   ScaleWidth      =   5760
   StartUpPosition =   1  'CenterOwner
   Begin VB.Frame Frame1 
      Height          =   3735
      Left            =   0
      TabIndex        =   0
      Top             =   -120
      Width           =   5775
      Begin VB.Frame Frame4 
         Height          =   975
         Left            =   3480
         TabIndex        =   3
         Top             =   2520
         Width           =   2055
         Begin VB.CommandButton btnExit 
            Caption         =   "ออกจากโปรแกรม"
            Height          =   375
            Left            =   240
            TabIndex        =   7
            Top             =   360
            Width           =   1575
         End
      End
      Begin VB.Frame Frame3 
         Height          =   2175
         Left            =   3480
         TabIndex        =   2
         Top             =   240
         Width           =   2055
         Begin VB.CommandButton btnPaper 
            Caption         =   "บทความ"
            Height          =   375
            Left            =   240
            TabIndex        =   6
            Top             =   1560
            Width           =   1575
         End
         Begin VB.CommandButton btnJournal 
            Caption         =   "วารสาร"
            Height          =   375
            Left            =   240
            TabIndex        =   5
            Top             =   960
            Width           =   1575
         End
         Begin VB.CommandButton btnIssn 
            Caption         =   "ISSN"
            Height          =   375
            Left            =   240
            TabIndex        =   4
            Top             =   360
            Width           =   1575
         End
      End
      Begin VB.Frame Frame2 
         Height          =   3255
         Left            =   240
         TabIndex        =   1
         Top             =   240
         Width           =   3015
         Begin VB.Label Label1 
            AutoSize        =   -1  'True
            BackStyle       =   0  'Transparent
            Caption         =   "Electronic Journal"
            BeginProperty Font 
               Name            =   "MS Sans Serif"
               Size            =   14.25
               Charset         =   222
               Weight          =   700
               Underline       =   0   'False
               Italic          =   0   'False
               Strikethrough   =   0   'False
            EndProperty
            ForeColor       =   &H00FF0000&
            Height          =   360
            Left            =   240
            TabIndex        =   8
            Top             =   1440
            Width           =   2550
         End
         Begin VB.Image Image1 
            Height          =   2850
            Left            =   120
            Stretch         =   -1  'True
            Top             =   240
            Width           =   2730
         End
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub btnExit_Click()

    End
    
End Sub

Private Sub btnIssn_Click()

    frmIssn.Show vbModal, frmMain
    
End Sub

Private Sub btnJournal_Click()

    frmJournal.Show vbModal, frmMain
    
End Sub

Private Sub btnPaper_Click()

    frmPaper.Show vbModal, frmMain
    
End Sub

Private Sub Form_Load()
    
    frmMain.Icon = LoadPicture(App.Path & "\Icon.ico")
    Image1.Picture = LoadPicture(App.Path & "\Title.jpg")
    
End Sub

Private Sub Form_Unload(Cancel As Integer)

    Call btnExit_Click
    
End Sub
