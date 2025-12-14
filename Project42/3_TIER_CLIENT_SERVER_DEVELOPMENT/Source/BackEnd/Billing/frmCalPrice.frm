VERSION 5.00
Begin VB.Form frmCalPrice 
   Caption         =   "Calculate Price"
   ClientHeight    =   1215
   ClientLeft      =   2955
   ClientTop       =   2475
   ClientWidth     =   5130
   LinkTopic       =   "Form1"
   ScaleHeight     =   1215
   ScaleWidth      =   5130
   Begin VB.CommandButton cmdCalPrice 
      Caption         =   "Calculate Price"
      Height          =   495
      Left            =   3240
      TabIndex        =   4
      Top             =   240
      Width           =   1455
   End
   Begin VB.TextBox txtItemID 
      Height          =   405
      Left            =   1200
      TabIndex        =   3
      Top             =   600
      Width           =   1575
   End
   Begin VB.TextBox txtBillingID 
      Height          =   405
      Left            =   1200
      TabIndex        =   1
      Top             =   120
      Width           =   1575
   End
   Begin VB.Label Label2 
      Caption         =   "Item ID"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   720
      Width           =   855
   End
   Begin VB.Label Label1 
      Caption         =   "Billing ID"
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   855
   End
End
Attribute VB_Name = "frmCalPrice"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdCalPrice_Click()
Dim ObjBillingdetail As Object
Dim Price As Single

  cmdCalPrice.Enabled = False
On Error GoTo CalPriceError
Set ObjBillingdetail = CreateObject("Ecomm.billingdetail")

With ObjBillingdetail
  .billingid = CInt(txtBillingID.Text)
  .itemid = CInt(txtItemID.Text)
  
  Price = .calprice
End With

 MsgBox "Price : " & Price & vbCrLf & _
        "And update to tblBillingDetail.price complete"
 
 Set ObjBillingdetail = Nothing

 cmdCalPrice.Enabled = True
Exit Sub
CalPriceError:
    Me.Caption = Err.Number & " : " & Err.Description
    cmdCalPrice.Enabled = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

