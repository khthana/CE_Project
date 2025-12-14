VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "BillingDetail"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarBillingID As Integer 'local copy
Private mvarItemID As Integer 'local copy
Private mvarStatus As String 'local copy
Private mvarDiscount As Single 'local copy
Private mvarAmount As Integer 'local copy
Private mvarTaxValue As Single 'local copy
Private mvarPrice As Single 'local copy



' ----- Method of Class BillingDetail ----

Public Function CalTax() As Single
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String
Dim TaxRate As Single
'Dim Tx As ObjectContext
Dim TaxValue As Single

' --- Start Transaction ---
'Set Tx = GetObjectContext()
'If Tx Is Nothing Then
'   Err.Raise NoContextError, , "Could not establish an object context"
'   Exit Function
'End If

On Error GoTo CalTaxError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

' --- Retrieve Tax Rate from TblConsts ----
strSQL = "Select TaxRate From tblConsts"
Set rs = cn.Execute(strSQL)
    TaxRate = rs!TaxRate

' --- Calculate Tax Value --------
strSQL = "Select T1.Price, T2.Amount, T1.Discount " & _
         "From VItem T1, VBillingDetail T2 " & _
         "Where T1.ItemID = T2.ItemID And " & _
         "      BillingID = " & mvarBillingID & " And " & _
         "      T1.ItemID = " & mvarItemID
Set rs = cn.Execute(strSQL)
' field(0) = rs!price in item
' field(1) = rs!amount in billingdetail
' field(2) = rs!discount in item
    
' TaxValue = (rs!Price - rs!Discount) * rs!Amount * (TaxRate / 100)

  TaxValue = (rs.Fields(0).Value - rs.Fields(2).Value) * _
              rs.Fields(1).Value * (TaxRate / 100)

rs.Close
' ---- Store TaxValue to TblBillingDetail ----
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
strSQL = "Select BillingID, TaxValue From VBillingDetail " & _
         "Where BillingID = " & mvarBillingID & " And " & _
               "ItemID = " & mvarItemID
rs.Open strSQL, cn
    rs!TaxValue = TaxValue
rs.Update

' -- Return CalTax
    CalTax = TaxValue

'    Tx.SetComplete
Exit Function
CalTaxError:
'    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Function

Public Function CalPrice() As Single
' --- Use for update billingDetail
' Net price in each order detail
' Not nessesary for use transaction

Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String
Dim PriceValue As Single
Dim TaxRate As Single
'Dim Tx As ObjectContext

' --- Start Transaction ---
'Set Tx = GetObjectContext()
'If Tx Is Nothing Then
'   Err.Raise NoContextError, , "Could not establish an object context"
'   Exit Function
'End If

On Error GoTo CalPriceError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

strSQL = "Select TaxRate From TblConsts"
Set rs = cn.Execute(strSQL)

    TaxRate = rs!TaxRate


strSQL = "Select T1.ItemID, T1.Price, T2.Amount ,T1.Discount, T2.TaxValue " & _
         "From VItem T1, VBillingDetail T2 " & _
         "Where T1.ItemID = T2.ItemID And " & _
         "      BillingID = " & mvarBillingID & " And " & _
         "      T1.ItemID = " & mvarItemID

' --- Calculate Price to Property Price ----
Set rs = cn.Execute(strSQL)

' Discount, TaxRate is not % unit
' field(0) = rs!price in item
' field(1) = rs!amount
' field(2) = rs!discount in item
' field(3) = rs!TaxValue in billingDetail

'PriceValue = ((rs!Price - rs!Discount) + (rs!Price * (TaxRate / 100))) * rs!Amount

PriceValue = ((rs.Fields(0).Value - rs.Fields(2).Value) + _
              (rs.Fields(0).Value * (TaxRate / 100))) * rs.Fields(1).Value

rs.Close
' --- Store Price to TblBillingDetail ---
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
strSQL = "Select * From VBillingDetail " & _
         "Where BillingID = " & mvarBillingID & " And " & _
         "ItemID = " & mvarItemID

