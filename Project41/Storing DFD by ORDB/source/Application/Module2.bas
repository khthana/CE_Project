Attribute VB_Name = "Module2"
Option Explicit

Public isERformModified As Boolean
Public isDFformModified As Boolean

Public Function isEntityConnect(ByVal Ei As Integer) As Boolean
    Dim i As Integer
    
    isEntityConnect = False
    For i = 1 To UBound(relationGroupState)
        If relationGroupState(i).Deleted = False Then
            If relationGroupState(i).destinationIndex = Ei Then
                isEntityConnect = True
                Exit For
            ElseIf relationGroupState(i).sourceIndex = Ei Then
                isEntityConnect = True
                Exit For
            End If
        End If
    Next
    
End Function

Public Function isCompConnect(ByVal Ci As Integer, Ct As String) As Boolean
    Dim i As Integer
    
    isCompConnect = False
    For i = 1 To UBound(lineGroupState)
        If lineGroupState(i).Deleted = False Then
            If (lineGroupState(i).destinationID = Ci) And (lineGroupState(i).destinationType = Ct) Then
                isCompConnect = True
                Exit For
            ElseIf (lineGroupState(i).sourceID = Ci) And (lineGroupState(i).sourceType = Ct) Then
                isCompConnect = True
                Exit For
            End If
        End If
    Next
End Function

Public Sub deleteRelation(Rgroup As Integer)
    Dim i As Integer
    
    For i = 1 To UBound(relationState)
        If relationState(i).Deleted = False Then
            If relationState(i).group = Rgroup Then
                relationState(i).Deleted = True
                ERform.relation(i).Visible = False
                relationState(i).group = 0
            End If
        End If
    Next
    
    relationGroupState(Rgroup).Deleted = True
    relationGroupState(Rgroup).destinationIndex = 0
    relationGroupState(Rgroup).DestinationPoint.X = 0
    relationGroupState(Rgroup).sourceIndex = 0
    relationGroupState(Rgroup).SourcePoint.X = 0
    
    ERform.tooltipLabel.Visible = False
    ERform.tooltipLabel.Caption = ""
End Sub

Public Sub deleteLine(Lgroup As Integer)
    Dim i As Integer
    
    For i = 1 To UBound(lineState)
        If lineState(i).Deleted = False Then
            If lineState(i).group = Lgroup Then
                lineState(i).Deleted = True
                formArray(CInt(choseItem.ofForm.tag)).flowLine(i).Visible = False
                lineState(i).group = 0
            End If
        End If
    Next
    
    lineGroupState(Lgroup).Deleted = True
    lineGroupState(Lgroup).destinationID = 0
    lineGroupState(Lgroup).DestinationPoint.X = 0
    lineGroupState(Lgroup).sourceID = 0
    lineGroupState(Lgroup).SourcePoint.X = 0
    
    formArray(CInt(choseItem.ofForm.tag)).tooltipLabel.Visible = False
    formArray(CInt(choseItem.ofForm.tag)).tooltipLabel.Caption = ""
End Sub

Public Sub clearExistingER()
    Dim deleteERtable As ddoTable
    Dim deleteRELtable As ddoTable
    
    Set deleteERtable = oDatagroup.CreateVirtualTable()
    Set deleteRELtable = oDatagroup.CreateVirtualTable()
    
    deleteERtable.DeleteCommand = "delete from entityTable where projectId=?"
    deleteRELtable.DeleteCommand = "delete from relationTable where projectId=?"
    
    deleteERtable.SetParam DELETE_CMD, 1, projectId.id
    deleteRELtable.SetParam DELETE_CMD, 1, projectId.id
    
    
    oDatagroup.BeginTransaction
    deleteRELtable.ExecuteCommand DELETE_CMD
    deleteERtable.ExecuteCommand DELETE_CMD
    oDatagroup.CommitTransaction
    
    
    oDatagroup.DeleteVirtualTable ("deleteERtable")
    oDatagroup.DeleteVirtualTable ("deleteRELtable")
