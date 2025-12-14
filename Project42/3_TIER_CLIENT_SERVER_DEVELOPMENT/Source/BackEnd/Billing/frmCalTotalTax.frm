VERSION 5.00
Begin VB.Form frmCalTotalTax 
   Caption         =   "Calculate total tax"
   ClientHeight    =   915
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   915
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdCalTotalTax 
      Caption         =   "Calculate total tax"
      Height          =   495
      Left            =   2640
      TabIndex        =   2
      Top             =   240
      Width           =   1815
   End
   Begin VB.TextBox txtBillingID 
      Height          =   375
      Left            =   1080
      TabIndex        =   1
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Billing ID"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   855
   End
End
Attribute VB_Name = "frmCalTotalTax"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCalTotalTax_Click()
Dim ObjBilling As Object
Dim TotalTax As Single

cmdCalTotalTax.Enabled = False

On Error GoTo CalTotalTaxError
Set ObjBilling = CreateObject("EComm.Billing")

ObjBilling.billingid = txtBillingID.Text
TotalTax = ObjBilling.Caltotaltax

MsgBox "Total tax : " & TotalTax & vbCrLf & _
        "And update to tblBilling.TotalTax complete"

    cmdCalTotalTax.Enabled = True

Exit Sub
CalTotalTaxError:
  Me.Caption = Err.Number & " : " & Err.Description
  cmdCalTotalTax.Enabled = True

End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

