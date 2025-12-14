VERSION 5.00
Begin VB.Form frmAddItem 
   Caption         =   "Form1"
   ClientHeight    =   5655
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   8775
   LinkTopic       =   "Form1"
   ScaleHeight     =   5655
   ScaleWidth      =   8775
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtFields 
      BackColor       =   &H80000013&
      DataField       =   "EMAIL"
      Height          =   285
      Index           =   5
      Left            =   1320
      Locked          =   -1  'True
      TabIndex        =   7
      Top             =   2400
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "EMAIL"
      Height          =   285
      Index           =   1
      Left            =   1320
      TabIndex        =   6
      Top             =   2040
      Width           =   1600
   End
   Begin VB.TextBox txtCategoryID 
      Height          =   315
      Left            =   3960
      TabIndex        =   1
      Top             =   120
      Width           =   975
   End
   Begin VB.TextBox txtShopID 
      Height          =   285
      Left            =   1080
      TabIndex        =   0
      Top             =   120
      Width           =   735
   End
   Begin VB.CommandButton cmdAddNewItem 
      Caption         =   "Add New Item"
      Height          =   495
      Left            =   6480
      TabIndex        =   33
      Top             =   4920
      Width           =   1455
   End
   Begin VB.TextBox txtFields 
      DataField       =   "SHOPNAME"
      Height          =   285
      Index           =   32
      Left            =   1320
      TabIndex        =   2
      Top             =   720
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   285
      Index           =   31
      Left            =   6840
      TabIndex        =   29
      Top             =   3360
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   285
      Index           =   30
      Left            =   6840
      TabIndex        =   30
      Top             =   3675
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   285
      Index           =   29
      Left            =   6840
      TabIndex        =   31
      Top             =   4005
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   285
      Index           =   28
      Left            =   6840
      TabIndex        =   32
      Top             =   4320
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   285
      Index           =   27
      Left            =   6840
      TabIndex        =   25
      Top             =   2040
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   285
      Index           =   26
      Left            =   6840
      TabIndex        =   26
      Top             =   2355
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   285
      Index           =   25
      Left            =   6840
      TabIndex        =   27
      Top             =   2685
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   285
      Index           =   24
      Left            =   6840
      TabIndex        =   28
      Top             =   3000
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   285
      Index           =   23
      Left            =   6840
      TabIndex        =   21
      Top             =   720
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   285
      Index           =   22
      Left            =   6840
      TabIndex        =   22
      Top             =   1035
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   285
      Index           =   21
      Left            =   6840
      TabIndex        =   23
      Top             =   1365
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   285
      Index           =   20
      Left            =   6840
      TabIndex        =   24
      Top             =   1680
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   285
      Index           =   19
      Left            =   3720
      TabIndex        =   17
      Top             =   3720
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   285
      Index           =   18
      Left            =   3720
      TabIndex        =   18
      Top             =   4035
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   285
      Index           =   17
      Left            =   3720
      TabIndex        =   19
      Top             =   4365
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   285
      Index           =   0
      Left            =   3720
      TabIndex        =   20
      Top             =   4680
      Width           =   1815
   End
   Begin VB.TextBox txtFields 
      BackColor       =   &H80000013&
      DataField       =   "OWNERNAME"
      Height          =   285
      Index           =   2
      Left            =   1320
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   1035
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "OWNERSURNAME"
      Height          =   285
      Index           =   3
      Left            =   1320
      TabIndex        =   4
      Top             =   1365
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "EMAIL"
      Height          =   285
      Index           =   4
      Left            =   1320
      TabIndex        =   5
      Top             =   1680
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "USERNAME"
      Height          =   285
      Index           =   6
      Left            =   4440
      TabIndex        =   8
      Top             =   720
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "SEX"
      Height          =   285
      Index           =   7
      Left            =   4440
      TabIndex        =   9
      Top             =   1080
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "AGE"
      Height          =   285
      Index           =   8
      Left            =   4440
      TabIndex        =   10
      Top             =   1440
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "ADDRESS"
      Height          =   645
      Index           =   10
      Left            =   1320
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   12
      Top             =   2760
      Width           =   4245
   End
   Begin VB.TextBox txtFields 
      DataField       =   "PROVINCE"
      Height          =   285
      Index           =   11
      Left            =   4440
      TabIndex        =   11
      Top             =   1800
      Width           =   1600
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   285
      Index           =   13
      Left            =   840
      TabIndex        =   13
      Top             =   3720
      Width           =   2000
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   285
      Index           =   14
      Left            =   840
      TabIndex        =   14
      Top             =   4035
      Width           =   2000
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   285
      Index           =   15
      Left            =   840
      TabIndex        =   15
      Top             =   4365
      Width           =   2000
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   285
      Index           =   16
      Left            =   840
      TabIndex        =   16
      Top             =   4680
      Width           =   2000
   End
   Begin VB.Label LaddItem 
      Height          =   615
      Left            =   480
      TabIndex        =   67
      Top             =   5040
      Width           =   5535
   End
   Begin VB.Label lblLabels 
      Caption         =   "Create On"
      Height          =   255
      Index           =   5
      Left            =   240
      TabIndex        =   66
      Top             =   2400
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Discount"
      Height          =   255
      Index           =   1
      Left            =   240
      TabIndex        =   65
      Top             =   2040
      Width           =   1005
   End
   Begin VB.Label Label3 
      Caption         =   "Category ID"
      Height          =   255
      Left            =   2880
      TabIndex        =   64
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "Shop ID"
      Height          =   255
      Left            =   240
      TabIndex        =   63
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "ItemName"
      Height          =   255
      Left            =   240
      TabIndex        =   62
      Top             =   720
      Width           =   1000
   End
   Begin VB.Label lblLabels 
      Caption         =   "F17"
      Height          =   255
      Index           =   31
      Left            =   6360
      TabIndex        =   61
      Top             =   3480
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F18"
      Height          =   255
      Index           =   30
      Left            =   6360
      TabIndex        =   60
      Top             =   3795
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F19"
      Height          =   255
      Index           =   29
      Left            =   6360
      TabIndex        =   59
      Top             =   4125
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F20"
      Height          =   255
      Index           =   28
      Left            =   6360
      TabIndex        =   58
      Top             =   4440
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F13"
      Height          =   255
      Index           =   27
      Left            =   6360
      TabIndex        =   57
      Top             =   2040
      Width           =   615
   End
   Begin VB.Label lblLabels 
      Caption         =   "F14"
      Height          =   255
      Index           =   26
      Left            =   6360
      TabIndex        =   56
      Top             =   2355
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F15"
      Height          =   255
      Index           =   25
      Left            =   6360
      TabIndex        =   55
      Top             =   2685
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F16"
      Height          =   255
      Index           =   24
      Left            =   6360
      TabIndex        =   54
      Top             =   3000
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F9"
      Height          =   255
      Index           =   23
      Left            =   6360
      TabIndex        =   53
      Top             =   840
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F10"
      Height          =   255
      Index           =   22
      Left            =   6360
      TabIndex        =   52
      Top             =   1155
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F11"
      Height          =   255
      Index           =   21
      Left            =   6360
      TabIndex        =   51
      Top             =   1485
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F12"
      Height          =   255
      Index           =   20
      Left            =   6360
      TabIndex        =   50
      Top             =   1800
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F5"
      Height          =   255
      Index           =   19
      Left            =   3240
      TabIndex        =   49
      Top             =   3720
      Width           =   615
   End
   Begin VB.Label lblLabels 
      Caption         =   "F6"
      Height          =   255
      Index           =   18
      Left            =   3240
      TabIndex        =   48
      Top             =   4035
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F7"
      Height          =   255
      Index           =   17
      Left            =   3240
      TabIndex        =   47
      Top             =   4365
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "F8"
      Height          =   255
      Index           =   0
      Left            =   3240
      TabIndex        =   46
      Top             =   4680
      Width           =   375
   End
   Begin VB.Label lblLabels 
      Caption         =   "Picture"
      Height          =   255
      Index           =   2
      Left            =   240
      TabIndex        =   45
      Top             =   1035
      Width           =   1000
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sound"
      Height          =   255
      Index           =   3
      Left            =   240
      TabIndex        =   44
      Top             =   1365
      Width           =   1000
   End
   Begin VB.Label lblLabels 
      Caption         =   "Video"
      Height          =   255
      Index           =   4
      Left            =   240
      TabIndex        =   43
      Top             =   1680
      Width           =   1000
   End
   Begin VB.Label lblLabels 
      Caption         =   "Barcode"
      Height          =   255
      Index           =   6
      Left            =   3360
      TabIndex        =   42
      Top             =   720
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Status"
      Height          =   255
      Index           =   7
      Left            =   3360
      TabIndex        =   41
      Top             =   1080
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Price"
      Height          =   255
      Index           =   8
      Left            =   3360
      TabIndex        =   40
      Top             =   1440
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "Description"
      Height          =   255
      Index           =   10
      Left            =   240
      TabIndex        =   39
      Top             =   2760
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "UnitInStock"
      Height          =   255
      Index           =   11
      Left            =   3360
      TabIndex        =   38
      Top             =   1800
      Width           =   1005
   End
   Begin VB.Label lblLabels 
      Caption         =   "F1"
      Height          =   255
      Index           =   13
      Left            =   240
      TabIndex        =   37
      Top             =   3720
      Width           =   795
   End
   Begin VB.Label lblLabels 
      Caption         =   "F2"
      Height          =   255
      Index           =   14
      Left            =   240
      TabIndex        =   36
      Top             =   4035
      Width           =   795
   End
   Begin VB.Label lblLabels 
      Caption         =   "F3"
      Height          =   255
      Index           =   15
      Left            =   240
      TabIndex        =   35
      Top             =   4365
      Width           =   795
   End
   Begin VB.Label lblLabels 
      Caption         =   "F4"
      Height          =   255
      Index           =   16
      Left            =   240
      TabIndex        =   34
      Top             =   4680
      Width           =   795
   End
