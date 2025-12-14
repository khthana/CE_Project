VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "Item"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Private mvarItemID As Integer 'local copy
Private mvarCreateOn As Date 'local copy
Private mvarPicture As String 'local copy
Private mvarSound As String 'local copy
Private mvarVideo As String 'local copy
Private mvarItemName As String 'local copy
Private mvarBarcode As String 'local copy
Private mvarStatus As String 'local copy
Private mvarPrice As Single 'local copy
Private mvarDescription As String 'local copy
Private mvarUnitInStock As Integer 'local copy
Private mvarUnitOnOrder As Integer 'local copy
Private mvarF1 As String 'local copy
Private mvarF2 As String 'local copy
Private mvarF3 As String 'local copy
Private mvarF4 As String 'local copy
Private mvarF5 As String 'local copy
Private mvarF6 As String 'local copy
Private mvarF7 As String 'local copy
Private mvarF8 As String 'local copy
Private mvarF9 As String 'local copy
Private mvarF10 As String 'local copy
Private mvarF11 As String 'local copy
Private mvarF12 As String 'local copy
Private mvarF13 As String 'local copy
Private mvarF14 As String 'local copy
Private mvarF15 As String 'local copy
Private mvarF16 As String 'local copy
Private mvarF17 As String 'local copy
Private mvarF18 As String 'local copy
Private mvarF19 As String 'local copy
Private mvarF20 As String 'local copy
Private mvarShopID As Integer 'local copy
Private mvarCategoryID As Integer 'local copy
Private mvarDiscount As Single 'local copy



' ----- Method of Class TItem ----- '
Public Sub Update()
' -- Description
' Update by add new value replace old value that sent by properties
' If new value is null or empty that field doesn't update
' That mean not allow delete some field in Item
' -- Input
' Information pass through properties

Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If


On Error GoTo UpdateItemError

' --- For update status ---
If mvarUnitInStock <> 0 Then        ' Not allow update when input is zero or null of integer
   If mvarUnitInStock > 0 Then
      mvarStatus = "available"
   Else
      mvarStatus = "out of stock"
   End If
End If

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

Set rs = New ADODB.Recordset

rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * From VItem Where Itemid = " & CStr(mvarItemID), cn

' ItemID, ShopID, CatgoryID Not allow update

  UpdateField rs!ItemName, mvarItemName
'  UpdateField rs!Picture , mvarPicture
  UpdateField rs!Sound, mvarSound
  UpdateField rs!Video, mvarVideo
  UpdateField rs!Barcode, mvarBarcode
  UpdateFieldNumber rs!Discount, mvarDiscount
  UpdateField rs!Status, mvarStatus
  UpdateFieldNumber rs!Price, mvarPrice
'  UpdateField rs!CreateOn , mvarCreateOn
  UpdateField rs!Description, mvarDescription
  UpdateFieldNumber rs!UnitInStock, mvarUnitInStock
  UpdateFieldNumber rs!UnitOnOrder, mvarUnitOnOrder
  UpdateField rs!F1, mvarF1
  UpdateField rs!F2, mvarF2
  UpdateField rs!F3, mvarF3
  UpdateField rs!F4, mvarF4
  UpdateField rs!F5, mvarF5
  UpdateField rs!F6, mvarF6
  UpdateField rs!F7, mvarF7
  UpdateField rs!F8, mvarF8
  UpdateField rs!F9, mvarF9
  UpdateField rs!F10, mvarF10
  UpdateField rs!F11, mvarF11
  UpdateField rs!F12, mvarF12
  UpdateField rs!F13, mvarF13
  UpdateField rs!F14, mvarF14
  UpdateField rs!F15, mvarF15
  UpdateField rs!F16, mvarF16
  UpdateField rs!F17, mvarF17
  UpdateField rs!F18, mvarF18
  UpdateField rs!F19, mvarF19
  UpdateField rs!F20, mvarF20
rs.Update
rs.Close

' -- Finish Transaction --
tx.SetComplete

Exit Sub
UpdateItemError:
    tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Sub

Public Function Find(Optional ByVal strSQL As String) As ADODB.Recordset
' -- Description
' Find follow by sql statement
' -- Input
' [Optional default is select all]
'   SQL statement through argument
' -- Output
' Result of sql commnad in recordset data type


Dim rs As ADODB.Recordset

On Error GoTo FindError
If strSQL = "" Then
    strSQL = "Select * from Vitem"
End If

Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open strSQL, StrConn, , , adCmdText

Set Find = rs

Exit Function
FindError:
    Err.Raise Err.Number, , Err.Description

End Function

