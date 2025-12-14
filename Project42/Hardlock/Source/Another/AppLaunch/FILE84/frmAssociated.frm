VERSION 5.00
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.1#0"; "COMDLG32.OCX"
Begin VB.Form frmAssociated 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Run Associated Program"
   ClientHeight    =   2775
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7290
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2775
   ScaleWidth      =   7290
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton cmdRunAssociated 
      Caption         =   "Run Associated"
      Height          =   375
      Left            =   2910
      TabIndex        =   3
      Top             =   1260
      Width           =   1365
   End
   Begin VB.CommandButton cmdBrowse 
      Caption         =   "Browse"
      Height          =   300
      Left            =   6015
      TabIndex        =   2
      Top             =   600
      Width           =   1095
   End
   Begin VB.TextBox txtFile 
      Height          =   285
      Left            =   1005
      TabIndex        =   1
      Text            =   "Path of file to run associated applications of..."
      Top             =   615
      Width           =   4815
   End
   Begin MSComDlg.CommonDialog cdlBrowse 
      Left            =   180
      Top             =   2220
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   327681
   End
   Begin VB.Label lblBSS 
      Caption         =   $"frmAssociated.frx":0000
      Height          =   750
      Left            =   330
      TabIndex        =   4
      Top             =   1830
      Width           =   6675
   End
   Begin VB.Label lblFile 
      Alignment       =   1  'Right Justify
      Caption         =   "File:"
      Height          =   240
      Left            =   135
      TabIndex        =   0
      Top             =   630
      Width           =   705
   End
End
Attribute VB_Name = "frmAssociated"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
' ------------------------------------------------------------------------
'
'                       BulletSoft Solutions
'
'  You have a royalty-free right to use, modify, reproduce and distribute
'  this file (and/or any modified version) in any way you find useful,
'  provided that you agree that BulletSoft Solutions has no
'  warranty, obligation or liability for its contents.
'  Refer to the http://www.bulletsoftsolutions.com for more project
'  examples like this one.
'
' ------------------------------------------------------------------------

Private Sub cmdBrowse_Click()

    On Error Resume Next
    
    Err.Clear
    cdlBrowse.CancelError = True
    cdlBrowse.Flags = cdlOFNExplorer + cdlOFNFileMustExist + cdlOFNHideReadOnly
    cdlBrowse.DialogTitle = "Choose File With Association"
    cdlBrowse.ShowOpen
    
    If Err.Number = 0 Then
        Err.Clear
        txtFile.Text = cdlBrowse.filename
    End If
    
End Sub

Private Sub cmdRunAssociated_Click()
    
    RunAssociated txtFile.Text
    
End Sub

