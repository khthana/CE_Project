Attribute VB_Name = "ModWebBilling"
Option Explicit

Public Const StrConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;Server=Threetier"
Public Const NoItemForCheckOut = 9995
Public Const InvalidCreditCard = 9994



Public Function ReturnCheckBoxValue(ByVal CkValue As String) As String
  If CkValue = "yes" Then
     ReturnCheckBoxValue = "yes"
  Else
     ReturnCheckBoxValue = "no"
  End If
End Function

Public Function GenMailContent(ByVal strBillTo As String, _
                               ByVal strShipTo As String, _
                               ByVal strSelectedItem As String, _
                               ByVal strSumary As String)
  GenMailContent = "<H3>Billed To</H3>" & _
                   strBillTo & "" & _
                   "<H3>Ship To</H3>" & _
                   strShipTo & "" & _
                   "<H3>Selected Item</H3>" & _
                   "<table width=""100%"" border=""1"" cellspacing=""0"" cellpadding=""0"">" & _
                   "<tr bgcolor=""#99CCFF"">" & _
                   "<td width=""5%"" align=""center"">" & _
                   "<b><font face=""MS Sans Serif"">No</font></b></td>" & _
                   "<td width=""37%"" align=""center"">" & _
                   "<b><font face=""MS Sans Serif"">Item name</font></b></td>" & _
                   "<td width=""6%"" align=""center"">" & _
                   "<b><font face=""MS Sans Serif"">Qty</font></b></td>" & _
                   "<td width=""14%"" align=""center"">" & _
                   "<b><font face=""MS Sans Serif"">Price</font></b></td>" & _
                   "<td width=""38%"" align=""center"">" & _
                   "<b><font face=""MS Sans Serif"">Status</font></b></td>" & _
                   "</tr>" & _
                   strSelectedItem & _
                   "</table>" & _
                   strSumary
End Function

Public Function CCInt(expression) As Integer
On Error GoTo CCIntError:
    CCInt = CInt(expression)
Exit Function
CCIntError:
' -- IF Error occur this function return 0
    CCInt = 0
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

