VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form frmMain 
   AutoRedraw      =   -1  'True
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "โปรแกรมฮาร์ดล็อคสำหรับผู้ใช้งาน KMITL"
   ClientHeight    =   5325
   ClientLeft      =   45
   ClientTop       =   615
   ClientWidth     =   6750
   Icon            =   "frmMain2.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   355
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   450
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Cmdexit 
      Caption         =   "EXIT"
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
      Left            =   3960
      TabIndex        =   9
      ToolTipText     =   "Begin Encryption"
      Top             =   2520
      Width           =   1095
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   720
      Top             =   1680
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
      Begin VB.TextBox Text1 
         Height          =   315
         Left            =   480
         TabIndex        =   8
         Text            =   "c:\box\centauri\A342.exe"
         Top             =   4320
         Visible         =   0   'False
         Width           =   3735
      End
      Begin VB.Timer Timer3 
         Enabled         =   0   'False
         Interval        =   5500
         Left            =   1680
         Top             =   1680
      End
      Begin VB.Timer Timer2 
         Enabled         =   0   'False
         Interval        =   2500
         Left            =   1200
         Top             =   1680
      End
      Begin MSCommLib.MSComm Mscomm1 
         Left            =   120
         Top             =   2280
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
         Enabled         =   0   'False
         ForeColor       =   &H00000000&
         Height          =   375
         Left            =   1800
         TabIndex        =   5
         ToolTipText     =   "Enter Input File Name"
         Top             =   720
         Width           =   3735
      End
      Begin VB.CommandButton cmdInput 
         Caption         =   "Browse"
         Height          =   375
         Left            =   5760
         TabIndex        =   4
         ToolTipText     =   "Browse For An Input File"
         Top             =   720
         Width           =   735
      End
      Begin VB.CommandButton cmdrun 
         Caption         =   "RUN"
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
         Left            =   2040
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
            TabIndex        =   7
            Top             =   480
            Width           =   4935
            _ExtentX        =   8705
            _ExtentY        =   450
            _Version        =   393216
            BorderStyle     =   1
            Appearance      =   1
         End
         Begin VB.Label lblWork2 
            BackColor       =   &H8000000D&
            BackStyle       =   0  'Transparent
            ForeColor       =   &H8000000E&
            Height          =   315
            Left            =   120
            TabIndex        =   2
            Top             =   120
            Width           =   2415
         End
      End
      Begin MSComDlg.CommonDialog CdlFile 
         Left            =   120
         Top             =   1680
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         Filter          =   $"frmMain2.frx":27A2
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
         Caption         =   "สถาบันเทคโนโลยีพระจอมเกล้าเจ้าคุณทหารลาดกระบัง"
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   12
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   2
         Left            =   3000
         TabIndex        =   12
         Top             =   4920
         Width           =   3615
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
         Caption         =   "ภาควิชาวิศวกรรมคอมพิวเตอร์"
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   12
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   1
         Left            =   4440
         TabIndex        =   11
         Top             =   4680
         Width           =   2175
      End
      Begin VB.Label Label2 
         Alignment       =   1  'Right Justify
         BackColor       =   &H00E0E0E0&
         Caption         =   "พัฒนาโดย"
         BeginProperty Font 
            Name            =   "CordiaUPC"
            Size            =   12
            Charset         =   222
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Index           =   0
         Left            =   4920
         TabIndex        =   10
         Top             =   4440
         Width           =   1695
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
         TabIndex        =   6
         Top             =   720
         Width           =   1230
      End
   End
   Begin VB.Menu mfile 
      Caption         =   "File"
      Index           =   1
      Begin VB.Menu mexit 
         Caption         =   "Exit"
         Index           =   2
      End
   End
   Begin VB.Menu msetting 
      Caption         =   "Setting"
      Index           =   3
      Begin VB.Menu mport 
         Caption         =   "Port"
         Index           =   4
      End
      Begin VB.Menu mreset 
         Caption         =   "Reset HL"
         Index           =   5
      End
   End
   Begin VB.Menu mhelp 
      Caption         =   "Help"
      Index           =   6
      Begin VB.Menu mmanual 
         Caption         =   "Manual"
         Index           =   7
      End
      Begin VB.Menu mabout 
         Caption         =   "About"
         Index           =   8
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False


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

Private Sub cmdrun_Click()
On Error Resume Next
If txtWork.Text = "" Then
    MsgBox ("Please enter Input File")
    Exit Sub
End If
'================ encode =================
DEEN = True

 MkDir "c:\box\centauri"
MousePointer = vbHourglass
fraWork.Visible = True
If SecureFile(txtWork.Text, Text1.Text, True, True) Then
End If
MousePointer = vbDefault
'fraControls.Enabled = True
'cmdexit.Enabled = True

' Call the Function to Run File
'
Runfile Text1.Text

Timer3.Enabled = True

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

Private Sub cmdexit_Click()
    On Error Resume Next

rt = KillApp(Text1.Text)
'DoEvents

MsgBox "Program is Terminated", vbOKOnly

DestroyFile Text1.Text

End
          
End Sub



Private Sub Form_Load()
Move (Screen.Width - Width) \ 2, (Screen.Height - Height) \ 2
rmvMnuClose Me
Timer3.Enabled = False

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

Sub mexit_Click(Index As Integer)
On Error Resume Next

rt = KillApp(Text1.Text)
'DoEvents

MsgBox "Program is Terminated", vbOKOnly

DestroyFile Text1.Text

End

End Sub

Private Sub mport_Click(Index As Integer)
 On Error Resume Next
    Mscomm1.PortOpen = False
    Temp = InputBox$("Enter New Com Port Number:", "Communication Port", Str$(Mscomm1.CommPort))
    If Len(Temp) Then
        Mscomm1.CommPort = Val(Temp)
        If Err Then MsgBox Error$, 48
    End If
    Mscomm1.PortOpen = True
End Sub

Private Sub mreset_Click(Index As Integer)
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

Public Sub MSComm1_OnComm()
    Dim InString As String
    Dim Realstr As String
    Dim Realbyte As Byte
If Mscomm1.InBufferCount Then
   ' Read data.
   
   Realstr = Mscomm1.Input
   Realbyte = Asc(Realstr) Xor 120   'Decode data
   InString = Chr$(Realbyte)
   
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
        cmdrun.Enabled = False
        TerminatebyHL
    Else
        Image1.Visible = False  'found
        Image2.Visible = True
        cmdInput.Enabled = True
        Cmdexit.Enabled = True
        cmdrun.Enabled = True
        frmMain.Enabled = True
    End If
    CheckHL = False
Exit Sub
abc:
    MsgBox ("Can't Access Port")
    
End Sub

Private Sub Timer2_Timer()
    Checkcon = True
End Sub

Public Sub Cdelay()          'for test 90000
    Delaynum = 90000         'for make exe 4000000
    Do While Delaynum <> 1
        Delaynum = Delaynum - 1
    Loop
    
End Sub

Private Sub Timer3_Timer()
On Error Resume Next

DestroyFile Text1.Text
End Sub
Private Sub TerminatebyHL()

On Error Resume Next

rt = KillApp(Text1.Text)
'DoEvents

DestroyFile Text1.Text

' Exit Program
'
'End

End Sub
