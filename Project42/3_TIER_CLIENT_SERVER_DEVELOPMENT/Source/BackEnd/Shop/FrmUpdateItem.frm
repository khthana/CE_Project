VERSION 5.00
Begin VB.Form frmUpdateItem 
   Caption         =   "Upadate Item"
   ClientHeight    =   7575
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6015
   LinkTopic       =   "Form1"
   ScaleHeight     =   7575
   ScaleWidth      =   6015
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtFields 
      DataField       =   "PROVINCE"
      Height          =   375
      Index           =   5
      Left            =   1080
      TabIndex        =   68
      Top             =   4800
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "EMAIL"
      Height          =   375
      Index           =   2
      Left            =   1080
      TabIndex        =   66
      Top             =   3720
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      BackColor       =   &H80000013&
      DataField       =   "EMAIL"
      Height          =   375
      Index           =   1
      Left            =   1080
      Locked          =   -1  'True
      TabIndex        =   64
      Top             =   1560
      Width           =   1695
   End
   Begin VB.CommandButton cmdRetrieveItem 
      Caption         =   "Retrieve Item"
      Height          =   495
      Left            =   360
      TabIndex        =   3
      Top             =   600
      Width           =   5535
   End
   Begin VB.TextBox TxtItemID 
      Height          =   375
      Left            =   4920
      TabIndex        =   2
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   16
      Left            =   1200
      TabIndex        =   15
      Top             =   6360
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   15
      Left            =   1200
      TabIndex        =   14
      Top             =   6000
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   14
      Left            =   1200
      TabIndex        =   13
      Top             =   5640
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   13
      Left            =   1200
      TabIndex        =   12
      Top             =   5280
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "PROVINCE"
      Height          =   375
      Index           =   11
      Left            =   1080
      TabIndex        =   11
      Top             =   4440
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "ADDRESS"
      Height          =   375
      Index           =   10
      Left            =   1080
      TabIndex        =   10
      Top             =   4080
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "AGE"
      Height          =   375
      Index           =   8
      Left            =   1080
      TabIndex        =   9
      Top             =   3360
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "SEX"
      Height          =   375
      Index           =   7
      Left            =   1080
      TabIndex        =   8
      Top             =   3000
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "USERNAME"
      Height          =   375
      Index           =   6
      Left            =   1080
      TabIndex        =   7
      Top             =   2640
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "EMAIL"
      Height          =   375
      Index           =   4
      Left            =   1080
      TabIndex        =   6
      Top             =   2280
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "OWNERSURNAME"
      Height          =   375
      Index           =   3
      Left            =   1080
      TabIndex        =   5
      Top             =   1920
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   0
      Left            =   4080
      TabIndex        =   19
      Top             =   1560
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   17
      Left            =   4080
      TabIndex        =   18
      Top             =   1200
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   18
      Left            =   1200
      TabIndex        =   17
      Top             =   7080
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   19
      Left            =   1200
      TabIndex        =   16
      Top             =   6720
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   20
      Left            =   4080
      TabIndex        =   23
      Top             =   3000
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   21
      Left            =   4080
      TabIndex        =   22
      Top             =   2640
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   22
      Left            =   4080
      TabIndex        =   21
      Top             =   2280
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   23
      Left            =   4080
      TabIndex        =   20
      Top             =   1920
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   24
      Left            =   4080
      TabIndex        =   27
      Top             =   4440
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   25
      Left            =   4080
      TabIndex        =   26
      Top             =   4080
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   26
      Left            =   4080
      TabIndex        =   25
      Top             =   3720
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   27
      Left            =   4080
      TabIndex        =   24
      Top             =   3360
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "FAX"
      Height          =   375
      Index           =   28
      Left            =   4080
      TabIndex        =   31
      Top             =   5880
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TEL"
      Height          =   375
      Index           =   29
      Left            =   4080
      TabIndex        =   30
      Top             =   5520
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "COUNTRY"
      Height          =   375
      Index           =   30
      Left            =   4080
      TabIndex        =   29
      Top             =   5160
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "POSTCODE"
      Height          =   375
      Index           =   31
      Left            =   4080
      TabIndex        =   28
      Top             =   4800
      Width           =   1695
   End
   Begin VB.TextBox txtFields 
      DataField       =   "SHOPNAME"
      Height          =   375
      Index           =   32
      Left            =   1080
      TabIndex        =   4
      Top             =   1200
      Width           =   1695
   End
   Begin VB.CommandButton cmdUpdateItem 
      Caption         =   "Update Item"
      Height          =   495
      Left            =   3840
      TabIndex        =   32
      Top             =   6360
      Width           =   1455
   End
   Begin VB.TextBox txtShopID 
      Height          =   285
      Left            =   1200
      TabIndex        =   0
      Top             =   120
      Width           =   615
   End
   Begin VB.TextBox txtCategoryID 
      Height          =   315
      Left            =   3240
      TabIndex        =   1
      Top             =   120
      Width           =   615
   End
   Begin VB.Label Lupdateitem 
      Height          =   495
      Left            =   3000
      TabIndex        =   70
      Top             =   6960
      Width           =   2895
   End
   Begin VB.Label lblLabels 
      Caption         =   "UnitOnOrder"
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   69
      Top             =   4920
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Discount"
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   67
      Top             =   3840
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Picture"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   65
      Top             =   1680
      Width           =   1095
   End
   Begin VB.Label Label4 
      Caption         =   "ItemID"
      Height          =   255
      Left            =   4200
      TabIndex        =   63
      Top             =   120
      Width           =   615
   End
   Begin VB.Label lblLabels 
      Caption         =   "F4"
      Height          =   255
      Index           =   16
      Left            =   600
      TabIndex        =   62
      Top             =   6480
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F3"
      Height          =   255
      Index           =   15
      Left            =   600
      TabIndex        =   61
      Top             =   6120
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F2"
      Height          =   255
      Index           =   14
      Left            =   600
      TabIndex        =   60
      Top             =   5760
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F1"
      Height          =   255
      Index           =   13
      Left            =   600
      TabIndex        =   59
      Top             =   5400
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "UnitInStock"
      Height          =   255
      Index           =   11
      Left            =   120
      TabIndex        =   58
      Top             =   4560
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Description"
      Height          =   255
      Index           =   10
      Left            =   120
      TabIndex        =   57
      Top             =   4200
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Price"
      Height          =   255
      Index           =   8
      Left            =   120
      TabIndex        =   56
      Top             =   3480
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Status"
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   55
      Top             =   3120
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Barcode"
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   54
      Top             =   2760
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Video"
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   53
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "Sound"
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   52
      Top             =   2040
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      Caption         =   "F8"
      Height          =   255
      Index           =   0
      Left            =   3600
      TabIndex        =   51
      Top             =   1680
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F7"
      Height          =   255
      Index           =   17
      Left            =   3600
      TabIndex        =   50
      Top             =   1320
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F6"
      Height          =   255
      Index           =   18
      Left            =   600
      TabIndex        =   49
      Top             =   7200
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F5"
      Height          =   255
      Index           =   19
      Left            =   600
      TabIndex        =   48
      Top             =   6840
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F12"
      Height          =   255
      Index           =   20
      Left            =   3600
      TabIndex        =   47
      Top             =   3240
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F11"
      Height          =   255
      Index           =   21
      Left            =   3600
      TabIndex        =   46
      Top             =   2760
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F10"
      Height          =   255
      Index           =   22
      Left            =   3600
      TabIndex        =   45
      Top             =   2400
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F9"
      Height          =   255
      Index           =   23
      Left            =   3600
      TabIndex        =   44
      Top             =   2040
      Width           =   500
   End
   Begin VB.Label lblLabels 
      Caption         =   "F16"
      Height          =   255
      Index           =   24
      Left            =   3600
      TabIndex        =   43
      Top             =   4560
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F15"
      Height          =   255
      Index           =   25
      Left            =   3600
      TabIndex        =   42
      Top             =   4200
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F14"
      Height          =   255
      Index           =   26
      Left            =   3600
      TabIndex        =   41
      Top             =   3840
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F13"
      Height          =   255
      Index           =   27
      Left            =   3600
      TabIndex        =   40
      Top             =   3480
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F20"
      Height          =   255
      Index           =   28
      Left            =   3600
      TabIndex        =   39
      Top             =   6000
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F19"
      Height          =   255
      Index           =   29
      Left            =   3600
      TabIndex        =   38
      Top             =   5640
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F18"
      Height          =   255
      Index           =   30
      Left            =   3600
      TabIndex        =   37
      Top             =   5280
      Width           =   495
   End
   Begin VB.Label lblLabels 
      Caption         =   "F17"
      Height          =   255
      Index           =   31
      Left            =   3600
      TabIndex        =   36
      Top             =   4920
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "ItemName"
      Height          =   255
      Left            =   120
      TabIndex        =   35
      Top             =   1320
      Width           =   1095
   End
   Begin VB.Label Label2 
      Caption         =   "Shop ID"
      Height          =   255
      Left            =   360
      TabIndex        =   34
      Top             =   120
      Width           =   1095
   End
   Begin VB.Label Label3 
      Caption         =   "Category ID"
      Height          =   255
      Left            =   2160
      TabIndex        =   33
      Top             =   120
      Width           =   1215
   End
