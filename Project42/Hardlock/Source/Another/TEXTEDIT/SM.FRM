VERSION 5.00
Begin VB.Form SM 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Slot Machine"
   ClientHeight    =   2055
   ClientLeft      =   45
   ClientTop       =   570
   ClientWidth     =   4575
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2055
   ScaleWidth      =   4575
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton ExitCmd 
      Caption         =   "Exit"
      Height          =   255
      Left            =   120
      TabIndex        =   20
      Top             =   1680
      Width           =   4335
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   0
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   6
      Top             =   120
      Width           =   255
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   1
      Left            =   480
      Locked          =   -1  'True
      TabIndex        =   5
      Top             =   120
      Width           =   255
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   2
      Left            =   840
      Locked          =   -1  'True
      TabIndex        =   4
      Top             =   120
      Width           =   255
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   3
      Left            =   1200
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   120
      Width           =   255
   End
   Begin VB.TextBox Text1 
      Height          =   285
      Index           =   4
      Left            =   1560
      Locked          =   -1  'True
      TabIndex        =   2
      Top             =   120
      Width           =   255
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Start"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   600
      Width           =   1695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Stop"
      Enabled         =   0   'False
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   840
      Width           =   1695
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Index           =   0
      Interval        =   500
      Left            =   0
      Top             =   1200
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Index           =   1
      Interval        =   400
      Left            =   360
      Top             =   1200
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Index           =   2
      Interval        =   300
      Left            =   720
      Top             =   1200
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Index           =   3
      Interval        =   200
      Left            =   1080
      Top             =   1200
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Index           =   4
      Interval        =   100
      Left            =   1440
      Top             =   1200
   End
   Begin VB.Timer Timer2 
      Interval        =   1
      Left            =   3240
      Top             =   360
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   1920
      Y1              =   480
      Y2              =   480
   End
   Begin VB.Line Line2 
      X1              =   120
      X2              =   1920
      Y1              =   1200
      Y2              =   1200
   End
   Begin VB.Label Label1 
      Caption         =   "Cash:"
      Height          =   255
      Left            =   120
      TabIndex        =   19
      Top             =   1320
      Width           =   495
   End
   Begin VB.Label Label2 
      Height          =   255
      Left            =   720
      TabIndex        =   18
      Top             =   1320
      Width           =   1095
   End
   Begin VB.Line Line3 
      X1              =   1920
      X2              =   1920
      Y1              =   120
      Y2              =   1560
   End
   Begin VB.Label Label3 
      Caption         =   "11111 = +$100"
      Height          =   255
      Left            =   2040
      TabIndex        =   17
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label4 
      Caption         =   "22222 = +$200"
      Height          =   255
      Left            =   2040
      TabIndex        =   16
      Top             =   360
      Width           =   1095
   End
   Begin VB.Label Label5 
      Caption         =   "33333 = +$300"
      Height          =   255
      Left            =   2040
      TabIndex        =   15
      Top             =   600
      Width           =   1095
   End
   Begin VB.Label Label6 
      Caption         =   "44444 = +$400"
      Height          =   255
      Left            =   2040
      TabIndex        =   14
      Top             =   840
      Width           =   1095
   End
   Begin VB.Label Label7 
      Caption         =   "55555 = +$500"
      Height          =   255
      Left            =   2040
      TabIndex        =   13
      Top             =   1080
      Width           =   1095
   End
   Begin VB.Label Label8 
      Caption         =   "12345 = +$1000"
      Height          =   255
      Left            =   3240
      TabIndex        =   12
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label9 
      Caption         =   "Cost to Play One Round:  -$10"
      Height          =   255
      Left            =   2220
      TabIndex        =   11
      Top             =   1320
      Width           =   2175
   End
   Begin VB.Label Label10 
      Caption         =   "54321 = +$1000"
      Height          =   255
      Left            =   3240
      TabIndex        =   10
      Top             =   360
      Width           =   1215
   End
   Begin VB.Label Label11 
      Caption         =   "15243 = +$1500"
      Height          =   255
      Left            =   3240
      TabIndex        =   9
      Top             =   600
      Width           =   1215
   End
   Begin VB.Label Label12 
      Caption         =   "53142 = +$1500"
      Height          =   255
      Left            =   3240
      TabIndex        =   8
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Label13 
      Caption         =   "42513 = +$2000"
      Height          =   255
      Left            =   3240
      TabIndex        =   7
      Top             =   1080
      Width           =   1215
   End
   Begin VB.Menu DiffMenu 
      Caption         =   "&Difficulty"
      Begin VB.Menu Diff1 
         Caption         =   "Easy"
      End
      Begin VB.Menu Diff2 
         Caption         =   "Medium"
         Checked         =   -1  'True
      End
      Begin VB.Menu Diff3 
         Caption         =   "Hard"
      End
   End
