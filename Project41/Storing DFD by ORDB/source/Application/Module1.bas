Attribute VB_Name = "Module1"
Option Explicit

'----------------------
' Declare public Type
'----------------------
Public Type point
    X As Single
    Y As Single
End Type

Public Type LineStatus
    Deleted As Boolean
    Color As ColorConstants
    group As Integer
    isSubOf As Integer
    loaded As Boolean
End Type

Public Type entityStatus
    Deleted As Boolean
    loaded As Boolean
    name As String
    position As point
End Type

Public Type componentStatus
    Deleted As Boolean
    isSubOf As Integer
    loaded As Boolean
    name As String
    position As point
End Type

Public Type processStatus
    Deleted As Boolean
    isSubOf As Integer
    loaded As Boolean
    name As String
    description As String
    position As point
    haveSub As Boolean
End Type

Public Type gateStatus
    Deleted As Boolean
    isSubOf As Integer
    loaded As Boolean
    position As point
    modelIndex As Integer
    modelName As String
    modelTag As String
End Type

Public Type formStatus
    Deleted As Boolean
    isSubOf As Integer
    saved As Boolean
    modified As Boolean
End Type

Public Type lineGroupStatus
    Deleted As Boolean
    isSubOf As Integer
    sourceID As Integer
    sourceType As String
    destinationID As Integer
    destinationType As String
    data As String
    SourcePoint As point
    DestinationPoint As point
End Type

Public Type relationGroupStatus
    Deleted As Boolean
    sourceIndex As Integer
    destinationIndex As Integer
    type As String
    SourcePoint As point
    DestinationPoint As point
    relationship As String
End Type

Public Type choseItemType
    tag As String
    Index As Integer
    ofForm As Form1
End Type

Public Type projectIdType
    id As Integer
    name As String
End Type
'----------------------
' Declare public Constant
'----------------------
Public Const processPic = "c:\som\GIFtransparent\pro90.gif"
Public Const datastorePic = "c:\som\GIFtransparent\sto114.gif"
Public Const externalPic = "c:\som\GIFtransparent\ext.gif"
Public Const White = &H80000005
Public Const Grey = &H80000004
Public Const Red = &HFF&
Public Const Black = &H80000007
Public Const lightGreen = &HC0FFC0
Public Const Green = &H80000001

'datagroup
Public Const DGname = "DGm1903"
Public Const ModelPath = "c:\som\application\m1903.mlt"


'--------------------
' Declare public variables
'--------------------
Public dbClickedProcess As Integer

'for popping up menu "delete","propreties"
Public choseItem As choseItemType

Public lineState() As LineStatus
Public processState() As processStatus
Public datastoreState() As componentStatus
Public externalState() As componentStatus
Public lineGroupState() As lineGroupStatus
Public formState() As formStatus
Public gateState() As gateStatus
Public entityState() As entityStatus
Public relationGroupState() As relationGroupStatus
Public relationState() As LineStatus

Public formArray() As Form1
Public ERform As Form2
Public formQueue As New Collection
'---------------------------------------
'Declare Variable for connecting to DB
'---------------------------------------
Public oEngine As ddoEngine
Public oDatagroup As ddoDataGroup

Public createDiagramType As String
Public isERformSaved As Boolean
Public isERformLoaded As Boolean
Public projectId As projectIdType