rs.Open strSQL, cn
    rs!Price = PriceValue
rs.Update

' -- Return CalPrice
   CalPrice = PriceValue
    
'   Tx.SetComplete
Exit Function
CalPriceError:
'    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Function

Public Function FindBillingDetail(Optional ByVal strSQL As String) As ADODB.Recordset
Dim rs As ADODB.Recordset

On Error GoTo FindBillingDetailError

If strSQL = "" Then
    strSQL = "Select * from VBillingDetail"
End If

Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.CursorType = adOpenKeyset
rs.LockType = adLockReadOnly
rs.Open strSQL, StrConn, , , adCmdText

Set FindBillingDetail = rs

Exit Function
FindBillingDetailError:
    Err.Raise Err.Number, , Err.Description

End Function

Public Sub UpdateBillingDetail()
' ---- NOT COMPLETE ------
' -- In update unitInStock at VItem
' -- Not match in real world


Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim Tx As ObjectContext

' --- Start Transaction ---
Set Tx = GetObjectContext()
If Tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo UpdateBillingDetailError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset


rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

' ---- Add constrain for update billing detail status




' --------------------------------------
rs.Open "Select * From VBillingDetail Where " & _
        "ItemID = " & mvarItemID & " And " & _
        "BillingID = " & mvarBillingID, cn

'    rs!BillingID = mvarBillingID
'    rs!ItemID = mvarItemID
    UpdateField rs!Status, mvarStatus
    UpdateField rs!Discount, mvarDiscount
    UpdateField rs!Amount, mvarAmount
    UpdateField rs!TaxValue, mvarTaxValue
    UpdateField rs!Price, mvarPrice
rs.Update

' -- Finish Transaction --
Tx.SetComplete

Exit Sub
UpdateBillingDetailError:
    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Sub

Public Sub DeleteBillingDetail(ByVal Criteria As String)
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim Tx As ObjectContext

' --- Start Transaction ---
Set Tx = GetObjectContext()
If Tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo DeleteBillingDetailError
' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

' -- Delete Shop --
rs.Open "Select * From VBillingDetail where " & Criteria, _
        cn, , , adCmdText
        
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
Tx.SetComplete


Exit Sub
DeleteBillingDetailError:
    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description
    
End Sub

Public Sub AddBillingDetail()
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strStatus As String
Dim Tx As ObjectContext

' --- Start Transaction ---
Set Tx = GetObjectContext()
If Tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo AddBillingDetailError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset


rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

' -- Update item.unitInStock
rs.Open "Select ItemID, unitinstock, UnitOnOrder, status From Vitem Where ItemID=" & mvarItemID, cn
    rs!unitinstock = rs!unitinstock - mvarAmount
    rs!unitOnOrder = rs!unitOnOrder + mvarAmount
rs.Update

' --- Update status of billingDetail
' available if item.status = "available"
' out of stock if item.status = "out of stock"

    strStatus = rs!Status
rs.Close

' -- Add Billing detail
rs.Open "Select * From VBillingDetail", cn
rs.AddNew
    rs!BillingID = mvarBillingID
    rs!ItemID = mvarItemID
    rs!Status = strStatus
    rs!Discount = mvarDiscount
    rs!Amount = mvarAmount
    rs!TaxValue = mvarTaxValue
    rs!Price = mvarPrice
rs.Update


' -- Finish Transaction --
Tx.SetComplete


Exit Sub
AddBillingDetailError:
    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Sub



' ----- Property of Class BillingDetail -----

Public Property Let TaxValue(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.TaxValue = 5
    mvarTaxValue = vData
End Property


Public Property Get TaxValue() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.TaxValue
    TaxValue = mvarTaxValue
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



Public Property Let BillingID(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingID = 5
    mvarBillingID = vData
End Property


Public Property Get BillingID() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingID
    BillingID = mvarBillingID
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

Private Sub Class_Initialize()

End Sub
