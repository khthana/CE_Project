Attribute VB_Name = "ModAdminItem"
Option Explicit

Public Const StrConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"
Public Const NoRecordDelete = 9997
Public Const UserNameDuplicate = 9996
Public Const ShopNameDuplicate = 9995
Public Const CategoryTypeDuplicate = 9994

Public tmpShopID As Integer
Public tmpCategoryID As Integer

Public Function CCInt(expression) As Integer
On Error GoTo CCIntError:
    CCInt = CInt(expression)
Exit Function
CCIntError:
' -- IF Error occur this function return 0
    CCInt = 0
End Function

Public Function NullToEmpty(expression) As String
    If IsNull(expression) Then
       NullToEmpty = ""
    Else
       NullToEmpty = expression
    End If
    
End Function
Public Function CCSng(expression) As Single
    If expression = "" Then
        CCSng = 0
    Else
        CCSng = CSng(expression)
    End If
    
End Function

Function CheckValidRs(ByVal Rs As Variant) As Boolean
    If IsEmpty(Rs) Then
       CheckValidRs = False
    Else
        If Rs.BOF And Rs.EOF Then
            CheckValidRs = False
        Else
            CheckValidRs = True
        End If
    End If
End Function


'Public Function CheckValidRs(ByVal rs As Recordset) As Boolean
'    If IsEmpty(rs) Then
'        CheckValidRs =
'End Function


