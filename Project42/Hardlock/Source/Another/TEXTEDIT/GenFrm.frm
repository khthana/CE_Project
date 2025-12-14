VERSION 5.00
Begin VB.Form GenFrm 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Generate New Key File"
   ClientHeight    =   2895
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   3015
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2895
   ScaleWidth      =   3015
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Cancel 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   120
      TabIndex        =   11
      Top             =   2520
      Width           =   2775
   End
   Begin VB.CommandButton OK 
      Caption         =   "OK"
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   2160
      Width           =   2775
   End
   Begin VB.ComboBox LTK 
      Height          =   315
      Left            =   1680
      TabIndex        =   7
      Text            =   "50"
      Top             =   1200
      Width           =   1215
   End
   Begin VB.ComboBox SKC 
      Height          =   315
      Left            =   1680
      TabIndex        =   5
      Text            =   "100"
      Top             =   480
      Width           =   1215
   End
   Begin VB.ComboBox TKC 
      Height          =   315
      Left            =   1680
      TabIndex        =   4
      Text            =   "100"
      Top             =   840
      Width           =   1215
   End
   Begin VB.ComboBox NKC 
      Height          =   315
      Left            =   1680
      TabIndex        =   0
      Text            =   "100"
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label SecLev 
      Alignment       =   2  'Center
      Caption         =   "5000"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   1800
      Width           =   2775
   End
   Begin VB.Label Label5 
      Caption         =   "Security Level (scale from 1 to 100000)"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   1560
      Width           =   2775
   End
   Begin VB.Label Label4 
      Caption         =   "Len of Text Keys:"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1200
      Width           =   1455
   End
   Begin VB.Label Label3 
      Caption         =   "# of Text Keys:"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   840
      Width           =   1455
   End
   Begin VB.Label Label2 
      Caption         =   "# of Sub Keys:"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "# of Normal Keys:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   1455
   End
End
Attribute VB_Name = "GenFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub Calc()
Dim Am As Long
Am = ((Val(NKC.Text) + Val(SKC.Text) + (Val(TKC.Text) * 5)) * Val(LTK.Text)) / 3
SecLev.Caption = Am
End Sub

Private Sub Cancel_Click()
SetFrm.Show
GenFrm.Hide
End Sub

Private Sub Form_Load()
Dim i As Integer
Ontop Me
For i = 1 To 1000
NKC.AddItem i
SKC.AddItem i
Next i
For i = 1 To 100
TKC.AddItem i
LTK.AddItem i
Next i
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
Cancel_Click
End Sub

Private Sub LTK_Change()
Dim i As Integer
On Error GoTo error
If LTK.Text > 100 Then
LTK.Text = 100
ElseIf LTK.Text < 1 Then
LTK.Text = 1
End If
TKC.Clear
For i = 1 To LTK.Text * 2
TKC.AddItem i
Next i
TKC.Text = LTK.Text
Calc
Exit Sub
error:
LTK.Text = 50
Calc
End Sub

Private Sub LTK_Click()
LTK_Change
End Sub

Private Sub NKC_Change()
On Error GoTo error
If NKC.Text > 1000 Then
NKC.Text = 1000
ElseIf NKC.Text < 1 Then
NKC.Text = 1
End If
Calc
Exit Sub
error:
NKC.Text = 100
Calc
End Sub

Private Sub NKC_Click()
NKC_Change
End Sub

Private Sub OK_Click()
Dim CurPos As Integer
Dim ValN As Integer
Dim i As Integer
SetFrm.NK.Clear
SetFrm.SK.Clear
SetFrm.TK.Clear
Randomize Timer
For i = 0 To Val(NKC.Text) - 1
SetFrm.NK.AddItem Int((255 - 1 + 1) * Rnd + 1)
Next i
For i = 0 To Val(SKC.Text) - 1
SetFrm.SK.AddItem Int((255 - 1 + 1) * Rnd + 1)
Next i
i = 0
CurPos = 0
Start:
  If i = (Val(TKC.Text) - 1) Then
  ValN = Val(LTK.Text)
  SetFrm.TK.AddItem MakeRndChrString(ValN, True, True, False, False)
  i = i + 1
  Else
  ValN = Val(LTK.Text) + CurPos
  SetFrm.TK.AddItem MakeRndChrString(ValN, True, True, False, False)
  ValN = Val(LTK.Text) - CurPos
  SetFrm.TK.AddItem MakeRndChrString(ValN, True, True, False, False)
  i = i + 2
  End If
If CurPos = Val(LTK.Text) - 1 Then
CurPos = 0
Else
CurPos = CurPos + 1
End If
If i < Val(TKC.Text) Then
GoTo Start
End If
Cancel_Click
End Sub

Private Sub SKC_Change()
On Error GoTo error
If SKC.Text > 1000 Then
SKC.Text = 1000
ElseIf SKC.Text < 1 Then
SKC.Text = 1
End If
Calc
Exit Sub
error:
SKC.Text = 100
Calc
End Sub

Private Sub SKC_Click()
SKC_Change
End Sub

Private Sub TKC_Change()
On Error GoTo error
If TKC.Text > 1000 Then
TKC.Text = 1000
ElseIf TKC.Text < 1 Then
TKC.Text = 1
End If
Calc
Exit Sub
error:
TKC.Text = 100
Calc
End Sub

Private Sub TKC_Click()
TKC_Change
End Sub

Function MakeRndChrString(Length As Integer, Numbers As Boolean, Letters As Boolean, Symbols As Boolean, Other As Boolean) As String
'This will make a random string (good for passwords)
On Error GoTo error
Dim chrasc As Integer
Dim i As Integer
Dim endstr As String
Randomize Timer
For i = 1 To Length
Start:
chrasc = Int((255 - 1 + 1) * Rnd + 1)
  If chrasc < 34 Then
    If Other = False Then
    GoTo Start
    End If
  ElseIf chrasc > 33 And chrasc < 49 Then
    If Symbols = False Then
    GoTo Start
    End If
  ElseIf chrasc > 48 And chrasc < 58 Then
    If Numbers = False Then
    GoTo Start
    End If
  ElseIf chrasc > 57 And chrasc < 65 Then
    If Symbols = False Then
    GoTo Start
    End If
  ElseIf chrasc > 64 And chrasc < 91 Then
    If Letters = False Then
    GoTo Start
    End If
  ElseIf chrasc > 90 And chrasc < 97 Then
    If Symbols = False Then
    GoTo Start
    End If
  ElseIf chrasc > 96 And chrasc < 123 Then
    If Letters = False Then
    GoTo Start
    End If
  ElseIf chrasc > 122 And chrasc < 127 Then
    If Symbols = False Then
    GoTo Start
    End If
  Else
    If Other = False Then
    GoTo Start
    End If
  End If
endstr$ = endstr$ & Chr$(chrasc)
Next i
MakeRndChrString = endstr$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function