End
Attribute VB_Name = "frmUpdateItem"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


Private Sub CmdRetrieveItem_Click()
Dim obj As Object
Dim rs As Recordset
Dim strSQL As String

cmdRetrieveItem.Enabled = False

strSQL = "Select * From VItem Where Shopid = " & txtShopID.Text & _
         " And Categoryid = " & txtCategoryID.Text & _
         " And ItemId = " & TxtItemID.Text
Set obj = CreateObject("ecomm.Item")
Set rs = New Recordset

Set rs = obj.Find(strSQL)
    
    txtFields(32).Text = NullToEmpty(rs!itemname)
    txtFields(3).Text = NullToEmpty(rs!sound)
    txtFields(4).Text = NullToEmpty(rs!video)
    txtFields(6).Text = NullToEmpty(rs!barcode)
    txtFields(7).Text = NullToEmpty(rs!Status)
    txtFields(8).Text = NullToEmpty(rs!price)
    txtFields(2).Text = NullToEmpty(rs!discount)
    txtFields(10).Text = NullToEmpty(rs!Description)
    txtFields(11).Text = NullToEmpty(rs!unitinstock)
    txtFields(5).Text = NullToEmpty(rs!unitonorder)

    txtFields(13).Text = NullToEmpty(rs!F1)
    txtFields(14).Text = NullToEmpty(rs!F2)
    txtFields(15).Text = NullToEmpty(rs!F3)
    txtFields(16).Text = NullToEmpty(rs!F4)
    txtFields(19).Text = NullToEmpty(rs!F5)
    txtFields(18).Text = NullToEmpty(rs!F6)
    txtFields(17).Text = NullToEmpty(rs!F7)
    txtFields(0).Text = NullToEmpty(rs!F8)
    txtFields(23).Text = NullToEmpty(rs!F9)
    txtFields(22).Text = NullToEmpty(rs!F10)
    txtFields(21).Text = NullToEmpty(rs!F11)
    txtFields(20).Text = NullToEmpty(rs!F12)
    txtFields(27).Text = NullToEmpty(rs!F13)
    txtFields(26).Text = NullToEmpty(rs!F14)
    txtFields(25).Text = NullToEmpty(rs!F15)
    txtFields(24).Text = NullToEmpty(rs!F16)
    txtFields(31).Text = NullToEmpty(rs!F17)
    txtFields(30).Text = NullToEmpty(rs!F18)
    txtFields(29).Text = NullToEmpty(rs!F19)
    txtFields(28).Text = NullToEmpty(rs!F20)