End
Attribute VB_Name = "SM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Cash As Long
Dim Pos As Integer
Dim DiffVal As Integer

Public Sub DiffSet()
Dim i As Integer
If 1 > Cash - 5 Then
  If DiffVal = 1 Then
  MsgBox "You're out of money!!  I will give you a little extra to keep this game going.", 48, "Error"
  Cash = Cash + 100
  ElseIf DiffVal = 2 Then
  MsgBox "You're out of money!!  I will give you a little extra to keep this game going.", 48, "Error"
  Cash = Cash + 50
  Else
  MsgBox "You're out of money!!  I will give you a little extra to keep this game going.", 48, "Error"
  Cash = Cash + 20
  End If
End If
If DiffVal = 1 Then
Cash = Cash - 5
ElseIf DiffVal = 2 Then
Cash = Cash - 10
Else
Cash = Cash - 20
End If
Label2.Caption = "$" & Cash
If DiffVal = 1 Then
Timer1(0).Interval = 500
Timer1(1).Interval = 400
Timer1(2).Interval = 300
Timer1(3).Interval = 200
Timer1(4).Interval = 100
ElseIf DiffVal = 2 Then
Timer1(0).Interval = 400
Timer1(1).Interval = 350
Timer1(2).Interval = 200
Timer1(3).Interval = 125
Timer1(4).Interval = 50
Else
Timer1(0).Interval = 1
Timer1(1).Interval = 1
Timer1(2).Interval = 1
Timer1(3).Interval = 1
Timer1(4).Interval = 1
End If
For i = 0 To 4
Timer1(i).Enabled = True
Next i
Command1.Enabled = False
Command2.Enabled = True
Command2.SetFocus
End Sub

Public Sub RegSave()
Call SaveSetting("TU", "Settings", "SM", Cash)
End Sub

Public Sub RegLoad()
Cash = GetSetting("TU", "Settings", "SM", 200)
End Sub

