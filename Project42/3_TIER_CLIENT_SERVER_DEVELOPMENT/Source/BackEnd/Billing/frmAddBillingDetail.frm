VERSION 5.00
Begin VB.Form frmAddBillingDetail 
   Caption         =   "Add Billing Detail"
   ClientHeight    =   2925
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5145
   LinkTopic       =   "Form1"
   ScaleHeight     =   2925
   ScaleWidth      =   5145
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtPrice 
      Height          =   375
      Left            =   1080
      TabIndex        =   13
      Top             =   1560
      Width           =   1095
   End
   Begin VB.CommandButton cmdAddnew 
      Caption         =   "Add new billing detail"
      Height          =   495
      Left            =   1320
      TabIndex        =   12
      Top             =   2160
      Width           =   2175
   End
   Begin VB.TextBox txtTaxValue 
      BackColor       =   &H80000013&
      Height          =   375
      Left            =   3480
      Locked          =   -1  'True
      TabIndex        =   11
      Top             =   1080
      Width           =   1095
   End
   Begin VB.TextBox txtAmount 
      Height          =   375
      Left            =   3480
      TabIndex        =   9
      Top             =   600
      Width           =   1095
   End
   Begin VB.TextBox txtDiscount 
      Height          =   375
      Left            =   3480
      TabIndex        =   7
      Top             =   120
      Width           =   1095
   End
   Begin VB.TextBox txtStatus 
      Height          =   375
      Left            =   1080
      TabIndex        =   5
      Top             =   1080
      Width           =   1095
   End
   Begin VB.TextBox txtItemID 
      Height          =   375
      Left            =   1080
      TabIndex        =   3
      Top             =   600
      Width           =   1095
   End
   Begin VB.TextBox txtBillingID 
      Height          =   375
      Left            =   1080
      TabIndex        =   1
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label7 
      Caption         =   "Price"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   1680
      Width           =   735
   End
   Begin VB.Label Label6 
      Caption         =   "Tax value"
      Height          =   255
      Left            =   2520
      TabIndex        =   10
      Top             =   1200
      Width           =   735
   End
   Begin VB.Label Label5 
      Caption         =   "Amount"
      Height          =   255
      Left            =   2520
      TabIndex        =   8
      Top             =   720
      Width           =   735
   End
   Begin VB.Label Label4 
      Caption         =   "Discount"
      Height          =   255
      Left            =   2520
      TabIndex        =   6
      Top             =   240
      Width           =   735
   End
   Begin VB.Label Label3 
      Caption         =   "Status"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1200
      Width           =   735
   End
   Begin VB.Label Label2 
      Caption         =   "Item ID"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   720
      Width           =   735
   End
   Begin VB.Label Label1 
      Caption         =   "Billing ID"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   240
      Width           =   735
   End
End
Attribute VB_Name = "frmAddBillingDetail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAddnew_Click()
Dim ObjBillingdetail As Object

    cmdAddnew.Enabled = False

On Error GoTo AddnewDetailError
Set ObjBillingdetail = CreateObject("ecomm.billingdetail")

With ObjBillingdetail
    .billingid = CInt(txtBillingID.Text)
    .itemid = CInt(txtItemID.Text)
    .Status = txtStatus.Text
    .discount = txtDiscount.Text
    .amount = CInt(txtAmount.Text)
    .TaxValue = txtTaxValue.Text
    .Price = TxtPrice.Text
    
    .addbillingdetail
End With

    MsgBox "Add billing detail complete"
Set ObjBillingdetail = Nothing
    
    cmdAddnew.Enabled = True
Exit Sub
AddnewDetailError:
    cmdAddnew.Enabled = True
    Me.Caption = Err.Number & " : " & Err.Description

End Sub

Private Sub Form_Load()
    txtBillingID.Text = 1
    txtItemID.Text = 1
    txtStatus.Text = "Availiable"
    txtAmount.Text = "1"
    txtDiscount.Text = 10
    txtTaxValue.Text = CStr(200 * 1 * 0.07)
    TxtPrice = "200"
End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

Private Sub CalTaxValue()

    txtTaxValue.Text = CStr(CCSng(TxtPrice.Text) * CCInt(txtAmount.Text) * 0.07)

End Sub

Private Sub txtAmount_Change()
    CalTaxValue
End Sub

Private Sub TxtPrice_Change()
    CalTaxValue
End Sub