Function FindFreeIndex(ByVal Thing As String) As Integer
    
    ' Cycle through the Array array. If one of the
    ' Arrays has been deleted, then return that index.
    

    ' If none of the elements in the Array have
    ' been deleted, then increment the Array and the
    ' state arrays by one and return the index to the
    ' new element.
    
    Dim i As Integer
    Dim ArrayCount As Integer
    
    Select Case Thing
    Case "line"
        ArrayCount = UBound(lineState)
        For i = 1 To ArrayCount
            If (lineState(i).Deleted = True) And (lineState(i).loaded = False) Then
                FindFreeIndex = i
                Exit Function
            End If
        Next
        ReDim Preserve lineState(ArrayCount + 1)
        FindFreeIndex = UBound(lineState)
        
    Case "relation"
        ArrayCount = UBound(relationState)
        For i = 1 To ArrayCount
            If (relationState(i).Deleted) And (relationState(i).loaded = False) Then
                FindFreeIndex = i
                Exit Function
            End If
        Next
        ReDim Preserve relationState(ArrayCount + 1)
        FindFreeIndex = UBound(relationState)
        
    Case "process"
        ArrayCount = UBound(processState)
        For i = 1 To ArrayCount
            If (processState(i).Deleted = True) And (processState(i).loaded = False) Then
                FindFreeIndex = i
                Exit Function
            End If
        Next
        ReDim Preserve processState(ArrayCount + 1)
        FindFreeIndex = UBound(processState)
    
    Case "datastore"
        ArrayCount = UBound(datastoreState)
        For i = 1 To ArrayCount
            If (datastoreState(i).Deleted = True) And (datastoreState(i).loaded = False) Then
                FindFreeIndex = i
                Exit Function
            End If
        Next
        ReDim Preserve datastoreState(ArrayCount + 1)
        FindFreeIndex = UBound(datastoreState)
    
    Case "external"
        ArrayCount = UBound(externalState)
        For i = 1 To ArrayCount
            If (externalState(i).Deleted = True) And (externalState(i).loaded = False) Then
                FindFreeIndex = i
                Exit Function
            End If
        Next
        ReDim Preserve externalState(ArrayCount + 1)
        FindFreeIndex = UBound(externalState)
        
    Case "gate"
        ArrayCount = UBound(gateState)
        For i = 1 To ArrayCount
            If (gateState(i).Deleted = True) And (gateState(i).loaded = False) Then
                FindFreeIndex = i
                Exit Function
            End If
        Next
        ReDim Preserve gateState(ArrayCount + 1)
        FindFreeIndex = UBound(gateState)
    
    Case "entity"
        ArrayCount = UBound(entityState)
        For i = 1 To ArrayCount
            If (entityState(i).Deleted) And (entityState(i).loaded = False) Then
                FindFreeIndex = i
                Exit Function
            End If
        Next
        ReDim Preserve entityState(ArrayCount + 1)
        FindFreeIndex = UBound(entityState)
    
    Case "linegroup"
        ArrayCount = UBound(lineGroupState)
        For i = 1 To ArrayCount
            If lineGroupState(i).Deleted Then
                FindFreeIndex = i
                
                Exit Function
            End If
        Next
        ReDim Preserve lineGroupState(ArrayCount + 1)
        FindFreeIndex = UBound(lineGroupState)
        
    Case "relationGroup"
        ArrayCount = UBound(relationGroupState)
        For i = 1 To ArrayCount
            If relationGroupState(i).Deleted Then
                FindFreeIndex = i
                
                Exit Function
            End If
        Next
        ReDim Preserve relationGroupState(ArrayCount + 1)
        FindFreeIndex = UBound(relationGroupState)
        
    Case "form"
        ArrayCount = UBound(formArray)
        For i = 1 To ArrayCount
            If formState(i).Deleted Then
                FindFreeIndex = i
                
                Exit Function
            End If
        Next
        ReDim Preserve formState(ArrayCount + 1)
        ReDim Preserve formArray(ArrayCount + 1)
        FindFreeIndex = UBound(formState)
    End Select
    
End Function

Public Function askYesNo(TTs As String, TPs As String) As String
    
    Dim response As String
    Dim Style As VbMsgBoxStyle
    
    Style = vbYesNo + vbQuestion + vbDefaultButton1
    response = MsgBox(TPs, Style, TTs, "", 0)

    If response = vbYes Then askYesNo = "Y"
    If response = vbNo Then askYesNo = "N"
    
End Function

Public Sub InitializeConnect()
    
    Set oEngine = CreateObject("DataDirector.Engine")
    Set oDatagroup = oEngine.CurrentProject.CreateDataGroup("projecttable", DGname, ModelPath)
    
    oDatagroup.DisableErrorReporting DATABASE_ERROR
    oDatagroup.Logon "informix", "dataflow"

End Sub

Public Sub Disconnect()
        
    oDatagroup.Logoff
    Set oDatagroup = Nothing
    Set oEngine = Nothing
    
End Sub

Public Function isThisLevelComplete(Fi As Integer) As Boolean
    Dim complete As Boolean
    Dim Ccount As Integer
    Dim Lcount As Integer
    
    complete = False
   
    If UBound(lineGroupState) <= 0 Then
        isThisLevelComplete = False
        Exit Function
    ElseIf (UBound(lineGroupState) = 1) And (lineGroupState(1).Deleted = True) Then
        isThisLevelComplete = False
        Exit Function
    End If
    
    
