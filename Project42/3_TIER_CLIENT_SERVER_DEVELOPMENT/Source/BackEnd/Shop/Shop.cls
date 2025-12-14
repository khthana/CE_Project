VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "Shop"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Member0" ,"Category"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarShopID As Integer 'local copy
Private mvarShopName As String 'local copy
Private mvarOwnerName As String 'local copy
Private mvarOwnerSurname As String 'local copy
Private mvarEmail As String 'local copy
Private mvarUsername As String 'local copy
Private mvarPassword As String 'local copy
Private mvarSex As String 'local copy
Private mvarAge As Integer 'local copy
Private mvarOccupation As String 'local copy
Private mvarAddress As String 'local copy
Private mvarProvince As String 'local copy
Private mvarSubProvince As String 'local copy
Private mvarPostcode As String 'local copy
Private mvarCountry As String 'local copy
Private mvarTel As String 'local copy
Private mvarFax As String 'local copy
Private mvarCreateOn As Date 'local copy
Private mvarWebTemplate As String 'local copy
Private mvarCategory As Category



' ---- Method for Class Shop ---- '
Public Sub Delete(ByVal Criteria As String)
' -- Description
' Delete one to more rows by Criteria
'  That is clause after where in sql command.
' Set constrain cascade delete in table Item
'  That if shop deleted, item in it deleted too.
' And already cascade delete constrain in table category
'  That had nested relation

Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Sub
End If

On Error GoTo DeleteShopError
' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

' -- Delete Shop --
rs.Open "Select * From Vshop where " & Criteria, _
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
tx.SetComplete

Exit Sub
DeleteShopError:
    tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Sub

Public Sub Update()
' -- Description
' Update by add new value replace old value that sent by properties
' If new value is null or empty that field doesn't update
' That mean not allow delete some field in shop
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

On Error GoTo UpdateError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * From VShop Where ShopID = " & CStr(mvarShopID), cn

'    UpdateField rs!ShopName, mvarShopName
    UpdateField rs!OwnerName, mvarOwnerName
    UpdateField rs!OwnerSurname, mvarOwnerSurname
    UpdateField rs!Email, LCase(mvarEmail)
    UpdateField rs!Password, mvarPassword
'    UpdateField rs!Username , mvarUsername
    UpdateField rs!Sex, mvarSex
    UpdateField rs!Age, mvarAge
    UpdateField rs!Occupation, mvarOccupation
    UpdateField rs!Address, mvarAddress
    UpdateField rs!Province, mvarProvince
    UpdateField rs!SubProvince, mvarSubProvince
    UpdateField rs!Postcode, mvarPostcode
    UpdateField rs!Country, mvarCountry
    UpdateField rs!Tel, mvarTel
    UpdateField rs!Fax, mvarFax
'    UpdateField rs!CreateOn , mvarCreateOn
    UpdateField rs!WebTemplate, mvarWebTemplate
rs.Update
rs.Close
' -- Finish Transaction --
tx.SetComplete

Exit Sub
UpdateError:
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
    strSQL = "Select * from Vshop"
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

Public Function Addnew() As Integer
' -- Description
' Add new shop by pass information to properties
' And return shopid by return value


Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim Qy As New ADODB.Command
Dim IntShopID As Integer
Dim tx As ObjectContext

' --- Start Transaction ---
Set tx = GetObjectContext()
If tx Is Nothing Then
   Err.Raise NoContextError, , "Could not establish an object context"
   Exit Function
End If

On Error GoTo AddNewShopError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

' --- Auto increase ID
Set rs = cn.Execute("Select Max(ShopID) From VShop")
If rs.BOF And rs.EOF Then
   IntShopID = 1
Else
   If IsNull(rs.Fields(0).Value) Or rs.Fields(0).Value = "" Then
      IntShopID = 1
   Else
      IntShopID = rs.Fields(0).Value + 1
   End If
End If


' --------- Add Constrain ---------
' ------ Username Unique ----
Set rs = cn.Execute("Select Username From VShop " & _
                    "Where Username = '" & mvarUsername & "'")
If Not (rs.BOF And rs.EOF) Then
    Err.Raise UserNameDuplicate, , "Username was duplicate"
End If

' ------ Shopname Unique -----
Set rs = cn.Execute("Select Shopname from vshop " & _
                     "Where Shopname = '" & mvarShopName & "'")
If Not (rs.BOF And rs.EOF) Then
    Err.Raise ShopNameDuplicate, , "Shop name was duplicate"
End If


' Use Stored Procedure InitShop for insert new row
Set Qy.ActiveConnection = cn
Qy.CommandType = adCmdStoredProc
Qy.CommandText = "InitShop"
 ' -- Set parameter for SP InitShop --
Qy(0) = IntShopID
Set rs = Qy.Execute()

   
' Now create Nested Tables Complete
' Use update for update all column with out Nested tables
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * From VShop Where ShopID = " & IntShopID, cn
    rs!ShopName = mvarShopName
    rs!OwnerName = mvarOwnerName
    rs!OwnerSurname = mvarOwnerSurname
    rs!Email = LCase(mvarEmail)
    rs!Password = mvarPassword
    rs!Username = LCase(mvarUsername)
    rs!Sex = mvarSex
    rs!Age = mvarAge
    rs!Occupation = mvarOccupation
    rs!Address = mvarAddress
    rs!Province = mvarProvince
    rs!SubProvince = mvarSubProvince
    rs!Postcode = mvarPostcode
    rs!Country = mvarCountry
    rs!Tel = mvarTel
    rs!Fax = mvarFax
    rs!CreateOn = Date          ' Initial
    rs!WebTemplate = mvarWebTemplate
rs.Update

' --- Return ShopID by return value ---
    Addnew = IntShopID


' -- Finish Transaction --
tx.SetComplete

' --- End of Addnew method ---
Exit Function
AddNewShopError:
    tx.SetAbort
    Err.Raise Err.Number, , Err.Description

End Function




' ---- Property of Class Shop ----- '

Private Sub Class_Initialize()
  'create the mCategory object when the Shop class is created
  Set mvarCategory = New Category
End Sub

Private Sub Class_Terminate()
  Set mvarCategory = Nothing
End Sub


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



Public Property Let Address(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Address = 5
    mvarAddress = vData
End Property


Public Property Get Address() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Address
    Address = mvarAddress
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



Public Property Let Username(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Username = 5
    mvarUsername = vData
End Property


Public Property Get Username() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Username
    Username = mvarUsername
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



Public Property Let OwnerSurname(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.OwnerSurname = 5
    mvarOwnerSurname = vData
End Property


Public Property Get OwnerSurname() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.OwnerSurname
    OwnerSurname = mvarOwnerSurname
End Property



Public Property Let OwnerName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.OwnerName = 5
    mvarOwnerName = vData
End Property


Public Property Get OwnerName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.OwnerName
    OwnerName = mvarOwnerName
End Property



Public Property Let ShopName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShopName = 5
    mvarShopName = vData
End Property


Public Property Get ShopName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShopName
    ShopName = mvarShopName
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


Public Property Get Category() As Category
    Set Category = mvarCategory
End Property


Public Property Set Category(vData As Category)
    Set mvarCategory = vData
End Property

Public Property Let WebTemplate(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.WebTemplate = 5
    mvarWebTemplate = vData
End Property


Public Property Get WebTemplate() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.WebTemplate
    WebTemplate = mvarWebTemplate
End Property