End Sub

Public Function CanDeleteLine(LGi As Integer) As String
    Dim i As Integer
    
    CanDeleteLine = "Y"
    
    If lineGroupState(LGi).sourceType = "P" Then
        If processState(lineGroupState(LGi).sourceID).haveSub = True Then
            CanDeleteLine = "you have to delete subprocess of P" & lineGroupState(LGi).sourceID & " before."
            Exit Function
        End If
    ElseIf lineGroupState(LGi).destinationType = "P" Then
        If processState(lineGroupState(LGi).destinationID).haveSub = True Then
            CanDeleteLine = "you have to delete subprocess of P" & lineGroupState(LGi).destinationID & " before."
            Exit Function
        End If
    End If
    
End Function

Public Sub deleteSub(subP As Integer)
    
    Dim i As Integer
    Dim j As Integer
    Dim Fi As Integer
    
    For i = 1 To UBound(formState)
        If formState(i).Deleted = False Then
            If formState(i).isSubOf = subP Then
                Fi = i
                Exit For
            End If
        End If
    Next
    
    formState(Fi).Deleted = True
    formState(Fi).isSubOf = 0
    Unload formArray(Fi)
    
    For i = 1 To UBound(processState)
        If processState(i).Deleted = False Then
            If processState(i).isSubOf = subP Then
                processState(i).Deleted = True
            End If
        End If
    Next
        
    For i = 1 To UBound(datastoreState)
        If datastoreState(i).Deleted = False Then
            If datastoreState(i).isSubOf = subP Then
                datastoreState(i).Deleted = True
            End If
        End If
    Next
    
    For i = 1 To UBound(externalState)
        If externalState(i).Deleted = False Then
            If externalState(i).isSubOf = subP Then
                externalState(i).Deleted = True
            End If
        End If
    Next
    
    For i = 1 To UBound(gateState)
        If gateState(i).Deleted = False Then
            If gateState(i).isSubOf = subP Then
                gateState(i).Deleted = True
            End If
        End If
    Next
    
    For i = 1 To UBound(lineGroupState)
        If lineGroupState(i).Deleted = False Then
            If lineGroupState(i).isSubOf = subP Then
                For j = 1 To UBound(lineState)
                    If lineState(j).Deleted = False Then
                        If lineState(j).group = i Then
                            lineState(j).Deleted = True
                            lineState(j).group = 0
                        End If
                    End If
                Next
    
                lineGroupState(i).Deleted = True
                lineGroupState(i).destinationID = 0
                lineGroupState(i).DestinationPoint.X = 0
                lineGroupState(i).sourceID = 0
                lineGroupState(i).SourcePoint.X = 0
                
            End If
        End If
    Next
    
    If formState(Fi).saved = True Then
        Call deleteSubFromDB(subP)
    End If
    
    MsgBox "finish deleting subProcess"
End Sub

Public Function isThereAnotherSub(subP As Integer) As Boolean
    Dim i As Integer
    
    isThereAnotherSub = False
    For i = 1 To UBound(processState)
        If processState(i).Deleted = False Then
            If processState(i).isSubOf = subP Then
                If processState(i).haveSub = True Then
                    isThereAnotherSub = True
                    Exit Function
                End If
            End If
        End If
    Next
End Function

