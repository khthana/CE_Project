VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
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
   Begin VB.TextBox Text2 
      Alignment       =   1  'Right Justify
      Height          =   315
      Left            =   2640
      TabIndex        =   14
      Text            =   "0"
      Top             =   4800
      Width           =   495
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   2160
      Top             =   5520
   End
   Begin VB.Frame Text1Text1Text1Text1 
      BackColor       =   &H00E0E0E0&
      BorderStyle     =   0  'None
      ForeColor       =   &H0000FFFF&
      Height          =   6375
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6855
      Begin VB.CommandButton Cmdreset 
         Caption         =   "Reset Hardlock"
         Height          =   375
         Left            =   4800
         TabIndex        =   27
         Top             =   1920
         Width           =   1455
      End
      Begin VB.CommandButton Command7 
         Caption         =   "RC"
         Height          =   375
         Left            =   120
         TabIndex        =   26
         Top             =   5040
         Width           =   375
      End
      Begin VB.CommandButton Command6 
         Caption         =   "ST"
         Height          =   375
         Left            =   120
         TabIndex        =   25
         Top             =   4320
         Width           =   375
      End
      Begin VB.Timer Timer2 
         Enabled         =   0   'False
         Interval        =   2500
         Left            =   2520
         Top             =   5520
      End
      Begin VB.CommandButton Command5 
         Caption         =   "E"
         Height          =   375
         Left            =   600
         TabIndex        =   24
         Top             =   5040
         Width           =   375
      End
      Begin VB.CommandButton Command4 
         Caption         =   "D"
         Height          =   375
         Left            =   600
         TabIndex        =   23
         Top             =   4320
         Width           =   375
      End
      Begin VB.CommandButton Command3 
         Caption         =   "R"
         Height          =   375
         Left            =   1320
         TabIndex        =   18
         Top             =   4320
         Width           =   375
      End
      Begin VB.CommandButton Command2 
         Caption         =   "S"
         Height          =   375
         Left            =   5040
         TabIndex        =   17
         Top             =   4800
         Width           =   375
      End
      Begin VB.TextBox Text4 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   4080
         TabIndex        =   16
         Text            =   "0"
         Top             =   4800
         Width           =   495
      End
      Begin VB.TextBox Text3 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   3360
         TabIndex        =   15
         Text            =   "0"
         Top             =   4800
         Width           =   495
      End
      Begin VB.TextBox Text1 
         Alignment       =   1  'Right Justify
         Height          =   315
         Left            =   1920
         TabIndex        =   13
         Text            =   "0"
         Top             =   4800
         Width           =   495
      End
      Begin VB.CommandButton Cmddecode 
         BackColor       =   &H000080FF&
         Caption         =   "Decode"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   18
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   450
         Left            =   4080
         TabIndex        =   11
         Top             =   2520
         Width           =   975
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Connect"
         Height          =   375
         Left            =   3120
         TabIndex        =   10
         Top             =   5400
         Width           =   975
      End
      Begin MSCommLib.MSComm Mscomm1 
         Left            =   4440
         Top             =   5520
         _ExtentX        =   1005
         _ExtentY        =   1005
         _Version        =   393216
         CommPort        =   2
         DTREnable       =   -1  'True
         InputLen        =   1
         RThreshold      =   1
         RTSEnable       =   -1  'True
         SThreshold      =   1
      End
      Begin VB.TextBox txtWork 
         CausesValidation=   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   1800
         TabIndex        =   7
         ToolTipText     =   "Enter Input File Name"
         Top             =   480
         Width           =   3735
      End
      Begin VB.CommandButton cmdInput 
         Caption         =   "Browse"
         Height          =   375
         Left            =   5760
         TabIndex        =   6
         ToolTipText     =   "Browse For An Input File"
         Top             =   480
         Width           =   735
      End
      Begin VB.TextBox txtOutput 
         Height          =   405
         Left            =   1800
         TabIndex        =   5
         ToolTipText     =   "Enter Output File Name"
         Top             =   1200
         Width           =   3735
      End
      Begin VB.CommandButton cmdOutput 
         Caption         =   "Browse"
         Height          =   375
         Left            =   5760
         TabIndex        =   4
         ToolTipText     =   "Browse For An Output File"
         Top             =   1200
         Width           =   735
      End
      Begin VB.CommandButton cmdEncode 
         Caption         =   "Encode"
         Enabled         =   0   'False
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   18
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   435
         Left            =   2280
         TabIndex        =   3
         ToolTipText     =   "Begin Encryption"
         Top             =   2520
         Width           =   1095
      End
      Begin VB.Frame fraWork 
         BackColor       =   &H00808080&
         BorderStyle     =   0  'None
         Height          =   975
         Left            =   840
         TabIndex        =   1
         Top             =   3240
         Width           =   5415
         Begin MSComctlLib.ProgressBar PBar 
            Height          =   255
            Index           =   0
            Left            =   240
            TabIndex        =   12
            Top             =   480
            Width           =   4935
            _ExtentX        =   8705
            _ExtentY        =   450
            _Version        =   393216
            BorderStyle     =   1
            Appearance      =   1
         End
         Begin VB.Label lblWork2 
            Alignment       =   2  'Center
            BackColor       =   &H8000000D&
            BackStyle       =   0  'Transparent
            ForeColor       =   &H8000000E&
            Height          =   195
            Left            =   0
            TabIndex        =   2
            Top             =   120
            Width           =   735
         End
      End
      Begin MSComDlg.CommonDialog CdlFile 
         Left            =   1440
         Top             =   5400
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         Filter          =   $"frmMain2.frx":27A2
      End
      Begin VB.Label Label6 
         Caption         =   "0"
         Height          =   255
         Left            =   4080
         TabIndex        =   22
         Top             =   4320
         Width           =   495
      End
      Begin VB.Label Label5 
         Caption         =   "0"
         Height          =   255
         Left            =   3360
         TabIndex        =   21
         Top             =   4320
         Width           =   495
      End
      Begin VB.Label Label4 
         Caption         =   "0"
         Height          =   255
         Left            =   2640
         TabIndex        =   20
         Top             =   4320
         Width           =   495
      End
      Begin VB.Label Label3 
         Caption         =   "0"
         Height          =   255
         Left            =   1920
         TabIndex        =   19
         Top             =   4320
         Width           =   495
      End
      Begin VB.Image Image2 
         Height          =   510
         Left            =   2640
         Picture         =   "frmMain2.frx":2847
         Top             =   1800
         Visible         =   0   'False
         Width           =   1575
      End
      Begin VB.Image Image1 
         Height          =   555
         Left            =   2520
         Picture         =   "frmMain2.frx":2FBA
         Top             =   1800
         Width           =   1980
      End
      Begin VB.Label Label2 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Output file"
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   15.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   360
         TabIndex        =   9
         Top             =   1200
         Width           =   1275
      End
      Begin VB.Label Label1 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Input File"
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   15.75
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   405
         Left            =   390
         TabIndex        =   8
         Top             =   480
         Width           =   1230
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Cmddecode_Click()
'================ encode =================
DEEN = True

