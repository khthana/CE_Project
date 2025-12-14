VERSION 5.00
Begin VB.Form frmAddAccount 
   Caption         =   "Add Account"
   ClientHeight    =   4305
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   7170
   LinkTopic       =   "Form1"
   ScaleHeight     =   4305
   ScaleWidth      =   7170
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdAddAccount 
      Caption         =   "Add Account"
      Height          =   495
      Left            =   4200
      TabIndex        =   14
      Top             =   3480
      Width           =   1455
   End
   Begin VB.TextBox txtFax 
      Height          =   405
      Left            =   4800
      TabIndex        =   13
      Top             =   2040
      Width           =   2175
   End
   Begin VB.TextBox txtTel 
      Height          =   405
      Left            =   4800
      TabIndex        =   12
      Top             =   1560
      Width           =   2175
   End
   Begin VB.TextBox txtCountry 
      Height          =   405
      Left            =   4800
      TabIndex        =   11
      Top             =   1080
      Width           =   2175
   End
   Begin VB.TextBox txtPostcode 
      Height          =   405
      Left            =   4800
      TabIndex        =   10
      Top             =   600
      Width           =   2175
   End
   Begin VB.TextBox txtProvince 
      Height          =   405
      Left            =   4800
      TabIndex        =   9
      Top             =   120
      Width           =   2175
   End
   Begin VB.TextBox txtSubprovince 
      Height          =   405
      Left            =   1320
      TabIndex        =   8
      Top             =   3480
      Width           =   2175
   End
   Begin VB.TextBox txtAddress 
      Height          =   405
      Left            =   1320
      TabIndex        =   7
      Top             =   3000
      Width           =   2175
   End
   Begin VB.TextBox txtOccupation 
      Height          =   405
      Left            =   1320
      TabIndex        =   6
      Top             =   2520
      Width           =   2175
   End
   Begin VB.TextBox txtAge 
      Height          =   405
      Left            =   2880
      TabIndex        =   5
      Top             =   2040
      Width           =   615
   End
   Begin VB.TextBox txtSex 
      Height          =   405
      Left            =   1320
      TabIndex        =   4
      Top             =   2040
      Width           =   735
   End
   Begin VB.TextBox txtPassword 
      Height          =   375
      Left            =   1320
      TabIndex        =   3
      Top             =   1560
      Width           =   2175
   End
   Begin VB.TextBox txtEmail 
      Height          =   375
      Left            =   1320
      TabIndex        =   2
      Top             =   1080
      Width           =   2175
   End
   Begin VB.TextBox txtCussurname 
      Height          =   375
      Left            =   1320
      TabIndex        =   1
      Top             =   600
      Width           =   2175
   End
   Begin VB.TextBox txtCusname 
      Height          =   375
      Left            =   1320
      TabIndex        =   0
      Top             =   120
      Width           =   2175
   End
   Begin VB.Label Labeladdaccount 
      Height          =   615
      Left            =   3840
      TabIndex        =   29
      Top             =   2640
      Width           =   3015
   End
   Begin VB.Label Label14 
      Caption         =   "Fax"
      Height          =   255
      Left            =   3960
      TabIndex        =   28
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label Label13 
      Caption         =   "Tel"
      Height          =   255
      Left            =   3960
      TabIndex        =   27
      Top             =   1680
      Width           =   615
   End
   Begin VB.Label Label12 
      Caption         =   "Country"
      Height          =   255
      Left            =   3960
      TabIndex        =   26
      Top             =   1200
      Width           =   615
   End
   Begin VB.Label Label11 
      Caption         =   "Postcode"
      Height          =   255
      Left            =   3960
      TabIndex        =   25
      Top             =   720
      Width           =   975
   End
   Begin VB.Label Label10 
      Caption         =   "Province"
      Height          =   255
      Left            =   3960
      TabIndex        =   24
      Top             =   240
      Width           =   855
   End
   Begin VB.Label Label9 
      Caption         =   "Subprovince"
      Height          =   255
      Left            =   240
      TabIndex        =   23
      Top             =   3600
      Width           =   975
   End
   Begin VB.Label Label8 
      Caption         =   "Address"
      Height          =   255
      Left            =   240
      TabIndex        =   22
      Top             =   3120
      Width           =   615
   End
   Begin VB.Label Label7 
      Caption         =   "Occupation"
      Height          =   255
      Left            =   240
      TabIndex        =   21
      Top             =   2640
      Width           =   975
   End
   Begin VB.Label Label6 
      Caption         =   "Age"
      Height          =   255
      Left            =   2400
      TabIndex        =   20
      Top             =   2160
      Width           =   375
   End
   Begin VB.Label Label5 
      Caption         =   "Sex"
      Height          =   255
      Left            =   240
      TabIndex        =   19
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label Label4 
      Caption         =   "Password"
      Height          =   255
      Left            =   240
      TabIndex        =   18
      Top             =   1680
      Width           =   855
   End
   Begin VB.Label Label3 
      Caption         =   "Email"
      Height          =   255
      Left            =   240
      TabIndex        =   17
      Top             =   1200
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "Surname"
      Height          =   255
      Left            =   240
      TabIndex        =   16
      Top             =   720
      Width           =   615
   End
   Begin VB.Label Label1 
      Caption         =   "Name"
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   240
      Width           =   615
   End
End
Attribute VB_Name = "frmAddAccount"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAddAccount_Click()
Dim IntAccountID As Integer
Dim ObjAccount As Object

cmdAddAccount.Enabled = False

On Error GoTo AddAccountError
Set ObjAccount = CreateObject("ecomm.account")
With ObjAccount
  .Cusname = txtCusname.Text
  .cussurname = txtCussurname.Text
  .email = txtEmail.Text
  .Password = txtPassword.Text
  .sex = txtSex.Text
  .age = CCInt(txtAge.Text)
  .occupation = txtOccupation.Text
  .address = txtAddress.Text
  .subprovince = txtSubprovince.Text
  .province = txtProvince.Text
  .postcode = txtPostcode.Text
  .country = txtCountry.Text
  .tel = txtTel.Text
  .fax = txtFax.Text
  IntAccountID = .AddAccount
End With

Set ObjAccount = Nothing

MsgBox "Account ID : " & IntAccountID
cmdAddAccount.Enabled = True

Exit Sub
AddAccountError:
    cmdAddAccount.Enabled = True
    Labeladdaccount.Caption = Err.Number & " : " & Err.Description
    
End Sub

Private Sub Form_Load()
  txtCusname.Text = "Niran"
  txtCussurname.Text = "Luckcanakul"
  txtEmail.Text = "boy@yahoo.com"
  txtPassword.Text = "boy"
  txtSex.Text = "male"
  txtAge.Text = "20"
  txtOccupation.Text = "Engineer"
  txtAddress.Text = "42 Ladphrao"
  txtSubprovince.Text = "Bangkapi"
  txtProvince.Text = "Bangkok"
  txtPostcode.Text = "10310"
  txtCountry.Text = "Thailand"
  txtTel.Text = "933-7606"
  txtFax.Text = "933-7606"
  
End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub

