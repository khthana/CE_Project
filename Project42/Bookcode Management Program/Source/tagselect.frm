VERSION 5.00
Begin VB.Form tagselect 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Select  the  TAG"
   ClientHeight    =   360
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11955
   ControlBox      =   0   'False
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Moveable        =   0   'False
   ScaleHeight     =   360
   ScaleWidth      =   11955
   ShowInTaskbar   =   0   'False
   Begin VB.CommandButton Command10 
      Caption         =   "TAG800-850"
      Height          =   375
      Left            =   10800
      TabIndex        =   9
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command9 
      Caption         =   "TAG700-740"
      Height          =   375
      Left            =   9600
      TabIndex        =   8
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command8 
      Caption         =   "TAG600-651"
      Height          =   375
      Left            =   8400
      TabIndex        =   7
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command7 
      Caption         =   "TAG500-586"
      Height          =   375
      Left            =   7200
      TabIndex        =   6
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command6 
      Caption         =   "TAG250-490"
      Height          =   375
      Left            =   6000
      TabIndex        =   5
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command5 
      Caption         =   "TAG210-246"
      Height          =   375
      Left            =   4800
      TabIndex        =   4
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command4 
      Caption         =   "TAG100-130"
      Height          =   375
      Left            =   3600
      TabIndex        =   3
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command3 
      Caption         =   "TAG090-099"
      Height          =   375
      Left            =   2400
      TabIndex        =   2
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command2 
      Caption         =   "TAG020-022"
      Height          =   375
      Left            =   1200
      TabIndex        =   1
      Top             =   0
      Width           =   1200
   End
   Begin VB.CommandButton Command1 
      Caption         =   "TAG008"
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   1200
   End
End
Attribute VB_Name = "tagselect"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
tag008.Show
End Sub



Private Sub Command2_Click()
tag020.Show
End Sub

Private Sub Command3_Click()
tag090.Show
End Sub

Private Sub Command4_Click()
tag100.Show
End Sub

Private Sub Command5_Click()
tag210.Show
End Sub

Private Sub Command6_Click()
tag250.Show
End Sub

Private Sub Command7_Click()
tag500.Show
End Sub

Private Sub Command8_Click()
tag600.Show
End Sub

Private Sub Command9_Click()
tag700.Show
End Sub
Private Sub Command10_Click()
tag800.Show
End Sub