'fraControls.Enabled = False
MousePointer = vbHourglass
fraWork.Visible = True
If SecureFile(txtWork.Text, txtOutput.Text, True, True) Then
End If
MousePointer = vbDefault
'fraControls.Enabled = True

End Sub

Private Sub Cmdreset_Click()
    If Mscomm1.PortOpen = True Then
        Mscomm1.Output = Enterkey & "Z"
        Mscomm1.Output = Enterkey & "Z"
        Mscomm1.Output = Enterkey & "Z"
        Mscomm1.Output = Enterkey & "Z"
        Mscomm1.Output = Enterkey & "5"
        Mscomm1.Output = Enterkey & "5"
        Mscomm1.Output = Enterkey & "5"
        Mscomm1.Output = Enterkey & "5"
    End If
End Sub

Private Sub Command2_Click()
    Senddata(0) = Text1.Text
    Senddata(1) = Text2.Text
    Senddata(2) = Text3.Text
    Senddata(3) = Text4.Text
    
End Sub

Sub Senddes()
    If Mscomm1.PortOpen = True Then
        Mscomm1.Output = Enterkey & "1" & Chr$(Senddata(0)) & Chr$(Senddata(1)) & Chr$(Senddata(2)) & Chr$(Senddata(3))
    End If
End Sub

