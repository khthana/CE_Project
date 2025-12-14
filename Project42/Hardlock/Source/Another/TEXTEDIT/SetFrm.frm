VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form SetFrm 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Settings"
   ClientHeight    =   4095
   ClientLeft      =   45
   ClientTop       =   570
   ClientWidth     =   4575
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4095
   ScaleWidth      =   4575
   StartUpPosition =   2  'CenterScreen
   Begin VB.ListBox OpenL 
      Height          =   255
      Left            =   0
      TabIndex        =   12
      Top             =   480
      Visible         =   0   'False
      Width           =   135
   End
   Begin MSComDlg.CommonDialog CMDialog 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.ProgressBar Security 
      Height          =   255
      Left            =   1200
      TabIndex        =   11
      Top             =   2400
      Width           =   3255
      _ExtentX        =   5741
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   1
      Min             =   3
      Max             =   3e5
      Scrolling       =   1
   End
   Begin VB.TextBox View 
      Height          =   285
      Left            =   120
      Locked          =   -1  'True
      TabIndex        =   9
      Top             =   2040
      Width           =   4335
   End
   Begin VB.CommandButton RetDef 
      Caption         =   "Return Default Key File to Default Settings"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   3240
      Width           =   4335
   End
   Begin VB.CommandButton OK 
      Caption         =   "OK"
      Height          =   255
      Left            =   120
      TabIndex        =   7
      Top             =   3720
      Width           =   4335
   End
   Begin VB.CommandButton GenKey 
      Caption         =   "Generate New Key File"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   2880
      Width           =   4335
   End
   Begin VB.ListBox TK 
      Height          =   1620
      Left            =   2520
      TabIndex        =   2
      Top             =   360
      Width           =   1935
   End
   Begin VB.ListBox SK 
      Height          =   1620
      Left            =   1320
      TabIndex        =   1
      Top             =   360
      Width           =   1215
   End
   Begin VB.ListBox NK 
      Height          =   1620
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   1215
   End
   Begin VB.Label Label4 
      Caption         =   "Key Security:"
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   2400
      Width           =   975
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      Index           =   3
      X1              =   120
      X2              =   4440
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00E0E0E0&
      Index           =   2
      X1              =   120
      X2              =   4440
      Y1              =   2775
      Y2              =   2775
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00E0E0E0&
      Index           =   1
      X1              =   120
      X2              =   4440
      Y1              =   3615
      Y2              =   3615
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00808080&
      Index           =   0
      X1              =   120
      X2              =   4440
      Y1              =   3600
      Y2              =   3600
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Text Keys"
      Height          =   255
      Left            =   2520
      TabIndex        =   5
      Top             =   120
      Width           =   1935
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Sub # Keys"
      Height          =   255
      Left            =   1320
      TabIndex        =   4
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Number Keys"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   1215
   End
   Begin VB.Menu Save 
      Caption         =   "&Save"
   End
   Begin VB.Menu Open 
      Caption         =   "&Open"
   End
End
Attribute VB_Name = "SetFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Public Sub KeySec()
Dim Val As Long
Val = (NK.ListCount + SK.ListCount + (TK.ListCount * 5)) * Len(TK.List(0))
If Val = 0 Then
Exit Sub
End If
Security.Value = Val
End Sub

Private Sub Form_Activate()
KeySec
End Sub

Private Sub Form_Load()
Ontop Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
OK_Click
End Sub

Private Sub GenKey_Click()
GenFrm.Show
SetFrm.Hide
End Sub

Private Sub NK_Click()
TK.ListIndex = -1
SK.ListIndex = -1
View.Text = NK.Text
End Sub

Private Sub OK_Click()
SetFrm.Hide
TUFrm.Enabled = True
TUFrm.SetFocus
End Sub

Private Sub Open_Click()
On Error GoTo error
Dim Directory As String
Dim CurPos As Integer
Dim Pos(1) As Integer
Dim i As Integer
Start:
CMDialog.filename = ""
CMDialog.DialogTitle = "Open"
CMDialog.InitDir = App.Path
CMDialog.Filter = "UE Key Files|*.key"
CMDialog.ShowOpen
If CMDialog.filename <> "" Then
Directory$ = CMDialog.filename
Else
Exit Sub
End If
If TUFrm.FileExists(Directory$) = False Then
MsgBox "The file you specified doesn't exist!", 48, "Error"
GoTo Start
End If
OpenFile:
Open Directory$ For Input As #1
While Not EOF(1)
Input #1, MyString$
OpenL.AddItem MyString$
Wend
Close #1
CurPos = 0
NK.Clear
SK.Clear
TK.Clear
For i = 0 To OpenL.ListCount - 1
  If OpenL.List(i) = "*" Then
  Pos(CurPos) = i
    If CurPos = 1 Then
    Exit For
    Else
    CurPos = CurPos + 1
    End If
  End If
Next i
If SetFrm.OpenL.ListCount > 2202 Or SetFrm.OpenL.ListCount < 5 Then
MsgBox "Invalid key file!  Returning to default settings.", 48, "Error"
RetDef_Click
End If
For i = 0 To Pos(0) - 1
NK.AddItem OpenL.List(i)
Next i
For i = Pos(0) + 1 To Pos(1) - 1
SK.AddItem OpenL.List(i)
Next i
For i = Pos(1) + 1 To OpenL.ListCount - 1
TK.AddItem OpenL.List(i)
Next i
OpenL.Clear
KeySec
Exit Sub
error:
MsgBox Err.Description, 48, "Error"
End Sub

Private Sub RetDef_Click()
Kill App.Path & "/Default.key"
TUFrm.OpenSet
End Sub

Private Sub Save_Click()
Dim Directory As String
Dim i As Integer
Start:
CMDialog.filename = ""
CMDialog.DialogTitle = "Save"
CMDialog.InitDir = App.Path
CMDialog.Filter = "UE Key Files|*.key"
CMDialog.ShowSave
If CMDialog.filename <> "" Then
Directory$ = CMDialog.filename
Else
Exit Sub
End If
If TUFrm.FileExists(Directory$) = True Then
  If MsgBox("Are you sure you want to overwrite the previous file?", vbCritical + vbYesNo, "Error") = vbYes Then
  GoTo SaveFile
  Else
  GoTo Start
  End If
End If
SaveFile:
Open Directory$ For Output As #1
  For i = 0 To NK.ListCount - 1
  Print #1, NK.List(i)
  Next i
  Print #1, "*"
  For i = 0 To SK.ListCount - 1
  Print #1, SK.List(i)
  Next i
  Print #1, "*"
  For i = 0 To TK.ListCount - 1
  Print #1, TK.List(i)
  Next i
Close #1
End Sub

Private Sub SK_Click()
NK.ListIndex = -1
TK.ListIndex = -1
View.Text = SK.Text
End Sub

Private Sub TK_Click()
NK.ListIndex = -1
SK.ListIndex = -1
View.Text = TK.Text
End Sub
