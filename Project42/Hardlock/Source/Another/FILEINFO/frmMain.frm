VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "File Info Demo Project"
   ClientHeight    =   5400
   ClientLeft      =   3105
   ClientTop       =   3330
   ClientWidth     =   5670
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5400
   ScaleWidth      =   5670
   Begin VB.TextBox txtsize 
      Height          =   375
      Left            =   960
      Locked          =   -1  'True
      TabIndex        =   19
      Top             =   840
      Width           =   4455
   End
   Begin VB.TextBox txtname 
      Height          =   375
      Left            =   960
      Locked          =   -1  'True
      TabIndex        =   18
      Top             =   240
      Width           =   4455
   End
   Begin VB.Frame fradates 
      Caption         =   "Dates"
      Height          =   2175
      Left            =   2040
      TabIndex        =   9
      Top             =   1320
      Width           =   3375
      Begin VB.Label lbldate 
         Caption         =   "00/00/0000 00:00:00"
         Height          =   255
         Index           =   0
         Left            =   1560
         TabIndex        =   15
         Top             =   240
         Width           =   1695
      End
      Begin VB.Label lbldatetxt 
         Caption         =   "Created:"
         Height          =   255
         Index           =   0
         Left            =   240
         TabIndex        =   14
         Top             =   240
         Width           =   1215
      End
      Begin VB.Label lbldatetxt 
         Caption         =   "Last Modified:"
         Height          =   255
         Index           =   1
         Left            =   240
         TabIndex        =   13
         Top             =   600
         Width           =   1215
      End
      Begin VB.Label lbldate 
         Caption         =   "00/00/0000 00:00:00"
         Height          =   255
         Index           =   1
         Left            =   1560
         TabIndex        =   12
         Top             =   600
         Width           =   1695
      End
      Begin VB.Label lbldatetxt 
         Caption         =   "Last Accessed:"
         Height          =   255
         Index           =   2
         Left            =   240
         TabIndex        =   11
         Top             =   960
         Width           =   1215
      End
      Begin VB.Label lbldate 
         Caption         =   "00/00/0000 00:00:00"
         Height          =   255
         Index           =   2
         Left            =   1560
         TabIndex        =   10
         Top             =   960
         Width           =   1695
      End
   End
   Begin VB.CommandButton ok 
      Cancel          =   -1  'True
      Caption         =   "&Done"
      Default         =   -1  'True
      Height          =   495
      Left            =   240
      TabIndex        =   8
      Top             =   3720
      Width           =   5175
   End
   Begin VB.Frame fraattrib 
      Caption         =   "Attributes"
      Height          =   2175
      Left            =   240
      TabIndex        =   0
      Top             =   1320
      Width           =   1695
      Begin VB.CheckBox attributes 
         Caption         =   "Normal"
         Height          =   195
         Index           =   6
         Left            =   240
         TabIndex        =   7
         Top             =   1560
         Width           =   1215
      End
      Begin VB.CheckBox attributes 
         Caption         =   "Compressed"
         Height          =   195
         Index           =   7
         Left            =   240
         TabIndex        =   6
         Top             =   1800
         Width           =   1215
      End
      Begin VB.CheckBox attributes 
         Caption         =   "Temporary"
         Height          =   195
         Index           =   5
         Left            =   240
         TabIndex        =   5
         Top             =   1320
         Width           =   1215
      End
      Begin VB.CheckBox attributes 
         Caption         =   "Archive"
         Height          =   195
         Index           =   4
         Left            =   240
         TabIndex        =   4
         Top             =   1080
         Width           =   1215
      End
      Begin VB.CheckBox attributes 
         Caption         =   "Read Only"
         Height          =   195
         Index           =   3
         Left            =   240
         TabIndex        =   3
         Top             =   840
         Width           =   1215
      End
      Begin VB.CheckBox attributes 
         Caption         =   "System"
         Height          =   195
         Index           =   2
         Left            =   240
         TabIndex        =   2
         Top             =   600
         Width           =   1215
      End
      Begin VB.CheckBox attributes 
         Caption         =   "Hidden"
         Height          =   195
         Index           =   1
         Left            =   240
         TabIndex        =   1
         Top             =   360
         Width           =   1215
      End
   End
   Begin MSComDlg.CommonDialog dialog 
      Left            =   0
      Top             =   0
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
      CancelError     =   -1  'True
      DialogTitle     =   "File Info Demo Project"
      Filter          =   "All Files (*.*) | *.*"
      Flags           =   2101252
   End
   Begin VB.Label lblinfo1 
      AutoSize        =   -1  'True
      Caption         =   "For more demonstration Visual Basic Projects, please visit:"
      Height          =   195
      Left            =   240
      TabIndex        =   23
      Top             =   4320
      Width           =   4080
   End
   Begin VB.Label lblurl 
      AutoSize        =   -1  'True
      Caption         =   "http://www.vb-world.net"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   195
      Left            =   240
      TabIndex        =   22
      Top             =   4560
      Width           =   1740
   End
   Begin VB.Label lblemail 
      AutoSize        =   -1  'True
      Caption         =   "john@vb-world.net"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   195
      Left            =   240
      TabIndex        =   21
      Top             =   5040
      Width           =   1335
   End
   Begin VB.Label lblinfo2 
      AutoSize        =   -1  'True
      Caption         =   "To contact us, please send email to:"
      Height          =   195
      Left            =   240
      TabIndex        =   20
      Top             =   4800
      Width           =   2565
   End
   Begin VB.Label lblsize 
      Caption         =   "Size:"
      Height          =   375
      Left            =   240
      TabIndex        =   17
      Top             =   840
      Width           =   735
   End
   Begin VB.Label lblname 
      Caption         =   "Name:"
      Height          =   375
      Left            =   240
      TabIndex        =   16
      Top             =   240
      Width           =   615
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Sub updatestats()

