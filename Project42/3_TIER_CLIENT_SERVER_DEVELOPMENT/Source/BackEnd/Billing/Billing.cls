VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "Billing"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"BillingDetail"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarBillingID As Integer 'local copy
Private mvarAccountID As Integer 'local copy
Private mvarBillingDate As Date 'local copy
Private mvarReqDate As Date 'local copy
Private mvarPayType As String 'local copy
Private mvarShipName As String 'local copy
Private mvarShipDate As Date 'local copy
Private mvarShipAddress As String 'local copy
Private mvarShipVia As String 'local copy
Private mvarFrieght As Single 'local copy
Private mvarShipCity As String 'local copy
Private mvarShipRegion As String 'local copy
Private mvarShipPostcode As String 'local copy
Private mvarShipCountry As String 'local copy
Private mvarStatus As String 'local copy
Private mvarTotalPrice As Single 'local copy
Private mvarBillingAddress As String 'local copy
Private mvarTotalTax As Single 'local copy
Private mvarBillingName As String 'local copy
Private mvarBillingSurname As String 'local copy
Private mvarBillingCity As String 'local copy
Private mvarBillingState As String 'local copy
Private mvarBillingPostcode As String 'local copy
Private mvarBillingCountry As String 'local copy
Private mvarBillingTel As String 'local copy
Private mvarBillingEmail As String 'local copy
Private mvarBillingDetail As BillingDetail
Private mvarBillingFax As String 'local copy
Private mvarPaid As String 'local copy
'local variable(s) to hold property value(s)
Private mvarPagerNumber As String 'local copy
Private mvarPagerType As String 'local copy
Private mvarPagerPassword As String 'local copy
Public Property Let PagerPassword(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.PagerPassword = 5
    mvarPagerPassword = vData
End Property


Public Property Get PagerPassword() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.PagerPassword
    PagerPassword = mvarPagerPassword
End Property



Public Property Let PagerType(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.PagerType = 5
    mvarPagerType = vData
End Property


Public Property Get PagerType() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.PagerType
    PagerType = mvarPagerType
End Property



Public Property Let PagerNumber(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.PagerNumber = 5
    mvarPagerNumber = vData
End Property


Public Property Get PagerNumber() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.PagerNumber
    PagerNumber = mvarPagerNumber
End Property




' ----- Method of Class Billing -----
Public Function UpdateBillingStatus() As String
' -- Update only billingid passed in Object.BillingID

Dim SendAll As Boolean
Dim paid As Boolean
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String

On Error GoTo UpdateBillingStatusError
' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

strSQL = "SELECT billingid " & _
         "FROM vbillingdetail T1 " & _
         "Where BillingID = " & mvarBillingID & " " & _
         "HAVING count(*) = (Select count(*) " & _
                            "From vbillingdetail T2 " & _
                            "Where T1.billingID = T2.BillingID And " & _
                            "lower(T2.status) = 'available' " & _
                            "Group by T2.billingid ) " & _
                            "GROUP BY billingid "

    Set rs = cn.Execute(strSQL)
    
    If rs.BOF And rs.EOF Then
       ' -- Not all billingdetail.status is available
       SendAll = False
    Else
       ' -- All billingdetail.status is available
       SendAll = True
    End If
    
strSQL = "Select BillingID, lower(Paid) From VBilling Where BillingID=" & mvarBillingID
    Set rs = cn.Execute(strSQL)
    
    If rs.Fields(1).Value = "yes" Then
        paid = True
    Else
    ' default is no
        paid = False
    End If

rs.Close
' --- Store Total Tax to TblBilling ---
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
strSQL = "Select BillingID, Status From VBilling " & _
         "Where BillingID = " & mvarBillingID
rs.Open strSQL, cn

    If SendAll And paid Then
       rs!Status = "sending all"
    Else
       If SendAll And (Not paid) Then
          rs!Status = "waiting send all"
       Else
          If (Not SendAll) And paid Then
             rs!Status = "sending some"
          Else
             If (Not SendAll) And (Not paid) Then
                rs!Status = "waiting send all"
             End If
          End If
      End If
   End If
       
rs.Update


Exit Function
UpdateBillingStatusError:
    Err.Raise Err.Number, , Err.Description

End Function

Public Function CalTotalTax() As Single
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String
'Dim Tx As ObjectContext
Dim TaxValue As Single

' --- Start Transaction ---
'Set Tx = GetObjectContext()
'If Tx Is Nothing Then
'   Err.Raise NoContextError, , "Could not establish an object context"
'   Exit Function
'End If

On Error GoTo CalTotalTaxError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

strSQL = "Select 1.0*SUM(TaxValue) From VBillingDetail " & _
         "Where BillingID = " & mvarBillingID

' --- Calculate Total Tax to Return value ----
Set rs = cn.Execute(strSQL)
TaxValue = rs.Fields(0).Value
CalTotalTax = TaxValue      ' temp for store total tax value

rs.Close
' --- Store Total Tax to TblBilling ---
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
strSQL = "Select BillingID, TotalTax From VBilling " & _
         "Where BillingID = " & mvarBillingID
rs.Open strSQL, cn
    rs!TotalTax = TaxValue
rs.Update

'    Tx.SetComplete
    
Exit Function
CalTotalTaxError:
'    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description
    
End Function

Public Function CalTotalPrice() As Single
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String
'Dim Tx As ObjectContext
Dim PriceValue As Single

' --- Start Transaction ---
'Set Tx = GetObjectContext()
'If Tx Is Nothing Then
'   Err.Raise NoContextError, , "Could not establish an object context"
'   Exit Function
'End If

On Error GoTo CalTotalPriceError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

strSQL = "Select 1.0*SUM(Price) From VBillingDetail " & _
         "Where BillingID = " & mvarBillingID

' --- Calculate Total Price to Property TotalPrice ----
Set rs = cn.Execute(strSQL)
PriceValue = rs.Fields(0).Value
CalTotalPrice = PriceValue

rs.Close
' --- Store Total Price to TblBilling ---
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
strSQL = "Select BillingID, TotalPrice From VBilling " & _
         "Where BillingID = " & mvarBillingID
rs.Open strSQL, cn
    rs!TotalPrice = PriceValue
rs.Update

'    Tx.SetComplete

Exit Function
CalTotalPriceError:
'    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Function

Public Function FindBilling(Optional ByVal strSQL As String) As ADODB.Recordset
Dim rs As ADODB.Recordset

On Error GoTo FindBillingError

If strSQL = "" Then
    strSQL = "Select * from VBilling"
End If

Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.CursorType = adOpenKeyset
rs.LockType = adLockReadOnly
rs.Open strSQL, StrConn, , , adCmdText

Set FindBilling = rs

Exit Function
FindBillingError:
    Err.Raise Err.Number, , Err.Description

End Function

Public Sub UpdateBilling()
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String
Dim Tx As ObjectContext

' --- Start Transaction ---
Set Tx = GetObjectContext()
If Tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo UpdateBillingError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

strSQL = "Select * From VBilling Where BillingID = " & CStr(mvarBillingID)

rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open strSQL, cn

'    rs!BillingID = mvarBillingID   not allow update
'    rs!AccountID = mvarAccountID
    UpdateField rs!BillingDate, mvarBillingDate
    UpdateField rs!ReqDate, mvarReqDate
    UpdateField rs!PayType, mvarPayType
    UpdateField rs!ShipName, mvarShipName
    UpdateField rs!ShipDate, mvarShipDate
    UpdateField rs!ShipAddress, mvarShipAddress
    UpdateField rs!ShipVia, mvarShipVia
    UpdateField rs!Frieght, mvarFrieght
    UpdateField rs!ShipCity, mvarShipCity
    UpdateField rs!ShipRegion, mvarShipRegion
    UpdateField rs!ShipPostcode, mvarShipPostcode
    UpdateField rs!ShipCountry, mvarShipCountry
    UpdateField rs!Status, mvarStatus
    UpdateField rs!TotalTax, mvarTotalTax
    UpdateField rs!TotalPrice, mvarTotalPrice
    UpdateField rs!BillingAddress, mvarBillingAddress
    UpdateField rs!BillingName, mvarBillingName
    UpdateField rs!BillingSurname, mvarBillingSurname
    UpdateField rs!BillingCity, mvarBillingCity
    UpdateField rs!BillingState, mvarBillingState
    UpdateField rs!BillingPostcode, mvarBillingPostcode
    UpdateField rs!BillingCountry, mvarBillingCountry
    UpdateField rs!BillingTel, mvarBillingTel
    UpdateField rs!BillingEmail, mvarBillingEmail
    UpdateField rs!BillingFax, mvarBillingFax
    UpdateField rs!paid, mvarPaid
    UpdateField rs!PagerNumber, mvarPagerNumber
    UpdateField rs!PagerType, mvarPagerType
    UpdateField rs!PagerPassword, mvarPagerPassword

rs.Update

' -- Finish Transaction --
Tx.SetComplete

' --- End of Update method ---
Exit Sub
UpdateBillingError:
    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description


End Sub

Public Sub DeleteBilling(ByVal Criteria As String)
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim Tx As ObjectContext

' --- Start Transaction ---
Set Tx = GetObjectContext()
If Tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo DeleteBillingError
' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open


Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

' -- Delete Billing that constrain
' on delete cascade with billingdetail
rs.Open "Select * From VBilling where " & Criteria, _
        cn, , , adCmdText
        
If rs.BOF And rs.EOF Then
    Err.Raise NoRecordDelete, , "No record was delete"
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
DeleteBillingError:
    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description
    
End Sub

Public Function AddBilling() As Integer
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim IntBillingID As Integer
Dim Tx As ObjectContext

' --- Start Transaction ---
Set Tx = GetObjectContext()
If Tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Function
End If


On Error GoTo AddNewBillingError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

' --- Auto increase ID
Set rs = cn.Execute("Select Max(BillingID) From VBilling")
If rs.BOF And rs.EOF Then
   IntBillingID = 1
Else
   If IsNull(rs.Fields(0).Value) Or rs.Fields(0).Value = "" Then
      IntBillingID = 1
   Else
      IntBillingID = rs.Fields(0).Value + 1
   End If
End If
rs.Close

' --- Update status ----




' --- Add billing -----
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * From VBilling", cn
rs.AddNew
    rs!BillingID = IntBillingID
    rs!AccountID = mvarAccountID
    rs!BillingDate = mvarBillingDate
    rs!ReqDate = mvarReqDate
    rs!PayType = mvarPayType
    rs!ShipName = mvarShipName
    rs!ShipDate = mvarShipDate
    rs!ShipAddress = mvarShipAddress
    rs!ShipVia = mvarShipVia
    rs!Frieght = mvarFrieght
    rs!ShipCity = mvarShipCity
    rs!ShipRegion = mvarShipRegion
    rs!ShipPostcode = mvarShipPostcode
    rs!ShipCountry = mvarShipCountry
    rs!Status = mvarStatus
    rs!TotalTax = 0         ' Initial
    rs!TotalPrice = 0       ' Initial
    rs!BillingAddress = mvarBillingAddress
    rs!BillingName = mvarBillingName
    rs!BillingSurname = mvarBillingSurname
    rs!BillingCity = mvarBillingCity
    rs!BillingState = mvarBillingState
    rs!BillingPostcode = mvarBillingPostcode
    rs!BillingCountry = mvarBillingCountry
    rs!BillingTel = mvarBillingTel
    rs!BillingFax = mvarBillingFax
    rs!BillingEmail = mvarBillingEmail
    rs!paid = "no"              ' Default is no
    rs!PagerNumber = mvarPagerNumber
    rs!PagerType = mvarPagerType
    rs!PagerPassword = mvarPagerPassword
rs.Update

' --- Return BillingID to return value ---
    AddBilling = IntBillingID

' -- Finish Transaction --
Tx.SetComplete

' --- End of Addnew method ---
Exit Function
AddNewBillingError:
    Tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Function


' ------ Property of Class Billing -----

Private Sub Class_Initialize()
    'create the mBillingDetail object when the Billing class is created
    Set mvarBillingDetail = New BillingDetail
End Sub


Public Property Get BillingDetail() As BillingDetail
    Set BillingDetail = mvarBillingDetail
End Property


Public Property Set BillingDetail(vData As BillingDetail)
    Set mvarBillingDetail = vData
End Property
Private Sub Class_Terminate()
    Set mvarBillingDetail = Nothing
End Sub



Public Property Let BillingEmail(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingEmail = 5
    mvarBillingEmail = vData
End Property


Public Property Get BillingEmail() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingEmail
    BillingEmail = mvarBillingEmail
End Property



Public Property Let BillingTel(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingTel = 5
    mvarBillingTel = vData
End Property


Public Property Get BillingTel() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingTel
    BillingTel = mvarBillingTel
End Property



Public Property Let BillingCountry(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingCountry = 5
    mvarBillingCountry = vData
End Property


Public Property Get BillingCountry() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingCountry
    BillingCountry = mvarBillingCountry
End Property



Public Property Let BillingPostcode(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingPostcode = 5
    mvarBillingPostcode = vData
End Property


Public Property Get BillingPostcode() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingPostcode
    BillingPostcode = mvarBillingPostcode
End Property



Public Property Let BillingState(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingState = 5
    mvarBillingState = vData
End Property


Public Property Get BillingState() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingState
    BillingState = mvarBillingState
End Property



Public Property Let BillingCity(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingCity = 5
    mvarBillingCity = vData
End Property


Public Property Get BillingCity() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingCity
    BillingCity = mvarBillingCity
End Property



Public Property Let BillingSurname(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingSurname = 5
    mvarBillingSurname = vData
End Property


Public Property Get BillingSurname() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingSurname
    BillingSurname = mvarBillingSurname
End Property



Public Property Let BillingName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingName = 5
    mvarBillingName = vData
End Property


Public Property Get BillingName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingName
    BillingName = mvarBillingName
End Property



Public Property Let TotalTax(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.TotalTax = 5
    mvarTotalTax = vData
End Property


Public Property Get TotalTax() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.TotalTax
    TotalTax = mvarTotalTax
End Property



Public Property Let BillingAddress(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingAddress = 5
    mvarBillingAddress = vData
End Property


Public Property Get BillingAddress() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingAddress
    BillingAddress = mvarBillingAddress
End Property



Public Property Let TotalPrice(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.TotalPrice = 5
    mvarTotalPrice = vData
End Property


Public Property Get TotalPrice() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.TotalPrice
    TotalPrice = mvarTotalPrice
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



Public Property Let ShipCountry(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipCountry = 5
    mvarShipCountry = vData
End Property


Public Property Get ShipCountry() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipCountry
    ShipCountry = mvarShipCountry
End Property



Public Property Let ShipPostcode(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipPostcode = 5
    mvarShipPostcode = vData
End Property


Public Property Get ShipPostcode() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipPostcode
    ShipPostcode = mvarShipPostcode
End Property



Public Property Let ShipRegion(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipRegion = 5
    mvarShipRegion = vData
End Property


Public Property Get ShipRegion() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipRegion
    ShipRegion = mvarShipRegion
End Property



Public Property Let ShipCity(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipCity = 5
    mvarShipCity = vData
End Property


Public Property Get ShipCity() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipCity
    ShipCity = mvarShipCity
End Property



Public Property Let Frieght(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Frieght = 5
    mvarFrieght = vData
End Property


Public Property Get Frieght() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Frieght
    Frieght = mvarFrieght
End Property



Public Property Let ShipVia(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipVia = 5
    mvarShipVia = vData
End Property


Public Property Get ShipVia() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipVia
    ShipVia = mvarShipVia
End Property



Public Property Let ShipAddress(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipAddress = 5
    mvarShipAddress = vData
End Property


Public Property Get ShipAddress() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipAddress
    ShipAddress = mvarShipAddress
End Property



Public Property Let ShipDate(ByVal vData As Date)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipDate = 5
    mvarShipDate = vData
End Property


Public Property Get ShipDate() As Date
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipDate
    ShipDate = mvarShipDate
End Property



Public Property Let ShipName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipName = 5
    mvarShipName = vData
End Property


Public Property Get ShipName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipName
    ShipName = mvarShipName
End Property




Public Property Let PayType(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.PayType = 5
    mvarPayType = vData
End Property


Public Property Get PayType() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.PayType
    PayType = mvarPayType
End Property



Public Property Let ReqDate(ByVal vData As Date)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ReqDate = 5
    mvarReqDate = vData
End Property


Public Property Get ReqDate() As Date
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ReqDate
    ReqDate = mvarReqDate
End Property



Public Property Let BillingDate(ByVal vData As Date)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingDate = 5
    mvarBillingDate = vData
End Property


Public Property Get BillingDate() As Date
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingDate
    BillingDate = mvarBillingDate
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

Public Property Let BillingFax(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingFax = 5
    mvarBillingFax = vData
End Property


Public Property Get BillingFax() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingFax
    BillingFax = mvarBillingFax
End Property

Public Property Let paid(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Paid = 5
    mvarPaid = vData
End Property


Public Property Get paid() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Paid
    paid = mvarPaid
End Property