End
Attribute VB_Name = "frmAddItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub cmdAddNewItem_Click()
Dim ObjItem As Object
Dim intItemID As Integer

cmdAddNewItem.Enabled = False

Set ObjItem = CreateObject("Ecomm.Item")

On Error GoTo AddNewItemError

With ObjItem
'   .itemid auto generate
    .ShopID = CCInt(txtShopID.Text)
    .categoryid = CCInt(txtCategoryID.Text)
    .itemname = txtFields(32).Text
'    .Picture = txtFields(2).Text
    .sound = txtFields(3).Text
    .video = txtFields(4).Text
    .barcode = txtFields(6).Text
    .Status = txtFields(7).Text
    .discount = txtFields(1).Text
    .price = txtFields(8).Text
'    .CreateOn = Date
    .Description = txtFields(10).Text
    .unitinstock = txtFields(11).Text
'   .unitOnOrder Initial to 0 By Item.Addnew
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
    intItemID = .AddNew
End With

    MsgBox "Add Item : " & txtFields(32) & " Complete" & vbCrLf & _
           "ItemID : " & intItemID
Set ObjItem = Nothing
cmdAddNewItem.Enabled = True

Exit Sub
AddNewItemError:
    cmdAddNewItem.Enabled = True
    LaddItem.Caption = Err.Number & " : " & Err.Description
    Set ObjItem = Nothing

