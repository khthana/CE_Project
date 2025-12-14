Attribute VB_Name = "saveDiagram"
Option Explicit


Public Sub saveERdiagram()

    Dim insertETtable As ddoTable
    Dim insertRELtable As ddoTable
    Dim deleteETtable As ddoTable
    Dim i As Integer
    
    Set insertETtable = oDatagroup.CreateVirtualTable()
    Set insertRELtable = oDatagroup.CreateVirtualTable()
    
    insertETtable.InsertCommand = "insert into entityTable values (?,?,?,?,?)"
    insertRELtable.InsertCommand = "insert into relationTable values (?,?,?,?,?,?,?,?,?,?)"
        
    insertETtable.SetParam INSERT_CMD, 1, projectId.id
    For i = 1 To UBound(entityState)
      If entityState(i).Deleted = False Then
        insertETtable.SetParam INSERT_CMD, 2, i
        insertETtable.SetParam INSERT_CMD, 3, entityState(i).name
        insertETtable.SetParam INSERT_CMD, 4, entityState(i).position.X
        insertETtable.SetParam INSERT_CMD, 5, entityState(i).position.Y
            
        oDatagroup.BeginTransaction
        insertETtable.ExecuteCommand INSERT_CMD
        oDatagroup.CommitTransaction
      End If
    Next
    
    insertRELtable.SetParam INSERT_CMD, 1, projectId.id
    For i = 1 To UBound(relationGroupState)
      If relationGroupState(i).Deleted = False Then
        insertRELtable.SetParam INSERT_CMD, 2, i
        insertRELtable.SetParam INSERT_CMD, 3, relationGroupState(i).sourceIndex
        insertRELtable.SetParam INSERT_CMD, 4, relationGroupState(i).destinationIndex
        insertRELtable.SetParam INSERT_CMD, 5, relationGroupState(i).type
        insertRELtable.SetParam INSERT_CMD, 6, relationGroupState(i).relationship
        insertRELtable.SetParam INSERT_CMD, 7, relationGroupState(i).SourcePoint.X
        insertRELtable.SetParam INSERT_CMD, 8, relationGroupState(i).SourcePoint.Y
        insertRELtable.SetParam INSERT_CMD, 9, relationGroupState(i).DestinationPoint.X
        insertRELtable.SetParam INSERT_CMD, 10, relationGroupState(i).DestinationPoint.Y
        
        oDatagroup.BeginTransaction
        insertRELtable.ExecuteCommand INSERT_CMD
        oDatagroup.CommitTransaction
      End If
    Next
     
    'finish saving data
    MsgBox "finish saving ERdiagram"
    isERformSaved = True
    isERformModified = False
    GoTo releaseRES
        
releaseRES:
    oDatagroup.DeleteVirtualTable ("insertETtable")
    oDatagroup.DeleteVirtualTable ("insertRELtable")
End Sub

Public Sub saveThisLevel(findex As Integer, isSubOf As Integer)
    Dim insertDFtable As ddoTable
    Dim insertDStable As ddoTable
    Dim insertEXtable As ddoTable
    Dim insertPCtable As ddoTable
    Dim insertGateTable As ddoTable
    
    Dim i As Integer
    Dim ret As String
    
    If formState(findex).saved = True Then
        If formState(findex).modified = True Then
            GoTo continueSave
        Else:
            Exit Sub
        End If
    End If
    
continueSave:
    Set insertDStable = oDatagroup.CreateVirtualTable()
    insertDStable.InsertCommand = "insert into datastoreTable values (?,?,?,?,?,?)"
    Set insertEXtable = oDatagroup.CreateVirtualTable()
    insertEXtable.InsertCommand = "insert into externalTable values (?,?,?,?,?,?)"
    Set insertPCtable = oDatagroup.CreateVirtualTable()
    insertPCtable.InsertCommand = "insert into processTable values (?,?,?,?,?,?,?)"
    Set insertGateTable = oDatagroup.CreateVirtualTable()
    insertGateTable.InsertCommand = "insert into gateTable values (?,?,?,?,?,?,?,?)"
    Set insertDFtable = oDatagroup.CreateVirtualTable()
    insertDFtable.InsertCommand = "insert into dataflowTable values (?,?,?,?,?,?,?,?,?,?,?,?)"
       
'start insert to datastoreTable
    insertDStable.SetParam INSERT_CMD, 1, projectId.id
    insertDStable.SetParam INSERT_CMD, 2, isSubOf
    '1-projectid    2-subprocess
    '3-id           4-name
    '5-px           6-py
    For i = 1 To UBound(datastoreState)
      If (datastoreState(i).Deleted = False) And (datastoreState(i).isSubOf = isSubOf) Then
        insertDStable.SetParam INSERT_CMD, 3, i
        insertDStable.SetParam INSERT_CMD, 4, datastoreState(i).name
        insertDStable.SetParam INSERT_CMD, 5, datastoreState(i).position.X
        insertDStable.SetParam INSERT_CMD, 6, datastoreState(i).position.Y
        
        oDatagroup.BeginTransaction
        insertDStable.ExecuteCommand INSERT_CMD
        oDatagroup.CommitTransaction
      End If
    Next
    
