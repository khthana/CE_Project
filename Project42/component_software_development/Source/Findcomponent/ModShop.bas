Attribute VB_Name = "ModShop"
Option Explicit

Public Const StrConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"
Public Const NoRecordDelete = 9997
Public Const UserNameDuplicate = 9996
Public Const ShopNameDuplicate = 9995
Public Const CategoryTypeDuplicate = 9994

Public tmpShopID As Integer
Public tmpCategoryID As Integer

Public Function CCInt(Expression) As Integer
On Error GoTo CCIntError:
    CCInt = CInt(Expression)
Exit Function
CCIntError:
' -- IF Error occur this function return 0
    CCInt = 0
End Function

Public Function NullToEmpty(Expression) As String
    If IsNull(Expression) Then
       NullToEmpty = ""
    Else
       NullToEmpty = Expression
    End If
    
End Function
