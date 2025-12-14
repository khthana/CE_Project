VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "Cwave"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = True
Attribute VB_Ext_KEY = "SavedWithClassBuilder6" ,"Yes"
Attribute VB_Ext_KEY = "Top_Level" ,"Yes"
Option Explicit
Dim TTs As New ACTIVEVOICEPROJECTLib.DirectSS


'local variable(s) to hold property value(s)
Private mvarCText As String 'local copy
'For store wav files
Private mvarIdFilename_in As String 'local copy

Private mvarIdAsffile As String
'local variable(s) to hold property value(s)
Private mvarGender As Integer 'local copy

'local variable(s) to hold property value(s)
Public Property Let Idasffile(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Gender = 5
    mvarIdAsffile = vData
End Property

Public Property Get Idasffile() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Gender
    Idasffile = mvarIdAsffile
End Property

Public Property Let Gender(ByVal vData As Integer)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Gender = 5
    mvarGender = vData
End Property

Public Property Get Gender() As Integer
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Gender
    Gender = mvarGender
End Property

Public Function Convert() As Boolean
Dim status As Boolean
Dim CommandString As String
Dim i, j, k As Integer ' for count for delay
On Error GoTo errorconvert
    TTs.FileName = mvarIdFilename_in
    'TTs.FileName = "D:\asfroot\" & mvarIdFilename_in 'If save to file fill path_name and file name
                                 'unless don't fill anything for speak tp speaker
    'For female Gender =1 For male Gender =2
    If mvarGender = 1 Then
        TTs.Select (TTs.Find("Mfg=Microsoft;Gender=1"))
    Else
        TTs.Select (TTs.Find("Mfg=Microsoft;Gender=2"))
    End If
    TTs.Speak Me.CText
    Convert = True
    Exit Function
errorconvert:
     Convert = False
     
    
    '----You must do with convert Wav file to ASF File use command line----------
    ' Specifying 1 as the second argument opens the application in
    ' normal size and gives it the focus.
End Function
Public Function converttoasf(ByVal Cmdstring As String) As Boolean
Dim RetVal
    RetVal = Shell(Cmdstring, 0)
   'Check For Error
    If RetVal = 0 Then
        converttoasf = False 'For error
    Else
        converttoasf = True 'For Succcessful
    End If
    

End Function
Public Property Let IdFilename_in(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.Path_name = 5
    mvarIdFilename_in = vData
End Property

Public Property Get IdFilename_in() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.Path_name
    IdFilename_in = mvarIdFilename_in
    
End Property

Public Property Let CText(ByVal vData As String)
'used when assigning a value to the property, on the left side of an assignment.
'Syntax: X.CText = 5
    mvarCText = vData
End Property

Public Property Get CText() As String
'used when retrieving value of a property, on the right side of an assignment.
'Syntax: Debug.Print X.CText
    CText = mvarCText
End Property

Private Sub Class_Initialize()
'    Set TTs = CreateObject("ACTIVEVOICEPROJECTLib.DirectSS")
    TTs.Initialized = 1 ' For automatic Initialize
    
    
End Sub
