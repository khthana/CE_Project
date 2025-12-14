VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Begin VB.Form TUFrm 
   Caption         =   "Text Utilities"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   630
   ClientWidth     =   4680
   Icon            =   "TUFrm.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   4680
   StartUpPosition =   2  'CenterScreen
   WindowState     =   2  'Maximized
   Begin VB.TextBox DefT 
      Height          =   195
      Left            =   0
      MultiLine       =   -1  'True
      TabIndex        =   2
      Text            =   "TUFrm.frx":0442
      Top             =   480
      Visible         =   0   'False
      Width           =   150
   End
   Begin VB.Timer UndoT 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   480
      Top             =   0
   End
   Begin MSComDlg.CommonDialog CMDialog 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSComctlLib.StatusBar Stat 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   2940
      Width           =   4680
      _ExtentX        =   8255
      _ExtentY        =   450
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   7752
            Text            =   "Characters Long:  0"
            TextSave        =   "Characters Long:  0"
         EndProperty
      EndProperty
   End
   Begin VB.TextBox TextT 
      Height          =   1455
      Left            =   0
      MaxLength       =   32760
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      Top             =   0
      Width           =   2175
   End
   Begin RichTextLib.RichTextBox TextTS 
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   480
      Width           =   135
      _ExtentX        =   238
      _ExtentY        =   450
      _Version        =   393217
      ScrollBars      =   2
      MaxLength       =   32766
      TextRTF         =   $"TUFrm.frx":1C2C
   End
   Begin VB.Menu FileMnu 
      Caption         =   "&File"
      Begin VB.Menu SaveMnu 
         Caption         =   "&Save"
         Shortcut        =   ^S
      End
      Begin VB.Menu OpenMnu 
         Caption         =   "&Open"
         Shortcut        =   ^O
      End
      Begin VB.Menu Exit 
         Caption         =   "E&xit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu EditMnu 
      Caption         =   "Ed&it"
      Begin VB.Menu Undo 
         Caption         =   "&Undo"
         Shortcut        =   ^{INSERT}
      End
      Begin VB.Menu MnuLine 
         Caption         =   "-"
      End
      Begin VB.Menu Copy 
         Caption         =   "&Copy"
      End
      Begin VB.Menu Paste 
         Caption         =   "&Paste"
      End
      Begin VB.Menu Clear 
         Caption         =   "C&lear"
         Shortcut        =   +{DEL}
      End
   End
   Begin VB.Menu AltTMnu 
      Caption         =   "&Alter Text"
      Begin VB.Menu BasicMnu 
         Caption         =   "Basic"
         Begin VB.Menu AltC 
            Caption         =   "Alternating Caps"
         End
         Begin VB.Menu BT 
            Caption         =   "Backwards Text"
         End
         Begin VB.Menu SCT 
            Caption         =   "Screwed Text"
         End
      End
      Begin VB.Menu TEMnu 
         Caption         =   "Text Expansion"
         Begin VB.Menu ST 
            Caption         =   "Spaced Text"
         End
         Begin VB.Menu DT 
            Caption         =   "Doubled Text"
         End
         Begin VB.Menu ET 
            Caption         =   "Echoed Text"
         End
      End
      Begin VB.Menu TDMnu 
         Caption         =   "Text Distortion"
         Begin VB.Menu SCRT 
            Caption         =   "Scrambled Text"
         End
         Begin VB.Menu TWT 
            Caption         =   "Twisted Text"
         End
         Begin VB.Menu MT 
            Caption         =   "Mixed Text"
         End
      End
      Begin VB.Menu TCMnu 
         Caption         =   "Text Codes"
         Begin VB.Menu EncMnu 
            Caption         =   "Encrypt"
         End
         Begin VB.Menu DecMnu 
            Caption         =   "Decrypt"
         End
         Begin VB.Menu C3 
            Caption         =   "Basic Encryption/Decryption"
         End
         Begin VB.Menu BE 
            Caption         =   "Basic Encryption (2)"
            Visible         =   0   'False
         End
         Begin VB.Menu BD 
            Caption         =   "Basic Decryption (2)"
            Visible         =   0   'False
         End
         Begin VB.Menu BC 
            Caption         =   "Basic Code"
         End
         Begin VB.Menu BDC 
            Caption         =   "Basic Decode"
         End
         Begin VB.Menu C1 
            Caption         =   "Code 1"
         End
         Begin VB.Menu D1 
            Caption         =   "Decode 1"
         End
         Begin VB.Menu C2 
            Caption         =   "Code 2"
         End
         Begin VB.Menu D2 
            Caption         =   "Decode 2"
         End
         Begin VB.Menu CB 
            Caption         =   "Code Binary"
         End
         Begin VB.Menu DCB 
            Caption         =   "Decode Binary"
         End
      End
   End
   Begin VB.Menu OptMnu 
      Caption         =   "&Options"
      Begin VB.Menu SetMnu 
         Caption         =   "Encryption/Decryption Settings"
      End
      Begin VB.Menu OS 
         Caption         =   "Other Settings"
      End
   End
   Begin VB.Menu GameMnu 
      Caption         =   "&Games"
      Begin VB.Menu DrawG 
         Caption         =   "Draw!"
      End
      Begin VB.Menu SMG 
         Caption         =   "Slot Machine"
      End
      Begin VB.Menu PUG 
         Caption         =   "Prediction Utilities"
      End
   End
   Begin VB.Menu About 
      Caption         =   "&About"
   End
End
Attribute VB_Name = "TUFrm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim CurLinePos As Integer
Dim ClearFor As Boolean
Dim OnFirst As Boolean

