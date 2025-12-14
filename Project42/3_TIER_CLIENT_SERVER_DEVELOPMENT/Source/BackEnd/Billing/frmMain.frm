VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Main"
   ClientHeight    =   4185
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6630
   LinkTopic       =   "Form1"
   ScaleHeight     =   4185
   ScaleWidth      =   6630
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdUpdateBillingStatus 
      Caption         =   "Update billing status"
      Height          =   735
      Left            =   5280
      TabIndex        =   14
      Top             =   480
      Width           =   1215
   End
   Begin VB.CommandButton cmdCalTax 
      Caption         =   "Calculate Tax"
      Height          =   495
      Left            =   3480
      TabIndex        =   13
      Top             =   3240
      Width           =   1455
   End
   Begin VB.CommandButton CmdCalPrice 
      Caption         =   "Calculate Price"
      Height          =   495
      Left            =   3480
      TabIndex        =   12
      Top             =   2520
      Width           =   1455
   End
   Begin VB.CommandButton cmdRetrieveBillingDetail 
      Caption         =   "Retrieve"
      Height          =   495
      Left            =   1920
      TabIndex        =   11
      Top             =   3240
      Width           =   1335
   End
   Begin VB.CommandButton cmdUpdateBillingDetail 
      Caption         =   "Update"
      Height          =   495
      Left            =   360
      TabIndex        =   10
      Top             =   3240
      Width           =   1335
   End
   Begin VB.CommandButton cmdDeleteBillingDetail 
      Caption         =   "Delete"
      Height          =   495
      Left            =   1920
      TabIndex        =   9
      Top             =   2520
      Width           =   1335
   End
   Begin VB.CommandButton cmdAddBillingDetail 
      Caption         =   "Add"
      Height          =   495
      Left            =   360
      TabIndex        =   8
      Top             =   2520
      Width           =   1335
   End
   Begin VB.Frame Frame2 
      Caption         =   "Billing Detail"
      Height          =   1935
      Left            =   120
      TabIndex        =   7
      Top             =   2160
      Width           =   5055
   End
   Begin VB.CommandButton cmdCalTotalFax 
      Caption         =   "Calculate TotalTax"
      Height          =   615
      Left            =   3480
      TabIndex        =   6
      Top             =   1320
      Width           =   1455
   End
   Begin VB.CommandButton CmdCalTotalPrice 
      Caption         =   "Calculate TotalPrice"
      Height          =   615
      Left            =   3480
      TabIndex        =   5
      Top             =   480
      Width           =   1455
   End
   Begin VB.CommandButton cmdRetrieveBilling 
      Caption         =   "Retrieve"
      Height          =   495
      Left            =   1920
      TabIndex        =   4
      Top             =   1320
      Width           =   1335
   End
   Begin VB.CommandButton cmdUpdateBilling 
      Caption         =   "Update"
      Height          =   495
      Left            =   360
      TabIndex        =   3
      Top             =   1320
      Width           =   1335
   End
   Begin VB.CommandButton cmdDeleteBilling 
      Caption         =   "Delete"
      Height          =   495
      Left            =   1920
      TabIndex        =   2
      Top             =   600
      Width           =   1335
   End
   Begin VB.CommandButton cmdAddBilling 
      Caption         =   "Add"
      Height          =   495
      Left            =   360
      TabIndex        =   1
      Top             =   600
      Width           =   1335
   End
   Begin VB.Frame Frame1 
      Caption         =   "Billing"
      Height          =   1935
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   5055
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAddBilling_Click()
  Me.Hide
  frmAddBilling.Show
End Sub

Private Sub cmdAddBillingDetail_Click()
  Me.Hide
  frmAddBillingDetail.Show
End Sub

Private Sub cmdCalPrice_Click()
  Me.Hide
  frmCalPrice.Show
End Sub

Private Sub cmdCalTax_Click()
  Me.Hide
  frmCalTax.Show
End Sub

Private Sub cmdCalTotalFax_Click()
  Me.Hide
  frmCalTotalTax.Show
End Sub

Private Sub cmdCalTotalPrice_Click()
  Me.Hide
  frmCalTotalPrice.Show
End Sub

Private Sub cmdDeleteBilling_Click()
  Me.Hide
  frmDeleteBilling.Show
End Sub

Private Sub cmdDeleteBillingDetail_Click()
  Me.Hide
  frmDeleteBillingDetail.Show
End Sub

Private Sub cmdRetrieveBilling_Click()
  Me.Hide
  frmRetrieveBilling.Show
End Sub

Private Sub cmdRetrieveBillingDetail_Click()
  Me.Hide
  frmRetrieveBillingDetail.Show
End Sub

Private Sub cmdUpdateBilling_Click()
  Me.Hide
  frmUpdateBilling.Show
End Sub

Private Sub cmdUpdateBillingDetail_Click()
  Me.Hide
  frmUpdateBillingDetail.Show
End Sub

Private Sub cmdUpdateBillingStatus_Click()
Dim objBilling As Object
Dim IntBillingID As Integer

    cmdUpdateBillingStatus.Enabled = False
On Error GoTo UpdateBillingStatusError
    IntBillingID = CCInt(InputBox("Billing id"))
    
    If IntBillingID > 0 Then
      Set objBilling = CreateObject("Ecomm.billing")
      objBilling.billingid = IntBillingID
      objBilling.updatebillingstatus
    End If
    
    cmdUpdateBillingStatus.Enabled = True
Exit Sub
UpdateBillingStatusError:
    cmdUpdateBillingStatus.Enabled = True
    Me.Caption = Err.Number & " : " & Err.Description

End Sub
