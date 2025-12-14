VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form frmMain 
   BackColor       =   &H00400000&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Secure FX v1.00,  (c) 1999"
   ClientHeight    =   2745
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3435
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   183
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   229
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdCancel 
      Cancel          =   -1  'True
      Caption         =   "&Close"
      Height          =   375
      Left            =   1920
      TabIndex        =   0
      ToolTipText     =   "End Program"
      Top             =   2160
      Width           =   735
   End
   Begin VB.Frame fraControls 
      BackColor       =   &H8000000D&
      BorderStyle     =   0  'None
      Height          =   2655
      Left            =   120
      TabIndex        =   1
      Top             =   0
      Width           =   3255
      Begin VB.TextBox txtWork 
         Height          =   285
         Left            =   120
         TabIndex        =   12
         ToolTipText     =   "Enter Input File Name"
         Top             =   840
         Width           =   2535
      End
      Begin VB.CommandButton cmdGetInput 
         Caption         =   "..."
         Height          =   255
         Left            =   2760
         TabIndex        =   11
         ToolTipText     =   "Browse For An Input File"
         Top             =   840
         Width           =   375
      End
      Begin VB.TextBox txtOutput 
         Height          =   285
         Left            =   120
         TabIndex        =   10
         ToolTipText     =   "Enter Output File Name"
         Top             =   1440
         Width           =   2535
      End
      Begin VB.CommandButton cmdGetOutPut 
         Caption         =   "..."
         Height          =   255
         Left            =   2760
         TabIndex        =   9
         ToolTipText     =   "Browse For An Output File"
         Top             =   1440
         Width           =   375
      End
      Begin VB.CommandButton cmdEncrypt 
         Caption         =   "&Encrypt"
         Height          =   375
         Left            =   120
         TabIndex        =   8
         ToolTipText     =   "Begin Encryption"
         Top             =   2160
         Width           =   735
      End
      Begin VB.Frame fraWork 
         BackColor       =   &H8000000D&
         BorderStyle     =   0  'None
         Height          =   495
         Left            =   2400
         TabIndex        =   5
         Top             =   1920
         Visible         =   0   'False
         Width           =   855
         Begin VB.Label lblWork2 
            Alignment       =   2  'Center
            BackColor       =   &H8000000D&
            BackStyle       =   0  'Transparent
            Caption         =   "Idle"
            ForeColor       =   &H8000000E&
            Height          =   195
            Left            =   120
            TabIndex        =   7
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
            TabIndex        =   6
            Top             =   240
            Width           =   735
         End
      End
      Begin VB.TextBox txtKey 
         Height          =   285
         IMEMode         =   3  'DISABLE
         Left            =   120
         PasswordChar    =   "*"
         TabIndex        =   4
         ToolTipText     =   "Specify A Password Key"
         Top             =   240
         Width           =   2535
      End
      Begin VB.CheckBox chkIntegrity 
         BackColor       =   &H8000000D&
         Caption         =   " Ensure System Response"
         ForeColor       =   &H8000000E&
         Height          =   255
         Left            =   120
         TabIndex        =   3
         ToolTipText     =   "Anti-System lock up"
         Top             =   1800
         Value           =   1  'Checked
         Width           =   2295
      End
      Begin VB.CommandButton cmdDecrypt 
         Caption         =   "&Decrypt"
         Height          =   375
         Left            =   960
         TabIndex        =   2
         ToolTipText     =   "Begin Decryption"
         Top             =   2160
         Width           =   735
      End
      Begin MSComDlg.CommonDialog CdlFile 
         Left            =   1440
         Top             =   1320
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         Filter          =   $"frmMain.frx":0442
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "3. Please enter output file"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   240
         Left            =   120
         TabIndex        =   15
         Top             =   1200
         Width           =   2220
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "1. Specify CryptKey [Optional]"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   240
         Left            =   120
         TabIndex        =   14
         Top             =   0
         Width           =   2640
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "2. Please enter working file"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H8000000E&
         Height          =   240
         Left            =   120
         TabIndex        =   13
         Top             =   600
         Width           =   2370
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

