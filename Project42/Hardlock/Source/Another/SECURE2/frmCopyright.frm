VERSION 5.00
Begin VB.Form frmCopyright 
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   4065
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7065
   Icon            =   "frmCopyright.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4065
   ScaleWidth      =   7065
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fraMainFrame 
      Height          =   4590
      Left            =   0
      TabIndex        =   0
      Top             =   -120
      Width           =   7380
      Begin VB.PictureBox picLogo 
         Height          =   2385
         Left            =   510
         Picture         =   "frmCopyright.frx":0442
         ScaleHeight     =   2325
         ScaleWidth      =   1755
         TabIndex        =   1
         Top             =   855
         Width           =   1815
      End
      Begin VB.Label Label3 
         Caption         =   "for Producer"
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   20.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   2760
         TabIndex        =   5
         Top             =   2040
         Width           =   2415
      End
      Begin VB.Label lblProductName 
         AutoSize        =   -1  'True
         Caption         =   "Hardlock"
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   36
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   900
         Left            =   2670
         TabIndex        =   4
         Tag             =   "Product"
         Top             =   1200
         Width           =   1890
      End
      Begin VB.Label lblCompanyProduct 
         AutoSize        =   -1  'True
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   18
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   2505
         TabIndex        =   3
         Tag             =   "CompanyProduct"
         Top             =   765
         Width           =   120
      End
      Begin VB.Label lblVersion 
         Alignment       =   1  'Right Justify
         AutoSize        =   -1  'True
         Caption         =   "Version 1.0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   300
         Index           =   0
         Left            =   5625
         TabIndex        =   2
         Tag             =   "Version"
         Top             =   2760
         Width           =   1380
      End
   End
End
Attribute VB_Name = "frmCopyright"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Form_Load()
    frmMain.Show
    frmCopyright.Hide
End Sub

Private Sub SysInfo1_ConfigChangeCancelled()

End Sub

Private Sub MSComm1_OnComm()

End Sub