rs.Close
cmdRetrieveItem.Enabled = True
    
    
End Sub

Private Sub cmdUpdateItem_Click()
Dim ObjItem As Object

cmdUpdateItem.Enabled = False

On Error GoTo UpdateItemError

Set ObjItem = CreateObject("Ecomm.Item")
With ObjItem
    .ShopID = CCInt(txtShopID.Text)
    .categoryid = CCInt(txtCategoryID.Text)
    .itemname = txtFields(32).Text
    .sound = txtFields(3).Text
    .video = txtFields(4).Text
    .barcode = txtFields(6).Text
    .Status = txtFields(7).Text
    .price = txtFields(8).Text
    .discount = txtFields(2).Text
'    .CreateOn = Date
    .Description = txtFields(10).Text
    .unitinstock = txtFields(11).Text
    .unitonorder = txtFields(5).Text
    
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
' Pass ItemID to Property of Item for update
    .ItemID = CCInt(TxtItemID.Text)
    .Update
End With
    MsgBox "Update Item : " & txtFields(32) & " Complete"
Set ObjItem = Nothing
cmdUpdateItem.Enabled = True

Exit Sub
UpdateItemError:
    cmdUpdateItem.Enabled = True
    Lupdateitem.Caption = Err.Number & " : " & Err.Description
    Set ObjItem = Nothing

End Sub

Private Sub Form_Unload(Cancel As Integer)
  frmMain.Show
End Sub
