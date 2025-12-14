VERSION 5.00
Begin VB.Form PU 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Prediction Utilities"
   ClientHeight    =   4335
   ClientLeft      =   45
   ClientTop       =   285
   ClientWidth     =   8535
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4335
   ScaleWidth      =   8535
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton ExitCmd 
      Caption         =   "Exit"
      Height          =   255
      Left            =   120
      TabIndex        =   24
      Top             =   3960
      Width           =   8295
   End
   Begin VB.Frame Love 
      Caption         =   "Love"
      Height          =   1815
      Left            =   120
      TabIndex        =   16
      Top             =   120
      Width           =   4095
      Begin VB.TextBox Love1 
         Height          =   285
         Left            =   120
         MaxLength       =   30
         MultiLine       =   -1  'True
         TabIndex        =   19
         Top             =   240
         Width           =   1335
      End
      Begin VB.TextBox Love2 
         Height          =   285
         Left            =   2160
         MaxLength       =   30
         MultiLine       =   -1  'True
         TabIndex        =   18
         Top             =   240
         Width           =   1335
      End
      Begin VB.CommandButton LoveC 
         Caption         =   "Activate"
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   600
         Width           =   3855
      End
      Begin VB.Label Label1 
         Caption         =   "Loves"
         Height          =   255
         Left            =   1580
         TabIndex        =   23
         Top             =   240
         Width           =   495
      End
      Begin VB.Label LoveP 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "0%"
         Height          =   255
         Left            =   3600
         TabIndex        =   22
         Top             =   240
         Width           =   375
      End
      Begin VB.Label Label4 
         Caption         =   "Rating:"
         Height          =   255
         Left            =   120
         TabIndex        =   21
         Top             =   1080
         Width           =   615
      End
      Begin VB.Label LoveR 
         Alignment       =   2  'Center
         Caption         =   "N/A"
         Height          =   255
         Left            =   720
         TabIndex        =   20
         Top             =   1080
         Width           =   3255
      End
      Begin VB.Line Line1 
         X1              =   120
         X2              =   3960
         Y1              =   960
         Y2              =   960
      End
      Begin VB.Shape LoveG1 
         Height          =   255
         Left            =   120
         Top             =   1440
         Width           =   3855
      End
      Begin VB.Shape LoveG2 
         BackColor       =   &H00FF0000&
         BackStyle       =   1  'Opaque
         BorderStyle     =   0  'Transparent
         Height          =   240
         Left            =   120
         Top             =   1455
         Width           =   15
      End
      Begin VB.Line Line2 
         X1              =   120
         X2              =   120
         Y1              =   1440
         Y2              =   1680
      End
      Begin VB.Line Line3 
         X1              =   3960
         X2              =   3960
         Y1              =   1440
         Y2              =   1680
      End
   End
   Begin VB.Frame Ins 
      Caption         =   "Insanity"
      Height          =   1815
      Left            =   120
      TabIndex        =   8
      Top             =   2040
      Width           =   4095
      Begin VB.TextBox Ins1 
         Height          =   285
         Left            =   120
         MaxLength       =   30
         MultiLine       =   -1  'True
         TabIndex        =   10
         Top             =   240
         Width           =   1335
      End
      Begin VB.CommandButton InsC 
         Caption         =   "Activate"
         Height          =   255
         Left            =   120
         TabIndex        =   9
         Top             =   600
         Width           =   3855
      End
      Begin VB.Label Label2 
         Caption         =   "is"
         Height          =   255
         Left            =   1560
         TabIndex        =   15
         Top             =   240
         Width           =   135
      End
      Begin VB.Label InsP 
         Alignment       =   2  'Center
         BackStyle       =   0  'Transparent
         Caption         =   "0%"
         Height          =   255
         Left            =   1800
         TabIndex        =   14
         Top             =   240
         Width           =   375
      End
      Begin VB.Label Label3 
         Caption         =   "insane!"
         Height          =   255
         Left            =   2280
         TabIndex        =   13
         Top             =   240
         Width           =   495
      End
      Begin VB.Line Line4 
         X1              =   120
         X2              =   3960
         Y1              =   960
         Y2              =   960
      End
      Begin VB.Label Label6 
         Caption         =   "Rating:"
         Height          =   255
         Left            =   120
         TabIndex        =   12
         Top             =   1080
         Width           =   615
      End
      Begin VB.Label InsR 
         Alignment       =   2  'Center
         Caption         =   "N/A"
         Height          =   255
         Left            =   720
         TabIndex        =   11
         Top             =   1080
         Width           =   3255
      End
      Begin VB.Shape InsG1 
         Height          =   255
         Left            =   120
         Top             =   1440
         Width           =   3855
      End
      Begin VB.Shape InsG2 
         BackColor       =   &H00FF0000&
         BackStyle       =   1  'Opaque
         BorderStyle     =   0  'Transparent
         Height          =   240
         Left            =   120
         Top             =   1455
         Width           =   15
      End
      Begin VB.Line Line5 
         X1              =   120
         X2              =   120
         Y1              =   1440
         Y2              =   1680
      End
      Begin VB.Line Line6 
         X1              =   3960
         X2              =   3960
         Y1              =   1440
         Y2              =   1680
      End
   End
   Begin VB.Frame Ball 
      Caption         =   "Magic 8 Ball"
      Height          =   1815
      Left            =   4320
      TabIndex        =   4
      Top             =   120
      Width           =   4095
      Begin VB.TextBox BallQ 
         Height          =   525
         Left            =   120
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   7
         Text            =   "PU.frx":0000
         Top             =   240
         Width           =   3855
      End
      Begin VB.CommandButton BallC 
         Caption         =   "Activate"
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   840
         Width           =   3855
      End
      Begin VB.TextBox BallA 
         Height          =   285
         Left            =   120
         Locked          =   -1  'True
         TabIndex        =   5
         Text            =   "Answer"
         Top             =   1380
         Width           =   3855
      End
      Begin VB.Line Line7 
         X1              =   120
         X2              =   3960
         Y1              =   1200
         Y2              =   1200
      End
   End
   Begin VB.Frame FC 
      Caption         =   "Fortune Cookie"
      Height          =   1815
      Left            =   4320
      TabIndex        =   0
      Top             =   2040
      Width           =   4095
      Begin VB.CommandButton FCC 
         Caption         =   "Activate"
         Height          =   255
         Left            =   120
         TabIndex        =   3
         Top             =   600
         Width           =   3855
      End
      Begin VB.TextBox FC1 
         Height          =   615
         Left            =   120
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         TabIndex        =   2
         Top             =   1080
         Width           =   3855
      End
      Begin VB.TextBox NameF 
         Height          =   285
         Left            =   120
         MultiLine       =   -1  'True
         TabIndex        =   1
         Text            =   "PU.frx":0009
         Top             =   240
         Width           =   3855
      End
      Begin VB.Line Line8 
         X1              =   120
         X2              =   3960
         Y1              =   960
         Y2              =   960
      End
   End