End Sub

Private Sub Form_Load()
    txtShopID.Text = tmpShopID
    txtCategoryID.Text = tmpCategoryID
    txtFields(32).Text = "Quick Pc"
    txtFields(3).Text = "MySound"
    txtFields(4).Text = "Myvideo"
    txtFields(6).Text = "xxxx555yyy"
    txtFields(7).Text = "Available"
    txtFields(8).Text = "200.25"
    txtFields(10).Text = "It's good"
    txtFields(11).Text = "50"
    txtFields(1).Text = "10.25"

    txtFields(13).Text = "myCol1"
    txtFields(14).Text = "myCol2"
    txtFields(15).Text = "myCol3"
    txtFields(16).Text = "myCol4"
    txtFields(19).Text = "myCol5"
    txtFields(18).Text = "myCol6"
    txtFields(17).Text = "myCol7"
    txtFields(0).Text = "myCol8"
    txtFields(23).Text = "myCol9"
    txtFields(22).Text = "myCol10"
    txtFields(21).Text = "myCol11"
    txtFields(20).Text = "myCol12"
    txtFields(27).Text = "myCol13"
    txtFields(26).Text = "myCol14"
    txtFields(25).Text = "myCol15"
    txtFields(24).Text = "myCol16"
    txtFields(31).Text = "myCol17"
    txtFields(30).Text = "myCol18"
    txtFields(29).Text = "myCol19"
    txtFields(28).Text = "myCol20"
    
End Sub
 
Private Sub Form_Unload(Cancel As Integer)
    frmMain.Show
End Sub

