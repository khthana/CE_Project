VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "COMDLG32.OCX"
Begin VB.MDIForm MDI 
   BackColor       =   &H8000000C&
   Caption         =   "Logic Trainer"
   ClientHeight    =   3195
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   4680
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   WindowState     =   2  'Maximized
   Begin MSComDlg.CommonDialog Dialog3 
      Left            =   480
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
      DefaultExt      =   "*.gate"
      DialogTitle     =   "Save As"
      FileName        =   "*.gate"
      Filter          =   "Project File (*.gate)|*.gate"
   End
   Begin MSComDlg.CommonDialog Dialog2 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
      DefaultExt      =   ".gate"
      DialogTitle     =   "Open"
      FileName        =   "*.gate"
      Filter          =   "Project File (*.gate)|*.gate|All Files (*.*)|*.*"
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuNew 
         Caption         =   "&New"
         Shortcut        =   ^N
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save"
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuSep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuNewComp 
         Caption         =   "Make New &Component"
         Shortcut        =   ^M
      End
      Begin VB.Menu mnuSep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "E&xit"
      End
   End
   Begin VB.Menu mnuProject 
      Caption         =   "&Project"
      Begin VB.Menu mnuSystemOutput 
         Caption         =   "System &Output"
      End
      Begin VB.Menu mnuCheck 
         Caption         =   "&Check"
      End
      Begin VB.Menu mnuSimulate 
         Caption         =   "&Simulate"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
   End
End
Attribute VB_Name = "MDI"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public wiredtype1 As Integer
Public wiredtype2 As Integer
Public checkType As Integer
Public Wired As Boolean
Public nWired1 As Integer
Public nWired2 As Integer
Public chooseGate1 As Integer
Public chooseGate2 As Integer
Public nInOut1 As Integer
Public nInOut2 As Integer
Public saveType As Integer
Public resultCheck As Integer
Public layoutClose As Boolean
Public templayout As Integer
Public tempninput As Integer
Public tempnoutput As Integer
Public tempname As String

Private Sub MDIForm_Load()
    Wired = False
    layoutClose = True
    mnuNew.Enabled = False
    mnuOpen.Enabled = False
    mnuSave.Enabled = False
    mnuNewComp.Enabled = False
    mnuProject.Enabled = False
End Sub

Private Sub MDIForm_MouseDown(Button As Integer, Shift As Integer, x As Single, y As Single)
    If Button = 2 Then PopupMenu mnuFile
End Sub

Private Sub mnuCheck_Click()
    saveType = 1
    If pid = "" Then
        SaveDB.Show
    Else
        saveModel
        checkModel
        If resultCheck = 0 Then
            MsgBox "PASS"
        End If
        If resultCheck = 1 Then
            MsgBox "NOT PASS (have loop)"
        End If
        If resultCheck = 2 Then
            MsgBox "NOT PASS (have input more than one)"
        End If
    End If
End Sub

Private Sub mnuExit_Click()
    End
End Sub

Private Sub mnuHelp_Click()
    HelpForm.Show
End Sub

Private Sub mnuNew_Click()
    If MDI.layoutClose = False Then
        MsgBox "You have to close this lay out before open the new one."
    Else
        Unload LayOut
        LayOut.Visible = True
        LayOut.Top = 1700
        LayOut.Left = 0
        Comp.Top = 0
        Comp.Left = 800
        mnuProject.Enabled = True
        mnuNew.Enabled = True
        mnuOpen.Enabled = True
        mnuSave.Enabled = True
        mnuNewComp.Enabled = True
    End If
       
End Sub

Private Sub mnuNewComp_Click()

    saveType = 3
    SaveDB.Show
End Sub

Private Sub mnuOpen_Click()
    If MDI.layoutClose = False Then
        MsgBox "You have to close this lay out before open the new one."
    Else
        OpenProject.Show
    End If
End Sub

Private Sub mnuSave_Click()
    Dim i As Integer
    
    saveType = 0
    If pid = "" Then
        SaveDB.Show
    Else
        saveModel
    End If
End Sub

Private Sub mnuSimulate_Click()
    saveType = 2
    If pid = "" Then
        SaveDB.Show
    Else
        saveModel
        checkModel
        If resultCheck = 0 Then
            Simulate.Show
            mnuSimulate.Enabled = False
        End If
        If resultCheck = 1 Then
            MsgBox "NOT PASS (have loop)"
        End If
        If resultCheck = 2 Then
            MsgBox "NOT PASS (have input more than one)"
        End If
    End If
End Sub


Private Sub mnuSystemOutput_Click()
    SystemOutput.Show
    
End Sub