Public Sub Delete(ByVal Criteria As String)
' -- Description
' Delete one to more rows by Criteria
' That is clause after where in sql command

Dim rs As ADODB.Recordset
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo DeleteItemError


Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * From VItem where " & Criteria, _
        StrConn, , , adCmdText

If rs.BOF And rs.EOF Then
    Err.Raise NoRecordDelete, , "No record was delete"
    Exit Sub
Else
    Do Until rs.EOF
        rs.Delete
        rs.MoveNext
    Loop
End If
    rs.Close

' -- Finish Transaction --
tx.SetComplete

Exit Sub
DeleteItemError:
    tx.SetAbort
    Err.Raise Err.Number, , Err.Description
    
End Sub

Public Function Addnew() As Integer
' -- Description
' Add new item to table tblItem
' -- Input
' Value in properties
' -- Output
' Return value of itemid

Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim IntItemID As Integer
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Function
End If


On Error GoTo AddNewItemError
' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

Set rs = New ADODB.Recordset

' --- Auto increase ID from max itemid ---
'Set rs = cn.Execute("Select Max(ItemID) From VItem")

'If rs.BOF And rs.EOF Then
'   IntItemID = 1
'Else
'   If IsNull(rs.Fields(0).Value) Or rs.Fields(0).Value = "" Then
'      IntItemID = 1
'    Else
'      IntItemID = rs.Fields(0).Value + 1
'    End If
'End If

' --- Auto increase ID From tblConsts ----

rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select itemid From tblConsts", cn
    
    IntItemID = rs!ItemID + 1
    
    rs!ItemID = IntItemID
rs.Update               ' update new value to tblConsts
rs.Close

' --- For update status ---
   If mvarUnitInStock > 0 Then
      mvarStatus = "available"
   Else
      mvarStatus = "out of stock"
   End If


' --- Add new item ---
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * From VItem", cn

rs.Addnew
  rs!ItemID = IntItemID
  rs!ShopID = mvarShopID
  rs!Categoryid = mvarCategoryID
  rs!ItemName = mvarItemName
'  rs!Picture = mvarPicture
  rs!Sound = mvarSound
  rs!Video = mvarVideo
  rs!Barcode = mvarBarcode
  rs!Discount = mvarDiscount
  rs!Status = mvarStatus
  rs!Price = mvarPrice
  rs!CreateOn = Date        ' Initial
  rs!Description = mvarDescription
  rs!UnitInStock = mvarUnitInStock
  rs!UnitOnOrder = 0        ' Initial to 0 at first time
  rs!F1 = mvarF1
  rs!F2 = mvarF2
  rs!F3 = mvarF3
  rs!F4 = mvarF4
  rs!F5 = mvarF5
  rs!F6 = mvarF6
  rs!F7 = mvarF7
  rs!F8 = mvarF8
  rs!F9 = mvarF9
  rs!F10 = mvarF10
  rs!F11 = mvarF11
  rs!F12 = mvarF12
  rs!F13 = mvarF13
  rs!F14 = mvarF14
  rs!F15 = mvarF15
  rs!F16 = mvarF16
  rs!F17 = mvarF17
  rs!F18 = mvarF18
  rs!F19 = mvarF19
  rs!F20 = mvarF20
rs.Update

rs.Close

' ---- Return itemid to return value --
   Addnew = IntItemID


' ---- Finish transaction ---
tx.SetComplete

Exit Function
AddNewItemError:
    tx.SetAbort
    Err.Raise Err.Number, , Err.Description


End Function