'check all datastore are linked
    For Ccount = 1 To UBound(datastoreState)
        If (datastoreState(Ccount).Deleted = False) And (datastoreState(Ccount).isSubOf = formState(Fi).isSubOf) Then
            complete = False
    
            For Lcount = 1 To UBound(lineGroupState)
                If (lineGroupState(Lcount).destinationType = "D") Or (lineGroupState(Lcount).sourceType = "D") Then
                    If (Ccount = lineGroupState(Lcount).destinationID) Then
                        complete = True
                        GoTo checkNext1
                    End If
                    If (Ccount = lineGroupState(Lcount).sourceID) Then
                        complete = True
                        GoTo checkNext1
                    End If
                End If
            Next
            
checkNext1:
            If complete = False Then
                isThisLevelComplete = False
                Exit Function
            End If
        End If
    Next
    

'check all externalstore are linked
    For Ccount = 1 To UBound(externalState)
        If (externalState(Ccount).Deleted = False) And (externalState(Ccount).isSubOf = formState(Fi).isSubOf) Then
            complete = False
    
            For Lcount = 1 To UBound(lineGroupState)
                If (lineGroupState(Lcount).destinationType = "E") Or (lineGroupState(Lcount).sourceType = "E") Then
                    If (Ccount = lineGroupState(Lcount).destinationID) Then
                        complete = True
                        GoTo checkNext2
                    End If
                    If (Ccount = lineGroupState(Lcount).sourceID) Then
                        complete = True
                        GoTo checkNext2
                    End If
                End If
            Next
checkNext2:
            If complete = False Then
                isThisLevelComplete = False
                Exit Function
            End If
        End If
    Next
    
'check all process are linked
    For Ccount = 1 To UBound(processState)
        If (processState(Ccount).Deleted = False) And (processState(Ccount).isSubOf = formState(Fi).isSubOf) Then
            complete = False
    
            For Lcount = 1 To UBound(lineGroupState)
                If (lineGroupState(Lcount).destinationType = "P") Or (lineGroupState(Lcount).sourceType = "P") Then
                    If (Ccount = lineGroupState(Lcount).destinationID) Then
                        complete = True
                        GoTo checkNext3
                    End If
                    If (Ccount = lineGroupState(Lcount).sourceID) Then
                        complete = True
                        GoTo checkNext3
                    End If
                End If
            Next
checkNext3:
            If complete = False Then
                isThisLevelComplete = False
                Exit Function
            End If
        End If
    Next
    
    'check all gate are linked
    For Ccount = 1 To UBound(gateState)
        If (gateState(Ccount).Deleted = False) And (gateState(Ccount).isSubOf = formState(Fi).isSubOf) Then
            complete = False
    
            For Lcount = 1 To UBound(lineGroupState)
                If (gateState(Ccount).modelTag = "P") Or (gateState(Ccount).modelTag = "GP") Then
                    If (lineGroupState(Lcount).destinationType = "GP") Or (lineGroupState(Lcount).sourceType = "GP") Then
                        If (Ccount = lineGroupState(Lcount).destinationID) Then
                            complete = True
                            GoTo checkNext4
                        End If
                        If (Ccount = lineGroupState(Lcount).sourceID) Then
                            complete = True
                            GoTo checkNext4
                        End If
                    End If
                End If
                
                If (gateState(Ccount).modelTag = "E") Or (gateState(Ccount).modelTag = "GE") Then
                    If (lineGroupState(Lcount).destinationType = "GE") Or (lineGroupState(Lcount).sourceType = "GE") Then
                        If (Ccount = lineGroupState(Lcount).destinationID) Then
                            complete = True
                            GoTo checkNext4
                        End If
                        If (Ccount = lineGroupState(Lcount).sourceID) Then
                            complete = True
                            GoTo checkNext4
                        End If
                    End If
                End If
                
                If (gateState(Ccount).modelTag = "D") Or (gateState(Ccount).modelTag = "GD") Then
                    If (lineGroupState(Lcount).destinationType = "GD") Or (lineGroupState(Lcount).sourceType = "GD") Then
                        If (Ccount = lineGroupState(Lcount).destinationID) Then
                            complete = True
                            GoTo checkNext4
                        End If
                        If (Ccount = lineGroupState(Lcount).sourceID) Then
                            complete = True
                            GoTo checkNext4
                        End If
                    End If
                End If
         
            Next
            
checkNext4:
            If complete = False Then
                isThisLevelComplete = False
                Exit Function
            End If
        End If
    Next
    
    isThisLevelComplete = True

End Function

