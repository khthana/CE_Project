VERSION 5.00
Begin VB.Form frmAddCategory 
   Caption         =   "Add Category"
   ClientHeight    =   5235
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5190
   LinkTopic       =   "Form1"
   ScaleHeight     =   5235
   ScaleWidth      =   5190
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdAddCategory 
      Caption         =   "Add Category"
      Height          =   495
      Left            =   960
      TabIndex        =   22
      Top             =   4320
      Width           =   1455
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   16
      Left            =   960
      TabIndex        =   5
      Top             =   2280
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   15
      Left            =   960
      TabIndex        =   4
      Top             =   1920
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   14
      Left            =   960
      TabIndex        =   3
      Top             =   1560
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      Height          =   375
      Index           =   13
      Left            =   960
      TabIndex        =   2
      Top             =   1200
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   0
      Left            =   960
      TabIndex        =   9
      Top             =   3720
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   17
      Left            =   960
      TabIndex        =   8
      Top             =   3360
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   18
      Left            =   960
      TabIndex        =   7
      Top             =   3000
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   19
      Left            =   960
      TabIndex        =   6
      Top             =   2640
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   20
      Left            =   3360
      TabIndex        =   13
      Top             =   1320
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   21
      Left            =   3360
      TabIndex        =   12
      Top             =   960
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   22
      Left            =   3360
      TabIndex        =   11
      Top             =   600
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   23
      Left            =   3360
      TabIndex        =   10
      Top             =   240
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   24
      Left            =   3360
      TabIndex        =   17
      Top             =   2760
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   25
      Left            =   3360
      TabIndex        =   16
      Top             =   2400
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   26
      Left            =   3360
      TabIndex        =   15
      Top             =   2040
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   27
      Left            =   3360
      TabIndex        =   14
      Top             =   1680
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   28
      Left            =   3360
      TabIndex        =   21
      Top             =   4200
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   29
      Left            =   3360
      TabIndex        =   20
      Top             =   3840
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   30
      Left            =   3360
      TabIndex        =   19
      Top             =   3480
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   31
      Left            =   3360
      TabIndex        =   18
      Top             =   3120
      Width           =   1600
   End
   Begin VB.TextBox txtCategoryType 
      Height          =   375
      Left            =   1320
      TabIndex        =   1
      Top             =   720
      Width           =   1215
   End
   Begin VB.TextBox txtShopID 
      Height          =   375
      Left            =   1320
      TabIndex        =   0
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Laddcategory 
      Height          =   255
      Left            =   120
      TabIndex        =   45
      Top             =   4920
      Width           =   5055
   End
   Begin VB.Label lblLabels 
      Caption         =   "F4"
      Height          =   255
      Index           =   16
      Left            =   360
      TabIndex        =   44
      Top             =   2400
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F3"
      Height          =   255
      Index           =   15
      Left            =   360
      TabIndex        =   43
      Top             =   2040
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F2"
      Height          =   255
      Index           =   14
      Left            =   360
      TabIndex        =   42
      Top             =   1680
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F1"
      Height          =   255
      Index           =   13
      Left            =   360
      TabIndex        =   41
      Top             =   1320
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F8"
      Height          =   255
      Index           =   0
      Left            =   360
      TabIndex        =   40
      Top             =   3840
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F7"
      Height          =   255
      Index           =   17
      Left            =   360
      TabIndex        =   39
      Top             =   3480
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F6"
      Height          =   255
      Index           =   18
      Left            =   360
      TabIndex        =   38
      Top             =   3120
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F5"
      Height          =   255
      Index           =   19
      Left            =   360
      TabIndex        =   37
      Top             =   2760
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F12"
      Height          =   255
      Index           =   20
      Left            =   2880
      TabIndex        =   36
      Top             =   1440
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F11"
      Height          =   255
      Index           =   21
      Left            =   2880
      TabIndex        =   35
      Top             =   1080
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F10"
      Height          =   255
      Index           =   22
      Left            =   2880
      TabIndex        =   34
      Top             =   720
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F9"
      Height          =   255
      Index           =   23
      Left            =   2880
      TabIndex        =   33
      Top             =   360
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F16"
      Height          =   255
      Index           =   24
      Left            =   2880
      TabIndex        =   32
      Top             =   2880
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F15"
      Height          =   255
      Index           =   25
      Left            =   2880
      TabIndex        =   31
      Top             =   2520
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F14"
      Height          =   255
      Index           =   26
      Left            =   2880
      TabIndex        =   30
      Top             =   2160
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F13"
      Height          =   255
      Index           =   27
      Left            =   2880
      TabIndex        =   29
      Top             =   1800
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F20"
      Height          =   255
      Index           =   28
      Left            =   2880
      TabIndex        =   28
      Top             =   4320
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F19"
      Height          =   255
      Index           =   29
      Left            =   2880
      TabIndex        =   27
      Top             =   3960
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F18"
      Height          =   255
      Index           =   30
      Left            =   2880
      TabIndex        =   26
      Top             =   3600
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F17"
      Height          =   255
      Index           =   31
      Left            =   2880
      TabIndex        =   25
      Top             =   3240
      Width           =   495
   End
   Begin VB.Label Label2 
      Caption         =   "Category type"
      Height          =   255
      Left            =   120
      TabIndex        =   24
      Top             =   720
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Shop ID"
      Height          =   255
      Left            =   120
      TabIndex        =   23
      Top             =   360
      Width           =   615
   End
