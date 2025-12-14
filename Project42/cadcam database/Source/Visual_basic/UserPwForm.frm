VERSION 5.00
Begin VB.Form UserPwForm 
   Caption         =   "Log On Database"
   ClientHeight    =   1425
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   1425
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Cancel 
      Cancel          =   -1  'True
      Caption         =   "Cancel"
      Height          =   375
      Left            =   3120
      TabIndex        =   5
      Top             =   720
      Width           =   1455
   End
   Begin VB.CommandButton OK 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   375
      Left            =   3120
      TabIndex        =   4
      Top             =   240
      Width           =   1455
   End
   Begin VB.TextBox TPassword 
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   1080
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   720
      Width           =   1815
   End
   Begin VB.TextBox TUser 
      Height          =   375
      Left            =   1080
      TabIndex        =   2
      Text            =   "informix"
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label LPassword 
      Caption         =   "Password:"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   975
   End
   Begin VB.Label LUser 
      Caption         =   "User:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   240
      Width           =   855
   End
End
Attribute VB_Name = "UserPwForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Cancel_Click()
    Main.Environment = False
    Unload UserPwForm
End Sub

Private Sub OK_Click()
    Main.User = TUser.Text
    If Len(TPassword.Text) <> 0 Then
        Main.Password = TPassword.Text
    Else
        Main.Password = "none"
    End If
    Unload UserPwForm
End Sub


