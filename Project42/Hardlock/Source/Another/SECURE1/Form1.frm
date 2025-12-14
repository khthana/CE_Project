VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Code"
   ClientHeight    =   4965
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6660
   Icon            =   "Form1.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4965
   ScaleWidth      =   6660
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command4 
      Caption         =   "Open"
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Top             =   4440
      Width           =   1455
   End
   Begin MSComctlLib.ImageList ImageList1 
      Left            =   4080
      Top             =   1080
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   32
      ImageHeight     =   32
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   3
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":0FC2
            Key             =   "direktorijum"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":2786
            Key             =   "kljuc"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":375A
            Key             =   "tekst"
         EndProperty
      EndProperty
   End
   Begin VB.DirListBox Dir1 
      Height          =   3690
      Left            =   120
      TabIndex        =   6
      Top             =   600
      Width           =   2295
   End
   Begin VB.FileListBox File1 
      Height          =   675
      Left            =   5400
      Pattern         =   "*.cod;*.txt"
      TabIndex        =   5
      Top             =   0
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Code"
      Height          =   375
      Left            =   1680
      TabIndex        =   4
      Top             =   4440
      Width           =   1455
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Decode"
      Height          =   375
      Left            =   3240
      TabIndex        =   3
      Top             =   4440
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Exit"
      Height          =   375
      Left            =   4800
      TabIndex        =   2
      Top             =   4440
      Width           =   1695
   End
   Begin MSComctlLib.ListView ListView1 
      Height          =   3615
      Left            =   2520
      TabIndex        =   1
      Top             =   720
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   6376
      Arrange         =   1
      LabelEdit       =   1
      SortOrder       =   -1  'True
      Sorted          =   -1  'True
      LabelWrap       =   -1  'True
      HideSelection   =   0   'False
      HotTracking     =   -1  'True
      HoverSelection  =   -1  'True
      PictureAlignment=   5
      _Version        =   393217
      Icons           =   "ImageList1"
      SmallIcons      =   "ImageList1"
      ColHdrIcons     =   "ImageList1"
      ForeColor       =   -2147483640
      BackColor       =   -2147483643
      BorderStyle     =   1
      Appearance      =   1
      NumItems        =   0
   End
   Begin VB.DriveListBox Drive1 
      Height          =   315
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   2895
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "Selected:"
      Height          =   195
      Left            =   3120
      TabIndex        =   9
      Top             =   240
      Width           =   675
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Label1"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFF00&
      Height          =   195
      Left            =   3960
      TabIndex        =   7
      Top             =   240
      Width           =   585
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



'                    Code and decode TextFiles

'     Pretty good way to code text file;
'     Code and Decode using password
'     How to use some common controlls (FileListBox,
'     Image list, ListView, DirLisBox, FileListBox...
'     Very clean encrypting (no trash left)
'                 sslavko@yubc.net
'     _______________________________________________





Public Sub osvezi() 'Refresh
ListView1.ListItems.Clear

'For i = 0 To Dir1.ListCount - 1
'ListView1.ListItems.Add , "dir" + Right$(Str$(i), Len(Str$(i))), Right$(Dir1.List(i), Len(Dir1.List(i)) - Len(Dir1.Path)), ImageList1.ListImages.Item(1).Key, ImageList1.ListImages.Item(1).Key
'Next i
Label1.Caption = Dir1.Path

File1.Path = Dir1.Path
For i = 0 To File1.ListCount - 1
If Right$(File1.List(i), 3) = "cod" Then
ListView1.ListItems.Add , "file" + Right$(Str$(i), Len(Str$(i))), File1.List(i), ImageList1.ListImages.Item(2).Key, ImageList1.ListImages.Item(2).Key
Else
ListView1.ListItems.Add , "file" + Right$(Str$(i), Len(Str$(i))), File1.List(i), ImageList1.ListImages.Item(3).Key, ImageList1.ListImages.Item(3).Key
End If
Next i
ListView1.Refresh
End Sub


Private Sub Command1_Click()
End
End Sub


Private Sub Command1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Command1.SetFocus
End Sub


Private Sub Command2_Click()
Dim slovo(1 To 80) As String

'Set password
s$ = InputBox$("Password:", "Enter Password")
If s$ = "" Then
Beep
MsgBox "Password required!", , "Error"
Exit Sub
End If

'processing password
For i = 1 To Len(s$)
 slovo(i) = Mid$(s$, i, 1)
Next i
k = 1
Max = i

