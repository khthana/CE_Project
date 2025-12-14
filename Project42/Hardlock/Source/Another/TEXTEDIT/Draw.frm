VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Draw 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Draw!"
   ClientHeight    =   4695
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   7200
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4695
   ScaleWidth      =   7200
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame1 
      Caption         =   "Options"
      Height          =   4455
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   1575
      Begin VB.CommandButton ExitCmd 
         Caption         =   "Exit"
         Height          =   375
         Left            =   120
         TabIndex        =   16
         Top             =   3960
         Width           =   1335
      End
      Begin VB.HScrollBar Scroll1 
         Height          =   255
         Left            =   240
         Max             =   255
         TabIndex        =   10
         Top             =   2400
         Width           =   1215
      End
      Begin VB.HScrollBar Scroll2 
         Height          =   255
         Left            =   240
         Max             =   255
         TabIndex        =   9
         Top             =   2760
         Width           =   1215
      End
      Begin VB.HScrollBar Scroll3 
         Height          =   255
         Left            =   240
         Max             =   255
         TabIndex        =   8
         Top             =   3120
         Width           =   1215
      End
      Begin VB.OptionButton Option1 
         Caption         =   "Cool Dots"
         Height          =   255
         Left            =   120
         TabIndex        =   7
         Top             =   240
         Value           =   -1  'True
         Width           =   1335
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Plain Lines"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   480
         Width           =   1335
      End
      Begin VB.OptionButton Option3 
         Caption         =   "Squares"
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   720
         Width           =   1335
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Wierd"
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   1520
         Width           =   1335
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Clear"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   1920
         Width           =   1335
      End
      Begin VB.CheckBox Check1 
         Caption         =   "Solid"
         Enabled         =   0   'False
         Height          =   255
         Left            =   240
         TabIndex        =   2
         Top             =   960
         Width           =   735
      End
      Begin MSComctlLib.Slider Size 
         Height          =   255
         Left            =   600
         TabIndex        =   1
         Top             =   1200
         Width           =   855
         _ExtentX        =   1508
         _ExtentY        =   450
         _Version        =   393216
         Min             =   10
         Max             =   100
         SelStart        =   10
         TickFrequency   =   10
         Value           =   10
      End
      Begin VB.Label Label1 
         BackColor       =   &H00C0C0C0&
         Caption         =   "R"
         ForeColor       =   &H000000FF&
         Height          =   255
         Left            =   120
         TabIndex        =   15
         Top             =   2400
         Width           =   135
      End
      Begin VB.Label Label2 
         Caption         =   "G"
         ForeColor       =   &H0000FF00&
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   2760
         Width           =   135
      End
      Begin VB.Label Label3 
         Caption         =   "B"
         ForeColor       =   &H00FF0000&
         Height          =   255
         Left            =   120
         TabIndex        =   13
         Top             =   3120
         Width           =   135
      End
      Begin VB.Label Label4 
         Caption         =   "Color:"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   3600
         Width           =   495
      End
      Begin VB.Shape Shape1 
         BackColor       =   &H00000000&
         BackStyle       =   1  'Opaque
         Height          =   255
         Left            =   600
         Top             =   3600
         Width           =   855
      End
      Begin VB.Label Label5 
         Caption         =   "Size:"
         Height          =   255
         Left            =   240
         TabIndex        =   11
         Top             =   1240
         Width           =   375
      End
   End
End
Attribute VB_Name = "Draw"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim hi As Boolean
Dim xl As Double
Dim yl As Double

Private Sub Command1_Click()
Draw.Cls
End Sub

Private Sub ExitCmd_Click()
TUFrm.Enabled = True
TUFrm.SetFocus
Hide
TUFrm.SetFocus
End Sub

Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
If Option1.Value = True Then
If Button = 1 Then
If hi = False Then
Draw.Line (X - 6, Y - 6)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), BF
hi = True
Else
Draw.Line (X - 6, Y - 6)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), BF
End If
End If
ElseIf Option2.Value = True Then
If Button = 1 Then
If hi = False Then
Draw.Line (X, Y)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value)
hi = True
xl = X
yl = Y
Else
Draw.Line (xl, yl)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value)
xl = X
yl = Y
End If
End If
ElseIf Option3.Value = True Then
If Button = 1 Then
If hi = False Then
If Check1.Value = 0 Then
Draw.Line (X - Size.Value, Y - Size.Value)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), B
Else
Draw.Line (X - Size.Value, Y - Size.Value)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), BF
End If
hi = True
Else
If Check1.Value = 0 Then
Draw.Line (X - Size.Value, Y - Size.Value)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), B
Else
Draw.Line (X - Size.Value, Y - Size.Value)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), BF
End If
End If
End If
ElseIf Option4.Value = True Then
If Button = 1 Then
If hi = False Then
Draw.Line (X, Y)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), B
hi = True
xl = X
yl = Y
Else
Draw.Line (xl, yl)-(X, Y), RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value), B
xl = X
yl = Y
End If
End If
End If
End Sub

Private Sub Form_Load()
Ontop Me
hi = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
ExitCmd_Click
End Sub

Private Sub Option1_Click()
Check1.Enabled = False
Size.Enabled = False
End Sub

Private Sub Option2_Click()
Check1.Enabled = False
Size.Enabled = False
End Sub

Private Sub Option3_Click()
Check1.Enabled = True
Size.Enabled = True
End Sub

Private Sub Option4_Click()
Check1.Enabled = False
Size.Enabled = False
End Sub

Private Sub Scroll1_Change()
Shape1.BackColor = RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value)
End Sub

Private Sub Scroll1_Scroll()
Scroll1_Change
End Sub
Private Sub Scroll2_Change()
Shape1.BackColor = RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value)
End Sub

Private Sub Scroll2_Scroll()
Scroll2_Change
End Sub
Private Sub Scroll3_Change()
Shape1.BackColor = RGB(Scroll1.Value, Scroll2.Value, Scroll3.Value)
End Sub

Private Sub Scroll3_Scroll()
Scroll3_Change
End Sub


