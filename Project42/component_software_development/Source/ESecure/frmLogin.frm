VERSION 5.00
Begin VB.Form frmLogin 
   Caption         =   "Login"
   ClientHeight    =   4440
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4470
   LinkTopic       =   "Form1"
   ScaleHeight     =   4440
   ScaleWidth      =   4470
   StartUpPosition =   3  'Windows Default
   Begin VB.Frame Frame2 
      Caption         =   "Frame2"
      Height          =   1935
      Left            =   120
      TabIndex        =   11
      Top             =   2280
      Width           =   3495
      Begin VB.TextBox txtOwnerUsername 
         Height          =   375
         Left            =   1200
         TabIndex        =   4
         Top             =   240
         Width           =   1935
      End
      Begin VB.TextBox txtOwnerPassword 
         Height          =   405
         IMEMode         =   3  'DISABLE
         Left            =   1200
         TabIndex        =   5
         Top             =   720
         Width           =   1935
      End
      Begin VB.CommandButton cmdLoginOwner 
         Caption         =   "Login"
         Height          =   495
         Left            =   360
         TabIndex        =   6
         Top             =   1320
         Width           =   1335
      End
      Begin VB.CommandButton cmdLogoutOwner 
         Caption         =   "Logout"
         Height          =   495
         Left            =   1920
         TabIndex        =   7
         Top             =   1320
         Width           =   1335
      End
      Begin VB.Label Label4 
         Caption         =   "Username"
         Height          =   255
         Left            =   240
         TabIndex        =   13
         Top             =   360
         Width           =   735
      End
      Begin VB.Label Label3 
         Caption         =   "Password"
         Height          =   255
         Left            =   240
         TabIndex        =   12
         Top             =   840
         Width           =   735
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Customer"
      Height          =   2175
      Left            =   120
      TabIndex        =   8
      Top             =   0
      Width           =   3495
      Begin VB.TextBox txtEmail 
         Height          =   375
         Left            =   1200
         TabIndex        =   0
         Top             =   360
         Width           =   1935
      End
      Begin VB.TextBox txtPassword 
         Height          =   405
         IMEMode         =   3  'DISABLE
         Left            =   1200
         TabIndex        =   1
         Top             =   840
         Width           =   1935
      End
      Begin VB.CommandButton cmdLogin 
         Caption         =   "Login"
         Height          =   495
         Left            =   360
         TabIndex        =   2
         Top             =   1440
         Width           =   1335
      End
      Begin VB.CommandButton cmdLogout 
         Caption         =   "Logout"
         Height          =   495
         Left            =   1920
         TabIndex        =   3
         Top             =   1440
         Width           =   1335
      End
      Begin VB.Label Label1 
         Caption         =   "E-Mail"
         Height          =   255
         Left            =   240
         TabIndex        =   10
         Top             =   480
         Width           =   735
      End
      Begin VB.Label Label2 
         Caption         =   "Password"
         Height          =   255
         Left            =   240
         TabIndex        =   9
         Top             =   960
         Width           =   735
      End
   End
End
Attribute VB_Name = "frmLogin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdLogin_Click()
Dim ObjSecure As Object

On Error GoTo LoginError
Set ObjSecure = CreateObject("FrontEcomm.ESecure")

  ObjSecure.CusUserName = txtEmail.Text
  ObjSecure.cuspassword = txtPassword.Text
    
  If ObjSecure.login Then
     MsgBox "Welcome your account ID : " & ObjSecure.accountid
  Else
     Me.Caption = Err.Number & " : " & Err.Description
  End If

  Set ObjSecure = Nothing
  
Exit Sub
LoginError:
    Me.Caption = Err.Number & " : " & Err.Description

End Sub

Private Sub cmdLoginOwner_Click()
Dim ObjSecure As Object

On Error GoTo LoginOwnerError
Set ObjSecure = CreateObject("Frontecomm.esecure")
    
  ObjSecure.CusUserName = txtOwnerUsername.Text
  ObjSecure.cuspassword = txtOwnerPassword.Text
    
  If ObjSecure.loginowner Then
     MsgBox "Welcome your shop ID : " & ObjSecure.accountid
  Else
     Me.Caption = Err.Number & " : " & Err.Description
  End If

  Set ObjSecure = Nothing
  
Exit Sub
LoginOwnerError:
    Me.Caption = Err.Number & " : " & Err.Description
    


End Sub

Private Sub cmdLogout_Click()
Dim ObjSecure As Object

Set ObjSecure = CreateObject("FrontEcomm.ESecure")
   If ObjSecure.logout Then
      MsgBox "Logout"
   Else
      Me.Caption = Err.Number & " : " & Err.Description
   End If
  
Set ObjSecure = Nothing
End Sub