Function AltCaps(Text As String)
'This will make the caps in text go on and off for each letter, like this:  cOoL
On Error GoTo error
Dim i As Integer
Dim s As String
s = ""
For i = 1 To Len(Text$)
Graph2 1, 0
  keyval = Asc(Mid$(Text$, i, 1))
  If (keyval >= 96 And keyval < 96 + 26) Or (keyval >= 64 And keyval < 64 + 26) Then
    If (i And 1) = 1 Then
      If keyval < 96 Then
        s = s + Chr$(96 + keyval - 64)
      Else
        s = s + Chr$(keyval)
      End If
    Else
      If keyval >= 96 Then
        s = s + Chr$(64 + keyval - 96)
      Else
        s = s + Chr$(keyval)
      End If
    End If
  Else
    s = s + Chr$(keyval)
  End If
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Graph2 1, 1
Next i
Text$ = s
AltCaps = Text$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function BackwardsText(Text As String)
'This will make text go backwards, like this:  looC (Cool)
On Error GoTo error
For i% = 1 To Len(Text$)
Graph2 2, 0
stringy$ = Mid$(Text$, i%, 1)
Graph2 2, 1
final$ = stringy$ + final$
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Graph2 2, 2
Next i%
BackwardsText = final$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function EliteType(Text As String)
'This will change characters to make them "elite", example:  ©00|_
On Error GoTo error
Dim s(52) As String
s(0) = "æ"
s(1) = "å"
s(2) = "b"
s(3) = "<"
s(4) = "c|"
s(5) = "ë"
s(6) = "f"
s(7) = "9"
s(8) = "h"
s(9) = "ï"
s(10) = "j"
s(11) = "|<"
s(12) = "|_"
s(13) = "/x\"
s(14) = "|\|"
s(15) = "0"
s(16) = "p"
s(17) = "q"
s(18) = "r"
s(19) = "_/¯"
s(20) = "-|-"
s(21) = "µ"
s(22) = "\/"
s(23) = "\/\/"
s(24) = "×"
s(25) = "ÿ"
s(26) = "¯/_"
s(27) = "Ä"
s(28) = "ß"
s(29) = "©"
s(30) = "|}"
s(31) = "È"
s(32) = "F"
s(33) = "G"
s(34) = "|-|"
s(35) = "I"
s(36) = "J"
s(37) = "]<"
s(38) = "]_"
s(39) = "/\/\"
s(40) = "|\|"
s(41) = "{}"
s(42) = "P"
s(43) = "¶"
s(44) = "|2"
s(45) = "§"
s(46) = "¯|¯"
s(47) = "|_|"
s(48) = "\/"
s(49) = "\x/"
s(50) = "><"
s(51) = "¥"
s(52) = "¯/_"
Graph1 6, 0
Text$ = ReplaceC(Text$, "ae", s(0))
Text$ = ReplaceC(Text$, "a", s(1))
Text$ = ReplaceC(Text$, "b", s(2))
Text$ = ReplaceC(Text$, "c", s(3))
Text$ = ReplaceC(Text$, "d", s(4))
Text$ = ReplaceC(Text$, "e", s(5))
Text$ = ReplaceC(Text$, "f", s(6))
Text$ = ReplaceC(Text$, "g", s(7))
Text$ = ReplaceC(Text$, "h", s(8))
Text$ = ReplaceC(Text$, "i", s(9))
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 1
Text$ = ReplaceC(Text$, "j", s(10))
Text$ = ReplaceC(Text$, "k", s(11))
Text$ = ReplaceC(Text$, "l", s(12))
Text$ = ReplaceC(Text$, "m", s(13))
Text$ = ReplaceC(Text$, "n", s(14))
Text$ = ReplaceC(Text$, "o", s(15))
Text$ = ReplaceC(Text$, "p", s(16))
Text$ = ReplaceC(Text$, "q", s(17))
Text$ = ReplaceC(Text$, "r", s(18))
Text$ = ReplaceC(Text$, "s", s(19))
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 2
Text$ = ReplaceC(Text$, "t", s(20))
Text$ = ReplaceC(Text$, "u", s(21))
Text$ = ReplaceC(Text$, "v", s(22))
Text$ = ReplaceC(Text$, "w", s(23))
Text$ = ReplaceC(Text$, "x", s(24))
Text$ = ReplaceC(Text$, "y", s(25))
Text$ = ReplaceC(Text$, "z", s(26))
Text$ = ReplaceC(Text$, "A", s(27))
Text$ = ReplaceC(Text$, "B", s(28))
Text$ = ReplaceC(Text$, "C", s(29))
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 3
Text$ = ReplaceC(Text$, "D", s(30))
Text$ = ReplaceC(Text$, "E", s(31))
Text$ = ReplaceC(Text$, "F", s(32))
Text$ = ReplaceC(Text$, "G", s(33))
Text$ = ReplaceC(Text$, "H", s(34))
Text$ = ReplaceC(Text$, "I", s(35))
Text$ = ReplaceC(Text$, "J", s(36))
Text$ = ReplaceC(Text$, "K", s(37))
Text$ = ReplaceC(Text$, "L", s(38))
Text$ = ReplaceC(Text$, "M", s(39))
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 4
Text$ = ReplaceC(Text$, "N", s(40))
Text$ = ReplaceC(Text$, "O", s(41))
Text$ = ReplaceC(Text$, "P", s(42))
Text$ = ReplaceC(Text$, "Q", s(43))
Text$ = ReplaceC(Text$, "R", s(44))
Text$ = ReplaceC(Text$, "S", s(45))
Text$ = ReplaceC(Text$, "T", s(46))
Text$ = ReplaceC(Text$, "U", s(47))
Text$ = ReplaceC(Text$, "V", s(48))
Text$ = ReplaceC(Text$, "W", s(49))
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 5
Text$ = ReplaceC(Text$, "X", s(50))
Text$ = ReplaceC(Text$, "Y", s(51))
Text$ = ReplaceC(Text$, "Z", s(52))
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 6
EliteType = Text$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function SpaceCharacters(Text As String, AmountOfSpaces As Integer)
'This will put a space between every character in the text, like this:  C o o l
On Error GoTo error
Dim i As Integer
Dim SpaceStr As String
If AmountOfSpaces > 100 Then
AmountOfSpaces = 100
ElseIf AmountOfSpaces < 1 Then
AmountOfSpaces = 1
End If
For i = 1 To AmountOfSpaces
SpaceStr$ = SpaceStr$ & " "
Next i
Dim endstr As String
For i = 1 To Len(Text$)
Graph2 1, 0
  If Not i = Len(Text) Then
  endstr$ = endstr$ & Mid$(Text$, i, 1) & SpaceStr$
  Else
  endstr$ = endstr$ & Mid$(Text$, i, 1)
  End If
Graph2 1, 1
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Next i
SpaceCharacters = endstr$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function DoubleCharacters(Text As String, AmountOfExtras As Integer)
'This will double every character in the text, like this:  CCooooll
On Error GoTo error
Dim i As Integer
Dim i2 As Integer
Dim endstr As String
If AmountOfExtras > 100 Then
AmountOfExtras = 100
ElseIf AmountOfExtras < 1 Then
AmountOfExtras = 1
End If
For i = 1 To Len(Text$)
  For i2 = 1 To AmountOfExtras + 1
  endstr$ = endstr$ & Mid$(Text$, i, 1)
  Graph2 AmountOfExtras + 1, i2
  Next i2
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Next i
DoubleCharacters = endstr$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function EchoText(Text As String, Reverse As Boolean)
'This will "echo" the text, like this:  Cool ool ol l
On Error GoTo error
Dim i As Integer
Dim endstr As String
For i = 1 To Len(Text$)
Graph2 1, 0
  If Reverse = True Then
  endstr$ = Mid$(Text$, i, Len(Text$) - (i - 1)) & " " & endstr$
  Else
  endstr$ = endstr$ & Mid$(Text$, i, Len(Text$) - (i - 1)) & " "
  End If
Graph2 1, 1
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Next i
endstr$ = Mid$(endstr$, 1, Len(endstr$) - 1)
EchoText = endstr$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function Scramble(Text As String, Key As Integer)
'This will scramble text up, example:  oCol
Dim RndNum As Long
Dim i As Integer
Dim endstr As String
Dim ListN(32766) As Long
Dim CurPos As Integer
Randomize Key
CurPos = 0
Text$ = Mid$(Text$, 1, 32766)
Start:
RndNum = Int((Len(Text$) - 1 + 1) * Rnd + 1)
For i = 0 To CurPos
  If RndNum = ListN(i) Then
  GoTo Start
  End If
