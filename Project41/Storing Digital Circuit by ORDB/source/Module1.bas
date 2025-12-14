Attribute VB_Name = "Module1"
Option Base 1

Public Type gate
    gateType As String
    posx As Integer
    posy As Integer
    inputlist(1 To 10) As Integer
    nInput As Integer
    outputlist(1 To 10) As Integer
    nOutput As Integer
    linkLayout As Integer
End Type

Public Type Wired
    gatelist(1 To 10) As Integer
    ngate As Integer
    wiredtype As String
End Type

Public Type group
    name As Integer
    number As Integer
End Type

Public gates() As gate
Public wireds() As Wired
Public oEngine As ddoEngine
Public oDatagroup As ddoDataGroup
Public gateCount As Integer
Public wiredCount As Integer
Public lineCount As Integer
Public pid As String
Public lid As Integer

Public Sub initConnect()
    
    Set oEngine = CreateObject("DataDirector.Engine")
    Set oDatagroup = oEngine.CurrentProject.CreateDataGroup("proj_layout", "gategroup", "E:\informix\sql\gatemodel.mlt")
    oDatagroup.AutoCommit = True
    oDatagroup.Logon "informix", "informix"
    
End Sub

Public Sub disconnect()
    oDatagroup.Logoff
    Set oDatagroup = Nothing
    Set oEngine = Nothing
End Sub