' ----- Property of Class TItem ----- '
Public Property Let F20(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F20 = 5
    mvarF20 = vData
End Property


Public Property Get F20() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F20
    F20 = mvarF20
End Property



Public Property Let F19(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F19 = 5
    mvarF19 = vData
End Property


Public Property Get F19() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F19
    F19 = mvarF19
End Property



Public Property Let F18(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F18 = 5
    mvarF18 = vData
End Property


Public Property Get F18() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F18
    F18 = mvarF18
End Property



Public Property Let F17(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F17 = 5
    mvarF17 = vData
End Property


Public Property Get F17() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F17
    F17 = mvarF17
End Property



Public Property Let F16(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F16 = 5
    mvarF16 = vData
End Property


Public Property Get F16() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F16
    F16 = mvarF16
End Property



Public Property Let F15(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F15 = 5
    mvarF15 = vData
End Property


Public Property Get F15() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F15
    F15 = mvarF15
End Property



Public Property Let F14(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F14 = 5
    mvarF14 = vData
End Property


Public Property Get F14() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F14
    F14 = mvarF14
End Property



Public Property Let F13(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F13 = 5
    mvarF13 = vData
End Property


Public Property Get F13() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F13
    F13 = mvarF13
End Property



Public Property Let F12(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F12 = 5
    mvarF12 = vData
End Property


Public Property Get F12() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F12
    F12 = mvarF12
End Property



Public Property Let F11(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F11 = 5
    mvarF11 = vData
End Property


Public Property Get F11() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F11
    F11 = mvarF11
End Property



Public Property Let F10(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F10 = 5
    mvarF10 = vData
End Property


Public Property Get F10() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F10
    F10 = mvarF10
End Property



Public Property Let F9(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F9 = 5
    mvarF9 = vData
End Property


Public Property Get F9() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F9
    F9 = mvarF9
End Property



Public Property Let F8(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F8 = 5
    mvarF8 = vData
End Property


Public Property Get F8() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F8
    F8 = mvarF8
End Property



Public Property Let F7(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F7 = 5
    mvarF7 = vData
End Property


Public Property Get F7() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F7
    F7 = mvarF7
End Property



Public Property Let F6(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F6 = 5
    mvarF6 = vData
End Property


Public Property Get F6() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F6
    F6 = mvarF6
End Property



Public Property Let F5(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F5 = 5
    mvarF5 = vData
End Property


Public Property Get F5() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F5
    F5 = mvarF5
End Property



Public Property Let F4(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F4 = 5
    mvarF4 = vData
End Property


Public Property Get F4() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F4
    F4 = mvarF4
End Property



Public Property Let F3(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F3 = 5
    mvarF3 = vData
End Property


Public Property Get F3() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F3
    F3 = mvarF3
End Property



Public Property Let F2(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F2 = 5
    mvarF2 = vData
End Property


Public Property Get F2() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F2
    F2 = mvarF2
End Property



Public Property Let F1(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.F1 = 5
    mvarF1 = vData
End Property


Public Property Get F1() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.F1
    F1 = mvarF1
End Property



Public Property Let UnitOnOrder(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.UnitOnOrder = 5
    mvarUnitOnOrder = vData
End Property


Public Property Get UnitOnOrder() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.UnitOnOrder
    UnitOnOrder = mvarUnitOnOrder
End Property



Public Property Let UnitInStock(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.UnitInStock = 5
    mvarUnitInStock = vData
End Property


Public Property Get UnitInStock() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.UnitInStock
    UnitInStock = mvarUnitInStock
End Property



Public Property Let Description(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Description = 5
    mvarDescription = vData
End Property


Public Property Get Description() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Description
    Description = mvarDescription
End Property



Public Property Let Price(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Price = 5
    mvarPrice = vData
End Property


Public Property Get Price() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Price
    Price = mvarPrice
End Property



Public Property Let Status(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Status = 5
    mvarStatus = vData
End Property


Public Property Get Status() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Status
    Status = mvarStatus
End Property



Public Property Let Barcode(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Barcode = 5
    mvarBarcode = vData
End Property


Public Property Get Barcode() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Barcode
    Barcode = mvarBarcode
End Property


Public Property Let ItemID(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ItemID = 5
    mvarItemID = vData
End Property


Public Property Get ItemID() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ItemID
    ItemID = mvarItemID
End Property

Public Property Let Video(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Video = 5
    mvarVideo = vData
End Property


Public Property Get Video() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Video
    Video = mvarVideo
End Property



Public Property Let Sound(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Sound = 5
    mvarSound = vData
End Property


Public Property Get Sound() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Sound
    Sound = mvarSound
End Property



Public Property Let Picture(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Picture = 5
    mvarPicture = vData
End Property


Public Property Get Picture() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Picture
    Picture = mvarPicture
End Property



Public Property Let CreateOn(ByVal vData As Date)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CreateOn = 5
    mvarCreateOn = vData
End Property


Public Property Get CreateOn() As Date
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CreateOn
    CreateOn = mvarCreateOn
End Property

Public Property Let ItemName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ItemName = 5
    mvarItemName = vData
End Property


Public Property Get ItemName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ItemName
    ItemName = mvarItemName
End Property

Public Property Let Categoryid(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CategoryID = 5
    mvarCategoryID = vData
End Property


Public Property Get Categoryid() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CategoryID
    Categoryid = mvarCategoryID
End Property



Public Property Let ShopID(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShopID = 5
    mvarShopID = vData
End Property


Public Property Get ShopID() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShopID
    ShopID = mvarShopID
End Property

Public Property Let Discount(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Discount = 5
    mvarDiscount = vData
End Property


Public Property Get Discount() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Discount
    Discount = mvarDiscount
End Property