Graph2 CurPos + 1, i + 1
Next i
ListN(CurPos) = RndNum
CurPos = CurPos + 1
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), CurPos
If Not CurPos = Len(Text$) Then
GoTo Start
End If
For i = 0 To CurPos - 1
endstr$ = endstr$ & Mid$(Text$, ListN(i), 1)
Next i
Scramble = endstr$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function TwistText(Text As String)
'This will "twist" text, it is kind of like scramble, example:  oClo
Dim CurPos As Integer
Dim endstr As String
CurPos = 1
Start:
Graph2 1, 0
endstr$ = endstr$ & Mid$(Text$, CurPos + 1, 1) & Mid$(Text$, CurPos, 1)
Graph2 1, 1
CurPos = CurPos + 2
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), CurPos
If Len(Text$) > CurPos Then
GoTo Start
ElseIf Len(Text$) = CurPos Then
endstr$ = endstr$ & Mid$(Text$, Len(Text$), 1)
End If
TwistText = endstr$
End Function

Function TwistText2(Text As String)
'This will "twist" text, it is kind of like scramble, example:  oClo
Dim CurPos As Integer
Dim endstr As String
CurPos = 1
Start:
endstr$ = endstr$ & Mid$(Text$, CurPos + 1, 1) & Mid$(Text$, CurPos, 1)
CurPos = CurPos + 2
If Len(Text$) > CurPos Then
GoTo Start
ElseIf Len(Text$) = CurPos Then
endstr$ = endstr$ & Mid$(Text$, Len(Text$), 1)
End If
TwistText2 = endstr$
End Function

Public Sub OpenSet()
Dim Directory As String
Dim CurPos As Integer
Dim Pos(1) As Integer
Dim i As Integer
Directory$ = App.Path & "\Default.key"
If FileExists(Directory$) = False Then
Default:
  Open Directory$ For Output As #1
  Print #1, DefT.Text
  Close #1
End If
Open Directory$ For Input As #1
While Not EOF(1)
Input #1, MyString$
SetFrm.OpenL.AddItem MyString$
Wend
Close #1
CurPos = 0
SetFrm.NK.Clear
SetFrm.SK.Clear
SetFrm.TK.Clear
For i = 0 To SetFrm.OpenL.ListCount - 1
  If SetFrm.OpenL.List(i) = "*" Then
  Pos(CurPos) = i
    If CurPos = 1 Then
    Exit For
    Else
    CurPos = CurPos + 1
    End If
  End If
Next i
If SetFrm.OpenL.ListCount > 3002 Or SetFrm.OpenL.ListCount < 5 Then
MsgBox "Invalid key file!  Returning to default settings.", 48, "Error"
GoTo Default
End If
For i = 0 To Pos(0) - 1
SetFrm.NK.AddItem SetFrm.OpenL.List(i)
Next i
For i = Pos(0) + 1 To Pos(1) - 1
SetFrm.SK.AddItem SetFrm.OpenL.List(i)
Next i
For i = Pos(1) + 1 To SetFrm.OpenL.ListCount - 1
SetFrm.TK.AddItem SetFrm.OpenL.List(i)
Next i
SetFrm.OpenL.Clear
SetFrm.KeySec
End Sub

Public Function FileExists(strFile As String) As String


    On Error Resume Next 'Doesn't raise error - FileExists will be False
    'if error occurs
    'a valid path would be someting like "C:\Windows\win.ini" - Full
    '     path
    'must be specified
    FileExists = Dir(strFile, vbHidden) <> ""
    
End Function

Private Sub About_Click()
Enabled = False
AboutFrm.Show
End Sub

Private Sub ChatCmd_Click()
ChatFrm.Show
End Sub

Private Sub AltC_Click()
GetReady
TextT.Text = AltCaps(TextT.Text)
DeReady
End Sub

Private Sub BC_Click()
GetReady
TextT.Text = Code(TextT.Text)
DeReady
End Sub

Private Sub BD_Click()
Dim i As Integer, Text As String, BinStr(39999) As String, Pos As Integer, MaxVal As Integer, endstr As String
GetReady
Text = ToBin2(TextT.Text)
Text = Mid$(Text, 5, Len(Text) - 8)
MaxVal = (Len(Text) / 8) - 1
For i = 1 To Len(Text)
Graph2 1, 0
BinStr(Pos) = BinStr(Pos) & Mid$(Text, i, 1)
  If Pos = MaxVal Then
  Pos = 0
  Else
  Pos = Pos + 1
  End If
DoEvents
  If DoCancel = True Then Exit Sub
Graph1 Len(Text) + MaxVal, i
Graph2 1, 1
Next i
For i = 0 To MaxVal
Graph2 1, 0
endstr = endstr & BinStr(i)
DoEvents
  If DoCancel = True Then Exit Sub
Graph2 1, 1
Graph1 Len(Text) + MaxVal, i + Len(Text)
Next i
TextT.Text = ToDec2(endstr)
DeReady
End Sub

Private Sub BDC_Click()
GetReady
TextT.Text = Decode(TextT.Text)
DeReady
End Sub

Private Sub BE_Click()
Dim i As Integer, i2 As Integer, Text As String, endstr As String, Shiftr As Boolean
GetReady
Randomize Timer
Text = ToBin2(TextT.Text)
For i = 1 To 8
  For i2 = 0 To (Len(Text) / 8) - 1
  endstr = endstr & Mid$(Text, (i2 * 8) + i, 1)
    If i = 1 And Mid$(Text, (i2 * 8) + i, 1) = "1" Then Shiftr = True
  DoEvents
    If DoCancel = True Then Exit Sub
  Graph2 (Len(Text) / 8) - 1, i2
  Next i2
DoEvents
  If DoCancel = True Then Exit Sub
Graph1 8, i
Next i
      If Shiftr = False Then
      endstr = "01" & (Int((2 - 1 + 1) * Rnd + 1) - 1) & (Int((2 - 1 + 1) * Rnd + 1) - 1) & endstr
      Else
      endstr = "10" & (Int((2 - 1 + 1) * Rnd + 1) - 1) & (Int((2 - 1 + 1) * Rnd + 1) - 1) & endstr
      End If
    endstr = endstr & (Int((2 - 1 + 1) * Rnd + 1) - 1) & (Int((2 - 1 + 1) * Rnd + 1) - 1) & (Int((2 - 1 + 1) * Rnd + 1) - 1) & (Int((2 - 1 + 1) * Rnd + 1) - 1)
TextT.Text = ToDec2(endstr)
DeReady
End Sub

Private Sub BT_Click()
GetReady
TextT.Text = BackwardsText(TextT.Text)
DeReady
End Sub

Private Sub C1_Click()
GetReady
TextT.Text = Code1(TextT.Text)
DeReady
End Sub

