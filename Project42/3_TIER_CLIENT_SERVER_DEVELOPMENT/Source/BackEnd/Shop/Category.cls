VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 2  'RequiresTransaction
END
Attribute VB_Name = "Category"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"No"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarCategoryID As Integer 'local copy
Private mvarCategoryType As String 'local copy
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


' --- Method of Class Category -----
Public Sub Update(ByVal ShopID As Integer)
' -- Description
' Update by add new value replace old value that sent by properties
' If new value is null or empty that field doesn't update
' That mean not allow delete some field in category
' -- Input
' Information pass through properties
' ShopID for access nested table through table shop

Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim updatestr As String
Dim strCategoryType As String, strF1 As String
Dim strF2 As String, strF3 As String, strF4 As String
Dim strF5 As String, strF6 As String, strF7 As String
Dim strF8 As String, strF9 As String, strF10 As String
Dim strF11 As String, strF12 As String, strF13 As String
Dim strF14 As String, strF15 As String, strF16 As String
Dim strF17 As String, strF18 As String, strF19 As String
Dim strF20 As String
Dim tx As ObjectContext

' --- Start Transaction ---
'Set tx = GetObjectContext()
'If tx Is Nothing Then
'   Err.Raise NoContextError, , "Could not establish an object context"
'   Exit Sub
'End If


strCategoryType = CatIFNotEmpty("CategoryType='", mvarCategoryType, "',")
strF1 = CatIFNotEmpty("F1='", mvarF1, "',")
strF2 = CatIFNotEmpty("F2='", mvarF2, "',")
strF3 = CatIFNotEmpty("F3='", mvarF3, "',")
strF4 = CatIFNotEmpty("F4='", mvarF4, "',")
strF5 = CatIFNotEmpty("F5='", mvarF5, "',")
strF6 = CatIFNotEmpty("F6='", mvarF6, "',")
strF7 = CatIFNotEmpty("F7='", mvarF7, "',")
strF8 = CatIFNotEmpty("F8='", mvarF8, "',")
strF9 = CatIFNotEmpty("F9='", mvarF9, "',")
strF10 = CatIFNotEmpty("F10='", mvarF10, "',")
strF11 = CatIFNotEmpty("F11='", mvarF11, "',")
strF12 = CatIFNotEmpty("F12='", mvarF12, "',")
strF13 = CatIFNotEmpty("F13='", mvarF13, "',")
strF14 = CatIFNotEmpty("F14='", mvarF14, "',")
strF15 = CatIFNotEmpty("F15='", mvarF15, "',")
strF16 = CatIFNotEmpty("F16='", mvarF16, "',")
strF17 = CatIFNotEmpty("F17='", mvarF17, "',")
strF18 = CatIFNotEmpty("F18='", mvarF18, "',")
strF19 = CatIFNotEmpty("F19='", mvarF19, "',")
strF20 = CatIFNotEmpty("F20='", mvarF20, "'")

On Error GoTo updateCategoryError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

cn.BeginTrans

Set rs = New ADODB.Recordset

rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

updatestr = strCategoryType & strF1 & strF2 & strF3 & strF4 & _
            strF5 & strF6 & strF7 & strF8 & strF9 & strF10 & _
            strF11 & strF12 & strF13 & strF14 & strF15 & strF16 & _
            strF17 & strF18 & strF19 & strF20
If Replace(updatestr, ",", "", Len(updatestr)) = "" Then
 ' UpdateStr End with ","
    updatestr = Left(updatestr, Len(updatestr) - 1)
End If

updatestr = "Update the(select category from tblshop where shopid = " & ShopID & ") " & _
            " Set " & updatestr & _
            " Where Categoryid = " & CStr(mvarCategoryID)

rs.Open updatestr, cn ' Send SQL To Oracle

'tx.SetComplete
cn.CommitTrans

Exit Sub
updateCategoryError:
'    tx.SetAbort
    cn.RollbackTrans
    Err.Raise Err.Number, , Err.Description

End Sub

Public Sub Delete(ByVal ShopID As Integer, ByVal Criteria As String)
' -- Description
' Delete one to more rows by Criteria
'   That is clause after where in sql command.
' Make constrain ,if category deleted then item in it deleted too.
'   This constrain doesn't set in oracle because no foreign key
'   in nested table.
' -- Input
' ShopID for access nested table from master table
' Criteria is clause after where in sql command

Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim strSQL As String
'Dim tx As ObjectContext

' --- Start Transaction ---
'Set tx = GetObjectContext()
'If tx Is Nothing Then
'   Err.Raise NoContextError, , "Could not establish an object context"
'   Exit Sub
'End If


