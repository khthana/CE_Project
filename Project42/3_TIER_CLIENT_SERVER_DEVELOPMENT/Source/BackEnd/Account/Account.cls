VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "Account"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Private mvarAccountID As Integer 'local copy
Private mvarCusName As String 'local copy
Private mvarCusSurname As String 'local copy
Private mvarEmail As String 'local copy
Private mvarPassword As String 'local copy
Private mvarSex As String 'local copy
Private mvarAge As Integer 'local copy
Private mvaraddress As String 'local copy
Private mvarSubProvince As String 'local copy
Private mvarPostcode As String 'local copy
Private mvarOccupation As String 'local copy
Private mvarProvince As String 'local copy
Private mvarTel As String 'local copy
Private mvarFax As String 'local copy
Private mvarCountry As String 'local copy




' -------- Method of Class Account ------

Public Function AddAccount() As Integer
Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String
Dim IntAccountID As Integer
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Function
End If

On Error GoTo AddNewCustomerError

' -- open connection to oracle by strConn
Set cn = New ADODB.Connection
cn.CursorLocation = adUseClient
cn.Open StrConn

Set rs = New ADODB.Recordset
rs.CursorType = adOpenForwardOnly
rs.LockType = adLockReadOnly

' ----- Auto increase id ----
strSQL = "Select Max(AccountID) From VAccount"
rs.Open strSQL, cn

If rs.BOF And rs.EOF Then
   IntAccountID = 1
Else
    If IsNull(rs.Fields(0).Value) Or rs.Fields(0).Value = "" Then
       IntAccountID = 1
    Else
       IntAccountID = rs.Fields(0) + 1
    End If
End If
rs.Close
' ----- Integrity rule ------
' ---- E-mail not duplicate ---
strSQL = "Select Email From VAccount " & _
         "Where Email = '" & mvarEmail & "'"
rs.Open strSQL, cn

If Not (rs.BOF And rs.EOF) Then
   ' --- Already have this email ----
   Err.Raise EmailDuplicate, , "Email was duplicate"
End If
rs.Close

' ---- Add customer ----
strSQL = "Select * From VAccount"
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open strSQL, cn

rs.AddNew
   rs!AccountID = IntAccountID
   rs!CusName = Trim(mvarCusName)
   rs!CusSurname = Trim(mvarCusSurname)
   rs!Email = LCase(Trim(mvarEmail))
   rs!Password = Trim(mvarPassword)
   rs!Sex = Trim(mvarSex)
   rs!Age = Trim(mvarAge)
   rs!Occupation = Trim(mvarOccupation)
   rs!address = Trim(mvaraddress)
   rs!Province = Trim(mvarProvince)
   rs!SubProvince = Trim(mvarSubProvince)
   rs!Postcode = Trim(mvarPostcode)
   rs!Country = Trim(mvarCountry)
   rs!Tel = Trim(mvarTel)
   rs!Fax = Trim(mvarFax)
rs.Update


' ------ Return value AccountID Out ------
    AddAccount = IntAccountID

' -- Finish Transaction --
tx.SetComplete

' ------ End of AddAccount Method ----
Exit Function
AddNewCustomerError:
   tx.SetAbort
   Err.Raise Err.Number, , Err.Description

End Function


Public Function GetInformation(Optional ByVal strSQL As String) As ADODB.Recordset
Dim rs As ADODB.Recordset
Dim cn As ADODB.Connection
  
If strSQL = "" Then
    strSQL = "Select * from VAccount"
End If

On Error GoTo GetInformationError
' -- open connection to oracle by strConn
Set cn = New ADODB.Connection
cn.CursorLocation = adUseClient
cn.Open StrConn

Set rs = New ADODB.Recordset
rs.CursorType = adOpenForwardOnly
rs.LockType = adLockReadOnly
rs.Open strSQL, cn

Set GetInformation = rs

Exit Function
GetInformationError:
   Err.Raise Err.Number, , Err.Description
   
End Function


Public Sub DeleteAccount(ByVal Criteria As String)
Dim strSQL As String
Dim rs As ADODB.Recordset
Dim cn As ADODB.Connection
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo DeleteAccountError
' -- open connection to oracle by strConn
Set cn = New ADODB.Connection
cn.Open StrConn