End
Attribute VB_Name = "frmAddCategory"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAddCategory_Click()
Dim ObjShop As Object

cmdAddCategory.Enabled = False

Set ObjShop = CreateObject("Ecomm.Shop")

On Error GoTo AddNewCategoryError

With ObjShop.category
'   .Categoryid auto generate
    .CategoryType = txtCategoryType.Text
    .F1 = txtFields(13).Text
    .F2 = txtFields(14).Text
    .F3 = txtFields(15).Text
    .F4 = txtFields(16).Text
    .F5 = txtFields(19).Text
    .F6 = txtFields(18).Text
    .F7 = txtFields(17).Text
    .F8 = txtFields(0).Text
    .F9 = txtFields(23).Text
    .F10 = txtFields(22).Text
    .F11 = txtFields(21).Text
    .F12 = txtFields(20).Text
    .F13 = txtFields(27).Text
    .F14 = txtFields(26).Text
    .F15 = txtFields(25).Text
    .F16 = txtFields(24).Text
    .F17 = txtFields(31).Text
    .F18 = txtFields(30).Text
    .F19 = txtFields(29).Text
    .F20 = txtFields(28).Text
    tmpCategoryID = .AddNew(CCInt(txtShopID.Text))
End With
    
    MsgBox "Add Category type : " & txtCategoryType.Text & " Complete"
    cmdAddCategory.Enabled = True
    
Set ObjShop = Nothing

Exit Sub
AddNewCategoryError:
    cmdAddCategory.Enabled = True
    Laddcategory.Caption = Err.Number & " : " & Err.Description
    Set ObjShop = Nothing

End Sub

Private Sub Form_Load()
    txtShopID.Text = CStr(tmpShopID)
    txtCategoryType = "Book"
    txtFields(13).Text = "ColName1"
    txtFields(14).Text = "ColName2"
    txtFields(15).Text = "ColName3"
    txtFields(16).Text = "ColName4"
    txtFields(19).Text = "ColName5"
    txtFields(18).Text = "ColName6"
    txtFields(17).Text = "ColName7"
    txtFields(0).Text = "ColName8"
    txtFields(23).Text = "ColName9"
    txtFields(22).Text = "ColName10"
    txtFields(21).Text = "ColName11"
    txtFields(20).Text = "ColName12"
    txtFields(27).Text = "ColName13"
    txtFields(26).Text = "ColName14"
    txtFields(25).Text = "ColName15"
    txtFields(24).Text = "ColName16"
    txtFields(31).Text = "ColName17"
    txtFields(30).Text = "ColName18"
    txtFields(29).Text = "ColName19"
    txtFields(28).Text = "ColName20"
    
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    frmMain.Show
End Sub

