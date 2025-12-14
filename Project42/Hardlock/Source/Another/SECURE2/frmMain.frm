VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Secure FX v1.00,  (c) 1999"
   ClientHeight    =   4470
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6825
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   298
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   455
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "Exit"
      Height          =   375
      Left            =   4080
      TabIndex        =   0
      ToolTipText     =   "End Program"
      Top             =   2040
      Width           =   735
   End
   Begin VB.Frame fraControls 
      BorderStyle     =   0  'None
      Height          =   4455
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   6855
      Begin MSCommLib.MSComm MSComm1 
         Left            =   5640
         Top             =   1080
         _ExtentX        =   1005
         _ExtentY        =   1005
         _Version        =   393216
      End
      Begin VB.TextBox txtWork 
         Height          =   405
         Left            =   1800
         TabIndex        =   9
         ToolTipText     =   "Enter Input File Name"
         Top             =   480
         Width           =   2535
      End
      Begin VB.CommandButton cmdGetInput 
         Caption         =   "Browse"
         Height          =   375
         Left            =   4680
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
         Width           =   2535
      End
      Begin VB.CommandButton cmdGetOutPut 
         Caption         =   "Browse"
         Height          =   375
         Left            =   4680
         TabIndex        =   6
         ToolTipText     =   "Browse For An Output File"
         Top             =   1200
         Width           =   735
      End
      Begin VB.CommandButton cmdEncrypt 
         Caption         =   "Encode"
         Height          =   375
         Left            =   2280
         TabIndex        =   5
         ToolTipText     =   "Begin Encryption"
         Top             =   2040
         Width           =   735
      End
      Begin VB.Frame fraWork 
         BackColor       =   &H8000000D&
         BorderStyle     =   0  'None
         Height          =   735
         Left            =   4680
         TabIndex        =   2
         Top             =   2880
         Visible         =   0   'False
         Width           =   1455
         Begin VB.Label lblWork2 
            Alignment       =   2  'Center
            BackColor       =   &H8000000D&
            BackStyle       =   0  'Transparent
            Caption         =   "Idle"
            ForeColor       =   &H8000000E&
            Height          =   195
            Left            =   120
            TabIndex        =   4
            Top             =   0
            Width           =   735
         End
         Begin VB.Label lblStatus 
            Alignment       =   2  'Center
            BackColor       =   &H8000000D&
            BackStyle       =   0  'Transparent
            Caption         =   "X%"
            ForeColor       =   &H8000000E&
            Height          =   195
            Left            =   120
            TabIndex        =   3
            Top             =   240
            Width           =   735
         End
      End
      Begin MSComDlg.CommonDialog CdlFile 
         Left            =   5640
         Top             =   240
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         Filter          =   $"frmMain.frx":0442
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

Private Sub Command3_Click()

End Sub

Private Sub cmdCancel_Click()
Unload Me
End
End Sub

Private Sub cmdDecrypt_Click()
fraControls.Enabled = False
MousePointer = vbHourglass
fraWork.Visible = True
lblStatus.Caption = "X%"
If txtKey.Text <> "" Then
    'Password supplied. Use it
    If SecureFile(txtWork.Text, txtOutput.Text, False, txtKey.Text, IIf(chkIntegrity.Value = Checked, True, False)) Then MsgBox "Done", vbInformation, "Decryption"
Else
    'No password. Use Default
    If SecureFile(txtWork.Text, txtOutput.Text, False, , IIf(chkIntegrity.Value = Checked, True, False)) Then MsgBox "Done", vbInformation, "Decryption"
End If
MousePointer = vbDefault
fraControls.Enabled = True
End Sub

Private Sub cmdEncrypt_Click()
fraControls.Enabled = False
MousePointer = vbHourglass
fraWork.Visible = True
lblStatus.Caption = "X%"
If txtKey.Text <> "" Then
    'Password supplied. Use it
    If SecureFile(txtWork.Text, txtOutput.Text, True, txtKey.Text, IIf(chkIntegrity.Value = Checked, True, False)) Then MsgBox "Done", vbInformation, "Encryption"
Else
    'No password. Use Default
    If SecureFile(txtWork.Text, txtOutput.Text, True, , IIf(chkIntegrity.Value = Checked, True, False)) Then MsgBox "Done", vbInformation, "Encryption"
End If
MousePointer = vbDefault
fraControls.Enabled = True
End Sub

Private Sub cmdGetInput_Click()
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

Private Sub cmdGetOutPut_Click()
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

Private Sub MSComm1_OnComm()

End Sub
