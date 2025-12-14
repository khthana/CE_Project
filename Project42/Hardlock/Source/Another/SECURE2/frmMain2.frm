VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Encode for Hardlock"
   ClientHeight    =   6495
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6750
   Icon            =   "frmMain2.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   433
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   450
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command5 
      Caption         =   "Debug"
      Height          =   375
      Left            =   480
      TabIndex        =   17
      Top             =   3960
      Width           =   975
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Receive"
      Height          =   375
      Left            =   480
      TabIndex        =   16
      Top             =   3360
      Width           =   975
   End
   Begin VB.CommandButton cmdexit 
      Cancel          =   -1  'True
      Caption         =   "Exit"
      Height          =   375
      Left            =   3960
      TabIndex        =   0
      ToolTipText     =   "End Program"
      Top             =   1920
      Width           =   735
   End
   Begin VB.Frame fraControls 
      BorderStyle     =   0  'None
      Height          =   6375
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6855
      Begin VB.CommandButton Command7 
         Caption         =   "decode"
         Height          =   375
         Left            =   4560
         TabIndex        =   23
         Top             =   5400
         Width           =   735
      End
      Begin VB.CommandButton Command6 
         Caption         =   "encode"
         Height          =   375
         Left            =   2160
         TabIndex        =   22
         Top             =   5400
         Width           =   735
      End
      Begin VB.CommandButton Command2 
         Caption         =   "Send"
         Height          =   375
         Left            =   480
         TabIndex        =   15
         Top             =   2640
         Width           =   975
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Connect"
         Height          =   375
         Left            =   480
         TabIndex        =   14
         Top             =   1920
         Width           =   975
      End
      Begin MSCommLib.MSComm Mscomm1 
         Left            =   5880
         Top             =   1800
         _ExtentX        =   1005
         _ExtentY        =   1005
         _Version        =   393216
         CommPort        =   2
         DTREnable       =   0   'False
         InputLen        =   1
         RThreshold      =   1
      End
      Begin VB.TextBox txtWork 
         Height          =   405
         Left            =   1800
         TabIndex        =   9
         ToolTipText     =   "Enter Input File Name"
         Top             =   480
         Width           =   3495
      End
      Begin VB.CommandButton cmdInput 
         Caption         =   "Browse"
         Height          =   375
         Left            =   5640
         TabIndex        =   8
         ToolTipText     =   "Browse For An Input File"
         Top             =   480
         Width           =   735
      End
      Begin VB.TextBox txtOutput 
         Height          =   405
         Left            =   1800
         TabIndex        =   7
         ToolTipText     =   "Enter Output File Name"
         Top             =   1200
         Width           =   3495
      End
      Begin VB.CommandButton cmdOutput 
         Caption         =   "Browse"
         Height          =   375
         Left            =   5640
         TabIndex        =   6
         ToolTipText     =   "Browse For An Output File"
         Top             =   1200
         Width           =   735
      End
      Begin VB.CommandButton cmdEncode 
         Caption         =   "Encode"
         Height          =   375
         Left            =   2400
         TabIndex        =   5
         ToolTipText     =   "Begin Encryption"
         Top             =   1920
         Width           =   735
      End
      Begin VB.Frame fraWork 
         BackColor       =   &H8000000D&
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   4920
         TabIndex        =   2
         Top             =   4440
         Visible         =   0   'False
         Width           =   1335
         Begin VB.Label lblWork2 
            Alignment       =   2  'Center
            BackColor       =   &H8000000D&
            BackStyle       =   0  'Transparent
            Caption         =   "Idle"
            ForeColor       =   &H8000000E&
            Height          =   195
            Left            =   0
            TabIndex        =   4
            Top             =   120
            Width           =   735
         End
         Begin VB.Label lblStatus 
            Alignment       =   2  'Center
            BackColor       =   &H8000000D&
            BackStyle       =   0  'Transparent
            Caption         =   "X%"
            ForeColor       =   &H8000000E&
            Height          =   195
            Left            =   720
            TabIndex        =   3
            Top             =   120
            Width           =   735
         End
      End
      Begin MSComDlg.CommonDialog CdlFile 
         Left            =   5280
         Top             =   1800
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         Filter          =   $"frmMain2.frx":27A2
      End
      Begin VB.TextBox Text1 
         BeginProperty Font 
            Name            =   "Terminal"
            Size            =   6
            Charset         =   255
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   1695
         Left            =   1560
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   13
         Top             =   2640
         Width           =   5175
      End
      Begin VB.Label Label4 
         Caption         =   "0"
         Height          =   255
         Left            =   1800
         TabIndex        =   21
         Top             =   4680
         Width           =   615
      End
      Begin VB.Label Label7 
         Caption         =   "0"
         Height          =   255
         Left            =   4320
         TabIndex        =   20
         Top             =   4680
         Width           =   495
      End
      Begin VB.Label Label6 
         Caption         =   "0"
         Height          =   255
         Left            =   3480
         TabIndex        =   19
         Top             =   4680
         Width           =   495
      End
      Begin VB.Label Label5 
         Caption         =   "0"
         Height          =   255
         Left            =   2760
         TabIndex        =   18
         Top             =   4680
         Width           =   495
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Status"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   2280
         TabIndex        =   12
         Top             =   2760
         Width           =   555
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Output file"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   360
         TabIndex        =   11
         Top             =   1200
         Width           =   750
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "File to Encode"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   360
         TabIndex        =   10
         Top             =   480
         Width           =   1290
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Command2_Click()
    Senddes
End Sub

Sub Senddes()
    If Mscomm1.PortOpen = True Then
        Mscomm1.Output = Enterkey & "1" & Chr$(Senddata(0)) & Chr$(Senddata(1)) & Chr$(Senddata(2)) & Chr$(Senddata(3))
    End If
End Sub

Sub Receivedes()
    If Mscomm1.PortOpen = True Then
                
        Mscomm1.Output = Enterkey & "2"
        Datanum = 0
        Sendnextbyte
        
        Do While Not Receiveflag
            DoEvents
        Loop
        Datanum = 1
        Sendnextbyte
        
        Do While Not Receiveflag
            DoEvents
        Loop
        Datanum = 2
        Sendnextbyte
        
        Do While Not Receiveflag
            DoEvents
        Loop
        Datanum = 3
        Sendnextbyte
        
        
    End If
End Sub

Sub Encode()
    If Mscomm1.PortOpen = True Then
        Mscomm1.Output = Enterkey & "3"
    End If
End Sub
Sub Decode()
    If Mscomm1.PortOpen = True Then
        Mscomm1.Output = Enterkey & "4"
    End If
End Sub

Sub Sendnextbyte()
    If Mscomm1.PortOpen = True Then
        Mscomm1.Output = Enterkey & "Z"
        Receiveflag = False
    End If
End Sub

Private Sub cmdencode_Click()
fraControls.Enabled = False
cmdexit.Enabled = False
MousePointer = vbHourglass
fraWork.Visible = True
lblStatus.Caption = "X%"
If SecureFile(txtWork.Text, txtOutput.Text, True, True) Then
End If
MousePointer = vbDefault
fraControls.Enabled = True
cmdexit.Enabled = True
End Sub

Private Sub cmdexit_Click()
    Unload Me
    End
End Sub

Private Sub cmdinput_Click()
'Setup error handling
On Error GoTo Err_Sub
'Show open dialog
CdlFile.ShowOpen

'Check to make sure file exists
If Dir$(CdlFile.FileName) = "" Then
    MsgBox "File not found", vbExclamation, "Error"
    Exit Sub
End If


'Record the name of our file
txtWork.Text = CdlFile.FileName
txtOutput.Text = txtWork.Text
txtWork.SelStart = Len(txtWork.Text)
txtOutput.SelStart = Len(txtOutput.Text)
Exit_Sub:
Exit Sub

Err_Sub:

End Sub

Private Sub cmdoutput_Click()
'Setup error handling
On Error GoTo Err_Sub
'Show open dialog
CdlFile.ShowSave

'Check to make sure file exists
If Dir$(CdlFile.FileName) = "" Then
    MsgBox "File not found", vbExclamation, "Error"
    Exit Sub
End If


'Record the name of our file
txtOutput.Text = CdlFile.FileName
txtOutput.SelStart = Len(txtOutput.Text)

Exit_Sub:
Exit Sub

Err_Sub:
End Sub

Private Sub cmdOK_Click()


End Sub

Private Sub Command1_Click()
    If Mscomm1.PortOpen = True Then
        Command1.Caption = "Connect"
        Mscomm1.PortOpen = False
    Else
        Command1.Caption = "Disconnect"
        Mscomm1.PortOpen = True
    End If
     
End Sub

Private Sub Command3_Click()
    Receivedes
End Sub


Private Sub Command6_Click()
    Encode
End Sub

Private Sub Command5_Click()
    Label4.Caption = Receivedata(0)
    Label5.Caption = Receivedata(1)
    Label6.Caption = Receivedata(2)
    Label7.Caption = Receivedata(3)
End Sub

Private Sub Command7_Click()
    Decode
End Sub

Private Sub Form_Load()
   Enterkey = "XyZ"
   Receiveflag = False
   Datanum = 0
   
   Senddata(0) = 11
   Senddata(1) = 22
   Senddata(2) = 33
   Senddata(3) = 44
   
End Sub

Private Sub MSComm1_OnComm()
    Dim InString As String

If Mscomm1.InBufferCount Then
   ' Read data.
   InString = Mscomm1.Input
     
'===============================================

   
        Receivedata(Datanum) = Asc(InString)
        MsgBox ("ok")
        Receiveflag = True

    
'===============================================
   ShowData Text1, InString
  
End If

End Sub
Private Static Sub ShowData(Term As Control, Data As String)
    On Error GoTo Handler
    Const MAXTERMSIZE = 16000
    Dim TermSize As Long, i
    
    ' Make sure the existing text doesn't get too large.
    TermSize = Len(Term.Text)
    If TermSize > MAXTERMSIZE Then
       Term.Text = Mid$(Term.Text, 4097)
       TermSize = Len(Term.Text)
    End If

    ' Point to the end of Term's data.
    Term.SelStart = TermSize

    ' Filter/handle BACKSPACE characters.
    Do
       i = InStr(Data, Chr$(8))
       If i Then
          If i = 1 Then
             Term.SelStart = TermSize - 1
             Term.SelLength = 1
             Data = Mid$(Data, i + 1)
          Else
             Data = Left$(Data, i - 2) & Mid$(Data, i + 1)
          End If
       End If
    Loop While i

    ' Eliminate line feeds.
    Do
       i = InStr(Data, Chr$(10))
       If i Then
          Data = Left$(Data, i - 1) & Mid$(Data, i + 1)
       End If
    Loop While i

    ' Make sure all carriage returns have a line feed.
    i = 1
    Do
       i = InStr(i, Data, Chr$(13))
       If i Then
          Data = Left$(Data, i) & Chr$(10) & Mid$(Data, i + 1)
          i = i + 1
       End If
    Loop While i

    ' Add the filtered data to the SelText property.
    Term.SelText = Data
  
    ' Log data to file if requested.
    If hLogFile Then
       i = 2
       Do
          Err = 0
          Put hLogFile, , Data
          If Err Then
             i = MsgBox(Error$, 21)
             If i = 2 Then
                'mnuCloseLog_Click
             End If
          End If
       Loop While i <> 2
    End If
    Term.SelStart = Len(Term.Text)
Exit Sub

Handler:
    MsgBox Error$
    Resume Next
End Sub