Public Sub Award()
Command1.Enabled = True
Command2.Enabled = False
If Text1(0).Text = "1" Then
If Text1(1).Text = "1" Then
If Text1(2).Text = "1" Then
If Text1(3).Text = "1" Then
If Text1(4).Text = "1" Then
Cash = Cash + 100
End If
End If
End If
End If
End If
If Text1(0).Text = "2" Then
If Text1(1).Text = "2" Then
If Text1(2).Text = "2" Then
If Text1(3).Text = "2" Then
If Text1(4).Text = "2" Then
Cash = Cash + 200
End If
End If
End If
End If
End If
If Text1(0).Text = "3" Then
If Text1(1).Text = "3" Then
If Text1(2).Text = "3" Then
If Text1(3).Text = "3" Then
If Text1(4).Text = "3" Then
Cash = Cash + 300
End If
End If
End If
End If
End If
If Text1(0).Text = "4" Then
If Text1(1).Text = "4" Then
If Text1(2).Text = "4" Then
If Text1(3).Text = "4" Then
If Text1(4).Text = "4" Then
Cash = Cash + 400
End If
End If
End If
End If
End If
If Text1(0).Text = "5" Then
If Text1(1).Text = "5" Then
If Text1(2).Text = "5" Then
If Text1(3).Text = "5" Then
If Text1(4).Text = "5" Then
Cash = Cash + 500
End If
End If
End If
End If
End If
If Text1(0).Text = "1" Then
If Text1(1).Text = "2" Then
If Text1(2).Text = "3" Then
If Text1(3).Text = "4" Then
If Text1(4).Text = "5" Then
Cash = Cash + 1000
End If
End If
End If
End If
End If
If Text1(0).Text = "5" Then
If Text1(1).Text = "4" Then
If Text1(2).Text = "3" Then
If Text1(3).Text = "2" Then
If Text1(4).Text = "1" Then
Cash = Cash + 1000
End If
End If
End If
End If
End If
If Text1(0).Text = "1" Then
If Text1(1).Text = "5" Then
If Text1(2).Text = "2" Then
If Text1(3).Text = "4" Then
If Text1(4).Text = "3" Then
Cash = Cash + 1500
End If
End If
End If
End If
End If
If Text1(0).Text = "5" Then
If Text1(1).Text = "3" Then
If Text1(2).Text = "1" Then
If Text1(3).Text = "4" Then
If Text1(4).Text = "2" Then
Cash = Cash + 1500
End If
End If
End If
End If
End If
If Text1(0).Text = "4" Then
If Text1(1).Text = "2" Then
If Text1(2).Text = "5" Then
If Text1(3).Text = "1" Then
If Text1(4).Text = "3" Then
Cash = Cash + 2000
End If
End If
End If
End If
End If
If Cash > 9999999 Then
Cash = 9999999
End If
RegSave
Label2.Caption = "$" & Cash
End Sub

Private Sub Command1_Click()
DiffSet
End Sub

Private Sub Command2_Click()
If Pos = 0 Then
Timer1(Pos).Enabled = False
Pos = 1
ElseIf Pos = 1 Then
Timer1(Pos).Enabled = False
Pos = 2
ElseIf Pos = 2 Then
Timer1(Pos).Enabled = False
Pos = 3
ElseIf Pos = 3 Then
Timer1(Pos).Enabled = False
Pos = 4
ElseIf Pos = 4 Then
Timer1(Pos).Enabled = False
Award
Command1.SetFocus
Pos = 0
End If
End Sub

Private Sub Diff1_Click()
Diff1.Checked = True
Diff2.Checked = False
Diff3.Checked = False
DiffVal = 1
Label9.Caption = "Cost to Play One Round:  -$5"
End Sub

Private Sub Diff2_Click()
Diff1.Checked = False
Diff2.Checked = True
Diff3.Checked = False
DiffVal = 2
Label9.Caption = "Cost to Play One Round:  -$10"
End Sub

Private Sub Diff3_Click()
Diff1.Checked = False
Diff2.Checked = False
Diff3.Checked = True
DiffVal = 3
Label9.Caption = "Cost to Play One Round:  -$20"
End Sub

Private Sub ExitCmd_Click()
TUFrm.Enabled = True
TUFrm.SetFocus
Hide
TUFrm.SetFocus
End Sub

Private Sub Form_Load()
Ontop Me
DiffVal = 2
RegLoad
Label2.Caption = "$" & Cash
Pos = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
ExitCmd_Click
End Sub

Private Sub Timer1_Timer(Index As Integer)
If Text1(Index).Text = "" Then
Text1(Index).Text = "1"
ElseIf Text1(Index).Text = "1" Then
Text1(Index).Text = "2"
ElseIf Text1(Index).Text = "2" Then
Text1(Index).Text = "3"
ElseIf Text1(Index).Text = "3" Then
Text1(Index).Text = "4"
ElseIf Text1(Index).Text = "4" Then
Text1(Index).Text = "5"
ElseIf Text1(Index).Text = "5" Then
Text1(Index).Text = "1"
End If
End Sub

Private Sub Timer2_Timer()
Command1.SetFocus
Timer2.Enabled = False
End Sub
