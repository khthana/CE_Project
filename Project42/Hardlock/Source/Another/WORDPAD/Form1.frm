VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "COMDLG32.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.1#0"; "RICHTX32.OCX"
Begin VB.Form Form1 
   Caption         =   "RichTextBox Sample - [Noname]"
   ClientHeight    =   6255
   ClientLeft      =   3360
   ClientTop       =   2295
   ClientWidth     =   9150
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6255
   ScaleWidth      =   9150
   Begin RichTextLib.RichTextBox RTF2 
      Height          =   1095
      Left            =   9480
      TabIndex        =   1
      Top             =   2040
      Width           =   495
      _ExtentX        =   873
      _ExtentY        =   1931
      _Version        =   327680
      TextRTF         =   $"Form1.frx":0442
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   1320
      Top             =   6240
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327680
      CancelError     =   -1  'True
      Filter          =   "RTF Files|*.RTF|Text Files|*.TXT|All Files|*.*"
   End
   Begin RichTextLib.RichTextBox RTF 
      Height          =   6255
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   9135
      _ExtentX        =   16113
      _ExtentY        =   11033
      _Version        =   327680
      ScrollBars      =   3
      TextRTF         =   $"Form1.frx":0513
   End
   Begin VB.Menu MenuFile 
      Caption         =   "&File"
      Begin VB.Menu SubMenuNew 
         Caption         =   "&New"
         Shortcut        =   ^N
      End
      Begin VB.Menu SubMenuOpen 
         Caption         =   "&Open..."
         Shortcut        =   ^O
      End
      Begin VB.Menu SubMenuSave 
         Caption         =   "&Save"
         Enabled         =   0   'False
         Shortcut        =   {F2}
      End
      Begin VB.Menu SubMenuSaveAs 
         Caption         =   "&Save As..."
      End
      Begin VB.Menu SubMenuSaveaCopy 
         Caption         =   "&Save a Copy..."
      End
      Begin VB.Menu Separator1 
         Caption         =   "-"
      End
      Begin VB.Menu SubMenuExit 
         Caption         =   "E&xit"
         Shortcut        =   ^Q
      End
   End
   Begin VB.Menu EditMenu 
      Caption         =   "&Edit"
      Begin VB.Menu OpenFindBox 
         Caption         =   "Find..."
         Shortcut        =   {F3}
      End
      Begin VB.Menu Separator3 
         Caption         =   "-"
      End
      Begin VB.Menu EditSW 
         Caption         =   "Select the Word"
         Shortcut        =   ^W
      End
      Begin VB.Menu EditSS 
         Caption         =   "Select the Sentence"
         Shortcut        =   ^S
      End
   End
   Begin VB.Menu MenuFont 
      Caption         =   "F&ont"
      Begin VB.Menu SubMenuRegular 
         Caption         =   "Regular"
      End
      Begin VB.Menu CheckBold 
         Caption         =   "Bold"
         Shortcut        =   ^B
      End
      Begin VB.Menu CheckItalic 
         Caption         =   "Italic"
         Shortcut        =   ^I
      End
      Begin VB.Menu CheckUnderLine 
         Caption         =   "UnderLine"
         Shortcut        =   ^U
      End
      Begin VB.Menu CheckStrikeLine 
         Caption         =   "StrikeLine"
      End
      Begin VB.Menu Separator2 
         Caption         =   "-"
      End
      Begin VB.Menu SubMenuDialog 
         Caption         =   "Dialog Box..."
         Shortcut        =   ^F
      End
   End
   Begin VB.Menu MenuHelp 
      Caption         =   "Help"
      Begin VB.Menu ShowAbout 
         Caption         =   "About..."
         Shortcut        =   {F1}
      End
      Begin VB.Menu ShowShortcut 
         Caption         =   "Show the list of the Shortcut Keys"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim Saved As Boolean
