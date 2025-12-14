VERSION 5.00
Begin VB.Form frmMain 
   Caption         =   "Main"
   ClientHeight    =   1845
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3960
   LinkTopic       =   "Form1"
   ScaleHeight     =   1845
   ScaleWidth      =   3960
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdRetrieveAccount 
      Caption         =   "Retrieve Account"
      Height          =   495
      Left            =   2040
      TabIndex        =   3
      Top             =   1080
      Width           =   1575
   End
   Begin VB.CommandButton cmdUpdateAccount 
      Caption         =   "Update Account"
      Height          =   495
      Left            =   2040
      TabIndex        =   2
      Top             =   240
      Width           =   1575
   End
   Begin VB.CommandButton cmdDeleteAccount 
      Caption         =   "Delete Account"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   1080
      Width           =   1575
   End
   Begin VB.CommandButton cmdAddAccount 
      Caption         =   "Add Account"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAddAccount_Click()
  frmAddAccount.Show
  Me.Hide
End Sub

Private Sub cmdDeleteAccount_Click()
 frmDeleteAccount.Show
 Me.Hide
End Sub

Private Sub cmdRetrieveAccount_Click()
 frmRetrieveAccount.Show
 Me.Hide
End Sub

Private Sub cmdUpdateAccount_Click()
  frmUpdateAccount.Show
  Me.Hide
End Sub
