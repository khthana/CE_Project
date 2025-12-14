VERSION 5.00
Begin VB.Form OSFrm 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Other Settings"
   ClientHeight    =   1575
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   4215
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1575
   ScaleWidth      =   4215
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton ExitCmd 
      Caption         =   "OK"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1200
      Width           =   3975
   End
   Begin VB.ComboBox Combo2 
      Height          =   315
      Left            =   3480
      Style           =   2  'Dropdown List
      TabIndex        =   5
      Top             =   840
      Width           =   615
   End
   Begin VB.ComboBox Combo1 
      Height          =   315
      Left            =   3480
      Style           =   2  'Dropdown List
      TabIndex        =   4
      Top             =   480
      Width           =   615
   End
   Begin VB.CheckBox Check1 
      Caption         =   "Yes"
      Height          =   255
      Left            =   3480
      TabIndex        =   3
      Top             =   120
      Width           =   615
   End
   Begin VB.Line Line1 
      X1              =   3360
      X2              =   3360
      Y1              =   120
      Y2              =   1080
   End
   Begin VB.Label Label3 
      Caption         =   "Backwards Echo on Echo Text:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   3135
   End
   Begin VB.Label Label2 
      Caption         =   "Amount of Extra Characters on Double Text:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   840
      Width           =   3135
   End
   Begin VB.Label Label1 
      Caption         =   "Amount of Spaces on Space Text:"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   480
      Width           =   3135
   End
End
Attribute VB_Name = "OSFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub ExitCmd_Click()
If Check1.Value = 1 Then
EchoBack = True
Else
EchoBack = False
End If
AmSpace = Combo1.Text
AmDouble = Combo2.Text
TUFrm.SOS
TUFrm.Enabled = True
TUFrm.SetFocus
OSFrm.Hide
End Sub

Private Sub Form_Load()
Dim i As Integer
Ontop Me
If EchoBack = True Then
Check1.Value = 1
Else
Check1.Value = 0
End If
For i = 1 To 100
Combo1.AddItem i
Combo2.AddItem i
Next i
Combo1.Text = AmSpace
Combo2.Text = AmDouble
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
ExitCmd_Click
End Sub