strSQL = "Select * From VAccount " & _
         "Where " & Criteria

Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open strSQL, cn

If rs.BOF And rs.EOF Then
    Err.Raise NoRecordDelete, , "No record was delete"
    Exit Sub
Else
    rs.MoveFirst
    Do Until rs.EOF
       rs.Delete
       rs.MoveNext
    Loop
End If

' -- Finish Transaction --
tx.SetComplete


Exit Sub
DeleteAccountError:
    tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Sub

Public Sub UpdateAccount()
Dim rs As ADODB.Recordset
Dim strSQL As String
Dim id As Integer
Dim cn As ADODB.Connection
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If


On Error GoTo UpdateAccountError
' -- open connection to oracle by strConn
Set cn = New ADODB.Connection
cn.Open StrConn


Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

' ---- Update customer ----
strSQL = "Select * " & _
         "From VAccount " & _
         "Where AccountID = " & CStr(mvarAccountID)
rs.Open strSQL, cn

   UpdateField rs!CusName, mvarCusName
   UpdateField rs!CusSurname, mvarCusSurname
'   updatefield rs!Email , mvarEmail    Not allow to update email
   UpdateField rs!Password, mvarPassword
   UpdateField rs!Sex, mvarSex
   UpdateField rs!Age, mvarAge
   UpdateField rs!address, mvaraddress
   UpdateField rs!SubProvince, mvarSubProvince
   UpdateField rs!Province, mvarProvince
   UpdateField rs!Postcode, mvarPostcode
   UpdateField rs!Occupation, mvarOccupation
   UpdateField rs!Country, mvarCountry
   UpdateField rs!Tel, mvarTel
   UpdateField rs!Fax, mvarFax
rs.Update

' ----- Finish Transction ----
tx.SetComplete

Exit Sub
'  --- Error handler ----
UpdateAccountError:
    tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Sub



' ------- Property of Class Account -------------
Public Property Let Country(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Country = 5
    mvarCountry = vData
End Property


Public Property Get Country() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Country
    Country = mvarCountry
End Property



Public Property Let Fax(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Fax = 5
    mvarFax = vData
End Property


Public Property Get Fax() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Fax
    Fax = mvarFax
End Property



Public Property Let Tel(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Tel = 5
    mvarTel = vData
End Property


Public Property Get Tel() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Tel
    Tel = mvarTel
End Property





Public Property Let Province(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Province = 5
    mvarProvince = vData
End Property


Public Property Get Province() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Province
    Province = mvarProvince
End Property



Public Property Let Occupation(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Occupation = 5
    mvarOccupation = vData
End Property


Public Property Get Occupation() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Occupation
    Occupation = mvarOccupation
End Property



Public Property Let Postcode(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Postcode = 5
    mvarPostcode = vData
End Property


Public Property Get Postcode() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Postcode
    Postcode = mvarPostcode
End Property



Public Property Let SubProvince(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.SubProvince = 5
    mvarSubProvince = vData
End Property


Public Property Get SubProvince() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.SubProvince
    SubProvince = mvarSubProvince
End Property



Public Property Let address(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.address = 5
    mvaraddress = vData
End Property


Public Property Get address() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.address
    address = mvaraddress
End Property



Public Property Let Age(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Age = 5
    mvarAge = vData
End Property


Public Property Get Age() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Age
    Age = mvarAge
End Property



Public Property Let Sex(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Sex = 5
    mvarSex = vData
End Property


Public Property Get Sex() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Sex
    Sex = mvarSex
End Property



Public Property Let Password(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Password = 5
    mvarPassword = vData
End Property


Public Property Get Password() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Password
    Password = mvarPassword
End Property



Public Property Let Email(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Email = 5
    mvarEmail = vData
End Property


Public Property Get Email() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Email
    Email = mvarEmail
End Property



Public Property Let CusSurname(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CusSurname = 5
    mvarCusSurname = vData
End Property


Public Property Get CusSurname() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CusSurname
    CusSurname = mvarCusSurname
End Property



Public Property Let CusName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CusName = 5
    mvarCusName = vData
End Property


Public Property Get CusName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CusName
    CusName = mvarCusName
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