On Error GoTo DeleteCategoryError
' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

cn.BeginTrans

Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

 ' ----- Delete Item in this category ------
strSQL = "Delete TblItem " & _
         "Where CategoryID in ( Select CategoryID From " & _
         "The (Select Category From TblShop " & _
         "Where ShopID = " & ShopID & ") " & _
         "Where " & Criteria & ")"

rs.Open strSQL, cn


rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

 ' ------- Delete Category ------------
strSQL = "Delete the(Select category From tblshop where ShopID = " & CStr(ShopID) & _
        ") Where " & Criteria
rs.Open strSQL, cn, , , adCmdText

' -- Finish Transaction --
'tx.SetComplete
cn.CommitTrans

Exit Sub
DeleteCategoryError:
'    tx.SetAbort
    cn.RollbackTrans
    Err.Raise Err.Number, , Err.Description
    
End Sub

Public Function Find(ByVal ShopID As Integer, Optional ByVal Criteria As String) As ADODB.Recordset
' -- Description
' Find follow by sql statement
' -- Input
' [Optional default is select all]
'   SQL statement through argument
' ShopID for access nested table from master table
' -- Output
' Result of sql commnad in recordset data type


Dim rs As ADODB.Recordset
Dim strSQL As String

On Error GoTo FindcategoryError
If Criteria = "" Then
    Criteria = "categoryid > 0"
End If

strSQL = "Select * From the(select category from tblshop  where shopid = " & ShopID & ") Where " & Criteria

Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open strSQL, StrConn, , , adCmdText

Set Find = rs

Exit Function
FindcategoryError:
    Err.Raise Err.Number, , Err.Description

End Function

Public Function Addnew(ByVal ShopID As Integer) As Integer
' -- Description
' Add new category that is nested table in tblshop
' that add new category through sql command
' -- Input
' Information certain in properties
' ShopID for access nested table from master table
' -- Output
' Return categoryID through return value


Dim cn As ADODB.Connection
Dim rs As ADODB.Recordset
Dim IntCategoryID As Integer
Dim strSQL As String
'Dim tx As ObjectContext

' --- Start Transaction ---
'Set tx = GetObjectContext()
'If tx Is Nothing Then
'   Err.Raise NoContextError, , "Could not establish an object context"
'   Exit Function
'End If


On Error GoTo AddNewCategoryError
' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

cn.BeginTrans

Set rs = New ADODB.Recordset

' --- Auto increase ID
' -- Unique in NCategory
Set rs = cn.Execute("Select max(CategoryId) From (Select categoryID from NCategory)")
If rs.BOF And rs.EOF Then
   IntCategoryID = 1
Else
    If IsNull(rs.Fields(0).Value) Or rs.Fields(0).Value = "" Then
        IntCategoryID = 1
    Else
        IntCategoryID = rs.Fields(0).Value + 1
    End If
End If

' ---- Unique CategoryType ------
strSQL = "Select CategoryType From The(Select category From tblShop where Shopid = " & ShopID & ")" & _
         "Where CategoryType = '" & mvarCategoryType & "'"
Set rs = cn.Execute(strSQL)

If Not (rs.BOF And rs.EOF) Then
    Err.Raise CategoryTypeDuplicate, , "Category type was duplicate"
End If
rs.Close

rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic

strSQL = IntCategoryID & ",'" & mvarCategoryType & "','" & mvarF1 & "','" & mvarF2 & "','" & mvarF3 & "','" & mvarF4 & "','" & mvarF5 & "','" & mvarF6 & "','" & mvarF7 & "','" & mvarF8 & _
            "','" & mvarF9 & "','" & mvarF10 & "','" & mvarF11 & "','" & mvarF12 & "','" & mvarF13 & "','" & mvarF14 & "','" & mvarF15 & "','" & mvarF16 & "','" & mvarF17 & "','" & mvarF18 & "','" & mvarF19 & "','" & mvarF20 & "'"

strSQL = "Insert Into the(select category from tblshop where shopid = " & ShopID & " ) values (" & strSQL & ")"
rs.Open strSQL, cn    ' Send SQL To Oracle

' -- Return categoryid to return value
    Addnew = IntCategoryID

' -- Finish transaction
'tx.SetComplete
cn.CommitTrans

Exit Function
AddNewCategoryError:
'    tx.SetAbort
    cn.RollbackTrans
    Err.Raise Err.Number, , Err.Description

End Function



' ------ Property of Class Category ------
Public Property Let CategoryType(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CategoryType = 5
    mvarCategoryType = vData
End Property


Public Property Get CategoryType() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CategoryType
    CategoryType = mvarCategoryType
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