Private Sub C2_Click()
GetReady
TextT.Text = Code2(TextT.Text)
DeReady
End Sub

Private Sub C3_Click()
Dim Text As String, i As Integer, xtra As String
GetReady
Text = ""
For i = 0 To Int(Len(TextT.Text) / 2) - 1
Graph2 3, 0
xtra = Mid$(TextT.Text, (i * 2) + 1, 2)
xtra = ToBin2(xtra)
Graph2 3, 1
xtra = TwistText2(xtra)
Graph2 3, 2
xtra = ToDec2(xtra)
Graph2 3, 3
Text = Text & xtra
DoEvents
If DoCancel = True Then Exit Sub
Graph1 Int(Len(TextT.Text) / 2) - 1, i
Next i
  If Not Int(Len(TextT.Text) / 2) = Len(TextT.Text) / 2 Then Text = Text & Mid$(TextT.Text, Len(TextT.Text), 1)
TextT.Text = Text
DeReady
End Sub

Private Sub CB_Click()
GetReady
TextT.Text = ToBin(TextT.Text)
DeReady
End Sub

Private Sub Clear_Click()
TextT.Text = ""
End Sub

Private Sub Copy_Click()
Clipboard.Clear
Clipboard.SetText TextT.Text
End Sub

Private Sub D1_Click()
GetReady
TextT.Text = Decode1(TextT.Text)
DeReady
End Sub

Private Sub D2_Click()
GetReady
TextT.Text = Decode2(TextT.Text)
DeReady
End Sub

Private Sub DCB_Click()
GetReady
TextT.Text = ToDec(TextT.Text)
DeReady
End Sub

Private Sub DecMnu_Click()
Dim buffer As String
If Len(TextT.Text) < 1 Then
MsgBox "No text to decrypt!", 48, "Error"
Exit Sub
End If
buffer = TextT.Text
PrgFrm.Show
WindowState = 1
TextT.Text = Decrypt(SetFrm.NK, SetFrm.TK, SetFrm.SK, TextT.Text)
If TextT.Text = "" Then TextT.Text = buffer
PrgFrm.GraphF.Width = 15
PrgFrm.GraphF2.Width = 15
PrgFrm.Hide
WindowState = 2
End Sub

Private Sub DrawG_Click()
Draw.Show
Enabled = False
End Sub

Private Sub DT_Click()
GetReady
TextT.Text = DoubleCharacters(TextT.Text, AmDouble)
DeReady
End Sub

Private Sub EncMnu_Click()
Dim buffer As String
If Len(TextT.Text) < 1 Then
MsgBox "No text to encrypt!", 48, "Error"
Exit Sub
End If
buffer = TextT.Text
PrgFrm.Show
WindowState = 1
TextT.Text = Encrypt(SetFrm.NK, SetFrm.TK, SetFrm.SK, TextT.Text)
If TextT.Text = "" Then TextT.Text = buffer
PrgFrm.GraphF.Width = 15
PrgFrm.GraphF2.Width = 15
PrgFrm.Hide
WindowState = 2
End Sub

Private Sub ET_Click()
GetReady
TextT.Text = EchoText(TextT.Text, EchoBack)
DeReady
End Sub

Private Sub Exit_Click()
SOS
Unload AboutFrm
Unload PrgFrm
Unload SetFrm
Unload GenFrm
Unload OSFrm
Unload Draw
Unload PU
Unload SM
Unload Me
End
End Sub

Private Sub Form_Load()
OpenSet
OOS
TextTS.Text = ""
End Sub

Private Sub Form_Resize()
If WindowState = 1 Then
Exit Sub
End If
If Width < 4800 Then
Width = 4800
End If
If Height < 3885 Then
Height = 3885
End If
TextT.Move 0, 0, Width - 120, Height - (Stat.Height + 680)
End Sub

Private Sub Form_Terminate()
SOS
End Sub

Private Sub Form_Unload(Cancel As Integer)
Cancel = 1
Exit_Click
End Sub

Private Sub MT_Click()
GetReady
TextT.Text = Mix(TextT.Text)
DeReady
End Sub

Private Sub OpenMnu_Click()
Dim Directory As String
Dim TextT As String
Start:
CMDialog.filename = ""
CMDialog.DialogTitle = "Open"
CMDialog.InitDir = App.Path
CMDialog.Filter = "TU Text Files|*.tu"
CMDialog.ShowOpen
If CMDialog.filename <> "" Then
Directory$ = CMDialog.filename
Else
Exit Sub
End If
If FileExists(Directory$) = False Then
MsgBox "The file you specified doesn't exist!", 48, "Error"
GoTo Start
End If
OpenFile:
TUFrm.TextTS.Text = ""
TUFrm.TextTS.LoadFile Directory$, rtfText
TUFrm.TextT.Text = TextTS.Text
End Sub

Private Sub OS_Click()
Enabled = False
OSFrm.Show
End Sub

Private Sub Paste_Click()
TextT.Text = Clipboard.GetText
End Sub

Private Sub PUG_Click()
PU.Show
Enabled = False
End Sub

Private Sub SaveMnu_Click()
Dim Directory As String
Start:
CMDialog.filename = ""
CMDialog.DialogTitle = "Save"
CMDialog.InitDir = App.Path
CMDialog.Filter = "TU Text Files|*.tu"
CMDialog.ShowSave
If CMDialog.filename <> "" Then
Directory$ = CMDialog.filename
Else
Exit Sub
End If
If FileExists(Directory$) = True Then
  If MsgBox("Are you sure you want to overwrite the previous file?", 48 + vbYesNo, "Error") = vbYes Then
  GoTo SaveFile
  Else
  GoTo Start
  End If
End If
SaveFile:
TextTS.Text = TextT.Text
TextTS.SaveFile Directory$, 1
End Sub

Private Sub SCRT_Click()
GetReady
TextT.Text = Scramble(TextT.Text, 1)
DeReady
End Sub

Private Sub SCT_Click()
GetReady
TextT.Text = EliteType(TextT.Text)
DeReady
End Sub

Private Sub SetMnu_Click()
TUFrm.Enabled = False
SetFrm.Show
End Sub

Private Sub SMG_Click()
SM.Show
Enabled = False
End Sub

Private Sub ST_Click()
GetReady
TextT.Text = SpaceCharacters(TextT.Text, AmSpace)
DeReady
End Sub

Private Sub TextT_Change()
Stat.Panels.Item(1).Text = "Characters Long:  " & Len(TextT.Text)
End Sub

Private Sub TextTS_GotFocus()
TextT.SetFocus
End Sub

Private Sub TWT_Click()
GetReady
TextT.Text = TwistText(TextT.Text)
DeReady
End Sub

Private Sub Undo_Click()
UndoT.Enabled = True
End Sub

Private Sub UndoT_Timer()
TextTS.SetFocus
SendKeys "(^)z"
TextT.Text = TextTS.Text
TextT.SetFocus
UndoT.Enabled = False
End Sub

Function ToBin(Text As String)
Dim endstr As String, xtra As String, i As Integer, i2 As Integer
endstr$ = ""
DoEvents
For i = 1 To Len(Text)
Graph2 1, 0
xtra$ = Bin(Asc(Mid$(Text, i, 1)))
  For i2 = 1 To 8 - Len(xtra$)
  xtra$ = "0" & xtra$
  Next i2
Do While Len(xtra$) > 8
xtra$ = Mid$(xtra$, 2, Len(xtra$) - 1)
Loop
endstr$ = endstr$ & xtra$
Graph2 1, 1
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Next i
ToBin = endstr$
End Function

Function ToBin2(Text As String)
Dim endstr As String, xtra As String, i As Integer, i2 As Integer
endstr$ = ""
DoEvents
For i = 1 To Len(Text)
xtra$ = Bin(Asc(Mid$(Text, i, 1)))
  For i2 = 1 To 8 - Len(xtra$)
  xtra$ = "0" & xtra$
  Next i2
Do While Len(xtra$) > 8
xtra$ = Mid$(xtra$, 2, Len(xtra$) - 1)
Loop
endstr$ = endstr$ & xtra$
Next i
ToBin2 = endstr$
End Function

Function Bin(ByVal intDec As Integer) As String


    Dim strDummy As String
    Dim intLess As Integer
    Dim lngVal As Long
    Dim strTrue As String
    Dim strFalse As String
    lngVal = intDec
    intLess = 16384


    If Abs(lngVal) = lngVal Then
        strTrue = "1"
        strFalse = "0"
        strDummy = "0"
    Else
        strTrue = "0"
        strFalse = "1"
        strDummy = "1"
        lngVal = Abs(lngVal) - 1
    End If



    Do


        If lngVal - intLess >= 0 Then
            strDummy = strDummy & strTrue
            lngVal = lngVal - intLess
        Else
            strDummy = strDummy & strFalse
        End If

        intLess = intLess / 2
    Loop While intLess >= 1

    Bin = strDummy
End Function

Function Mix(Text As String) As String
Dim TT(64000) As String, i As Integer, ParseChr As String, LTP As Integer, Pos As Integer, endstr As String, DC As Boolean
ParseChr = " "
Pos = 0
LTP = 0
DS:
DC = False
For i = 1 To Len(Text)
  If Mid$(Text, i, 2) = "  " Then
  DC = True
  Text = Mid$(Text, 1, i) & Mid$(Text, i + 2, Len(Text) - (i + 1))
  End If
Next i
    If DC = True Then GoTo DS
DS2:
        If Mid$(Text, Len(Text), 1) = " " Then
        Text = Mid$(Text, 1, Len(Text) - 1)
        GoTo DS2
        End If
For i = 1 To Len(Text)
Graph2 1, 0
  If Mid$(Text, i, Len(ParseChr)) = " " Then
  TT(Pos) = Mid$(Text, LTP + Len(ParseChr), i - (LTP + Len(ParseChr)))
  LTP = i
  Pos = Pos + 1
  End If
Graph2 1, 1
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Next i
TT(Pos) = Mid$(Text, LTP + Len(ParseChr), (Len(Text) + 1) - (LTP + Len(ParseChr)))
Pos = Pos + 1
  If Pos = 0 Then
  Pos = 1
  TT(0) = Text
  End If
Randomize Timer
endstr = ""
For i = 0 To Pos - 1
endstr = endstr & Scramble(TT(i), Int((10000 - 1 + 1) * Rnd + 1))
  If i < Pos - 1 Then endstr = endstr & " "
Next i
Mix = endstr
End Function

Function Code(Text As String)
Randomize Timer
Dim i As Integer, endstr As String, RndNum As Integer
endstr = ""
For i = 1 To Len(Text)
Graph2 2, 0
RndNum = Int((255 - 1 + 1) * Rnd + 1)
Check1:
  If RndNum < Asc("a") Or RndNum > Asc("z") Then
    If RndNum < Asc("A") Or RndNum > Asc("Z") Then
    RndNum = Int((255 - 1 + 1) * Rnd + 1)
    GoTo Check1
    End If
  End If
endstr = endstr & Chr(RndNum) & Mid$(Text, i, 1)
RndNum = Int((255 - 1 + 1) * Rnd + 1)
Graph2 2, 1
Check2:
  If RndNum < Asc("a") Or RndNum > Asc("z") Then
    If RndNum < Asc("A") Or RndNum > Asc("Z") Then
    RndNum = Int((255 - 1 + 1) * Rnd + 1)
    GoTo Check2
    End If
  End If
endstr = endstr & Chr(RndNum)
  If i > 1 Then endstr = " " & endstr
Graph2 2, 2
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Next i
Check3:
  If Mid$(endstr, 1, 1) = " " Then
  endstr = Mid$(endstr, 2, Len(endstr) - 1)
  GoTo Check3
  End If
Code = endstr
End Function

Function Code1(Text As String)
'This codes text into different words and phrases!  Make like a secret agent..
On Error GoTo error
Dim i As Integer
Dim RndN As Integer
Dim endstr As String
Randomize Timer
Text$ = ReplaceC(Text$, "A", "a")
Text$ = ReplaceC(Text$, "B", "b")
Text$ = ReplaceC(Text$, "C", "c")
Text$ = ReplaceC(Text$, "D", "d")
Text$ = ReplaceC(Text$, "E", "e")
Text$ = ReplaceC(Text$, "F", "f")
Text$ = ReplaceC(Text$, "G", "g")
Text$ = ReplaceC(Text$, "H", "h")
Text$ = ReplaceC(Text$, "I", "i")
Text$ = ReplaceC(Text$, "J", "j")
Text$ = ReplaceC(Text$, "K", "k")
Text$ = ReplaceC(Text$, "L", "l")
Text$ = ReplaceC(Text$, "M", "m")
Text$ = ReplaceC(Text$, "N", "n")
Text$ = ReplaceC(Text$, "O", "o")
Text$ = ReplaceC(Text$, "P", "p")
Text$ = ReplaceC(Text$, "Q", "q")
Text$ = ReplaceC(Text$, "R", "r")
Text$ = ReplaceC(Text$, "S", "s")
Text$ = ReplaceC(Text$, "T", "t")
Text$ = ReplaceC(Text$, "U", "u")
Text$ = ReplaceC(Text$, "V", "v")
Text$ = ReplaceC(Text$, "W", "w")
Text$ = ReplaceC(Text$, "X", "x")
Text$ = ReplaceC(Text$, "Y", "y")
Text$ = ReplaceC(Text$, "Z", "z")
Text$ = ReplaceC(Text$, "  ", ";")
Text$ = ReplaceC(Text$, " ", ",")
For i = 1 To Len(Text$)
Graph2 1, 0
RndN = Int((3 - 0 + 1) * Rnd + 0)
If Mid$(Text$, i, 1) = "a" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " somewhere"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " did you"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " flowers"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " eat food"
  End If
ElseIf Mid$(Text$, i, 1) = "b" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " light candle"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " mirror"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " cold soup"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " video tape"
  End If
