Attribute VB_Name = "ModBillingDetail"
Option Explicit

Public Const ShipPeriod = 21
Public Const PayinDate = 15

Public Function CCSng(ByVal expression) As Single

On Error GoTo CCSngError

    CCSng = CSng(expression)
    
Exit Function
CCSngError:
    CCSng = 0
End Function

Public Function CCInt(ByVal expression) As Single

On Error GoTo CCIntError

    CCInt = CInt(expression)

Exit Function
CCIntError:
    CCInt = 0

End Function