Public Sub saveModel()
    Dim oInitlayout As ddoTable
    Dim oGetwid As ddoTable
    Dim oGetlid As ddoTable
    Dim oInsertlid As ddoTable
    Dim i As Integer
    Dim j As Integer
    Dim inlist As String
    Dim outlist As String
    Dim temp As Integer
    
    saveInOutSystem
    For i = 1 To wiredCount
        If wireds(i).wiredtype = "" Then
            wireds(i).wiredtype = "N"
        End If
    Next i
    Set oGetlid = oDatagroup.CreateVirtualTable
    oGetlid.QueryCommand = "select lid,newcomp from proj_layout where pid = '" + pid + "'"
    oGetlid.ExecuteCommand QUERY_CMD
    If oGetlid.TotalRecordCount = 0 Then
        oGetlid.QueryCommand = "select max(lid) from proj_layout"
        oGetlid.ExecuteCommand QUERY_CMD
        If oGetlid.Columns(1) = "" Then
            lid = 1
        Else
            lid = oGetlid.Columns(1).Value + 1
        End If
        Set oInsertlid = oDatagroup.CreateVirtualTable
        oInsertlid.InsertCommand = "insert into proj_layout values('" + pid + "',?,'N')"
        oInsertlid.SetParam INSERT_CMD, 1, lid
        oInsertlid.ExecuteCommand INSERT_CMD
        oDatagroup.DeleteVirtualTable (oInsertlid.name)
    Else
        lid = oGetlid.Columns(1).Value
        If oGetlid.Columns(2).Value = "Y" Then
            MsgBox "can't save as exist new component"
            oDatagroup.DeleteVirtualTable (oGetlid.name)
            Set oGetlid = Nothing
            Exit Sub
        End If
    End If
    oDatagroup.DeleteVirtualTable (oGetlid.name)
    Set oGetlid = Nothing
    Set oGetlid = oDatagroup.CreateVirtualTable
    oGetlid.QueryCommand = "{call clearlayout(?)}"
    oGetlid.SetParam QUERY_CMD, 1, lid
    oGetlid.ExecuteCommand QUERY_CMD
    oDatagroup.DeleteVirtualTable (oGetlid.name)
    Set oGetlid = Nothing
    Set oInsertlid = Nothing
    Set oInitlayout = oDatagroup.CreateVirtualTable
    oInitlayout.QueryCommand = "{call initlayout(?,?)}"
    oInitlayout.SetParam QUERY_CMD, 1, gateCount
    oInitlayout.SetParam QUERY_CMD, 2, lid
    oInitlayout.ExecuteCommand QUERY_CMD
    oInitlayout.QueryCommand = "{call initwired(?)}"
    oInitlayout.SetParam QUERY_CMD, 1, wiredCount
    oInitlayout.ExecuteCommand QUERY_CMD
    oDatagroup.DeleteVirtualTable (oInitlayout.name)
    Set oInitlayout = Nothing
    oDatagroup.Logoff
    oDatagroup.Logon
    Set oGetwid = oDatagroup.CreateVirtualTable
    oGetwid.QueryCommand = "{call getnewwid(?)}"
    Set oInitlayout = oDatagroup.CreateVirtualTable
    oInitlayout.QueryCommand = "{call getgidorder(?,?)}"
    oInitlayout.SetParam QUERY_CMD, 2, lid
    oInitlayout.UpdateCommand = "update layout set(pos_x,pos_y) = (?,?) where gid = ?"
    For i = 1 To gateCount
        oInitlayout.SetParam QUERY_CMD, 1, i
        oInitlayout.SetParam UPDATE_CMD, 1, gates(i).posx
        oInitlayout.SetParam UPDATE_CMD, 2, gates(i).posy
        oInitlayout.ExecuteCommand QUERY_CMD
        oInitlayout.SetParam UPDATE_CMD, 3, oInitlayout.Columns(1).Value
        oInitlayout.ExecuteCommand UPDATE_CMD
        If gates(i).nInput = 0 Then
            inlist = "null"
        Else
            inlist = "'list{"
            For j = 1 To gates(i).nInput
                oGetwid.SetParam QUERY_CMD, 1, gates(i).inputlist(j)
                oGetwid.ExecuteCommand QUERY_CMD
                inlist = inlist + CStr(oGetwid.Columns(1))
                If j < gates(i).nInput Then
                    inlist = inlist + ","
                End If
            Next j
            inlist = inlist + "}'"
        End If
        If gates(i).nOutput = 0 Then
            outlist = "null"
        Else
            outlist = "'list{"
            For j = 1 To gates(i).nOutput
                oGetwid.SetParam QUERY_CMD, 1, gates(i).outputlist(j)
                oGetwid.ExecuteCommand QUERY_CMD
                outlist = outlist + CStr(oGetwid.Columns(1))
                If j < gates(i).nOutput Then
                    outlist = outlist + ","
                End If
            Next j
            outlist = outlist + "}'"
        End If
        If gates(i).gateType <> "new" Then
            oInitlayout.InsertCommand = "insert into " + gates(i).gateType + "gate values(?," + inlist + "," + outlist + ")"
            oInitlayout.SetParam INSERT_CMD, 1, oInitlayout.Columns(1).Value
            oInitlayout.ExecuteCommand INSERT_CMD
        Else
            oInitlayout.InsertCommand = "insert into " + gates(i).gateType + "gate values(?," + inlist + "," + outlist + ",?)"
            oInitlayout.SetParam INSERT_CMD, 1, oInitlayout.Columns(1).Value
            oInitlayout.SetParam INSERT_CMD, 2, gates(i).linkLayout
            oInitlayout.ExecuteCommand INSERT_CMD
        End If
    Next i
    oDatagroup.DeleteVirtualTable (oGetwid.name)
    Set oGetwid = Nothing
    Set oGetwid = oDatagroup.CreateVirtualTable
    oGetwid.QueryCommand = "{call getwidorder(?,?)}"
    oGetwid.SetParam QUERY_CMD, 2, lid
    For i = 1 To wiredCount
            If wireds(i).ngate = 0 Then
                inlist = "null"
            Else
                inlist = "'list{"
                For j = 1 To wireds(i).ngate
                    oInitlayout.SetParam QUERY_CMD, 1, wireds(i).gatelist(j)
                    oInitlayout.ExecuteCommand QUERY_CMD
                    inlist = inlist + CStr(oInitlayout.Columns(1))
                    If j < wireds(i).ngate Then
                        inlist = inlist + ","
                    End If
                Next j
                inlist = inlist + "}'"
            End If
            oInitlayout.UpdateCommand = "update wired set (gid,isoutput)= (" + inlist + ",?) where wid = ?"
            oGetwid.SetParam QUERY_CMD, 1, i
            oGetwid.ExecuteCommand QUERY_CMD
            oInitlayout.SetParam UPDATE_CMD, 1, wireds(i).wiredtype
            temp = oGetwid.Columns(1)
            oInitlayout.SetParam UPDATE_CMD, 2, temp
            oInitlayout.ExecuteCommand UPDATE_CMD
    Next i
End Sub

Public Sub loadModel()
    Dim oLoadLayout As ddoTable
    Dim oLoadGate As ddoTable
    Dim oLoadinput As ddoTable
    Dim oLoadoutput As ddoTable
    Dim oLoadLink As ddoTable
    Dim i As Integer
    Dim j As Integer
    
    Set oLoadLayout = oDatagroup.CreateVirtualTable
    oLoadLayout.QueryCommand = "{call getnumbergate(?)}"
    oLoadLayout.SetParam QUERY_CMD, 1, lid
    oLoadLayout.ExecuteCommand QUERY_CMD
    gateCount = oLoadLayout.Columns(1).Value
    oDatagroup.DeleteVirtualTable (oLoadLayout.name)
    Set oLoadLayout = Nothing
    Set oLoadLayout = oDatagroup.CreateVirtualTable
    oLoadLayout.QueryCommand = "{call getnumberwired(?)}"
    oLoadLayout.SetParam QUERY_CMD, 1, lid
    oLoadLayout.ExecuteCommand QUERY_CMD
    wiredCount = oLoadLayout.Columns(1).Value
    oDatagroup.DeleteVirtualTable (oLoadLayout.name)
    Set oLoadLayout = Nothing
    ReDim gates(gateCount + 10)
    ReDim wireds(wiredCount + 10)
    Set oLoadLayout = oDatagroup.CreateVirtualTable
    oLoadLayout.QueryCommand = "{call loadpos(?)}"
    oLoadLayout.SetParam QUERY_CMD, 1, lid
    oLoadLayout.ExecuteCommand QUERY_CMD
    oLoadLayout.FirstRecord
    Set oLoadGate = oDatagroup.CreateVirtualTable
    oLoadGate.QueryCommand = "{call loadgate(?)}"
    oLoadGate.SetParam QUERY_CMD, 1, lid
    oLoadGate.ExecuteCommand QUERY_CMD
    oLoadGate.FirstRecord
    Set oLoadinput = oDatagroup.CreateVirtualTable
    oLoadinput.QueryCommand = "{call loadinput(?,?)}"
    oLoadinput.SetParam QUERY_CMD, 2, lid
    Set oLoadoutput = oDatagroup.CreateVirtualTable
    oLoadoutput.QueryCommand = "{call loadoutput(?,?)}"
    oLoadoutput.SetParam QUERY_CMD, 2, lid
    For i = 1 To gateCount
        gates(i).posx = oLoadLayout.Columns(1).Value
        gates(i).posy = oLoadLayout.Columns(2).Value
        gates(i).gateType = Trim(oLoadGate.Columns(1).Value)
        gates(i).nInput = oLoadGate.Columns(2).Value
        gates(i).nOutput = oLoadGate.Columns(3).Value
        If gates(i).gateType = "new" Then
            Set oLoadLink = oDatagroup.CreateVirtualTable
            oLoadLink.QueryCommand = "{call loadlink(?,?)}"
            oLoadLink.SetParam QUERY_CMD, 1, i
            oLoadLink.SetParam QUERY_CMD, 2, lid
            oLoadLink.ExecuteCommand QUERY_CMD
            gates(i).linkLayout = oLoadLink.Columns(1).Value
            oDatagroup.DeleteVirtualTable (oLoadLink.name)
            Set oLoadLink = Nothing
        End If
        oLoadinput.SetParam QUERY_CMD, 1, i
        oLoadinput.ExecuteCommand QUERY_CMD
        oLoadinput.FirstRecord
        For j = 1 To gates(i).nInput
            gates(i).inputlist(j) = oLoadinput.Columns(1).Value
            oLoadinput.NextRecord
        Next j
        oLoadoutput.SetParam QUERY_CMD, 1, i
        oLoadoutput.ExecuteCommand QUERY_CMD
        oLoadoutput.FirstRecord
        For j = 1 To gates(i).nOutput
            gates(i).outputlist(j) = oLoadoutput.Columns(1).Value
            oLoadoutput.NextRecord
        Next j
        oLoadLayout.NextRecord
        oLoadGate.NextRecord
    Next i
    oDatagroup.DeleteVirtualTable (oLoadLayout.name)
    Set oLoadLayout = Nothing
    oDatagroup.DeleteVirtualTable (oLoadGate.name)
    Set oLoadGate = Nothing
    oDatagroup.DeleteVirtualTable (oLoadinput.name)
    Set oLoadinput = Nothing
    oDatagroup.DeleteVirtualTable (oLoadoutput.name)
    Set oLoadoutput = Nothing
    Set oLoadGate = oDatagroup.CreateVirtualTable
    oLoadGate.QueryCommand = "{call loadwired(?)}"
    oLoadGate.SetParam QUERY_CMD, 1, lid
    oLoadGate.ExecuteCommand QUERY_CMD
    oLoadGate.FirstRecord
    Set oLoadinput = oDatagroup.CreateVirtualTable
    oLoadinput.QueryCommand = "{call loadgatelist(?,?)}"
    oLoadinput.SetParam QUERY_CMD, 2, lid
    For i = 1 To wiredCount
        wireds(i).wiredtype = oLoadGate.Columns(1).Value
        wireds(i).ngate = oLoadGate.Columns(2).Value
        oLoadinput.SetParam QUERY_CMD, 1, i
        oLoadinput.ExecuteCommand QUERY_CMD
        oLoadinput.FirstRecord
        For j = 1 To wireds(i).ngate
            wireds(i).gatelist(j) = oLoadinput.Columns(1).Value
            oLoadinput.NextRecord
        Next j
        oLoadGate.NextRecord
    Next i
    oDatagroup.DeleteVirtualTable (oLoadGate.name)
    Set oLoadGate = Nothing
    oDatagroup.DeleteVirtualTable (oLoadinput.name)
    Set oLoadinput = Nothing
