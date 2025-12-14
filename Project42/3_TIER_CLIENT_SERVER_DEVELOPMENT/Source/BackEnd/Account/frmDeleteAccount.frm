VERSION 5.00
Begin VB.Form frmDeleteAccount 
   Caption         =   "Delete Account"
   ClientHeight    =   2940
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3300
   LinkTopic       =   "Form1"
   ScaleHeight     =   2940
   ScaleWidth      =   3300
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdDeleteAccount 
      Caption         =   "Delete Account"
      Height          =   495
      Left            =   720
      TabIndex        =   2
      Top             =   840
      Width           =   1815
   End
   Begin VB.TextBox txtCriteria 
      Height          =   405
      Left            =   1080
      TabIndex        =   1
      Top             =   240
      Width           =   1815
   End
   Begin VB.Label Labeldeleteaccount 
      Height          =   1215
      Left            =   240
      TabIndex        =   3
      Top             =   1560
      Width           =   2775
   End
   Begin VB.Label Label1 
      Caption         =   "Criteria"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   360
      Width           =   615
   End
End
Attribute VB_Name = "frmDeleteAccount"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdDeleteAccount_Click()
Dim ObjAccount As Object

cmdDeleteAccount.Enabled = False

On Error GoTo DeleteAccountError

Set ObjAccount = CreateObject("Ecomm.account")
  ObjAccount.deleteaccount (txtCriteria.Text)
Set ObjAccount = Nothing
  MsgBox "Delete Account by criteria " & txtCriteria.Text & " Complete"
  cmdDeleteAccount.Enabled = True

Exit Sub
DeleteAccountError:
    Labeldeleteaccount.Caption = Err.Number & " : " & Err.Description
    cmdDeleteAccount.Enabled = True

End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

