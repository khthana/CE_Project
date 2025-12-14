VERSION 5.00
Begin VB.Form frmDeleteItem 
   Caption         =   "Delete Item"
   ClientHeight    =   1725
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   2940
   LinkTopic       =   "Form1"
   ScaleHeight     =   1725
   ScaleWidth      =   2940
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtCriteria 
      Height          =   375
      Left            =   1080
      TabIndex        =   0
      ToolTipText     =   "ShopID > 0"
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton cmdDeleteItem 
      Caption         =   "Delete"
      Height          =   375
      Left            =   840
      TabIndex        =   1
      Top             =   840
      Width           =   1215
   End
   Begin VB.Label Ldeleteitem 
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1320
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
Attribute VB_Name = "frmDeleteItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdDeleteItem_Click()
Dim ObjItem As Object
  cmdDeleteItem.Enabled = False
  
On Error GoTo DeleteError
  Set ObjItem = CreateObject("Ecomm.Item")
  
  ObjItem.Delete txtCriteria.Text
  
  Set ObjItem = Nothing
  MsgBox "Delete vItem where " & txtCriteria.Text & " Complete"
  cmdDeleteItem.Enabled = True
  
Exit Sub
DeleteError:
  Ldeleteitem.Caption = Err.Number & " : " & Err.Description
  cmdDeleteItem.Enabled = True

End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