End Sub

Public Sub saveInOutSystem()
    Dim i, j As Integer

    For i = 1 To gateCount
        For j = 1 To gates(i).nInput
            If gates(i).inputlist(j) = 0 Then
                wiredCount = wiredCount + 1
                If UBound(wireds) < wiredCount Then
                    ReDim Preserve wireds(wiredCount + 10)
                End If
                gates(i).inputlist(j) = wiredCount
                wireds(wiredCount).gatelist(1) = i
                wireds(wiredCount).ngate = 1
                wireds(wiredCount).wiredtype = "I"
            End If
        Next j
    Next i
    For i = 1 To gateCount
        For j = 1 To gates(i).nOutput
            If gates(i).outputlist(j) = 0 Then
                wiredCount = wiredCount + 1
                If UBound(wireds) < wiredCount Then
                    ReDim Preserve wireds(wiredCount + 10)
                End If
                gates(i).outputlist(j) = wiredCount
                wireds(wiredCount).gatelist(1) = i
                wireds(wiredCount).ngate = 1
                wireds(wiredCount).wiredtype = "O"
            End If
        Next j
    Next i
End Sub

Public Sub checkModel()
    Dim oCheckInput As ddoTable
    Dim oCheckLoop As ddoTable
    
    Set oCheckInput = oDatagroup.CreateVirtualTable
    oCheckInput.QueryCommand = "{call checkinput(" + CStr(lid) + ")}"
    oCheckInput.ExecuteCommand QUERY_CMD
    If CStr(oCheckInput.Columns(1).Value) = "Y" Then
        Set oCheckLoop = oDatagroup.CreateVirtualTable
        oCheckLoop.QueryCommand = "{call checkloop(" + CStr(lid) + ")}"
        oCheckLoop.ExecuteCommand QUERY_CMD
        If CStr(oCheckLoop.Columns(1).Value) = "Y" Then
            MDI.resultCheck = 0
        Else
            MDI.resultCheck = 1
        End If
        oDatagroup.DeleteVirtualTable (oCheckLoop.name)
        Set oCheckLoop = Nothing
    Else
        MDI.resultCheck = 2
    End If
    oDatagroup.DeleteVirtualTable (oCheckInput.name)
    Set oCheckInput = Nothing
End Sub
