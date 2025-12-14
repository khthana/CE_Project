VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "shoppingbag"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Const strConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"
'local variable(s) to hold property value(s)
Private mvarItemID As Integer 'local copy
Private mvarAccountID As Integer 'local copy
Private mvarAmount As Integer 'local copy
Private mvarDiscount As Single 'local copy
Private mvarTaxrate As Single 'local copy
Private mvarprice As Single 'local copy



' ---- Method of ShoppingBag ----
Public Function LoadShoppingBag(ByVal intAccountID As Integer) As Recordset
Dim rs As ADODB.Recordset
Dim strsQL As String

strsQL = "Select * from vshoppingbag where accountid=" & CInt(intAccountID)

On Error GoTo LoadShoppingBagError

Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open strsQL, strConn, , , adCmdText

Set LoadShoppingBag = rs

Exit Function
LoadShoppingBagError:
    Err.Raise Err.Number, , Err.Description


End Function

Public Sub DeleteShoppingBag(DelAccount As Integer)
Dim rs As ADODB.Recordset
Dim cn As ADODB.Connection

On Error GoTo DeleteError


Set cn = New ADODB.Connection
cn.ConnectionString = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"
cn.CursorLocation = adUseClient
cn.Open

Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

rs.Open "Delete Vshoppingbag where AccountID = " & DelAccount, _
        cn, , , adCmdText


Exit Sub
DeleteError:
    Err.Raise Err.Number, , Err.Description

End Sub

Public Function SaveShoppingBag(ByVal RecSession As Recordset) As Boolean
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset


On Error GoTo saveerror

Set cn = New ADODB.Connection
cn.ConnectionString = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"
cn.CursorLocation = adUseClient
cn.Open
cn.BeginTrans

Set rs = New ADODB.Recordset

rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * From Vshoppingbag", cn

RecSession.MoveFirst

Do Until RecSession.EOF
rs.AddNew
   rs!ItemID = CInt(RecSession!ItemID)
   rs!AccountID = CInt(RecSession!AccountID)
   rs!Amount = CInt(RecSession!Amount)
   rs!Discount = RecSession!Discount
   rs!taxvalue = RecSession!taxvalue
   rs!price = RecSession!price
   
   RecSession.MoveNext
Loop
rs.Update
   
cn.CommitTrans
   SaveShoppingBag = True

Exit Function
saveerror:
    cn.RollbackTrans
    Err.Raise Err.Number, , Err.Description
    SaveShoppingBag = False

End Function


' ---- Property of shoppingbag ---

Public Property Let price(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.price = 5
    mvarprice = vData
End Property


Public Property Get price() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.price
    price = mvarprice
End Property



Public Property Let Taxrate(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Taxrate = 5
    mvarTaxrate = vData
End Property


Public Property Get Taxrate() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Taxrate
    Taxrate = mvarTaxrate
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



Public Property Let Amount(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Amount = 5
    mvarAmount = vData
End Property


Public Property Get Amount() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Amount
    Amount = mvarAmount
End Property



Public Property Let AccountID(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.AccountID = 5
    mvarAccountID = vData
End Property


Public Property Get AccountID() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.AccountID
    AccountID = mvarAccountID
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



