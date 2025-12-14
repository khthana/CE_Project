Attribute VB_Name = "ModBilling"
Option Explicit

Public Const StrConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"
Public Const NoRecordDelete = 9997
Public Const NoContextError = 9993

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

Public Sub UpdateField(ByRef RsField As ADODB.Field, ByVal ValUpdate As Variant)
    If ValUpdate <> "" And (Not IsNull(ValUpdate)) Then
        RsField = ValUpdate
    End If
End Sub

