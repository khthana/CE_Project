VERSION 5.00
Begin VB.Form frmCopyright 
   BackColor       =   &H8000000D&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Secure FX v1.0 TERMS OF USE"
   ClientHeight    =   3315
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4050
   Icon            =   "frmCopyright.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3315
   ScaleWidth      =   4050
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdDecline 
      Cancel          =   -1  'True
      Caption         =   "&Decline"
      Height          =   495
      Left            =   2640
      TabIndex        =   4
      Top             =   2760
      Width           =   1215
   End
   Begin VB.TextBox txtRead 
      Appearance      =   0  'Flat
      Height          =   1935
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   3
      ToolTipText     =   "Secure FX v1.0.0 Terms of Use"
      Top             =   720
      Width           =   3855
   End
   Begin VB.CommandButton cmdAccept 
      Caption         =   "&Accept"
      Height          =   495
      Left            =   120
      TabIndex        =   0
      Top             =   2760
      Width           =   1215
   End
   Begin VB.Label Label2 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Copyright 1999, Kenneth Gilbert Jr.  All rights reserved"
      ForeColor       =   &H8000000E&
      Height          =   195
      Left            =   120
      TabIndex        =   2
      Top             =   480
      Width           =   3795
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Secure FX v1.00"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   300
      Left            =   1080
      TabIndex        =   1
      Top             =   120
      Width           =   1770
   End
End
Attribute VB_Name = "frmCopyright"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdAccept_Click()
frmMain.Show
Unload Me
End Sub

Private Sub cmdDecline_Click()
Unload Me

End Sub

Private Sub Form_Load()
txtRead.Text = "TERMS OF USE" & vbNewLine & "By clicking 'Accept' you agree to the following:" & vbNewLine & "1) Copyright 1999, Kenneth Gilbert Jr." & vbNewLine & vbNewLine & "2) This code is provided  'As Is'.  No warranty or liabilty to author if damage occurs to your sytem" & vbNewLine & vbNewLine & "3)  This program will be used as a security utility ONLY"

End Sub