ElseIf Mid$(Text$, i, 1) = "c" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " the murder"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " read book"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " the show"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " paper"
  End If
ElseIf Mid$(Text$, i, 1) = "d" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " beautiful"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " do not"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " bring"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " that"
  End If
ElseIf Mid$(Text$, i, 1) = "e" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " star"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " itself"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " in a"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " by"
  End If
ElseIf Mid$(Text$, i, 1) = "f" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " it is"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " sea"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " myself"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " powerful"
  End If
ElseIf Mid$(Text$, i, 1) = "g" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " aren't"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " nail filer"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " everlasting"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " magic"
  End If
ElseIf Mid$(Text$, i, 1) = "h" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " tomorrow"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " tree"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " it will"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " fat"
  End If
ElseIf Mid$(Text$, i, 1) = "i" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " isn't"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " explosion"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " at school"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " apples"
  End If
ElseIf Mid$(Text$, i, 1) = "j" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " when"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " onions"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " night"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " about it"
  End If
ElseIf Mid$(Text$, i, 1) = "k" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " days"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " right"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " please"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " oranges"
  End If
ElseIf Mid$(Text$, i, 1) = "l" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " wrong"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " yesterday"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " has"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " money"
  End If
ElseIf Mid$(Text$, i, 1) = "m" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " today"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " dad"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " mother"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " his"
  End If
ElseIf Mid$(Text$, i, 1) = "n" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " french"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " hurt"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " ham"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " milk"
  End If
ElseIf Mid$(Text$, i, 1) = "o" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " not"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " see you"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " rot"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " five"
  End If
ElseIf Mid$(Text$, i, 1) = "p" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " see me"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " hard"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " mask"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " ants"
  End If
ElseIf Mid$(Text$, i, 1) = "q" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " yes"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " soft"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " four"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " in flour"
  End If
ElseIf Mid$(Text$, i, 1) = "r" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " no"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " fast"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " three"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " cat"
  End If
ElseIf Mid$(Text$, i, 1) = "s" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " slow"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " super"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " two"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " over the"
  End If
ElseIf Mid$(Text$, i, 1) = "t" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " medium"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " hit"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " one"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " rainbow"
  End If
ElseIf Mid$(Text$, i, 1) = "u" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " zero"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " fire"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " ice"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " malt"
  End If
ElseIf Mid$(Text$, i, 1) = "v" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " six"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " hair"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " light switch"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " metal"
  End If
ElseIf Mid$(Text$, i, 1) = "w" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " computer"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " comb"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " bomb"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " writing"
  End If
ElseIf Mid$(Text$, i, 1) = "x" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " eight ball"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " smear"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " letter"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " cups"
  End If
ElseIf Mid$(Text$, i, 1) = "y" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " nine"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " table"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " basket"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " open door"
  End If
ElseIf Mid$(Text$, i, 1) = "z" Then
  If RndN = 0 Then
  endstr$ = endstr$ + " ten"
  ElseIf RndN = 1 Then
  endstr$ = endstr$ + " to car"
  ElseIf RndN = 2 Then
  endstr$ = endstr$ + " hallway"
  ElseIf RndN = 3 Then
  endstr$ = endstr$ + " in house"
  End If
