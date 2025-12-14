VERSION 5.00
Begin VB.Form frmTest 
   Caption         =   "Form1"
   ClientHeight    =   2415
   ClientLeft      =   3300
   ClientTop       =   3540
   ClientWidth     =   4125
   LinkTopic       =   "Form1"
   ScaleHeight     =   2415
   ScaleWidth      =   4125
   Begin VB.TextBox txtBankName 
      Height          =   405
      Left            =   2160
      TabIndex        =   1
      Top             =   600
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Pay !"
      Height          =   495
      Left            =   1560
      TabIndex        =   3
      Top             =   1680
      Width           =   1215
   End
   Begin VB.TextBox txtMoney 
      Height          =   375
      Left            =   2160
      TabIndex        =   2
      Top             =   1080
      Width           =   1575
   End
   Begin VB.TextBox txtCreditCardNumber 
      Height          =   405
      Left            =   2160
      TabIndex        =   0
      Top             =   120
      Width           =   1575
   End
   Begin VB.Label Label3 
      Caption         =   "Bank name"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   720
      Width           =   1455
   End
   Begin VB.Label Label2 
      Caption         =   "Money"
      Height          =   255
      Left            =   240
      TabIndex        =   5
      Top             =   1200
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "CreditCard Number"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   240
      Width           =   1455
   End
End
Attribute VB_Name = "frmTest"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
Dim ObjBank As Object

On Error GoTo Command1Error
Set ObjBank = CreateObject("BankingCOM.Banking")

With ObjBank
    .CreditcardNumber = txtCreditCardNumber.Text
    .BankName = txtBankName.Text
    .Money = CSng(txtMoney.Text)
    
    If Not .CheckValid Then
       Me.Caption = "Invalid credit card"
    Else
       MsgBox "Valid creditcard"
    End If
End With


Exit Sub
Command1Error:
    Me.Caption = Err.Description
End Sub

