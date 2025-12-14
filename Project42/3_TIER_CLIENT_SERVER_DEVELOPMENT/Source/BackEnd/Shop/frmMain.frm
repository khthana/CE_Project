VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Form Main"
   ClientHeight    =   4170
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7320
   LinkTopic       =   "Form1"
   ScaleHeight     =   4170
   ScaleWidth      =   7320
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame3 
      Caption         =   "Category"
      Height          =   1815
      Left            =   3720
      TabIndex        =   14
      Top             =   120
      Width           =   3495
      Begin VB.CommandButton cmdfindcategory 
         Caption         =   "Retrieve Category"
         Height          =   495
         Left            =   1680
         TabIndex        =   7
         Top             =   1080
         Width           =   1575
      End
      Begin VB.CommandButton Cmdupdatecategory 
         Caption         =   "Update Category"
         Height          =   495
         Left            =   1680
         TabIndex        =   5
         Top             =   360
         Width           =   1575
      End
      Begin VB.CommandButton cmdDeleteCategory 
         Caption         =   "Delete Category"
         Height          =   495
         Left            =   120
         TabIndex        =   6
         Top             =   1080
         Width           =   1335
      End
      Begin VB.CommandButton cmdAddCategory 
         Caption         =   "Add Category"
         Height          =   495
         Left            =   120
         TabIndex        =   4
         Top             =   360
         Width           =   1335
      End
   End
   Begin VB.CommandButton cmdAddItem 
      Caption         =   "Add New Item"
      Height          =   495
      Left            =   360
      TabIndex        =   8
      Top             =   2400
      Width           =   1455
   End
   Begin VB.Frame Frame2 
      Caption         =   "Item"
      Height          =   1815
      Left            =   120
      TabIndex        =   13
      Top             =   2040
      Width           =   3495
      Begin VB.CommandButton CmdRetrieveItem 
         Caption         =   "Retrieve Item"
         Height          =   495
         Left            =   1800
         TabIndex        =   11
         Top             =   1080
         Width           =   1335
      End
      Begin VB.CommandButton CmdDeleteitem 
         Caption         =   "Delete Item"
         Height          =   495
         Left            =   240
         TabIndex        =   10
         Top             =   1080
         Width           =   1455
      End
      Begin VB.CommandButton CmdUpdateItem 
         Caption         =   "Update Item"
         Height          =   495
         Left            =   1800
         TabIndex        =   9
         Top             =   360
         Width           =   1335
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Shop"
      Height          =   1815
      Left            =   120
      TabIndex        =   12
      Top             =   120
      Width           =   3495
      Begin VB.CommandButton cmdAddNewShop 
         Caption         =   "Add New Shop"
         Height          =   495
         Left            =   240
         TabIndex        =   0
         Top             =   360
         Width           =   1455
      End
      Begin VB.CommandButton cmdUpdateShop 
         Caption         =   "Update Shop"
         Height          =   495
         Left            =   1800
         TabIndex        =   1
         Top             =   360
         Width           =   1335
      End
      Begin VB.CommandButton cmdDelete 
         Caption         =   "Delete Shop"
         Height          =   495
         Left            =   240
         TabIndex        =   2
         Top             =   1080
         Width           =   1455
      End
      Begin VB.CommandButton cmdRetrieve 
         Caption         =   "Retreive"
         Height          =   495
         Left            =   1800
         TabIndex        =   3
         Top             =   1080
         Width           =   1335
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


' ---- Shop --------

Private Sub cmdAddNewShop_Click()
  Me.Hide
  frmAddShop.Show
End Sub

Private Sub cmdDelete_Click()
  Me.Hide
  frmDeleteShop.Show
End Sub

Private Sub cmdUpdateShop_Click()
  Me.Hide
  frmUpdateShop.Show
End Sub

Private Sub cmdRetrieve_Click()
  Me.Hide
  frmRetrieveShop.Show
End Sub



' ---- Category ---------

Private Sub cmdAddCategory_Click()
  Me.Hide
  frmAddCategory.Show
End Sub

Private Sub cmdDeleteCategory_Click()
  Me.Hide
  frmDeleteCategory.Show
End Sub

Private Sub cmdupdateCategory_Click()
  Me.Hide
  frmupdatecategory.Show
End Sub

Private Sub cmdfindcategory_Click()
  Me.Hide
  frmRetrieveCategory.Show
End Sub



' -------- Item ---------

Private Sub cmdAddItem_Click()
  Me.Hide
  frmAddItem.Show
End Sub

Private Sub cmdDeleteItem_Click()
  Me.Hide
  frmDeleteItem.Show
End Sub

Private Sub cmdUpdateItem_Click()
  Me.Hide
  FrmUpdateItem.Show
End Sub

Private Sub CmdRetrieveItem_Click()
  Me.Hide
  frmRetrieveItem.Show
End Sub




