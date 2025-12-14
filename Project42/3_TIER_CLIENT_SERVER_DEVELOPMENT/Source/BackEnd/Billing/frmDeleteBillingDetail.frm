VERSION 5.00
Begin VB.Form frmDeleteBillingDetail 
   Caption         =   "Delete Billing Detail"
   ClientHeight    =   1365
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3585
   LinkTopic       =   "Form1"
   ScaleHeight     =   1365
   ScaleWidth      =   3585
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete"
      Height          =   495
      Left            =   1200
      TabIndex        =   2
      Top             =   720
      Width           =   1215
   End
   Begin VB.TextBox txtCriteria 
      Height          =   375
      Left            =   1320
      TabIndex        =   1
      Top             =   120
      Width           =   2055
   End
   Begin VB.Label Label1 
      Caption         =   "Criteria"
      Height          =   255
      Left            =   360
      TabIndex        =   0
      Top             =   240
      Width           =   735
   End
End
Attribute VB_Name = "frmDeleteBillingDetail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdDelete_Click()
Dim obj As Object

    cmdDelete.Enabled = False

On Error GoTo deleteerror

    Set obj = CreateObject("Ecomm.billingdetail")
    obj.deletebillingdetail txtCriteria.Text
    
    MsgBox "Delete by : " & txtCriteria.Text & " Complete"

    cmdDelete.Enabled = True

Exit Sub
deleteerror:
    cmdDelete.Enabled = True
    Me.Caption = Err.Number & " : " & Err.Description

End Sub


Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub


