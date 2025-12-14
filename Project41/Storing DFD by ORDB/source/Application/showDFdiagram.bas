Attribute VB_Name = "showDFdiagram"
Option Explicit

Private queryPCtable As ddoTable
Private queryDStable As ddoTable
Private queryEXtable As ddoTable
Private queryDFtable As ddoTable
Private queryGtable As ddoTable
Private subProcessTable As ddoTable

Private sourceControl As PictureBox
Private destinationControl As PictureBox
Private SourcePoint As point
Private DestinationPoint As point

Public Sub show_DFdiagram(PJ_id As Integer)

    Dim msg As String
    Dim i As Integer
    Dim formIsSet As Boolean
    Dim isSubOf As Integer
    Dim maxPC As ddoTable
    Dim maxDS As ddoTable
    Dim maxEX As ddoTable
    Dim maxDF As ddoTable
    Dim maxG As ddoTable
    
    Set maxPC = oDatagroup.CreateVirtualTable()
    Set maxDS = oDatagroup.CreateVirtualTable()
    Set maxEX = oDatagroup.CreateVirtualTable()
    Set maxDF = oDatagroup.CreateVirtualTable()
    Set maxG = oDatagroup.CreateVirtualTable()
    
    formIsSet = setForm()
    If formIsSet = False Then
        MsgBox "Don't have DFdiagram"
        GoTo releaseRES
    End If
    
    maxPC.QueryCommand = "select max(id) from processTable where projectid=?"
    maxPC.SetParam QUERY_CMD, 1, PJ_id
    maxPC.ExecuteQueryCommand
    
    'If Not maxPC Is Nothing Then
    If maxPC.Columns(1).Value <> "" Then
        ReDim Preserve processState(maxPC.Columns(1).Value)
        For i = 1 To maxPC.Columns(1).Value
            processState(i).Deleted = True
            processState(i).loaded = False
        Next
    End If
    
    For i = 1 To UBound(formState)
        If formState(i).isSubOf > 0 Then
            processState(formState(i).isSubOf).haveSub = True
        End If
    Next
    
    maxDS.QueryCommand = "select max(id) from datastoreTable where projectid=?"
    maxDS.SetParam QUERY_CMD, 1, PJ_id
    maxDS.ExecuteQueryCommand
    
    'If Not maxDS Is Nothing Then
    If maxDS.Columns(1).Value <> "" Then
        ReDim Preserve datastoreState(maxDS.Columns(1).Value)
        For i = 1 To maxDS.Columns(1).Value
            datastoreState(i).Deleted = True
            datastoreState(i).loaded = False
        Next
    End If
    
    maxEX.QueryCommand = "select max(id) from externalTable where projectid=?"
    maxEX.SetParam QUERY_CMD, 1, PJ_id
    maxEX.ExecuteQueryCommand
    
    'If Not maxEX Is Nothing Then
    If maxEX.Columns(1).Value <> "" Then
        ReDim Preserve externalState(maxEX.Columns(1).Value)
        For i = 1 To maxEX.Columns(1).Value
            externalState(i).Deleted = True
            externalState(i).loaded = False
        Next
    End If

    maxDF.QueryCommand = "select max(id) from dataflowTable where projectid=?"
    maxDF.SetParam QUERY_CMD, 1, PJ_id
    maxDF.ExecuteQueryCommand
    
    'If Not maxDF Is Nothing Then
    If maxDF.Columns(1).Value <> "" Then
        ReDim Preserve lineGroupState(maxDF.Columns(1).Value)
        For i = 1 To maxDF.Columns(1).Value
            lineGroupState(i).Deleted = True
        Next
    End If
    
    maxG.QueryCommand = "select max(id) from gateTable where projectid=?"
    maxG.SetParam QUERY_CMD, 1, PJ_id
    maxG.ExecuteQueryCommand
    
    'If Not maxG Is Nothing Then
    If maxG.Columns(1).Value <> "" Then
        ReDim Preserve gateState(maxG.Columns(1).Value)
        For i = 1 To maxG.Columns(1).Value
            gateState(i).Deleted = True
            gateState(i).loaded = False
        Next
    End If
        
    For i = 1 To UBound(formState)
        
        isSubOf = formState(i).isSubOf
        
        Set queryPCtable = oDatagroup.CreateVirtualTable()
        Set queryDStable = oDatagroup.CreateVirtualTable()
        Set queryEXtable = oDatagroup.CreateVirtualTable()
        Set queryDFtable = oDatagroup.CreateVirtualTable()
        Set queryGtable = oDatagroup.CreateVirtualTable()
        
        queryPCtable.QueryCommand = "select * from processTable where (projectId=?)and(subprocess=?)"
        queryDStable.QueryCommand = "select * from datastoreTable where (projectId=?)and(subprocess=?)"
        queryEXtable.QueryCommand = "select * from externalTable where (projectId=?)and(subprocess=?)"
        queryDFtable.QueryCommand = "select * from dataflowTable where (projectId=?)and(subprocess=?)"
        queryGtable.QueryCommand = "select * from gateTable where (projectId=?)and(subprocess=?)"
        
        queryPCtable.SetParam QUERY_CMD, 1, PJ_id
        queryDStable.SetParam QUERY_CMD, 1, PJ_id
        queryEXtable.SetParam QUERY_CMD, 1, PJ_id
        queryDFtable.SetParam QUERY_CMD, 1, PJ_id
        queryGtable.SetParam QUERY_CMD, 1, PJ_id
        
        queryPCtable.SetParam QUERY_CMD, 2, isSubOf
        queryDStable.SetParam QUERY_CMD, 2, isSubOf
        queryEXtable.SetParam QUERY_CMD, 2, isSubOf
        queryDFtable.SetParam QUERY_CMD, 2, isSubOf
        queryGtable.SetParam QUERY_CMD, 2, isSubOf
        
        queryPCtable.ExecuteQueryCommand
        queryDStable.ExecuteQueryCommand
        queryEXtable.ExecuteQueryCommand
        queryDFtable.ExecuteQueryCommand
        queryGtable.ExecuteQueryCommand
        
        'load component into form
        If queryPCtable.TotalRecordCount > 0 Then
            While Not queryPCtable.EOT
                Call setProcessBox_show(i, isSubOf)
                queryPCtable.NextRecord
            Wend
        End If
        If queryDStable.TotalRecordCount > 0 Then
            While Not queryDStable.EOT
                Call setDatastoreBox_show(i, isSubOf)
                queryDStable.NextRecord
            Wend
        End If
                        
        If queryEXtable.TotalRecordCount > 0 Then
            While Not queryEXtable.EOT
                Call setExternalBox_show(i, isSubOf)
                queryEXtable.NextRecord
            Wend
        End If
                
        If isSubOf > 0 Then
            If queryGtable.TotalRecordCount > 0 Then
                While Not queryGtable.EOT
                    Call setGateBox_show(i, isSubOf)
                    queryGtable.NextRecord
                Wend
            End If
        End If
        
        If queryDFtable.TotalRecordCount > 0 Then
            While Not queryDFtable.EOT
                Call setLine_show(i)
                queryDFtable.NextRecord
            Wend
        End If
        
        oDatagroup.DeleteVirtualTable ("queryPCtable")
        oDatagroup.DeleteVirtualTable ("queryDStable")
        oDatagroup.DeleteVirtualTable ("queryEXtable")
        oDatagroup.DeleteVirtualTable ("queryDFtable")
        oDatagroup.DeleteVirtualTable ("queryGtable")
    Next
    
