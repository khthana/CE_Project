VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Banking"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

Const strConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;Server=BankDB"

'local variable(s) to hold property value(s)
Private mvarCreditcardNumber As String 'local copy
Private mvarBankName As String 'local copy
Private mvarExpMonth As String 'local copy
Private mvarExpYear As String 'local copy
Private mvarMoney As Single 'local copy



' ---- Method -----

Public Function CheckValid() As Boolean
Dim rs As Recordset
Dim cn As Connection
Dim strSQL As String


strSQL = "Select * From TblCreditCard " & _
         "Where CreditCardNumber = '" & mvarCreditcardNumber & "' " & _
         "And lower(BankName) = '" & mvarBankName & "'"

On Error GoTo CheckValidError

' --- Open Connection ---
Set cn = New ADODB.Connection
cn.ConnectionString = strConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open
Set rs = New ADODB.Recordset

rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open strSQL, cn


' --- Check empty recordset
If Not (rs.EOF And rs.BOF) Then

    ' --- Check expire date
    If rs!ExpYear > Year(Date) Then
        CheckValid = True
    Else
       If rs!ExpYear = Year(Date) And rs!ExpMonth >= Month(Date) Then
          CheckValid = True
       Else
          CheckValid = False
       End If
    End If
    
    ' --- Check money
    If CheckValid Then
       If rs!Money >= mvarMoney Then
          CheckValid = True
       Else
          CheckValid = False
       End If
    Else
       CheckValid = False
    End If
    
Else
    CheckValid = False
End If

Exit Function
CheckValidError:
    Err.Raise Err.Number, , Err.Description

End Function



' ---- Property ------

Public Property Let Money(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Money = 5
    mvarMoney = vData
End Property


Public Property Get Money() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Money
    Money = mvarMoney
End Property

Public Property Let ExpYear(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ExpYear = 5
    mvarExpYear = vData
End Property


Public Property Get ExpYear() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ExpYear
    ExpYear = mvarExpYear
End Property



Public Property Let ExpMonth(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ExpMonth = 5
    mvarExpMonth = vData
End Property


Public Property Get ExpMonth() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ExpMonth
    ExpMonth = mvarExpMonth
End Property



Public Property Let BankName(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BankName = 5
    mvarBankName = vData
End Property


Public Property Get BankName() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BankName
    BankName = mvarBankName
End Property



Public Property Let CreditcardNumber(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CreditcardNumber = 5
    mvarCreditcardNumber = vData
End Property


Public Property Get CreditcardNumber() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CreditcardNumber
    CreditcardNumber = mvarCreditcardNumber
End Property