Else
endstr$ = endstr$ + Mid$(Text$, i, 1)
End If
Graph2 1, 1
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text$), i
Next i
endstr$ = Mid$(endstr$, 2, Len(endstr$) - 1)
Code1 = endstr$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function Code2(Text As String)
'This is a simpler (and smaller) coding system than code 1
On Error GoTo error
Graph1 6, 0
Text$ = ReplaceC(Text$, "  ", ";")
Text$ = ReplaceC(Text$, " ", ",")
Text$ = ReplaceC(Text$, "A", "a")
Text$ = ReplaceC(Text$, "B", "b")
Text$ = ReplaceC(Text$, "C", "c")
Text$ = ReplaceC(Text$, "D", "d")
Text$ = ReplaceC(Text$, "E", "e")
Text$ = ReplaceC(Text$, "F", "f")
Text$ = ReplaceC(Text$, "G", "g")
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 1
Text$ = ReplaceC(Text$, "H", "h")
Text$ = ReplaceC(Text$, "I", "i")
Text$ = ReplaceC(Text$, "J", "j")
Text$ = ReplaceC(Text$, "K", "k")
Text$ = ReplaceC(Text$, "L", "l")
Text$ = ReplaceC(Text$, "M", "m")
Text$ = ReplaceC(Text$, "N", "n")
Text$ = ReplaceC(Text$, "O", "o")
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 2
Text$ = ReplaceC(Text$, "P", "p")
Text$ = ReplaceC(Text$, "Q", "q")
Text$ = ReplaceC(Text$, "R", "r")
Text$ = ReplaceC(Text$, "S", "s")
Text$ = ReplaceC(Text$, "T", "t")
Text$ = ReplaceC(Text$, "U", "u")
Text$ = ReplaceC(Text$, "V", "v")
Text$ = ReplaceC(Text$, "W", "w")
Text$ = ReplaceC(Text$, "X", "x")
Text$ = ReplaceC(Text$, "Y", "y")
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 3
Text$ = ReplaceC(Text$, "Z", "z")
Text$ = ReplaceC(Text$, "a", " IT")
Text$ = ReplaceC(Text$, "b", " AE")
Text$ = ReplaceC(Text$, "c", " TA")
Text$ = ReplaceC(Text$, "d", " EA")
Text$ = ReplaceC(Text$, "e", " NA")
Text$ = ReplaceC(Text$, "f", " NT")
Text$ = ReplaceC(Text$, "g", " IE")
Text$ = ReplaceC(Text$, "h", " NN")
Text$ = ReplaceC(Text$, "i", " TE")
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 4
Text$ = ReplaceC(Text$, "j", " EI")
Text$ = ReplaceC(Text$, "k", " TI")
Text$ = ReplaceC(Text$, "l", " II")
Text$ = ReplaceC(Text$, "m", " NE")
Text$ = ReplaceC(Text$, "n", " AI")
Text$ = ReplaceC(Text$, "o", " TN")
Text$ = ReplaceC(Text$, "p", " AA")
Text$ = ReplaceC(Text$, "q", " EN")
Text$ = ReplaceC(Text$, "r", " IN")
Text$ = ReplaceC(Text$, "s", " AT")
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 5
Text$ = ReplaceC(Text$, "t", " AN")
Text$ = ReplaceC(Text$, "u", " NI")
Text$ = ReplaceC(Text$, "v", " EE")
Text$ = ReplaceC(Text$, "w", " TT")
Text$ = ReplaceC(Text$, "x", " XX")
Text$ = ReplaceC(Text$, "y", " ET")
Text$ = ReplaceC(Text$, "z", " IA")
Text$ = Mid$(Text$, 2, Len(Text$) - 1)
DoEvents
If DoCancel = True Then Exit Function
Graph1 6, 6
Code2 = Text$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function Decode1(Text As String)
'This decodes text coded by code 1
On Error GoTo error
Text$ = " " & Text$
Graph1 27, 0
Text$ = ReplaceC(Text$, " somewhere", "a")
Text$ = ReplaceC(Text$, " did you", "a")
Text$ = ReplaceC(Text$, " flowers", "a")
Text$ = ReplaceC(Text$, " eat food", "a")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 1
Text$ = ReplaceC(Text$, " light candle", "b")
Text$ = ReplaceC(Text$, " mirror", "b")
Text$ = ReplaceC(Text$, " cold soup", "b")
Text$ = ReplaceC(Text$, " video tape", "b")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 2
Text$ = ReplaceC(Text$, " the murder", "c")
Text$ = ReplaceC(Text$, " read book", "c")
Text$ = ReplaceC(Text$, " the show", "c")
Text$ = ReplaceC(Text$, " paper", "c")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 3
Text$ = ReplaceC(Text$, " beautiful", "d")
Text$ = ReplaceC(Text$, " do not", "d")
Text$ = ReplaceC(Text$, " bring", "d")
Text$ = ReplaceC(Text$, " that", "d")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 4
Text$ = ReplaceC(Text$, " star", "e")
Text$ = ReplaceC(Text$, " itself", "e")
Text$ = ReplaceC(Text$, " in a", "e")
Text$ = ReplaceC(Text$, " by", "e")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 5
Text$ = ReplaceC(Text$, " it is", "f")
Text$ = ReplaceC(Text$, " sea", "f")
Text$ = ReplaceC(Text$, " myself", "f")
Text$ = ReplaceC(Text$, " powerful", "f")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 6
Text$ = ReplaceC(Text$, " aren't", "g")
Text$ = ReplaceC(Text$, " nail filer", "g")
Text$ = ReplaceC(Text$, " everlasting", "g")
Text$ = ReplaceC(Text$, " magic", "g")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 7
Text$ = ReplaceC(Text$, " tomorrow", "h")
Text$ = ReplaceC(Text$, " tree", "h")
Text$ = ReplaceC(Text$, " it will", "h")
Text$ = ReplaceC(Text$, " fat", "h")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 8
Text$ = ReplaceC(Text$, " isn't", "i")
Text$ = ReplaceC(Text$, " explosion", "i")
Text$ = ReplaceC(Text$, " at school", "i")
Text$ = ReplaceC(Text$, " apples", "i")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 9
Text$ = ReplaceC(Text$, " when", "j")
Text$ = ReplaceC(Text$, " onions", "j")
Text$ = ReplaceC(Text$, " night", "j")
Text$ = ReplaceC(Text$, " about it", "j")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 10
Text$ = ReplaceC(Text$, " days", "k")
Text$ = ReplaceC(Text$, " right", "k")
Text$ = ReplaceC(Text$, " please", "k")
Text$ = ReplaceC(Text$, " oranges", "k")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 11
Text$ = ReplaceC(Text$, " wrong", "l")
Text$ = ReplaceC(Text$, " yesterday", "l")
Text$ = ReplaceC(Text$, " has", "l")
Text$ = ReplaceC(Text$, " money", "l")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 12
Text$ = ReplaceC(Text$, " today", "m")
Text$ = ReplaceC(Text$, " had", "m")
Text$ = ReplaceC(Text$, " mother", "m")
Text$ = ReplaceC(Text$, " his", "m")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 13
Text$ = ReplaceC(Text$, " french", "n")
Text$ = ReplaceC(Text$, " hurt", "n")
Text$ = ReplaceC(Text$, " ham", "n")
Text$ = ReplaceC(Text$, " milk", "n")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 14
Text$ = ReplaceC(Text$, " not", "o")
Text$ = ReplaceC(Text$, " see you", "o")
Text$ = ReplaceC(Text$, " rot", "o")
Text$ = ReplaceC(Text$, " five", "o")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 15
Text$ = ReplaceC(Text$, " see me", "p")
Text$ = ReplaceC(Text$, " hard", "p")
Text$ = ReplaceC(Text$, " mask", "p")
Text$ = ReplaceC(Text$, " ants", "p")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 16
Text$ = ReplaceC(Text$, " yes", "q")
Text$ = ReplaceC(Text$, " soft", "q")
Text$ = ReplaceC(Text$, " four", "q")
Text$ = ReplaceC(Text$, " in flour", "q")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 17
Text$ = ReplaceC(Text$, " no", "r")
Text$ = ReplaceC(Text$, " fast", "r")
Text$ = ReplaceC(Text$, " three", "r")
Text$ = ReplaceC(Text$, " cat", "r")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 18
Text$ = ReplaceC(Text$, " slow", "s")
Text$ = ReplaceC(Text$, " super", "s")
Text$ = ReplaceC(Text$, " two", "s")
Text$ = ReplaceC(Text$, " over the", "s")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 19
Text$ = ReplaceC(Text$, " medium", "t")
Text$ = ReplaceC(Text$, " hit", "t")
Text$ = ReplaceC(Text$, " one", "t")
Text$ = ReplaceC(Text$, " rainbow", "t")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 20
Text$ = ReplaceC(Text$, " zero", "u")
Text$ = ReplaceC(Text$, " fire", "u")
Text$ = ReplaceC(Text$, " ice", "u")
Text$ = ReplaceC(Text$, " malt", "u")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 21
Text$ = ReplaceC(Text$, " six", "v")
Text$ = ReplaceC(Text$, " hair", "v")
Text$ = ReplaceC(Text$, " light switch", "v")
Text$ = ReplaceC(Text$, " metal", "v")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 22
Text$ = ReplaceC(Text$, " computer", "w")
Text$ = ReplaceC(Text$, " comb", "w")
Text$ = ReplaceC(Text$, " bomb", "w")
Text$ = ReplaceC(Text$, " writing", "w")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 23
Text$ = ReplaceC(Text$, " eight ball", "x")
Text$ = ReplaceC(Text$, " smear", "x")
Text$ = ReplaceC(Text$, " letter", "x")
Text$ = ReplaceC(Text$, " cups", "x")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 24
Text$ = ReplaceC(Text$, " nine", "y")
Text$ = ReplaceC(Text$, " table", "y")
Text$ = ReplaceC(Text$, " basket", "y")
Text$ = ReplaceC(Text$, " open door", "y")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 25
Text$ = ReplaceC(Text$, " ten", "z")
Text$ = ReplaceC(Text$, " to car", "z")
Text$ = ReplaceC(Text$, " hallway", "z")
Text$ = ReplaceC(Text$, " in house", "z")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 26
Text$ = ReplaceC(Text$, ";", "  ")
Text$ = ReplaceC(Text$, ",", " ")
DoEvents
If DoCancel = True Then Exit Function
Graph1 27, 27
Decode1 = Text$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function Decode2(Text As String)
'This decodes text coded by code 2
On Error GoTo error
Text$ = " " & Text$
Graph1 7, 0
Text$ = ReplaceC(Text$, " IT", "a")
Text$ = ReplaceC(Text$, " AE", "b")
Text$ = ReplaceC(Text$, " TA", "c")
Text$ = ReplaceC(Text$, " EA", "d")
If DoCancel = True Then Exit Function
Graph1 7, 1
Text$ = ReplaceC(Text$, " NA", "e")
Text$ = ReplaceC(Text$, " NT", "f")
Text$ = ReplaceC(Text$, " IE", "g")
Text$ = ReplaceC(Text$, " NN", "h")
If DoCancel = True Then Exit Function
Graph1 7, 2
Text$ = ReplaceC(Text$, " TE", "i")
Text$ = ReplaceC(Text$, " EI", "j")
Text$ = ReplaceC(Text$, " TI", "k")
Text$ = ReplaceC(Text$, " II", "l")
If DoCancel = True Then Exit Function
Graph1 7, 3
Text$ = ReplaceC(Text$, " NE", "m")
Text$ = ReplaceC(Text$, " AI", "n")
Text$ = ReplaceC(Text$, " TN", "o")
Text$ = ReplaceC(Text$, " AA", "p")
If DoCancel = True Then Exit Function
Graph1 7, 4
Text$ = ReplaceC(Text$, " EN", "q")
Text$ = ReplaceC(Text$, " IN", "r")
Text$ = ReplaceC(Text$, " AT", "s")
Text$ = ReplaceC(Text$, " AN", "t")
If DoCancel = True Then Exit Function
Graph1 7, 5
Text$ = ReplaceC(Text$, " NI", "u")
Text$ = ReplaceC(Text$, " EE", "v")
Text$ = ReplaceC(Text$, " TT", "w")
Text$ = ReplaceC(Text$, " XX", "x")
If DoCancel = True Then Exit Function
Graph1 7, 6
Text$ = ReplaceC(Text$, " ET", "y")
Text$ = ReplaceC(Text$, " IA", "z")
Text$ = ReplaceC(Text$, ";", "  ")
Text$ = ReplaceC(Text$, ",", " ")
If DoCancel = True Then Exit Function
Graph1 7, 7
Decode2 = Text$
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Private Function ReplaceC(MainStr As String, OldStr As String, NewStr As String) As String
'For Section 12 (Code/Decode):  Replaces one string with another
On Error GoTo error
ReplaceC = ""
Dim NewStrString As String
Dim i As Integer
For i = 1 To Len(MainStr)
  If Mid(MainStr, i, Len(OldStr)) = OldStr Then
  NewStrString = NewStrString & NewStr
  i = i + Len(OldStr) - 1
  Else
  NewStrString = NewStrString & Mid(MainStr, i, 1)
  End If