Public Sub deleteSubFromDB(subP As Integer)
    Dim deleteDStable As ddoTable
    Dim deleteEXtable As ddoTable
    Dim deletePCtable As ddoTable
    Dim deleteGtable As ddoTable
    Dim deleteDFtable As ddoTable
    
        Set deletePCtable = oDatagroup.CreateVirtualTable()
        Set deleteDStable = oDatagroup.CreateVirtualTable()
        Set deleteEXtable = oDatagroup.CreateVirtualTable()
        Set deleteGtable = oDatagroup.CreateVirtualTable()
        Set deleteDFtable = oDatagroup.CreateVirtualTable()
        
        deletePCtable.DeleteCommand = "delete from processTable where (projectId=?)and(subprocess=?)"
        deletePCtable.SetParam DELETE_CMD, 1, projectId.id
        deletePCtable.SetParam DELETE_CMD, 2, subP
        
        deleteDStable.DeleteCommand = "delete from datastoreTable where (projectId=?)and(subprocess=?)"
        deleteDStable.SetParam DELETE_CMD, 1, projectId.id
        deleteDStable.SetParam DELETE_CMD, 2, subP
        
        deleteEXtable.DeleteCommand = "delete from externalTable where (projectId=?)and(subprocess=?)"
        deleteEXtable.SetParam DELETE_CMD, 1, projectId.id
        deleteEXtable.SetParam DELETE_CMD, 2, subP
        
        deleteGtable.DeleteCommand = "delete from gateTable where (projectId=?)and(subprocess=?)"
        deleteGtable.SetParam DELETE_CMD, 1, projectId.id
        deleteGtable.SetParam DELETE_CMD, 2, subP
        
        deleteDFtable.DeleteCommand = "delete from dataflowTable where (projectId=?)and(subprocess=?)"
        deleteDFtable.SetParam DELETE_CMD, 1, projectId.id
        deleteDFtable.SetParam DELETE_CMD, 2, subP
        
        oDatagroup.BeginTransaction
        deletePCtable.ExecuteCommand DELETE_CMD
        deleteDStable.ExecuteCommand DELETE_CMD
        deleteEXtable.ExecuteCommand DELETE_CMD
        deleteGtable.ExecuteCommand DELETE_CMD
        deleteDFtable.ExecuteCommand DELETE_CMD
        oDatagroup.CommitTransaction
        
        
        
        oDatagroup.DeleteVirtualTable ("deletePCtable")
        oDatagroup.DeleteVirtualTable ("deleteDStable")
        oDatagroup.DeleteVirtualTable ("deleteEXtable")
        oDatagroup.DeleteVirtualTable ("deleteGtable")
        oDatagroup.DeleteVirtualTable ("deleteDFtable")
End Sub

Public Function checkDFmatch(subP As Integer) As String
    Dim checkLevel As ddoTable
    Dim ret As String
    
    If subP > 0 Then
        Set checkLevel = oDatagroup.CreateVirtualTable()
        checkLevel.QueryCommand = "{call newFlow10(?,?)}"
        checkLevel.SetParam QUERY_CMD, 1, projectId.id
        checkLevel.SetParam QUERY_CMD, 2, subP
   
        oDatagroup.BeginTransaction
        checkLevel.ExecuteCommand QUERY_CMD
        oDatagroup.CommitTransaction
        
        ret = checkLevel.Columns(1).Value
   End If
   checkDFmatch = ret
   oDatagroup.DeleteVirtualTable ("checkLevel")
   
End Function

Public Function search_Gindex(Gid As Integer) As Integer
    Dim i As Integer
    Dim mId_temp As Integer
    Dim mType_temp As String
    Dim matchGid As Integer
    Dim GMt As String
    
    GMt = gateState(Gid).modelTag
    mId_temp = gateState(Gid).modelIndex
    mType_temp = GMt
    
    If (GMt = "P") Or (GMt = "E") Or (GMt = "D") Then
        search_Gindex = mId_temp
        Exit Function
    
    ElseIf (GMt = "GP") Or (GMt = "GE") Or (GMt = "GD") Then
        
        Do Until (mType_temp = "P") Or (mType_temp = "E") Or (mType_temp = "D")
            
            For i = 1 To UBound(gateState)
                If gateState(i).Deleted = False Then
                    If (i = mId_temp) Then
                        mType_temp = gateState(i).modelTag
                        Exit For
                    End If
                End If
            Next
            mId_temp = gateState(i).modelIndex
        Loop
        
        search_Gindex = mId_temp
    End If
End Function