releaseRES:
    'release resource
    oDatagroup.DeleteVirtualTable ("maxPC")
    oDatagroup.DeleteVirtualTable ("maxDS")
    oDatagroup.DeleteVirtualTable ("maxEX")
    oDatagroup.DeleteVirtualTable ("maxDF")
    oDatagroup.DeleteVirtualTable ("maxG")

    MsgBox "finish loading"
End Sub

Private Sub setLine_show(Fi As Integer)
    
    Dim s_id As Integer
    Dim d_id As Integer
    Dim s_type As String
    Dim d_type As String
    
    s_id = queryDFtable.Columns(4).Value
    d_id = queryDFtable.Columns(6).Value
    s_type = Trim(queryDFtable.Columns(5).Value)
    d_type = Trim(queryDFtable.Columns(7).Value)
    
    SourcePoint.X = queryDFtable.Columns(9).Value
    SourcePoint.Y = queryDFtable.Columns(10).Value
    DestinationPoint.X = queryDFtable.Columns(11).Value
    DestinationPoint.Y = queryDFtable.Columns(12).Value
    
    Select Case s_type
        Case "P"
            Set sourceControl = formArray(Fi)!ProcessBox(s_id)
        Case "E"
            Set sourceControl = formArray(Fi)!externalBox(s_id)
        Case "D"
            Set sourceControl = formArray(Fi)!datastoreBox(s_id)
        Case "GP"
            Set sourceControl = formArray(Fi)!GateBox(s_id)
        Case "GE"
            Set sourceControl = formArray(Fi)!GateBox(s_id)
        Case "GD"
            Set sourceControl = formArray(Fi)!GateBox(s_id)
    End Select
    
    Select Case d_type
        Case "P"
            Set destinationControl = formArray(Fi)!ProcessBox(d_id)
        Case "E"
            Set destinationControl = formArray(Fi)!externalBox(d_id)
        Case "D"
            Set destinationControl = formArray(Fi)!datastoreBox(d_id)
        Case "GP"
            Set destinationControl = formArray(Fi)!GateBox(d_id)
        Case "GE"
            Set destinationControl = formArray(Fi)!GateBox(d_id)
        Case "GD"
            Set destinationControl = formArray(Fi)!GateBox(d_id)
    End Select
    
    Call LineManager(sourceControl, destinationControl, SourcePoint, DestinationPoint, Fi)
    
End Sub

Private Function setForm() As Boolean
    Dim i As Integer
    Dim isSubOf As Integer
    Dim total As Integer
    
    
    Set subProcessTable = oDatagroup.CreateVirtualTable()
    
    subProcessTable.QueryCommand = "select distinct(subprocess) from gateTable where projectid=? order by subprocess"
    subProcessTable.SetParam QUERY_CMD, 1, projectId.id
    subProcessTable.ExecuteQueryCommand
    
    If subProcessTable.TotalRecordCount <= 0 Then
        If isThereAnyPC() = True Then
            ReDim Preserve formState(1)
            ReDim Preserve formArray(1)

            formState(1).Deleted = False
            formState(1).modified = False
            formState(1).isSubOf = 0
            formState(1).saved = True
    
            Set formArray(1) = New Form1
            formArray(1).tag = 1
            formArray(1).Caption = "Design Form"
            formArray(1).Visible = True
            formArray(1).Show
            setForm = True
            Exit Function
        Else
            setForm = False
            Exit Function
        End If
    End If

    total = 0
    While Not subProcessTable.EOT
        total = total + 1
        subProcessTable.NextRecord
    Wend
    
        
    ReDim Preserve formState(total + 1)
    ReDim Preserve formArray(total + 1)
    
    For i = 1 To total + 1
        formState(i).Deleted = True
    Next
    
setFirstForm:
    formState(1).Deleted = False
    formState(1).modified = False
    formState(1).isSubOf = 0
    formState(1).saved = True
    
    Set formArray(1) = New Form1
    formArray(1).tag = 1
    formArray(1).Caption = "Design Form"
    formArray(1).Visible = True
    formArray(1).Show
    
    For i = 1 To total
        
        subProcessTable.GotoRecord (i)
        
        formState(i + 1).Deleted = False
        formState(i + 1).modified = False
        isSubOf = subProcessTable.Columns(1).Value
        formState(i + 1).isSubOf = isSubOf
        formState(i + 1).saved = True
        
        Set formArray(i + 1) = New Form1
    
        formArray(i + 1).tag = i + 1
        formArray(i + 1).Caption = "Design Form"
        
        If isSubOf > 0 Then
            formArray(i + 1).Label1.Caption = "Process" & isSubOf
            formArray(i + 1).Label1.Visible = True
            formArray(i + 1).Line1.Visible = True
            formArray(i + 1).cmdGoBack.Visible = True
            formArray(i + 1).cmdGoTop.Visible = True
            formArray(i + 1).Visible = True
            formArray(i + 1).Hide
        End If
    Next
    setForm = True
    
    'release resource
    oDatagroup.DeleteVirtualTable ("subProcessTable")
    
End Function

Private Sub setProcessBox_show(Fi As Integer, isSubOf As Integer)

    Dim index As Integer
    Dim name As String
    Dim position As point
    Dim desc As String
    
    
    index = queryPCtable.Columns(3).Value
   
    name = Trim(queryPCtable.Columns(4).Value)
    position.X = queryPCtable.Columns(5).Value
    position.Y = queryPCtable.Columns(6).Value
    desc = Trim(queryPCtable.Columns(7).Value)
    
    Load formArray(Fi).ProcessBox(index)
    processState(index).Deleted = False
    processState(index).loaded = True
    
    processState(index).name = name
    processState(index).description = desc
    'processState(index).haveSub = False
    
    ' set isSubOf Property
    processState(index).isSubOf = isSubOf
    
    processState(index).position.X = position.X
    processState(index).position.Y = position.Y
    
    formArray(Fi).ProcessBox(index).Visible = True
    formArray(Fi).ProcessBox(index).tag = "P"
    formArray(Fi).ProcessBox(index).Left = position.X
    formArray(Fi).ProcessBox(index).Top = position.Y
    
    Load formArray(Fi).PcIdBox(index)
    Load formArray(Fi).PcNameBox(index)
    Load formArray(Fi).PcDescBox(index)
    
    If processState(index).haveSub = True Then
        formArray(Fi).PcIdBox(index).ForeColor = Green
    End If
    formArray(Fi).PcIdBox(index).Caption = "P" & index
    formArray(Fi).PcIdBox(index).Left = 6
    formArray(Fi).PcIdBox(index).Top = 5
    formArray(Fi).PcIdBox(index).Visible = True
    
    formArray(Fi).PcNameBox(index).Caption = name
    'formArray(Fi).PcNameBox(index).Left = 33
    'formArray(Fi).PcNameBox(index).Top = 6
    formArray(Fi).PcNameBox(index).Visible = True
    
    formArray(Fi).PcDescBox(index).Text = desc
    formArray(Fi).PcDescBox(index).Left = 7
    formArray(Fi).PcDescBox(index).Top = 35
    formArray(Fi).PcDescBox(index).Visible = True
    
    Set formArray(Fi).PcIdBox(index).Container = formArray(Fi).ProcessBox(index)
    Set formArray(Fi).PcNameBox(index).Container = formArray(Fi).ProcessBox(index)
    Set formArray(Fi).PcDescBox(index).Container = formArray(Fi).ProcessBox(index)
    
End Sub

Private Sub setDatastoreBox_show(Fi As Integer, isSubOf As Integer)
    
    Dim index As Integer
    Dim name As String
    Dim position As point
    
    index = queryDStable.Columns(3).Value
    
    name = Trim(queryDStable.Columns(4).Value)
    position.X = queryDStable.Columns(5).Value
    position.Y = queryDStable.Columns(6).Value
    
    Load formArray(Fi).datastoreBox(index)
    datastoreState(index).Deleted = False
    datastoreState(index).loaded = True
    datastoreState(index).name = name
    
    ' set isSubOf Property
    datastoreState(index).isSubOf = isSubOf
    
    datastoreState(index).position.X = position.X
    datastoreState(index).position.Y = position.Y
    
    formArray(Fi).datastoreBox(index).Visible = True
    formArray(Fi).datastoreBox(index).tag = "D"
    formArray(Fi).datastoreBox(index).Left = position.X
    formArray(Fi).datastoreBox(index).Top = position.Y
    
    Load formArray(Fi).DsIdBox(index)
    Load formArray(Fi).DsNameBox(index)
    
    formArray(Fi).DsIdBox(index).Caption = "D" & index
    'formArray(Fi).DsIdBox(index).Left = 3
    'formArray(Fi).DsIdBox(index).Top = 12
    formArray(Fi).DsIdBox(index).Visible = True
    
    formArray(Fi).DsNameBox(index).Caption = name
    'formArray(Fi).DsNameBox(index).Left = 27
    'formArray(Fi).DsNameBox(index).Top = 12
    formArray(Fi).DsNameBox(index).Visible = True
    
    Set formArray(Fi).DsIdBox(index).Container = formArray(Fi).datastoreBox(index)
    Set formArray(Fi).DsNameBox(index).Container = formArray(Fi).datastoreBox(index)

End Sub

Private Sub setExternalBox_show(Fi As Integer, isSubOf As Integer)
    
    Dim index As Integer
    Dim name As String
    Dim position As point
    
    index = queryEXtable.Columns(3).Value
    
    name = Trim(queryEXtable.Columns(4).Value)
    position.X = queryEXtable.Columns(5).Value
    position.Y = queryEXtable.Columns(6).Value
    
    Load formArray(Fi).externalBox(index)
    externalState(index).Deleted = False
    externalState(index).loaded = True
    
    ' set isSubOf Property
    externalState(index).isSubOf = isSubOf

    externalState(index).name = name
    externalState(index).position.X = position.X
    externalState(index).position.Y = position.Y
    
    formArray(Fi).externalBox(index).Visible = True
    formArray(Fi).externalBox(index).tag = "E"
    formArray(Fi).externalBox(index).Left = position.X
    formArray(Fi).externalBox(index).Top = position.Y
    Load formArray(Fi).EsNameBox(index)
    
    formArray(Fi).EsNameBox(index).Caption = name
    'formArray(Fi).EsNameBox(index).Left = 14
    'formArray(Fi).EsNameBox(index).Top = 22
    formArray(Fi).EsNameBox(index).Visible = True
    
    Set formArray(Fi).EsNameBox(index).Container = formArray(Fi).externalBox(index)

End Sub

Private Sub LineManager(ByVal S_ctrl As PictureBox, ByVal D_ctrl As PictureBox, S_pnt As point, D_pnt As point, Fi As Integer)
    
    Dim Point1 As point
    Dim Point2 As point
    Dim Point3 As point

    If (S_pnt.Y >= D_ctrl.Top) And (S_pnt.Y <= D_ctrl.Top + D_ctrl.Height) Then
    '{
    '   Horizontal Line
    '}
        If D_pnt.X > S_pnt.X Then
            Point1.X = S_ctrl.Left + S_ctrl.Width
            Point1.Y = S_pnt.Y
            Point2.X = 0
            Point2.Y = 0
            Point3.X = D_ctrl.Left
            Point3.Y = S_pnt.Y
        ElseIf (D_pnt.X < S_pnt.X) Then
            Point1.X = S_ctrl.Left
            Point1.Y = S_pnt.Y
            Point2.X = 0
            Point2.Y = 0
            Point3.X = D_ctrl.Left + D_ctrl.Width
            Point3.Y = S_pnt.Y
        End If

        Call drawLine(Point1, Point2, Point3, Fi)
        Exit Sub
    End If
    
    If (S_pnt.X >= D_ctrl.Left) And (S_pnt.X <= D_ctrl.Left + D_ctrl.Width) Then
    '{
    '   Vertical Line
    '}
        If D_pnt.Y > S_pnt.Y Then
            Point1.X = S_pnt.X
            Point1.Y = S_ctrl.Top + S_ctrl.Height
            Point2.X = 0
            Point2.Y = 0
            Point3.X = S_pnt.X
            Point3.Y = D_ctrl.Top
        ElseIf (D_pnt.Y < S_pnt.Y) Then
            Point1.X = S_pnt.X
            Point1.Y = S_ctrl.Top
            Point2.X = 0
            Point2.Y = 0
            Point3.X = S_pnt.X
            Point3.Y = D_ctrl.Top + D_ctrl.Height
        End If
        Call drawLine(Point1, Point2, Point3, Fi)
        Exit Sub
    End If
    
    If (S_pnt.Y > D_pnt.Y) Then
    '{
    '   Both Lines "Horizontal Line is on Left"
    '}
        Point1.X = S_pnt.X
        Point1.Y = S_ctrl.Top
        Point2.X = S_pnt.X
        Point2.Y = D_pnt.Y
        
        If (S_pnt.X > D_pnt.X) Then
            Point3.X = D_ctrl.Left + D_ctrl.Width
        ElseIf (S_pnt.X < D_pnt.X) Then
            Point3.X = D_ctrl.Left
        End If
        Point3.Y = D_pnt.Y
        
        Call drawLine(Point1, Point2, Point3, Fi)
        Exit Sub
    End If
    
    If (S_pnt.Y < D_pnt.Y) Then
    '{
    '   Both Lines "Horizontal Line is on Right"
    '}
        Point1.X = S_pnt.X
        Point1.Y = S_ctrl.Top + S_ctrl.Height
        Point2.X = S_pnt.X
        Point2.Y = D_pnt.Y
        
        If (S_pnt.X > D_pnt.X) Then
            Point3.X = D_ctrl.Left + D_ctrl.Width
        ElseIf (S_pnt.X < D_pnt.X) Then
            Point3.X = D_ctrl.Left
        End If
        Point3.Y = D_pnt.Y
        
        Call drawLine(Point1, Point2, Point3, Fi)
        Exit Sub
    End If
    
End Sub


Private Sub drawLine(P1 As point, P2 As point, P3 As point, Fi As Integer)
    Dim lineGroup As Integer
    Dim L1 As point
    Dim L2 As point
    
    lineGroup = queryDFtable.Columns(3).Value
    lineGroupState(lineGroup).Deleted = False
    
    ' set isSubOf Property
    lineGroupState(lineGroup).isSubOf = queryDFtable.Columns(2).Value
    
    lineGroupState(lineGroup).sourceID = sourceControl.index
    lineGroupState(lineGroup).sourceType = sourceControl.tag
    lineGroupState(lineGroup).destinationID = destinationControl.index
    lineGroupState(lineGroup).destinationType = destinationControl.tag
    
    lineGroupState(lineGroup).data = Trim(queryDFtable.Columns(8).Value)
    
    lineGroupState(lineGroup).SourcePoint = SourcePoint
    lineGroupState(lineGroup).DestinationPoint = DestinationPoint
    
    If (P2.X = 0) And (P2.Y = 0) Then
        L1.X = P1.X
        L1.Y = P1.Y
        L2.X = P3.X
        L2.Y = P3.Y
        Call setLine(lineGroup, L1, L2, Fi)
        
        If (P1.X = P3.X) Then
            If (P1.Y > P3.Y) Then
            '{
            ' up arrow
                L2.X = P3.X
                L2.Y = P3.Y
                L1.X = P3.X - 4
                L1.Y = P3.Y + 8
                Call setLine(lineGroup, L1, L2, Fi)
                
                L1.X = P3.X + 4
                L1.Y = P3.Y + 8
                Call setLine(lineGroup, L1, L2, Fi)
                'Line (P3.X, P3.Y)-(P3.X - 4, P3.Y + 8)
                'Line (P3.X, P3.Y)-(P3.X + 4, P3.Y + 8)
            '}
            ElseIf (P1.Y < P3.Y) Then
            '{
            ' down arrow
                L2.X = P3.X
                L2.Y = P3.Y
                L1.X = P3.X - 4
                L1.Y = P3.Y - 8
                Call setLine(lineGroup, L1, L2, Fi)
                
                L1.X = P3.X + 4
                L1.Y = P3.Y - 8
                Call setLine(lineGroup, L1, L2, Fi)
                
                'Line (P3.X, P3.Y)-(P3.X - 4, P3.Y - 8)
                'Line (P3.X, P3.Y)-(P3.X + 4, P3.Y - 8)
            '}
            End If
            Exit Sub
        ElseIf (P1.Y = P3.Y) Then
            If (P1.X > P3.X) Then
            '{
            ' left arrow
                L2.X = P3.X
                L2.Y = P3.Y
                L1.X = P3.X + 8
                L1.Y = P3.Y - 4
                Call setLine(lineGroup, L1, L2, Fi)
                
                L1.X = P3.X + 8
                L1.Y = P3.Y + 4
                Call setLine(lineGroup, L1, L2, Fi)
                
                'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y - 4)
                'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y + 4)
            ')
            ElseIf (P1.X < P3.X) Then
            '{
            ' right arrow
                L2.X = P3.X
                L2.Y = P3.Y
                L1.X = P3.X - 8
                L1.Y = P3.Y - 4
                Call setLine(lineGroup, L1, L2, Fi)
                L1.X = P3.X - 8
                L1.Y = P3.Y + 4
                Call setLine(lineGroup, L1, L2, Fi)
                
                'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y - 4)
                'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y + 4)
            '}
            End If
            Exit Sub
        End If
        
    Else
            L1.X = P1.X
            L1.Y = P1.Y
            L2.X = P1.X
            L2.Y = P2.Y
            Call setLine(lineGroup, L1, L2, Fi)
            
            L1.X = P2.X
            L1.Y = P2.Y
            L2.X = P3.X
            L2.Y = P2.Y
            Call setLine(lineGroup, L1, L2, Fi)
        'Line (P1.X, P1.Y)-(P1.X, P2.Y)
        'Line (P2.X, P2.Y)-(P3.X, P2.Y)
        If (P1.X > P3.X) Then
        '{
        '   left arrow
            L2.X = P3.X
            L2.Y = P3.Y
            L1.X = P3.X + 8
            L1.Y = P3.Y - 4
            Call setLine(lineGroup, L1, L2, Fi)
               
            L1.X = P3.X + 8
            L1.Y = P3.Y + 4
            Call setLine(lineGroup, L1, L2, Fi)
                
            'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y - 4)
            'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y + 4)
        '}
        ElseIf (P1.X < P3.X) Then
        '{
        '   right arrow
            L2.X = P3.X
            L2.Y = P3.Y
            L1.X = P3.X - 8
            L1.Y = P3.Y - 4
            Call setLine(lineGroup, L1, L2, Fi)
              
            L1.X = P3.X - 8
            L1.Y = P3.Y + 4
            Call setLine(lineGroup, L1, L2, Fi)
                     
            'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y - 4)
            'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y + 4)
        '}
        End If
        
    End If
