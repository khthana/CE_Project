VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Shipment"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit

'local variable(s) to hold property value(s)
Private mvarShipVia As String 'local copy
Private mvarShipCompany As String 'local copy
Private mvarFrieght As Single 'local copy
Private mvarShipPeriod As Integer 'local copy


' -- Method of Ship.Shipment
Public Sub Retrieve()
Dim rs As ADODB.Recordset

On Error GoTo FindError

Set rs = New ADODB.Recordset
rs.CursorLocation = adUseClient
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * from tblShipment", StrConn, , , adCmdText

  mvarShipVia = rs!ShipVia
  mvarShipCompany = rs!ShipCompany
  mvarFrieght = rs!Frieght
  mvarShipPeriod = rs!ShipPeriod

Exit Sub
FindError:
    Err.Raise Err.Number, , Err.Description


End Sub

Public Sub Update()
Dim cn As Connection
Dim rs As Recordset

On Error GoTo UpdateError

Set cn = New ADODB.Connection
cn.ConnectionString = StrConn  ' Public const StrConn in Module shop
cn.CursorLocation = adUseClient
cn.Open

Set rs = New ADODB.Recordset
rs.CursorType = adOpenKeyset
rs.LockType = adLockOptimistic
rs.Open "Select * from tblShipment", cn
  rs!ShipVia = mvarShipVia
  rs!ShipCompany = mvarShipCompany
  rs!Frieght = mvarFrieght
  rs!ShipPeriod = mvarShipPeriod
rs.Update

Exit Sub
UpdateError:
    Err.Raise Err.Number, , Err.Description

End Sub



' -- Property of ship.shipment
Public Property Let ShipPeriod(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipPeriod = 5
    mvarShipPeriod = vData
End Property


Public Property Get ShipPeriod() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipPeriod
    ShipPeriod = mvarShipPeriod
End Property



Public Property Let Frieght(ByVal vData As Single)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Frieght = 5
    mvarFrieght = vData
End Property


Public Property Get Frieght() As Single
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Frieght
    Frieght = mvarFrieght
End Property



Public Property Let ShipCompany(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipCompany = 5
    mvarShipCompany = vData
End Property


Public Property Get ShipCompany() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipCompany
    ShipCompany = mvarShipCompany
End Property



Public Property Let ShipVia(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.ShipVia = 5
    mvarShipVia = vData
End Property


Public Property Get ShipVia() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.ShipVia
    ShipVia = mvarShipVia
End Property



