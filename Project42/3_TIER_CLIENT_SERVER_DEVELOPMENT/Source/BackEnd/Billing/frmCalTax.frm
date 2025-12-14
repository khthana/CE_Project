VERSION 5.00
Begin VB.Form frmCalTax 
   Caption         =   "Calculate Tax"
   ClientHeight    =   1170
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form1"
   ScaleHeight     =   1170
   ScaleWidth      =   4680
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtBillingID 
      Height          =   405
      Left            =   1080
      TabIndex        =   2
      Top             =   120
      Width           =   1575
   End
   Begin VB.TextBox txtItemID 
      Height          =   405
      Left            =   1080
      TabIndex        =   1
      Top             =   600
      Width           =   1575
   End
   Begin VB.CommandButton cmdCalTax 
      Caption         =   "Calculate Tax"
      Height          =   495
      Left            =   3120
      TabIndex        =   0
      Top             =   240
      Width           =   1455
   End
   Begin VB.Label Label1 
      Caption         =   "Billing ID"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   240
      Width           =   855
   End
   Begin VB.Label Label2 
      Caption         =   "Item ID"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   720
      Width           =   855
   End
End
Attribute VB_Name = "frmCalTax"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCalTax_Click()
Dim ObjBillingdetail As Object
Dim Tax As Single

cmdCalTax.Enabled = False

On Error GoTo CalTaxError
Set ObjBillingdetail = CreateObject("Ecomm.billingdetail")

With ObjBillingdetail
 .billingid = CInt(txtBillingID.Text)
 .itemid = CInt(txtItemID.Text)
 
 Tax = .CalTax
End With

    MsgBox "Tax : " & Tax & vbCrLf & _
        "And update to tblBillingDetail.TaxValue complete"
    
    cmdCalTax.Enabled = True
    
    Set ObjBillingdetail = Nothing

Exit Sub
CalTaxError:
  Me.Caption = Err.Number & " : " & Err.Description
  cmdCalTax.Enabled = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