Dim Changed As Boolean
Dim FileName As String
Private Sub CheckBold_Click()
CheckBold.Checked = Not CheckBold.Checked
RTF.SelBold = CheckBold.Checked 'Set RTF.SelBold
End Sub
Private Sub CheckItalic_Click()
CheckItalic.Checked = Not CheckItalic.Checked
RTF.SelItalic = CheckItalic.Checked 'Set RTF.SelItalic
End Sub
Private Sub CheckStrikeLine_Click()
CheckStrikeLine.Checked = Not CheckStrikeLine.Checked
RTF.SelStrikeThru = CheckStrikeLine.Checked  'Set RTF.SelStrikeThru
End Sub
Private Sub CheckUnderLine_Click()
CheckUnderLine.Checked = Not CheckUnderLine.Checked
RTF.SelUnderline = CheckItalic.Checked 'Set RTF.SelUnderline
End Sub
Private Sub EditSS_Click()
SelectSentence
End Sub
Private Sub EditSW_Click()
SelectWord
End Sub
Private Sub Form_Load()
FileName = "Noname"
End Sub
Private Sub Form_Resize()
'Resize the richtextbox as the form is resized
On Error Resume Next
RTF.Width = Form1.Width - 120
RTF.Height = Form1.Height - 690
End Sub
Private Sub OpenFindBox_Click()
Form2.Show
End Sub
Private Sub RTF_Change()
Changed = True
ChangeCaption
End Sub
Private Sub RTF_KeyUp(KeyCode As Integer, Shift As Integer)
'If user pushes Ctrl-S, the sentence which the cursor is on will be selected.
'If user pushes Ctrl-W, the word which the cursor is on will be selected.
'If user pushes Ctrl-Shift-S, the cursor will move to the end of the sentence.
'If user pushes Ctrl-Shift-W, the cursor will move to the end of the word.

If Shift = vbCtrlMask Then
    Select Case KeyCode
        Case vbKeyS
            SelectSentence
        Case vbKeyW
            SelectWord
    End Select
End If
If Shift = (vbCtrlMask Or vbShiftMask) Then
    Select Case KeyCode
        Case vbKeyS
            RTF.UpTo ".?!", True, False
        Case vbKeyW
            RTF.UpTo ",;:.?! ", True, False
    End Select
End If
End Sub
Private Sub SelectSentence()
RTF.Span ".?!", False, True
SelectionStart = RTF.SelStart
RTF.Span ".?!", True, True
SelectionEnd = RTF.SelStart + RTF.SelLength
RTF.SelStart = SelectionStart
RTF.SelLength = SelectionEnd - SelectionStart
End Sub
Private Sub SelectWord()
RTF.Span " ,;:.?!", False, True
SelectionStart = RTF.SelStart
RTF.Span " ,;:.?!", True, True
SelectionEnd = RTF.SelStart + RTF.SelLength
RTF.SelStart = SelectionStart
RTF.SelLength = SelectionEnd - SelectionStart
End Sub
Private Sub RTF_SelChange()
CheckBold.Checked = IIf(RTF.SelBold = False, False, True)
CheckItalic.Checked = IIf(RTF.SelItalic = False, False, True)
CheckUnderLine.Checked = IIf(RTF.SelUnderline = False, False, True)
CheckStrikeLine.Checked = IIf(RTF.SelStrikeThru = False, False, True)
End Sub

Private Sub ShowAbout_Click()
Form1.Enabled = False
Form3.Show
End Sub
Private Sub ShowShortcut_Click()
Form1.Enabled = False
Form4.Show
End Sub
Private Sub SubMenuDialog_Click()
On Error Resume Next
CommonDialog1.Flags = cdlCFBoth
CommonDialog1.ShowFont
RTF.SelFontName = CommonDialog1.FontName
RTF.SelFontSize = CommonDialog1.FontSize
RTF.SelStrikeThru = CommonDialog1.FontStrikethru
RTF.SelUnderline = CommonDialog1.FontUnderline
RTF.SelBold = CommonDialog1.FontBold
RTF.SelItalic = CommonDialog1.FontItalic
End Sub
Private Sub SubMenuNew_Click()
'Make a new file!
If Changed = True Then
a = MsgBox("Do you want to save [" + FileName + "]?", vbYesNoCancel, "Alert!")
If a = 2 Then Exit Sub
If a = 7 Then GoTo 10
If Saved = True Then SubMenuSave_Click Else SubMenuSaveAs_Click
GoTo 10
Else
10 RTF.Text = "": Changed = False
ChangeCaption
FileName = "Noname": SubMenuSave.Enabled = False
Saved = False: SubMenuSave.Enabled = False
End If
End Sub
Private Sub SubMenuOpen_Click()
'Open a saved file!
On Error GoTo 10
If Changed = True Then
    a = MsgBox("Do you want to save [" + FileName + "]?", vbYesNoCancel, "Alert!")
    If a = 2 Then Exit Sub
    If a = 7 Then GoTo 20
    If Saved = True Then SubMenuSave_Click Else SubMenuSaveAs_Click
End If
20
CommonDialog1.Flags = cdlOFNFileMustExist
CommonDialog1.DefaultExt = "RTF"
CommonDialog1.ShowOpen
    If UCase(Right$(CommonDialog1.FileName, 3)) = "RTF" Then
        tmode = rtfRTF
    Else
        tmode = rtfText
    End If
        
    RTF.LoadFile CommonDialog1.FileName, tmode
    FileName = CommonDialog1.FileName
    Changed = False
    ChangeCaption
    SubMenuSave.Enabled = True
    Saved = True
    Exit Sub
10 MsgBox "Error while opening the file!"
End Sub
Private Sub SubMenuRegular_Click()
'Make the text regular font
RTF.SelBold = False: CheckBold.Checked = False
RTF.SelItalic = False: CheckItalic.Checked = False
RTF.SelUnderline = False: CheckUnderLine.Checked = False
RTF.SelStrikeThru = False: CheckStrikeLine.Checked = False
End Sub
Private Sub SubMenuSave_Click()
Changed = False
a = MsgBox("Do you want to save in RTF type? If you do, choose Yes. If you don't, choose No", vbYesNoCancel, "Choose the type")
    If a = 2 Then Exit Sub
    If K = 0 Then If a = 6 Then B = ".rtf" Else B = ".txt" Else B = ""
    RTF.SaveFile CommonDialog1.FileName + B, a - 6
End Sub

Private Sub SubMenuSaveaCopy_Click()
On Error GoTo 10
    B = CommonDialog1.Filter
    CommonDialog1.Filter = ""
    CommonDialog1.ShowSave
    CommonDialog1.Filter = B
    For I = 1 To Len(CommonDialog1.FileTitle) - 1
    B = Mid$(CommonDialog1.FileTitle, I, 1)
    If B = "." Then K = I
    Next I
    a = MsgBox("Do you want to save in RTF type? If you do, choose Yes. If you don't, choose No", vbYesNoCancel, "Choose the type")
    If a = 2 Then Exit Sub
    If K = 1 Then B = "": GoTo 20
    If a = 6 Then B = ".rtf" Else B = ".txt"
20  RTF.SaveFile CommonDialog1.FileName + B, a - 6
    Exit Sub
10  MsgBox "Error while saving file", vbOKOnly, "Error"
End Sub
Private Sub SubMenuSaveAs_Click()
'Save As...
On Error GoTo 10
    B = CommonDialog1.Filter
    CommonDialog1.Filter = ""
    CommonDialog1.ShowSave
    CommonDialog1.Filter = B
    K = 0
    For I = 1 To Len(CommonDialog1.FileTitle) - 1
    B = Mid$(CommonDialog1.FileTitle, I, 1)
    If B = "." Then K = I
    Next I
    a = MsgBox("Do you want to save in RTF type? If you do, choose Yes. If you don't, choose No", vbYesNoCancel, "Choose the type")
    If a = 2 Then Exit Sub
    If K > 0 Then B = "": GoTo 20
    If a = 6 Then B = ".rtf" Else B = ".txt"
20  RTF.SaveFile CommonDialog1.FileName + B, a - 6
    Changed = False: FileName = CommonDialog1.FileName + B: ChangeCaption
    Saved = True: SubMenuSave.Enabled = True
    Exit Sub

10  MsgBox "Error while saving file", vbOKOnly, "Error"
End Sub
Sub ChangeCaption()
If Changed = True Then m = "*" Else m = ""
Form1.Caption = "RichTextBox Sample [" + FileName + "] " + m
End Sub