End Sub


Private Sub setLine(ByVal group As Integer, L1 As point, L2 As point, Fi As Integer)
    
    Dim index As Integer
    
    index = FindFreeIndex("line")
    
    lineState(index).Deleted = False
    lineState(index).loaded = True
    
    lineState(index).group = group
    lineState(index).isSubOf = queryDFtable.Columns(2).Value
    
    Load formArray(Fi).flowLine(index)
    formArray(Fi).flowLine(index).Visible = True
    formArray(Fi).flowLine(index).tag = "Line" & group
    
    formArray(Fi).flowLine(index).X1 = L1.X
    formArray(Fi).flowLine(index).Y1 = L1.Y
    formArray(Fi).flowLine(index).X2 = L2.X
    formArray(Fi).flowLine(index).Y2 = L2.Y
    
End Sub

Private Sub setGateBox_show(Fi As Integer, isSubOf As Integer)
  Dim GType As String
  Dim gIndex As Integer
  Dim modelIndex As Integer
  Dim modelName As String
  Dim position As point
  Dim temp As Integer
  
  GType = Trim(queryGtable.Columns(5).Value)
  gIndex = queryGtable.Columns(3).Value
  modelIndex = queryGtable.Columns(4).Value
  modelName = Trim(queryGtable.Columns(6).Value)
  position.X = queryGtable.Columns(7).Value
  position.Y = queryGtable.Columns(8).Value
  
  gateState(gIndex).Deleted = False
  gateState(gIndex).loaded = True
  
  gateState(gIndex).isSubOf = isSubOf
  gateState(gIndex).modelName = modelName
  gateState(gIndex).modelIndex = modelIndex
  gateState(gIndex).modelTag = GType
  gateState(gIndex).position.X = position.X
  gateState(gIndex).position.Y = position.Y
  
  Load formArray(Fi).GateBox(gIndex)
  formArray(Fi).GateBox(gIndex).Visible = True
  formArray(Fi).GateBox(gIndex).Left = position.X
  formArray(Fi).GateBox(gIndex).Top = position.Y
  Load formArray(Fi).gIdBox(gIndex)
  Load formArray(Fi).gNameBox(gIndex)

  temp = search_Gindex(gIndex)
  
  If (GType = "P") Or (GType = "GP") Then
        formArray(Fi).GateBox(gIndex).tag = "GP"
        formArray(Fi).GateBox(gIndex).Width = 90
        formArray(Fi).GateBox(gIndex).Height = 90
        formArray(Fi).GateBox(gIndex).Picture = LoadPicture(processPic)
        
        
        'formArray(Fi).gIdBox(gIndex).Caption = "P" & modelIndex
        formArray(Fi).gIdBox(gIndex).Caption = "P" & temp
        
        formArray(Fi).gIdBox(gIndex).Left = 20
        formArray(Fi).gIdBox(gIndex).Top = 40
        formArray(Fi).gIdBox(gIndex).Visible = True
        formArray(Fi).gNameBox(gIndex).Caption = modelName
        formArray(Fi).gNameBox(gIndex).Left = 20
        formArray(Fi).gNameBox(gIndex).Top = 50
        formArray(Fi).gNameBox(gIndex).Visible = True
        Set formArray(Fi).gNameBox(gIndex).Container = formArray(Fi).GateBox(gIndex)
        Set formArray(Fi).gIdBox(gIndex).Container = formArray(Fi).GateBox(gIndex)
  End If
  
  If (GType = "E") Or (GType = "GE") Then
        formArray(Fi).GateBox(gIndex).tag = "GE"
        formArray(Fi).GateBox(gIndex).Width = 60
        formArray(Fi).GateBox(gIndex).Height = 60
        formArray(Fi).GateBox(gIndex).Picture = LoadPicture(externalPic)
        
        'formArray(Fi).gIdBox(gIndex).Caption = "E" & modelIndex
        formArray(Fi).gIdBox(gIndex).Caption = "E" & temp
        
        formArray(Fi).gIdBox(gIndex).Left = 8
        formArray(Fi).gIdBox(gIndex).Top = 15
        formArray(Fi).gIdBox(gIndex).Visible = True
        formArray(Fi).gNameBox(gIndex).Caption = modelName
        formArray(Fi).gNameBox(gIndex).Left = 8
        formArray(Fi).gNameBox(gIndex).Top = 25
        formArray(Fi).gNameBox(gIndex).Visible = True
        Set formArray(Fi).gNameBox(gIndex).Container = formArray(Fi).GateBox(gIndex)
        Set formArray(Fi).gIdBox(gIndex).Container = formArray(Fi).GateBox(gIndex)
  End If
  
  If (GType = "D") Or (GType = "GD") Then
        formArray(Fi).GateBox(gIndex).tag = "GD"
        formArray(Fi).GateBox(gIndex).Width = 110
        formArray(Fi).GateBox(gIndex).Height = 40
        formArray(Fi).GateBox(gIndex).Picture = LoadPicture(datastorePic)
        
        'formArray(Fi).gIdBox(gIndex).Caption = "D" & modelIndex
        formArray(Fi).gIdBox(gIndex).Caption = "D" & temp
        
        formArray(Fi).gIdBox(gIndex).Left = 3
        formArray(Fi).gIdBox(gIndex).Top = 12
        formArray(Fi).gIdBox(gIndex).Visible = True
        formArray(Fi).gNameBox(gIndex).Caption = modelName
        formArray(Fi).gNameBox(gIndex).Left = 27
        formArray(Fi).gNameBox(gIndex).Top = 12
        formArray(Fi).gNameBox(gIndex).Visible = True
        Set formArray(Fi).gNameBox(gIndex).Container = formArray(Fi).GateBox(gIndex)
        Set formArray(Fi).gIdBox(gIndex).Container = formArray(Fi).GateBox(gIndex)
  End If
  
End Sub

Public Function isThereAnyPC() As Boolean
    Dim queryProcess As ddoTable
    
    Set queryProcess = oDatagroup.CreateVirtualTable()
    
    queryProcess.QueryCommand = "select id from processtable where projectid=?"
    queryProcess.SetParam QUERY_CMD, 1, projectId.id
    
    queryProcess.ExecuteCommand QUERY_CMD
    
    If queryProcess.TotalRecordCount > 0 Then
        isThereAnyPC = True
    ElseIf queryProcess.TotalRecordCount <= 0 Then
        isThereAnyPC = False
    End If
    
End Function