Dim ftime As SYSTEMTIME               ' Initialise variables
Dim tfilename As String
tfilename = dialog.filename
Dim filedata As WIN32_FIND_DATA

filedata = Findfile(tfilename)        ' Get information

txtname = tfilename                   ' Put name in text box

If filedata.nFileSizeHigh = 0 Then    ' Put size into text box
  txtsize = filedata.nFileSizeLow & " Bytes"
Else
  txtsize = filedata.nFileSizeHigh & "Bytes"
End If

Call FileTimeToSystemTime(filedata.ftCreationTime, ftime)   ' Determine Creation date and time, then format it
lbldate(0) = ftime.wDay & "/" & ftime.wMonth & "/" & ftime.wYear & " " & ftime.wHour & ":" & ftime.wMinute & ":" & ftime.wSecond
Call FileTimeToSystemTime(filedata.ftLastWriteTime, ftime)  ' Determine Last Modified date and time
lbldate(1) = ftime.wDay & "/" & ftime.wMonth & "/" & ftime.wYear & " " & ftime.wHour & ":" & ftime.wMinute & ":" & ftime.wSecond
Call FileTimeToSystemTime(filedata.ftLastAccessTime, ftime) ' Determine Last accessed date (note no time is recorded)
lbldate(2) = ftime.wDay & "/" & ftime.wMonth & "/" & ftime.wYear

If (filedata.dwFileAttributes And FILE_ATTRIBUTE_HIDDEN) = FILE_ATTRIBUTE_HIDDEN Then
  attributes(1).Value = 1 ' Determine if file has hidden attribute set
Else
  attributes(1).Value = 0
End If
If (filedata.dwFileAttributes And FILE_ATTRIBUTE_SYSTEM) = FILE_ATTRIBUTE_SYSTEM Then
  attributes(2).Value = 1 ' Determine if file has system attribute set
Else
  attributes(2).Value = 0
End If
If (filedata.dwFileAttributes And FILE_ATTRIBUTE_READONLY) = FILE_ATTRIBUTE_READONLY Then
  attributes(3).Value = 1 ' Determine if file has readonly attribute set
Else
  attributes(3).Value = 0
End If
If (filedata.dwFileAttributes And FILE_ATTRIBUTE_ARCHIVE) = FILE_ATTRIBUTE_ARCHIVE Then
  attributes(4).Value = 1 ' Determine if file has archive attribute set
Else
  attributes(4).Value = 0
End If
If (filedata.dwFileAttributes And FILE_ATTRIBUTE_TEMPORARY) = FILE_ATTRIBUTE_TEMPORARY Then
  attributes(5).Value = 1 ' Determine if file has temporary attribute set
Else
  attributes(5).Value = 0
End If
If (filedata.dwFileAttributes And FILE_ATTRIBUTE_NORMAL) = FILE_ATTRIBUTE_NORMAL Then
  attributes(6).Value = 1 ' Determine if file has normal attribute set
Else
  attributes(6).Value = 0
End If
If (filedata.dwFileAttributes And FILE_ATTRIBUTE_COMPRESSED) = FILE_ATTRIBUTE_COMPRESSED Then
  attributes(7).Value = 1 ' Determine if file has compressed attribute set
Else
  attributes(7).Value = 0
End If
End Sub

Private Sub attributes_GotFocus(Index As Integer)
ok.SetFocus     ' Make it impossible to change check boxes
End Sub


Private Sub Form_Load()
On Error GoTo errhand

lblemail = email
lblurl = URL

dialog.ShowOpen ' Show open common dialog box
updatestats     ' Update infomation on form
Me.Show         ' Show the form
ok.SetFocus     ' Set focus to Done button
Exit Sub

errhand:
If Err.Number = cdlCancel Then
  Call MsgBox("You Pressed Cancel!", vbExclamation)   ' Cancel was pressed in common dialog box
Else
  Call MsgBox("An error has occured!", vbExclamation) ' An unexpected eror has occured
End If
End
End Sub

Private Sub ok_Click()
End
End Sub

Private Sub lblemail_Click()
sendemail
End Sub

Private Sub lblurl_Click()
gotoweb
End Sub