End
Attribute VB_Name = "PU"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim FRndNum As Integer
Dim BRndNum As Integer
Dim LRndNum As Integer
Dim IRndNum As Integer

Private Sub BallC_Click()
Dim i As Integer
Dim BallN As Integer
On Error Resume Next
If BallQ.Text = "" Then
leave:
MsgBox "Please enter a question!", 48, "Error"
Exit Sub
ElseIf BallQ.Text = "Question" Then
GoTo leave
End If
For i = 1 To Len(BallQ.Text)
cur$ = Mid$(BallQ.Text, i, 1)
If cur$ = "d" Then
BallN = BallN + 3
ElseIf cur$ = "u" Then
BallN = BallN + 9
ElseIf cur$ = "i" Then
BallN = BallN + 2
ElseIf cur$ = "p" Then
BallN = BallN + 2
ElseIf cur$ = "D" Then
BallN = BallN + 3
ElseIf cur$ = "U" Then
BallN = BallN + 9
ElseIf cur$ = "I" Then
BallN = BallN + 2
ElseIf cur$ = "P" Then
BallN = BallN + 2
ElseIf cur$ = "t" Then
BallN = BallN - 4
ElseIf cur$ = "c" Then
BallN = BallN - 7
ElseIf cur$ = "m" Then
BallN = BallN - 5
ElseIf cur$ = "e" Then
BallN = BallN - 1
ElseIf cur$ = "T" Then
BallN = BallN - 4
ElseIf cur$ = "C" Then
BallN = BallN - 7
ElseIf cur$ = "M" Then
BallN = BallN - 5
ElseIf cur$ = "E" Then
BallN = BallN - 1
End If
Next i
BallN = BallN + BRndNum
Check:
If BallN < 0 Then
BallN = BallN + 10
GoTo Check
ElseIf BallN > 9 Then
BallN = BallN - 10
GoTo Check
End If
If BallN = 0 Then
BallA.Text = "Yes"
ElseIf BallN = 1 Then
BallA.Text = "No"
ElseIf BallN = 2 Then
BallA.Text = "Definitely"
ElseIf BallN = 3 Then
BallA.Text = "Doubtfully"
ElseIf BallN = 4 Then
BallA.Text = "My sources say 'Yes'"
ElseIf BallN = 5 Then
BallA.Text = "I don't know!"
ElseIf BallN = 6 Then
BallA.Text = "Of course not!"
ElseIf BallN = 7 Then
BallA.Text = "Maybe"
ElseIf BallN = 8 Then
BallA.Text = "Surely"
ElseIf BallN = 9 Then
BallA.Text = "No way"
End If
BallQ.SetFocus
End Sub

