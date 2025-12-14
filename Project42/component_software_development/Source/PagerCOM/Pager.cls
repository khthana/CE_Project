VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Pager"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarPagerType As String 'local copy
Private mvarPagerNumber As String 'local copy
Private mvarPagerPassword As String 'local copy
Private mvarMessage As String 'local copy
Private mvarUsername As String 'local copy
Private mvarPassword As String 'local copy


' --- Method ---

Public Function Send() As String

Dim str162 As String
Dim strPassword162 As String
Dim str152 As String
Dim str1500 As String
Dim str142 As String
Dim strPassword142 As String
Dim str1188 As String
Dim strUsername As String
Dim strPassword1188 As String
Dim str1144 As String
Dim strGSM As String
Dim strPasswordGSM As String
Dim strICQ As String
Dim strForm As String
Dim strMessage As String


    Select Case mvarPagerType
    Case "0"  ' 142 Worldpage
        str142 = mvarPagerNumber
        strPassword142 = mvarPagerPassword
    
    Case "1"  ' 152 Phonelink
        str152 = mvarPagerNumber
    
    Case "2"  ' 162 Hutchison
        str162 = mvarPagerNumber
        strPassword162 = mvarPagerPassword
    
    Case "3"  ' 1144 Paclink
        str1144 = mvarPagerNumber
        
    Case "4"  ' 1188 Postel
        str1188 = mvarPagerNumber
        strUsername = mvarUsername
        strPassword1188 = mvarPassword
    
    Case "5"  ' 1500 Easycall
        str1500 = mvarPagerNumber
        
    Case "6"  ' ICQ Message
        strICQ = mvarPagerNumber
    
    Case "7"  ' GSM900
        strGSM = mvarPagerNumber
        strPasswordGSM = mvarPassword
    
    End Select

    strMessage = mvarMessage
    strForm = "Shop2000"


Send = "<form  action=""http://www.jorjae.com/pager/page.asp"" method=""post"" Target=""NewWindow"" onsubmit=""DriveMe('NewWindow')"">" & _
"<input type=""hidden"" name=""162"" size=""25"" value=""" & str162 & """>" & _
"<input type=""hidden"" name=""password162"" size=""25"" value=""" & strPassword162 & """>" & _
"<input type=""hidden"" name=""152"" size=""25"" value=""" & str152 & """>" & _
"<input type=""hidden"" name=""1500"" size=""25"" value=""" & str1500 & """>" & _
"<input type=""hidden"" name=""142"" size=""25"" value=""" & str142 & """>" & _
"<input type=""hidden"" name=""password142"" size=""25"" value=""" & strPassword142 & """>" & _
"<input type=""hidden"" name=""1188"" size=""25"" value=""" & str1188 & """>" & _
"<input type=""hidden"" name=""iusername"" size=""25"" value=""" & strUsername & """>" & _
"<input type=""hidden"" name=""password1188"" size=""25"" value=""" & strPassword1188 & """>" & _
"<input type=""hidden"" name=""1144"" size=""25"" value=""" & str1144 & """>" & _
"<input type=""hidden"" name=""gsm"" size=""21"" value=""" & strGSM & """>" & _
"<input type=""hidden"" name=""passwordGSM"" size=""25"" value=""" & strPasswordGSM & """>" & _
"<input type=""hidden"" name=""icq"" size=""25"" value=""" & strICQ & """>" & _
"<input type=""hidden"" name=""from"" size=""25"" value=""" & strForm & """>" & _
"<input type=""hidden"" name=""message"" value=""" & strMessage & """>" & _
"<input type=""hidden"" value=""124616303108208130"" name=""cookieid"">" & _
"<input type=""hidden"" value=""124616303108208130"" name=""cookieid1"">" & _
"<input type=""hidden"" value=""124616303108208130"" name=""cookieid2"">" & _
"<input type=""hidden"" value=""124616303108208130"" name=""cookieid3"">" & _
"<input type=""hidden"" value=""124616303108208130"" name=""cookieid4"">" & _
"<input type=""submit"" value=""Back to main page"" name=""B1"">" & _
"<input type=""hidden"" value=""ลบข้อความ"" name=""B2"">" & _
"</form>"



End Function


' --- Property ---

Public Property Let Message(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Message = 5
    mvarMessage = vData
End Property


Public Property Get Message() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Message
    Message = mvarMessage
End Property



Public Property Let pagerPassword(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.PagerPassword = 5
    mvarPagerPassword = vData
End Property


Public Property Get pagerPassword() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.PagerPassword
    pagerPassword = mvarPagerPassword
End Property



Public Property Let pagerNumber(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.PagerNumber = 5
    mvarPagerNumber = vData
End Property


Public Property Get pagerNumber() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.PagerNumber
    pagerNumber = mvarPagerNumber
End Property



Public Property Let pagerType(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.PagerType = 5
    mvarPagerType = vData
End Property


Public Property Get pagerType() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.PagerType
    pagerType = mvarPagerType
End Property

Public Property Let Password(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Password = 5
    mvarPassword = vData
End Property


Public Property Get Password() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Password
    Password = mvarPassword
End Property



Public Property Let Username(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Username = 5
    mvarUsername = vData
End Property


Public Property Get Username() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Username
    Username = mvarUsername
End Property





