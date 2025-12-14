VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "ESecure"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarCusUserName As String 'local copy
Private mvarCusPassword As String 'local copy
Private mvarAccountID As Integer 'local copy

' ------ Method of ESecure ------

Public Function LogoutOwner() As Boolean
    LogoutOwner = True
    mvarAccountID = 0
End Function

Public Function LoginOwner() As Boolean
Attribute LoginOwner.VB_UserMemId = 0
Dim ObjShop As Object
Dim strSQL As String
Dim rs As Recordset

strSQL = "Select ShopID From Vshop Where " & _
         "Username = '" & mvarCusUserName & "' And " & _
         "Password = '" & mvarCusPassword & "'"
         
On Error GoTo LoginOwnerError
         
Set ObjShop = CreateObject("EComm.Shop")
Set rs = ObjShop.Find(strSQL)

If rs.BOF And rs.EOF Then
   LoginOwner = False
Else
   LoginOwner = True
 ' --- Return Property AccountID ----
   mvarAccountID = rs!ShopID
End If

Set ObjShop = Nothing

Exit Function
LoginOwnerError:
    Err.Raise Err.Number, , Err.Description
    ObjShop = Nothing
End Function

Public Function Logout() As Boolean
    Logout = True
    mvarAccountID = 0
End Function

Public Function Login() As Boolean
Dim ObjAccount As Object
Dim strSQL As String
Dim rs As Recordset

strSQL = "Select AccountID From VAccount Where " & _
         "Email = '" & mvarCusUserName & "' And " & _
         "Password = '" & mvarCusPassword & "'"
         
On Error GoTo LoginError
         
Set ObjAccount = CreateObject("EComm.account")
Set rs = ObjAccount.GetInformation(strSQL)

If rs.BOF And rs.EOF Then
   Login = False
Else
   Login = True
 ' --- Return Property AccountID ----
   mvarAccountID = rs!AccountID
End If

Set ObjAccount = Nothing

Exit Function
LoginError:
    Err.Raise Err.Number, , Err.Description
    ObjAccount = Nothing

End Function

' ------ Method of ESecure ------

Public Property Let CusPassword(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CusPassword = 5
    mvarCusPassword = vData
End Property


Public Property Get CusPassword() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CusPassword
    CusPassword = mvarCusPassword
End Property



Public Property Let CusUserName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CusUserName = 5
    mvarCusUserName = vData
End Property


Public Property Get CusUserName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CusUserName
    CusUserName = mvarCusUserName
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