Public Sub emptyQueue()
    Dim i As Integer
    If formQueue.Count > 0 Then
        For i = formQueue.Count To 1 Step i - 1
            formQueue.Remove (i)
        Next
    End If
End Sub

Public Function popQueue() As Integer
    If formQueue.Count > 0 Then
        popQueue = formQueue.item(formQueue.Count)
        formQueue.Remove (formQueue.Count)
    Else
        popQueue = 0
    End If
End Function

Public Sub pushQueue(item As Integer)
    formQueue.Add item
End Sub

Public Sub init_MDIform()
     
    MDIForm1.menuViewDFdiagram.Enabled = False
    MDIForm1.menuViewERdiagram.Enabled = False
   
    projectId.id = 0
    createDiagramType = ""
    isERformSaved = False
    isERformLoaded = False
        
    ReDim lineState(1)
    lineState(1).Deleted = True
    lineState(1).Color = Black
    
    ReDim processState(1)
    processState(1).Deleted = True

    ReDim datastoreState(1)
    datastoreState(1).Deleted = True

    ReDim externalState(1)
    externalState(1).Deleted = True
    
    ReDim gateState(1)
    gateState(1).Deleted = True
    
    ReDim lineGroupState(1)
    lineGroupState(1).Deleted = True
    
    ReDim formState(1)
    ReDim formArray(1)
    formState(1).Deleted = True

End Sub

Public Sub init_ERform()
        
    isERformModified = False
    isERformSaved = False
    
    ReDim entityState(1)
    entityState(1).Deleted = True
    
    ReDim relationState(1)
    relationState(1).Deleted = True
    relationState(1).Color = Black
    
    ReDim relationGroupState(1)
    relationGroupState(1).Deleted = True
End Sub

Public Sub createDF()
        
    Dim findex As Integer
    
    findex = FindFreeIndex("form")
    Set formArray(findex) = New Form1
    formArray(findex).Caption = "Design Form"
    formArray(findex).Visible = True
    formArray(findex).tag = findex
        
    formState(findex).Deleted = False
    formState(findex).isSubOf = 0

End Sub


Public Sub createER()
    Set ERform = New Form2
    ERform.Caption = "ER Design"
    ERform.tag = "ERform"
    isERformLoaded = True
End Sub

Public Sub clearAllForm()
    Dim i As Integer
    
    If UBound(formArray) > 0 Then
        If formState(1).Deleted = False Then
            For i = 1 To UBound(formArray)
                Unload formArray(i)
                Set formArray(i) = Nothing
            Next
        End If
    End If
    
    If isERformLoaded = True Then
        Unload ERform
        Set ERform = Nothing
    End If
    
    Call init_MDIform
    Call init_ERform
    
End Sub

Public Function isERformComplete()
    Dim complete As Boolean
    Dim Ccount As Integer
    Dim Lcount As Integer
   
    complete = False
   
    If UBound(relationGroupState) <= 0 Then
        isERformComplete = False
        Exit Function
    ElseIf (UBound(relationGroupState) = 1) And (relationGroupState(1).Deleted = True) Then
        isERformComplete = False
        Exit Function
    End If
    
    'check all EntityBox are linked
    For Ccount = 1 To UBound(entityState)
        If (entityState(Ccount).Deleted = False) Then
            complete = False
            For Lcount = 1 To UBound(relationGroupState)
                If (relationGroupState(Lcount).destinationIndex) Then
                    If (Ccount = relationGroupState(Lcount).destinationIndex) Then
                        complete = True
                        Exit For
                    End If
                    If (Ccount = relationGroupState(Lcount).sourceIndex) Then
                        complete = True
                        Exit For
                    End If
                End If
            Next
            
            If complete = False Then
                isERformComplete = False
                Exit Function
            End If
        End If
    Next
    
    
    isERformComplete = True
End Function

Public Function referencedByGate(Ci As Integer, Ct As String)
    Dim i As Integer
    
    referencedByGate = False
    If UBound(gateState) = 0 Then
        referencedByGate = False
        Exit Function
    ElseIf (UBound(gateState) = 1) And (gateState(1).Deleted = True) Then
            referencedByGate = False
            Exit Function
    End If
    
    If UBound(gateState) >= 1 Then
        For i = 1 To UBound(gateState)
            If gateState(i).Deleted = False Then
                If (gateState(i).modelIndex = Ci) And (gateState(i).modelTag = Ct) Then
                    GoTo setTrue
                End If
            End If
        Next
    End If
    Exit Function
    
setTrue:
    referencedByGate = True
    
End Function
