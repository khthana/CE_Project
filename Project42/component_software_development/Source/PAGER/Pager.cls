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
Dim socket As New socket.TCP


Private mvarNumber As String 'local copy
Private mvarFrom As String 'local copy
Private mvarMessage As String 'local copy
'local variable(s) to hold property value(s)
Private mvarTypeOfPager As String 'local copy
'local variable(s) to hold property value(s)
Private mvarBillingID As Integer 'local copy
'local variable(s) to hold property value(s)
Private mvarreturnstring As String 'local copy
Public Property Let returnstring(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.returnstring = 5
    mvarreturnstring = vData
End Property


Public Property Get returnstring() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.returnstring
     returnstring = mvarreturnstring
End Property



Public Property Let BillingID(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.BillingID = 5
    mvarBillingID = vData
End Property


Public Property Get BillingID() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.BillingID
    BillingID = mvarBillingID
End Property



Public Property Let TypeOfPager(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.TypeOfPager = 5
    mvarTypeOfPager = vData
End Property


Public Property Get TypeOfPager() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.TypeOfPager
    TypeOfPager = mvarTypeOfPager
End Property



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



Public Property Let From(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.From = 5
    mvarFrom = vData
End Property


Public Property Get From() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.From
    From = mvarFrom
End Property



Public Property Let Number(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Number = 5
    mvarNumber = vData
End Property


Public Property Get Number() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Number
    Number = mvarNumber
End Property

Public Function SendMessage() As Boolean

Dim Billing As Object
Dim sentstring As String
        If mvarTypeOfPager = "152" And Not (socket.Connected) Then
            
            socket.Host = "www.phonelink.net:80"
        
            socket.Open
            sentstring = "POST http://www.phonelink.net/cgi-bin/inetplcgi990601 HTTP/1.1" & vbCrLf & _
                            "Accept: application/msword, application/vnd.ms-powerpoint, image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*" & vbCrLf & _
                            "Referer: http://www.phonelink.net/psnwwwp.shtml" & vbCrLf & _
                            "Accept -Language: th" & vbCrLf & _
                            "Content-Type: application/x-www-form-urlencoded" & vbCrLf & _
                            "Accept -Encoding: gzip , deflate" & vbCrLf & _
                            "User-Agent: Mozilla/4.0 (compatible; MSIE 5.0; Windows NT; DigExt)" & vbCrLf & _
                            "Host: www.phonelink.net" & vbCrLf & _
                            "Content-Length: 36" & vbCrLf & _
                            "Connection: Keep -Alive" & vbCrLf & _
                            "" & vbCrLf & _
                            "cPhone=" & mvarNumber & "&cMesg=" & mvarMessage & "&CHARCOUNT=" & Len(mvarMessage) & vbCrLf
                            
                            socket.SendText sentstring
                            socket.WaitForDisconnect
                            
            mvarreturnstring = socket.Buffer
        End If
        
        If mvarTypeOfPager = "142" And Not (socket.Connected) Then
        
        
        End If
    
        
End Function