Private Sub BallQ_GotFocus()
BallQ.SelStart = 0
BallQ.SelLength = Len(BallQ.Text)
End Sub

Private Sub ExitCmd_Click()
TUFrm.Enabled = True
TUFrm.SetFocus
Hide
TUFrm.SetFocus
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
ExitCmd_Click
End Sub

Private Sub NameF_GotFocus()
NameF.SelStart = 0
NameF.SelLength = Len(NameF.Text)
End Sub

Private Sub BallQ_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn Then
KeyAscii = 0
BallC_Click
End If
End Sub

Private Sub NameF_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn Then
KeyAscii = 0
FCC_Click
End If
End Sub

Private Sub FCC_Click()
Dim FCN As Integer
On Error Resume Next
If NameF.Text = "" Or NameF.Text = "Name" Then
MsgBox "Please enter a name!", 48, "Error"
Exit Sub
End If
For i = 1 To Len(NameF.Text)
cur$ = Mid$(NameF.Text, i, 1)
If cur$ = "r" Then
FCN = FCN + 14
ElseIf cur$ = "y" Then
FCN = FCN + 8
ElseIf cur$ = "l" Then
FCN = FCN + 7
ElseIf cur$ = "a" Then
FCN = FCN + 13
ElseIf cur$ = "R" Then
FCN = FCN + 14
ElseIf cur$ = "Y" Then
FCN = FCN + 8
ElseIf cur$ = "L" Then
FCN = FCN + 7
ElseIf cur$ = "A" Then
FCN = FCN + 13
ElseIf cur$ = "b" Then
FCN = FCN - 2
ElseIf cur$ = "h" Then
FCN = FCN - 16
ElseIf cur$ = "t" Then
FCN = FCN - 21
ElseIf cur$ = "s" Then
FCN = FCN - 8
ElseIf cur$ = "B" Then
FCN = FCN - 2
ElseIf cur$ = "H" Then
FCN = FCN - 16
ElseIf cur$ = "T" Then
FCN = FCN - 21
ElseIf cur$ = "S" Then
FCN = FCN - 8
End If
Next i
FCN = FCN + FRndNum
Check:
If FCN < 0 Then
FCN = FCN + 25
GoTo Check
ElseIf FCN > 24 Then
FCN = FCN - 25
GoTo Check
End If
If FCN = 0 Then
FC1.Text = "Your doom is soon!"
ElseIf FCN = 1 Then
FC1.Text = "Investments made will help in the future"
ElseIf FCN = 2 Then
FC1.Text = "Help is the key to success"
ElseIf FCN = 3 Then
FC1.Text = "Your future is in peril"
ElseIf FCN = 4 Then
FC1.Text = "The first three letters in 'diet' are 'die'!"
ElseIf FCN = 5 Then
FC1.Text = "Life is short, live it while you can"
ElseIf FCN = 6 Then
FC1.Text = "Add some excitement into you're life"
ElseIf FCN = 7 Then
FC1.Text = "You're over the limit, cool down!"
ElseIf FCN = 8 Then
FC1.Text = "Bad things can happen"
ElseIf FCN = 9 Then
FC1.Text = "Good things are possible"
ElseIf FCN = 10 Then
FC1.Text = "There's a light at the end of the tunnel"
ElseIf FCN = 11 Then
FC1.Text = "The grass is always greener on the other side of the fence"
ElseIf FCN = 12 Then
FC1.Text = "Every cloud has a silver lining"
ElseIf FCN = 13 Then
FC1.Text = "Every story has a happy ending!"
ElseIf FCN = 14 Then
FC1.Text = "Your frog is not a prince"
ElseIf FCN = 15 Then
FC1.Text = "Think twice before you jump"
ElseIf FCN = 16 Then
FC1.Text = "You are a loser!!"
ElseIf FCN = 17 Then
FC1.Text = "Add balance to your life"
ElseIf FCN = 18 Then
FC1.Text = "Bad guys never win"
ElseIf FCN = 19 Then
FC1.Text = "Be true to yourself"
ElseIf FCN = 20 Then
FC1.Text = "Things are not always as they seem"
ElseIf FCN = 21 Then
FC1.Text = "Do something you've never done before"
ElseIf FCN = 22 Then
FC1.Text = "You're tastes are changing"
ElseIf FCN = 23 Then
FC1.Text = "Ignoring is not the answer"
ElseIf FCN = 24 Then
FC1.Text = "Go for it!"
End If
End Sub