'Read, encrypt, write
If Label1.Caption = "" Then
Beep
MsgBox$ "Select File.", , "Error"
Exit Sub
End If

If Right$(Dir1.Path, 1) = "\" Then otvori$ = Dir1.Path Else otvori$ = Dir1.Path + "\"
Open otvori$ + Label1.Caption For Input As 1
Open otvori$ + "dekode.txt" For Output As 2
Do Until EOF(1)
Line Input #1, a$
'ENGINE
b$ = ""
posl = 1
For i = 1 To Len(a$) Step 4
d% = Val(Mid$(a$, i, 4)) - Asc(slovo(k))
If d% = 0 Or d% > 255 Then Exit For
b$ = b$ + Chr$(d%)
k = k + 1
If k > (Max - 1) Then k = 1
Next i
Print #2, b$
Loop
Close #1
Close #2
ListView1.ListItems.Add , "file" + Label1.Caption, "dekode.txt", ImageList1.ListImages.Item(3).Key, ImageList1.ListImages.Item(3).Key
End Sub

Private Sub Command2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Command2.SetFocus
End Sub


Private Sub Command3_Click()
Dim slovo(1 To 80) As String
Dim a As String * 80


s$ = InputBox$("Password:", "Enter")
If s$ = "" Then
Beep
MsgBox "Enter password", , "Error"
Exit Sub
End If


For i = 1 To Len(s$)
 slovo(i) = Mid$(s$, i, 1)
Next i
k = 1
Max = i

If Label1.Caption = "" Then
Beep
MsgBox "Select File.", vbOKOnly, "Error"
Exit Sub
End If



If Right$(Dir1.Path, 1) = "\" Then otvori$ = Dir1.Path + Label1.Caption Else otvori$ = Dir1.Path + "\" + Label1.Caption
fajl$ = Left$(otvori$, Len(otvori$) - 4) + ".cod"
Open otvori$ For Input As 1
Open fajl$ For Output As 2
Do Until EOF(1)
Line Input #1, a

'ENGINE
b$ = ""
For i = 1 To 80
d% = Asc(Mid$(a, i, 1)) + Asc(slovo(k))
b$ = b$ + Str$(d%)
k = k + 1
If k > (Max - 1) Then k = 1
Next i

Print #2, b$
Loop
Close #1
Close #2
ListView1.ListItems.Add , "file" + Label1.Caption, Left$(Label1.Caption, Len(Label1.Caption) - 4) + ".cod", ImageList1.ListImages.Item(2).Key, ImageList1.ListImages.Item(2).Key
End Sub

Private Sub Command3_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Command3.SetFocus
End Sub


Private Sub Command4_Click()
If LCase$(Right$(Label1.Caption, 3)) = "txt" Then
Form2.Show
Else
Beep
MsgBox "TextFiles only!", vbOKOnly, "Error"
End If
End Sub

Private Sub Command4_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Command4.SetFocus
End Sub


Private Sub Dir1_Change()
ListView1.ListItems.Clear

'For i = 0 To Dir1.ListCount - 1
'ListView1.ListItems.Add , "dir" + Right$(Str$(i), Len(Str$(i))), Right$(Dir1.List(i), Len(Dir1.List(i)) - Len(Dir1.Path)), ImageList1.ListImages.Item(1).Key, ImageList1.ListImages.Item(1).Key
'Next i
Label1.Caption = ""

File1.Path = Dir1.Path
For i = 0 To File1.ListCount - 1
If Right$(File1.List(i), 3) = "cod" Then
ListView1.ListItems.Add , "file" + Right$(Str$(i), Len(Str$(i))), File1.List(i), ImageList1.ListImages.Item(2).Key, ImageList1.ListImages.Item(2).Key
Else
ListView1.ListItems.Add , "file" + Right$(Str$(i), Len(Str$(i))), File1.List(i), ImageList1.ListImages.Item(3).Key, ImageList1.ListImages.Item(3).Key
End If
Next i

End Sub

Private Sub Dir1_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
Dir1.SetFocus
End Sub


Private Sub Drive1_Change()
Dir1.Path = Drive1.Drive
File1.Path = Dir1.Path

End Sub



Private Sub Form_Load()
Dir1.Path = "c:\My Documents"
osvezi
Label1.Caption = ""
End Sub

Private Sub ListView1_ItemClick(ByVal Item As MSComctlLib.ListItem)
Label1.Caption = Item.Text
Command3.Enabled = True

End Sub




