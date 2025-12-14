Attribute VB_Name = "ModSimPayment"
Option Explicit

Public Const StrConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"

Public Function CCInt(Expression) As Integer
On Error GoTo CCIntError:
    CCInt = CInt(Expression)
Exit Function
CCIntError:
' -- IF Error occur this function return 0
    CCInt = 0
End Function