Private Sub Form_Load()
Ontop Me
Randomize Timer
FRndNum = Int((24 - 0 + 1) * Rnd)
BRndNum = Int((9 - 0 + 1) * Rnd)
LRndNum = Int((25 - 0 + 1) * Rnd)
IRndNum = Int((25 - 0 + 1) * Rnd)
End Sub

Private Sub Ins1_GotFocus()
Ins1.SelStart = 0
Ins1.SelLength = Len(Ins1.Text)
End Sub

Private Sub Ins1_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn Then
KeyAscii = 0
InsC_Click
End If
End Sub

Private Sub InsC_Click()
Dim i As Integer
Dim InsN As Double
Dim curchr As String
On Error Resume Next
If Ins1.Text = "" Then
MsgBox "Please enter a name!", 48, "Error"
Exit Sub
End If
InsN = 0
For i = 1 To Len(Ins1.Text)
curchr$ = Mid$(Ins1.Text, i, 1)
If curchr$ = "y" Then
InsN = InsN + 5
ElseIf curchr$ = "e" Then
InsN = InsN + 18
ElseIf curchr$ = "w" Then
InsN = InsN + 23
ElseIf curchr$ = "c" Then
InsN = InsN + 1
ElseIf curchr$ = "Y" Then
InsN = InsN + 5
ElseIf curchr$ = "E" Then
InsN = InsN + 18
ElseIf curchr$ = "W" Then
InsN = InsN + 23
ElseIf curchr$ = "C" Then
InsN = InsN + 1
ElseIf curchr$ = "t" Then
InsN = InsN - 2
ElseIf curchr$ = "r" Then
InsN = InsN - 34
ElseIf curchr$ = "i" Then
InsN = InsN - 12
ElseIf curchr$ = "d" Then
InsN = InsN - 8
ElseIf curchr$ = "T" Then
InsN = InsN - 2
ElseIf curchr$ = "R" Then
InsN = InsN - 34
ElseIf curchr$ = "I" Then
InsN = InsN - 12
ElseIf curchr$ = "D" Then
InsN = InsN - 8
End If
Next i
InsN = InsN + IRndNum
checkup:
If InsN < 0 Then
InsN = InsN + 25
GoTo checkup
ElseIf InsN > 25 Then
InsN = InsN - 25
GoTo checkup
End If
InsN = InsN * 4
InsP.Caption = InsN & "%"
If InsN < 10 Then
InsR.Caption = "Very sane!"
ElseIf InsN < 20 Then
InsR.Caption = "Below Average"
ElseIf InsN < 30 Then
InsR.Caption = "Average"
ElseIf InsN < 40 Then
InsR.Caption = "Above Average"
ElseIf InsN < 50 Then
InsR.Caption = "Not all here.."
ElseIf InsN < 60 Then
InsR.Caption = "Really nuts"
ElseIf InsN < 70 Then
InsR.Caption = "Clinically crazy!"
ElseIf InsN < 80 Then
InsR.Caption = "Belongs in asylum"
ElseIf InsN < 90 Then
InsR.Caption = "No mind at all"
ElseIf InsN < 100 Then
InsR.Caption = "Crazy!"
Else
InsR.Caption = "COMPLETELY INSANE!!"
End If
InsG2.Width = (InsG1.Width / 100) * InsN
Ins1.SetFocus
End Sub

Private Sub Love1_GotFocus()
Love1.SelStart = 0
Love1.SelLength = Len(Love1.Text)
End Sub

Private Sub Love1_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn Then
KeyAscii = 0
Love2.SetFocus
End If
End Sub