DoEvents
If DoCancel = True Then Exit Function
Next i
ReplaceC = NewStrString
Exit Function
error:  MsgBox Err.Description, vbExclamation, "Error"
End Function

Function Decode(Text As String)
Dim Pos As Integer, endstr As String
Pos = 2
Again:
Graph2 1, 0
  If Not (Pos - 2) / 3 = Len(Text) - 1 Then
  endstr = endstr & Mid$(Text, Pos, 1)
  Pos = Pos + 3
  GoTo Again
  End If
Graph2 1, 1
DoEvents
If DoCancel = True Then Exit Function
Graph1 Len(Text) - 1, (Pos - 2) / 3
Decode = endstr
End Function

Public Sub OOS()
AmSpace = GetSetting("TU", "Settings", "AmSpace", 1)
EchoBack = GetSetting("TU", "Settings", "EchoBack", False)
AmDouble = GetSetting("TU", "Settings", "AmDouble", 1)
End Sub

Public Sub SOS()
Call SaveSetting("TU", "Settings", "AmSpace", AmSpace)
Call SaveSetting("TU", "Settings", "EchoBack", EchoBack)
Call SaveSetting("TU", "Settings", "AmDouble", AmDouble)
End Sub

Public Sub GetReady()
TextTS.Text = TextT.Text
DoCancel = False
Graph1 1, 0
Graph2 1, 0
TUFrm.WindowState = 1
TUFrm.Enabled = False
PrgFrm.Show
End Sub

Function ToDec(Text As String)
Dim endstr As String, xtra As String, xtra2 As Integer, xtra3 As String, i As Single
endstr$ = ""
CH:
  If Not Int(Len(Text) / 8) = Len(Text) / 8 Then
  Text = Mid$(Text, 1, Len(Text) - 1)
  GoTo CH
  End If
For i = 1 To Len(Text)
xtra$ = Mid$(Text, i, 1)
  If Not xtra$ = "1" Then
    If Not xtra$ = "0" Then
    Exit Function
    End If
  End If
Next i
For i = 0 To (Len(Text) / 8) - 1
Graph2 1, 0
xtra3$ = Mid(Text, (i * 8) + 1, 8)
xtra2 = Dec("00000000" & xtra3$)
xtra$ = Chr$(xtra2)
endstr$ = endstr$ & xtra$
Graph2 1, 1
DoEvents
If DoCancel = True Then Exit Function
Graph3 (Len(Text) / 8) - 1, i
Next i
ToDec = endstr$
End Function

Function ToDec2(Text As String)
Dim endstr As String, xtra As String, xtra2 As Integer, xtra3 As String, i As Single
endstr$ = ""
CH:
  If Not Int(Len(Text) / 8) = Len(Text) / 8 Then
  Text = Mid$(Text, 1, Len(Text) - 1)
  GoTo CH
  End If
For i = 1 To Len(Text)
xtra$ = Mid$(Text, i, 1)
  If Not xtra$ = "1" Then
    If Not xtra$ = "0" Then
    Exit Function
    End If
  End If
Next i
For i = 0 To (Len(Text) / 8) - 1
xtra3$ = Mid(Text, (i * 8) + 1, 8)
xtra2 = Dec("00000000" & xtra3$)
xtra$ = Chr$(xtra2)
endstr$ = endstr$ & xtra$
Next i
ToDec2 = endstr$
End Function

Function Dec(strBin) As Integer

    Dim intLess As Integer
    Dim lngDummy As Long
    Dim strDummy As String
    Dim i As Integer
    strDummy = strBin
    intLess = 16384


    If Left(strDummy, 1) = "0" Then


        For i = 2 To 16


            If Mid(strDummy, i, 1) = "1" Then
                lngDummy = lngDummy + intLess
            End If

            intLess = intLess / 2
        Next i

        lngDummy = lngDummy
    Else


        For i = 2 To 16


            If Mid(strDummy, i, 1) = "0" Then
                lngDummy = lngDummy + intLess
            End If

            intLess = intLess / 2
        Next i

        lngDummy = (lngDummy * -1) - 1
    End If

    Dec = CInt(lngDummy)
End Function

Public Sub DeReady()
Enabled = True
WindowState = 2
PrgFrm.Hide
Graph1 1, 0
Graph2 1, 0
If DoCancel = True Then TextT.Text = TextTS.Text
DoCancel = False
SetFocus
End Sub
