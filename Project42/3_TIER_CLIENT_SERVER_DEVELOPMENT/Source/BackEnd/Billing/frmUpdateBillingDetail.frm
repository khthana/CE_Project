VERSION 5.00
Begin VB.Form frmUpdateBillingDetail 
   Caption         =   "Update Billing Detail"
   ClientHeight    =   2580
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6630
   LinkTopic       =   "Form1"
   ScaleHeight     =   2580
   ScaleWidth      =   6630
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox TxtPrice 
      BackColor       =   &H80000013&
      Height          =   375
      Left            =   1080
      Locked          =   -1  'True
      TabIndex        =   14
      Top             =   2040
      Width           =   1095
   End
   Begin VB.CommandButton cmdRetrieve 
      Caption         =   "Retrieve"
      Height          =   375
      Left            =   4560
      TabIndex        =   13
      Top             =   360
      Width           =   1935
   End
   Begin VB.TextBox txtBillingID 
      Height          =   375
      Left            =   1080
      TabIndex        =   6
      Top             =   360
      Width           =   1095
   End
   Begin VB.TextBox txtItemID 
      Height          =   375
      Left            =   3240
      TabIndex        =   5
      Top             =   360
      Width           =   1095
   End
   Begin VB.TextBox txtStatus 
      Height          =   375
      Left            =   1080
      TabIndex        =   4
      Top             =   1080
      Width           =   1095
   End
   Begin VB.TextBox txtDiscount 
      Height          =   375
      Left            =   3240
      TabIndex        =   3
      Top             =   1080
      Width           =   1095
   End
   Begin VB.TextBox txtAmount 
      Height          =   375
      Left            =   1080
      TabIndex        =   2
      Top             =   1560
      Width           =   1095
   End
   Begin VB.TextBox txtTaxValue 
      BackColor       =   &H80000013&
      Height          =   375
      Left            =   3240
      Locked          =   -1  'True
      TabIndex        =   1
      Top             =   1560
      Width           =   1095
   End
   Begin VB.CommandButton cmdUpdatebillingdetail 
      Caption         =   "Update Billing detail"
      Height          =   495
      Left            =   4560
      TabIndex        =   0
      Top             =   1200
      Width           =   1935
   End
   Begin VB.Label Label7 
      Caption         =   "Price"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   2160
      Width           =   735
   End
   Begin VB.Line Line1 
      X1              =   120
      X2              =   5760
      Y1              =   960
      Y2              =   960
   End
   Begin VB.Label Label1 
      Caption         =   "Billing ID"
      Height          =   255
      Left            =   120
      TabIndex        =   12
      Top             =   480
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "Item ID"
      Height          =   255
      Left            =   2400
      TabIndex        =   11
      Top             =   480
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   "Status"
      Height          =   255
      Left            =   120
      TabIndex        =   10
      Top             =   1200
      Width           =   735
   End
   Begin VB.Label Label4 
      Caption         =   "Discount"
      Height          =   255
      Left            =   2400
      TabIndex        =   9
      Top             =   1200
      Width           =   735
   End
   Begin VB.Label Label5 
      Caption         =   "Amount"
      Height          =   255
      Left            =   120
      TabIndex        =   8
      Top             =   1680
      Width           =   735
   End
   Begin VB.Label Label6 
      Caption         =   "Tax value"
      Height          =   255
      Left            =   2400
      TabIndex        =   7
      Top             =   1680
      Width           =   735
   End
End
Attribute VB_Name = "frmUpdateBillingDetail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdRetrieve_Click()
Dim objBilling As Object
Dim StrSql As String
Dim rs As Recordset

cmdRetrieve.Enabled = False

On Error GoTo RetError
Set objBilling = CreateObject("ecomm.billingdetail")

StrSql = "Select * from Vbillingdetail where billingid = " & txtBillingID.Text & " and itemid = " & txtItemID.Text
Set rs = objBilling.findbillingdetail(StrSql)

txtStatus.Text = rs!Status
txtDiscount.Text = rs!discount
txtAmount.Text = rs!amount
txtTaxValue.Text = rs!taxvalue
txtPrice.Text = rs!Price

Set objBilling = Nothing
cmdRetrieve.Enabled = True

Exit Sub

RetError:
Me.Caption = Err.Number & " : " & Err.Description
 cmdRetrieve.Enabled = True

End Sub

Private Sub cmdUpdateBillingDetail_Click()
Dim ObjBillingdetail As Object

cmdUpdateBillingDetail.Enabled = False

On Error GoTo UpdateError
Set ObjBillingdetail = CreateObject("Ecomm.billingdetail")

With ObjBillingdetail
    .Status = txtStatus.Text
    .discount = txtDiscount.Text
    .amount = txtAmount.Text
    .taxvalue = txtTaxValue.Text
    .Price = txtPrice.Text
    
    
    .billingid = txtBillingID.Text
    .itemid = txtItemID.Text
    .Updatebillingdetail
End With

    MsgBox "Update Billing Detail : " & txtBillingID.Text & " " & txtItemID.Text & " Complete"
    cmdUpdateBillingDetail.Enabled = True
    Set ObjBillingdetail = Nothing
Exit Sub

UpdateError:
    cmdUpdateBillingDetail.Enabled = True
    Me.Caption = Err.Number & " : " & Err.Description

End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

Private Sub CalTaxValue()

    txtTaxValue.Text = CStr(CCSng(txtPrice.Text) * CCInt(txtAmount.Text) * 0.07)

End Sub

Private Sub txtAmount_Change()
    CalTaxValue
End Sub

Private Sub TxtPrice_Change()
    CalTaxValue
End Sub