Private Sub Love2_GotFocus()
Love2.SelStart = 0
Love2.SelLength = Len(Love2.Text)
End Sub

Private Sub Love2_KeyPress(KeyAscii As Integer)
If KeyAscii = vbKeyReturn Then
KeyAscii = 0
LoveC_Click
End If
End Sub

Private Sub LoveC_Click()
Dim i As Integer
Dim LoveN As Double
Dim cur As String
On Error Resume Next
If Love1.Text = "" Then
noname:
MsgBox "Please enter a name!", 48, "Error"
Exit Sub
ElseIf Love2.Text = "" Then
GoTo noname
End If
LoveN = 0
For i = 1 To Len(Love1.Text)
cur$ = Mid$(Love1.Text, i, 1)
If cur$ = "a" Then
LoveN = LoveN + 13
ElseIf cur$ = "t" Then
LoveN = LoveN + 19
ElseIf cur$ = "y" Then
LoveN = LoveN + 2
ElseIf cur$ = "g" Then
LoveN = LoveN + 21
ElseIf cur$ = "A" Then
LoveN = LoveN + 13
ElseIf cur$ = "T" Then
LoveN = LoveN + 19
ElseIf cur$ = "Y" Then
LoveN = LoveN + 2
ElseIf cur$ = "G" Then
LoveN = LoveN + 21
ElseIf cur$ = "u" Then
LoveN = LoveN - 4
ElseIf cur$ = "j" Then
LoveN = LoveN - 17
ElseIf cur$ = "b" Then
LoveN = LoveN - 35
ElseIf cur$ = "x" Then
LoveN = LoveN - 11
ElseIf cur$ = "U" Then
LoveN = LoveN - 4
ElseIf cur$ = "J" Then
LoveN = LoveN - 17
ElseIf cur$ = "B" Then
LoveN = LoveN - 35
ElseIf cur$ = "X" Then
LoveN = LoveN - 11
End If
Next i
For i = 1 To Len(Love2.Text)
cur$ = Mid$(Love2.Text, i, 1)
If cur$ = "b" Then
LoveN = LoveN + 13
ElseIf cur$ = "s" Then
LoveN = LoveN + 19
ElseIf cur$ = "r" Then
LoveN = LoveN + 2
ElseIf cur$ = "g" Then
LoveN = LoveN + 21
ElseIf cur$ = "B" Then
LoveN = LoveN + 2
ElseIf cur$ = "S" Then
LoveN = LoveN + 31
ElseIf cur$ = "R" Then
LoveN = LoveN + 7
ElseIf cur$ = "G" Then
LoveN = LoveN + 18
ElseIf cur$ = "i" Then
LoveN = LoveN - 4
ElseIf cur$ = "e" Then
LoveN = LoveN - 17
ElseIf cur$ = "h" Then
LoveN = LoveN - 35
ElseIf cur$ = "k" Then
LoveN = LoveN - 11
ElseIf cur$ = "I" Then
LoveN = LoveN - 13
ElseIf cur$ = "E" Then
LoveN = LoveN - 1
ElseIf cur$ = "H" Then
LoveN = LoveN - 4
ElseIf cur$ = "K" Then
LoveN = LoveN - 7
End If
Next i
LoveN = LoveN + LRndNum
Check:
If LoveN < 0 Then
LoveN = LoveN + 25
GoTo Check
ElseIf LoveN > 25 Then
LoveN = LoveN - 25
GoTo Check
End If
LoveN = LoveN * 4
LoveP.Caption = LoveN & "%"
If LoveN < 10 Then
LoveR.Caption = "HORRIBLE!"
ElseIf LoveN < 20 Then
LoveR.Caption = "In the pits"
ElseIf LoveN < 30 Then
LoveR.Caption = "No Love"
ElseIf LoveN < 40 Then
LoveR.Caption = "Bad"
ElseIf LoveN < 50 Then
LoveR.Caption = "Not enough.."
ElseIf LoveN < 60 Then
LoveR.Caption = "Below Average"
ElseIf LoveN < 70 Then
LoveR.Caption = "Average"
ElseIf LoveN < 80 Then
LoveR.Caption = "Above Average"
ElseIf LoveN < 90 Then
LoveR.Caption = "Getting good!"
ElseIf LoveN < 100 Then
LoveR.Caption = "Great relationship!"
Else
LoveR.Caption = "True love!"
End If
LoveG2.Width = (LoveG1.Width / 100) * LoveN
Love1.SetFocus
End Sub
