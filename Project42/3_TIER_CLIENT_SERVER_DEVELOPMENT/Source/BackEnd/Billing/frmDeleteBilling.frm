VERSION 5.00
Begin VB.Form frmDeleteBilling 
   Caption         =   "Delete Billing"
   ClientHeight    =   1650
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3645
   LinkTopic       =   "Form1"
   ScaleHeight     =   1650
   ScaleWidth      =   3645
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdDeleteBilling 
      Caption         =   "Delete"
      Height          =   495
      Left            =   1200
      TabIndex        =   2
      Top             =   960
      Width           =   1215
   End
   Begin VB.TextBox txtCriteria 
      Height          =   375
      Left            =   1080
      TabIndex        =   1
      Top             =   360
      Width           =   2175
   End
   Begin VB.Label Label1 
      Caption         =   "Criteria"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   480
      Width           =   735
   End
End
Attribute VB_Name = "frmDeleteBilling"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdDeleteBilling_Click()
Dim ObjBilling As Object

  cmdDeleteBilling.Enabled = False

On Error GoTo DeleteBillingError
Set ObjBilling = CreateObject("Ecomm.Billing")

ObjBilling.DeleteBilling (txtCriteria.Text)
Set ObjBilling = Nothing
  
  MsgBox "Delete By Criteria : " & txtCriteria.Text & " complete"
  cmdDeleteBilling.Enabled = True
  
  
Exit Sub
DeleteBillingError:
    cmdDeleteBilling.Enabled = True
    Me.Caption = Err.Number & " : " & Err.Description

End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

