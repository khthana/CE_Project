VERSION 5.00
Begin VB.Form frmCalTotalPrice 
   Caption         =   "Calculate Total Price"
   ClientHeight    =   1005
   ClientLeft      =   2565
   ClientTop       =   2565
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   1005
   ScaleWidth      =   4680
   Begin VB.CommandButton cmdCalTotalPrice 
      Caption         =   "Calculate total price"
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
Attribute VB_Name = "frmCalTotalPrice"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCalTotalPrice_Click()
Dim ObjBillingdetail As Object
Dim TotalPrice As Single

  cmdCalTotalPrice.Enabled = False
On Error GoTo CalTotalPrice

Set ObjBillingdetail = CreateObject("ecomm.billing")

With ObjBillingdetail
  .billingid = CInt(txtBillingID.Text)
  TotalPrice = .CalTotalPrice
End With

  MsgBox "Total Price : " & TotalPrice & vbCrLf & _
        "And update to tblBilling.TotalPrice complete"
  cmdCalTotalPrice.Enabled = True
  
Set ObjBillingdetail = Nothing

Exit Sub
CalTotalPrice:
    Me.Caption = Err.Number & " : " & Err.Description
    cmdCalTotalPrice.Enabled = True

End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