Sub Receivedes()
    Timer1.Enabled = False
    CheckHL = False
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
    Timer1.Enabled = True
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
'================ encode =================
DEEN = False

MousePointer = vbHourglass
fraWork.Visible = True
If SecureFile(txtWork.Text, txtOutput.Text, True, True) Then
End If
MousePointer = vbDefault
'fraControls.Enabled = True
'cmdexit.Enabled = True

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
        Image1.Visible = True
        Image2.Visible = False
    Else
        Command1.Caption = "Disconnect"
        Mscomm1.PortOpen = True
        Image2.Visible = True
        Image1.Visible = False
    End If
          
End Sub

Private Sub Command3_Click()
    Label3.Caption = Receivedata(0)
    Label4.Caption = Receivedata(1)
    Label5.Caption = Receivedata(2)
    Label6.Caption = Receivedata(3)
   
End Sub



Private Sub Command5_Click()
    CheckHL = False
    Timer1.Enabled = False
    
   frmMain.Senddes
    frmMain.Encode
    Cdelay
    frmMain.Receivedes
        Do While Not Continue
            DoEvents
        Loop
        Continue = False
    Timer1.Enabled = True
End Sub


Private Sub Command4_Click()
    CheckHL = False
    Timer1.Enabled = False
    
    frmMain.Senddes
    frmMain.Decode
    Cdelay
    frmMain.Receivedes
        Do While Not Continue
            DoEvents
        Loop
        Continue = False
        Timer1.Enabled = True
End Sub

Private Sub Command6_Click()
    Senddes
End Sub

Private Sub Command7_Click()
    Receivedes
End Sub


Private Sub Form_Load()
   Enterkey = "XyZ"
   Receiveflag = False
   Datanum = 0
   Continue = False
   CheckHL = False
   FoundHL = False
   Checkcon = False
End Sub


Private Sub Form_Unload(Cancel As Integer)
    Unload Me
End Sub

Public Sub MSComm1_OnComm()
    Dim InString As String

If Mscomm1.InBufferCount Then
   ' Read data.
   InString = Mscomm1.Input
     
'===============================================
    If CheckHL Then
        
       If InString = "A" Then
            FoundHL = True
       Else
            FoundHL = False
       End If
       Checkcon = True
       
    Else
   
        Receivedata(Datanum) = Asc(InString)
        Receiveflag = True
        
        If Datanum = 3 Then
            Continue = True
        End If
        
        Datanum = 0

    End If
'===============================================
   'ShowData Text1, InString
  
End If

End Sub


Private Sub Timer1_Timer()
On Error GoTo abc

    FoundHL = False
    Checkcon = False
    CheckHL = True
    Timer1.Interval = 4000
    
    If Mscomm1.PortOpen = False Then
      Mscomm1.PortOpen = True
    End If
    
    If Mscomm1.PortOpen = True Then
        Mscomm1.Output = Enterkey & "Z"
        Mscomm1.Output = Enterkey & "5"
        Timer2.Enabled = True
    End If
    
    
    Do While Not Checkcon
            DoEvents
    Loop
    
    Timer2.Enabled = False
    
    If FoundHL = False Then     ' not found
        Image1.Visible = True
        Image2.Visible = False
        cmdEncode.Enabled = False
        Cmddecode.Enabled = False
       
    Else
        Image1.Visible = False  'found
        Image2.Visible = True
        cmdEncode.Enabled = True
        Cmddecode.Enabled = True
    End If
    CheckHL = False
Exit Sub
abc:
    MsgBox ("Can't Access Port")
    
End Sub

Private Sub Timer2_Timer()
    Checkcon = True
End Sub

Public Sub Cdelay()
    Delaynum = 90000         'for make exe 4000000
    Do While Delaynum <> 1
        Delaynum = Delaynum - 1
    Loop
    
End Sub
