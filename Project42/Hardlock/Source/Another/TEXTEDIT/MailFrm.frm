VERSION 5.00
Begin VB.Form MailFrm 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "E-Mail Message"
   ClientHeight    =   4095
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   4575
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4095
   ScaleWidth      =   4575
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton CancelC 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   3120
      TabIndex        =   6
      Top             =   3720
      Width           =   1335
   End
   Begin VB.CommandButton ResetC 
      Caption         =   "Reset"
      Height          =   255
      Left            =   1680
      TabIndex        =   5
      Top             =   3720
      Width           =   1335
   End
   Begin VB.CommandButton SendC 
      Caption         =   "Send"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   3720
      Width           =   1455
   End
   Begin VB.TextBox DataT 
      Height          =   2295
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   1320
      Width           =   4335
   End
   Begin VB.TextBox FromT 
      Height          =   285
      Left            =   120
      TabIndex        =   2
      Text            =   "From"
      Top             =   480
      Width           =   4335
   End
   Begin VB.TextBox ToT 
      Height          =   285
      Left            =   120
      TabIndex        =   1
      Text            =   "To"
      Top             =   120
      Width           =   4335
   End
   Begin VB.TextBox SubjectT 
      Height          =   285
      Left            =   120
      TabIndex        =   0
      Text            =   "Subject"
      Top             =   960
      Width           =   4335
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   4440
      Y1              =   840
      Y2              =   840
   End
End
Attribute VB_Name = "MailFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command2_Click()

End Sub
