VERSION 5.00
Begin VB.Form frmDeleteShop 
   Caption         =   "Delete shop"
   ClientHeight    =   1845
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2850
   LinkTopic       =   "Form1"
   ScaleHeight     =   1845
   ScaleWidth      =   2850
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdDeleteShop 
      Caption         =   "Delete"
      Height          =   375
      Left            =   840
      TabIndex        =   1
      Top             =   840
      Width           =   1215
   End
   Begin VB.TextBox txtCriteria 
      Height          =   375
      Left            =   1080
      TabIndex        =   0
      ToolTipText     =   "ShopID > 0"
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Ldeleteshop 
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1440
      Width           =   2655
   End
   Begin VB.Label Label1 
      Caption         =   "Criteria"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   360
      Width           =   855
   End
End
Attribute VB_Name = "frmDeleteShop"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdDeleteShop_Click()
Dim ObjShop As Object
  cmdDeleteShop.Enabled = False
  
On Error GoTo DeleteError
  Set ObjShop = CreateObject("Ecomm.shop")
  
  ObjShop.Delete txtCriteria.Text
  
  Set ObjShop = Nothing
  MsgBox "Delete vShop where " & txtCriteria.Text & " Complete"
  cmdDeleteShop.Enabled = True
  
Exit Sub
DeleteError:
  Ldeleteshop.Caption = Err.Number & " : " & Err.Description
  cmdDeleteShop.Enabled = True
  
End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub
