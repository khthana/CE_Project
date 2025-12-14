Attribute VB_Name = "ModAccount"
Option Explicit
Public Const StrConn = "PROVIDER=MSDASQL;DSN=OracleDSN;UID=Ecomm;PWD=Public;"
' ---- Error Const -----
Public Const EmailDuplicate = 9998
Public Const NoRecordDelete = 9997
Public Const NoContextError = 9993


Public Function NullToStr(ChkRS As ADODB.Field) As String
    If IsNull(ChkRS.Value) Then
       NullToStr = ""
    Else
       NullToStr = ChkRS.Value
    End If
End Function

Public Sub UpdateField(ByRef RsField As ADODB.Field, ByVal ValUpdate As Variant)
    If ValUpdate <> "" And (Not IsNull(ValUpdate)) Then
        RsField = Trim(ValUpdate)
    End If
End Sub