'start insert to externalTable
    insertEXtable.SetParam INSERT_CMD, 1, projectId.id
    insertEXtable.SetParam INSERT_CMD, 2, isSubOf
    'like DStable
    For i = 1 To UBound(externalState)
      If (externalState(i).Deleted = False) And (externalState(i).isSubOf = isSubOf) Then
        insertEXtable.SetParam INSERT_CMD, 3, i
        insertEXtable.SetParam INSERT_CMD, 4, externalState(i).name
        insertEXtable.SetParam INSERT_CMD, 5, externalState(i).position.X
        insertEXtable.SetParam INSERT_CMD, 6, externalState(i).position.Y
        
        oDatagroup.BeginTransaction
        insertEXtable.ExecuteCommand INSERT_CMD
        oDatagroup.CommitTransaction
      End If
    Next

'start insert to processTable
    insertPCtable.SetParam INSERT_CMD, 1, projectId.id
    insertPCtable.SetParam INSERT_CMD, 2, isSubOf
    'like DStable + 7-description
    For i = 1 To UBound(processState)
      If (processState(i).Deleted = False) And (processState(i).isSubOf = isSubOf) Then
        insertPCtable.SetParam INSERT_CMD, 3, i
        insertPCtable.SetParam INSERT_CMD, 4, processState(i).name
        insertPCtable.SetParam INSERT_CMD, 5, processState(i).position.X
        insertPCtable.SetParam INSERT_CMD, 6, processState(i).position.Y
        insertPCtable.SetParam INSERT_CMD, 7, processState(i).description
        
        oDatagroup.BeginTransaction
        insertPCtable.ExecuteCommand INSERT_CMD
        oDatagroup.CommitTransaction
      End If
    Next
      
'start insert to dataflowTable
    insertDFtable.SetParam INSERT_CMD, 1, projectId.id
    insertDFtable.SetParam INSERT_CMD, 2, isSubOf
    '1-projectid    2-subprocess
    '3-id           4-sourceID
    '5-sourceType   6-destinationID
    '7-destinationType  8-formatdata
    '9-sx           10-sy
    '11-dx          12-dy
    
    For i = 1 To UBound(lineGroupState)
      If (lineGroupState(i).Deleted = False) And (lineGroupState(i).isSubOf = isSubOf) Then
        insertDFtable.SetParam INSERT_CMD, 3, i
        insertDFtable.SetParam INSERT_CMD, 4, lineGroupState(i).sourceID
        insertDFtable.SetParam INSERT_CMD, 5, lineGroupState(i).sourceType
        insertDFtable.SetParam INSERT_CMD, 6, lineGroupState(i).destinationID
        insertDFtable.SetParam INSERT_CMD, 7, lineGroupState(i).destinationType
        insertDFtable.SetParam INSERT_CMD, 8, lineGroupState(i).data
        insertDFtable.SetParam INSERT_CMD, 9, lineGroupState(i).SourcePoint.X
        insertDFtable.SetParam INSERT_CMD, 10, lineGroupState(i).SourcePoint.Y
        insertDFtable.SetParam INSERT_CMD, 11, lineGroupState(i).DestinationPoint.X
        insertDFtable.SetParam INSERT_CMD, 12, lineGroupState(i).DestinationPoint.Y
        
        oDatagroup.BeginTransaction
        insertDFtable.ExecuteCommand INSERT_CMD
        oDatagroup.CommitTransaction
      End If
    Next
          
If isSubOf > 0 Then
'start insert to gateTable
    insertGateTable.SetParam INSERT_CMD, 1, projectId.id
    insertGateTable.SetParam INSERT_CMD, 2, isSubOf
    '1-projectid    2-subprocess
    '3-id           4-dataflow
    '5-flowType     6-formatdata
    '7-px           8-py
    For i = 1 To UBound(gateState)
      If (gateState(i).Deleted = False) And (gateState(i).isSubOf = isSubOf) Then
        insertGateTable.SetParam INSERT_CMD, 3, i
        insertGateTable.SetParam INSERT_CMD, 4, gateState(i).modelIndex
        insertGateTable.SetParam INSERT_CMD, 5, gateState(i).modelTag
        insertGateTable.SetParam INSERT_CMD, 6, gateState(i).modelName
        insertGateTable.SetParam INSERT_CMD, 7, gateState(i).position.X
        insertGateTable.SetParam INSERT_CMD, 8, gateState(i).position.Y
        
        oDatagroup.BeginTransaction
        insertGateTable.ExecuteCommand INSERT_CMD
        oDatagroup.CommitTransaction
      End If
    Next
End If
  
      
    formState(findex).saved = True
    formState(findex).modified = False

exitSub:
    'release resource
    oDatagroup.DeleteVirtualTable ("insertPCtable")
    oDatagroup.DeleteVirtualTable ("insertDStable")
    oDatagroup.DeleteVirtualTable ("insertEXtable")
    oDatagroup.DeleteVirtualTable ("insertGateTable")
    oDatagroup.DeleteVirtualTable ("insertDFtable")
    
End Sub

Public Sub saveToPjTable()
    Dim insertPJtable As ddoTable
    
    Set insertPJtable = oDatagroup.CreateVirtualTable()
    insertPJtable.InsertCommand = "insert into projecttable values (?,?)"
    insertPJtable.SetParam INSERT_CMD, 1, projectId.id
    insertPJtable.SetParam INSERT_CMD, 2, projectId.name
    oDatagroup.BeginTransaction
    insertPJtable.ExecuteCommand INSERT_CMD
    oDatagroup.CommitTransaction
    
    oDatagroup.DeleteVirtualTable ("insertPJtable")
    
End Sub

