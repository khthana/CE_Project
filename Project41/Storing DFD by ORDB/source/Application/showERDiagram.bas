Attribute VB_Name = "showERdiagram"
Option Explicit
Private sourceControl As PictureBox
Private destinationControl As PictureBox
Private SourcePoint As point
Private DestinationPoint As point

'--------------------------------------
'declare virtual table for show ERdiagram
'--------------------------------------
Private queryETtable As ddoTable
Private queryRELtable As ddoTable

Public Sub show_ERdiagram(PJ_id As Integer)
    Dim i As Integer
    Dim maxET As ddoTable
    Dim maxREL As ddoTable
    
    Set queryETtable = oDatagroup.CreateVirtualTable()
    Set queryRELtable = oDatagroup.CreateVirtualTable()
    Set maxET = oDatagroup.CreateVirtualTable()
    Set maxREL = oDatagroup.CreateVirtualTable()
    
    maxET.QueryCommand = "select max(id) from entityTable where projectid=?"
    maxET.SetParam QUERY_CMD, 1, PJ_id
    maxET.ExecuteQueryCommand
    
    maxREL.QueryCommand = "select max(id) from relationTable where projectid=?"
    maxREL.SetParam QUERY_CMD, 1, PJ_id
    maxREL.ExecuteQueryCommand
    
    queryETtable.QueryCommand = "select * from entityTable where projectId=?"
    queryETtable.SetParam QUERY_CMD, 1, PJ_id
    queryETtable.ExecuteQueryCommand
    
    If queryETtable.TotalRecordCount <= 0 Then
        MsgBox "Don't have ERdiagram"
        Exit Sub
    End If
    
    queryRELtable.QueryCommand = "select * from relationTable where projectId=?"
    queryRELtable.SetParam QUERY_CMD, 1, PJ_id
    queryRELtable.ExecuteQueryCommand
    
'show form and load picture
    Set ERform = New Form2
    isERformLoaded = True
    ERform.Caption = "ER Design"
    
    ReDim Preserve entityState(maxET.Columns(1).Value)
    For i = 1 To maxET.Columns(1).Value
        entityState(i).Deleted = True
    Next
    While Not queryETtable.EOT
        Call setEntityBox_show
        queryETtable.NextRecord
    Wend
     
    ReDim Preserve relationGroupState(maxREL.Columns(1).Value)
    For i = 1 To maxREL.Columns(1).Value
        relationGroupState(i).Deleted = True
    Next
    While Not queryRELtable.EOT
        Call setRelation_show
        queryRELtable.NextRecord
    Wend
    
    MDIForm1.menuViewERdiagram.Enabled = True
    isERformSaved = True
    
End Sub

Private Sub setEntityBox_show()
    Dim Index As Integer
    Dim name As String
    Dim position As point
    
    'queryETtable.GotoRecord (Ri)
    Index = queryETtable.Columns(2).Value
    
    name = Trim(queryETtable.Columns(3).Value)
    position.X = queryETtable.Columns(4).Value
    position.Y = queryETtable.Columns(5).Value
    
    Load ERform.entityBox(Index)
    entityState(Index).Deleted = False
    entityState(Index).loaded = True
    
    entityState(Index).name = name
    entityState(Index).position.X = position.X
    entityState(Index).position.Y = position.Y
    
    ERform.entityBox(Index).Visible = True
    ERform.entityBox(Index).tag = "entity"
    ERform.entityBox(Index).Left = position.X
    ERform.entityBox(Index).Top = position.Y
    
    Load ERform.EtNameBox(Index)
    
    ERform.EtNameBox(Index).Caption = name
    'ERform.EtNameBox(index).Left = 30
    'ERform.EtNameBox(index).Top = 22
    'ERform.EtNameBox(index).AutoSize = True
    ERform.EtNameBox(Index).Visible = True
    ERform.EtNameBox(Index).Enabled = True
    
    Set ERform.EtNameBox(Index).Container = ERform.entityBox(Index)
    
End Sub

Private Sub setRelation_show()
    
    Dim s_id As Integer
    Dim d_id As Integer
    
    'queryRELtable.GotoRecord (Ri)
    
    s_id = queryRELtable.Columns(3).Value
    d_id = queryRELtable.Columns(4).Value
    SourcePoint.X = queryRELtable.Columns(7).Value
    SourcePoint.Y = queryRELtable.Columns(8).Value
    DestinationPoint.X = queryRELtable.Columns(9).Value
    DestinationPoint.Y = queryRELtable.Columns(10).Value
    
    Set sourceControl = ERform!entityBox(s_id)
    Set destinationControl = ERform!entityBox(d_id)
    
    If sourceControl.Index = destinationControl.Index Then
        Call setSelfRelationship(SourcePoint, DestinationPoint)
    Else
        Call LineManager(sourceControl, destinationControl, SourcePoint, DestinationPoint)
    End If
End Sub

Private Sub LineManager(ByVal S_ctrl As PictureBox, ByVal D_ctrl As PictureBox, S_pnt As point, D_pnt As point)
    
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
        Call drawLine(Point1, Point2, Point3)
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
        Call drawLine(Point1, Point2, Point3)
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
        
        Call drawLine(Point1, Point2, Point3)
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
        
        Call drawLine(Point1, Point2, Point3)
        Exit Sub
    End If
    
End Sub


Private Sub drawLine(P1 As point, P2 As point, P3 As point)
    Dim relationGroup As Integer
    Dim L1 As point
    Dim L2 As point
    Dim relationType As String
    
    relationType = Trim(queryRELtable.Columns(5).Value)
    relationGroup = queryRELtable.Columns(2).Value
    
    relationGroupState(relationGroup).Deleted = False
    relationGroupState(relationGroup).sourceIndex = sourceControl.Index
    relationGroupState(relationGroup).destinationIndex = destinationControl.Index
    relationGroupState(relationGroup).type = relationType
    relationGroupState(relationGroup).SourcePoint.X = SourcePoint.X
    relationGroupState(relationGroup).SourcePoint.Y = SourcePoint.Y
    relationGroupState(relationGroup).DestinationPoint.X = DestinationPoint.X
    relationGroupState(relationGroup).DestinationPoint.Y = DestinationPoint.Y
    
    relationGroupState(relationGroup).relationship = Trim(queryRELtable.Columns(6).Value)
    
    If (P2.X = 0) And (P2.Y = 0) Then
        L1.X = P1.X
        L1.Y = P1.Y
        L2.X = P3.X
        L2.Y = P3.Y
        Call setLine(relationGroup, L1, L2)
    Else
            L1.X = P1.X
            L1.Y = P1.Y
            L2.X = P1.X
            L2.Y = P2.Y
            Call setLine(relationGroup, L1, L2)
            
            L1.X = P2.X
            L1.Y = P2.Y
            L2.X = P3.X
            L2.Y = P2.Y
            Call setLine(relationGroup, L1, L2)
        'Line (P1.X, P1.Y)-(P1.X, P2.Y)
        'Line (P2.X, P2.Y)-(P3.X, P2.Y)
    End If
    
    If (relationType = "OTM") Or (relationType = "MTM") Then
      If (P2.X = 0) And (P2.Y = 0) Then
        If (P1.X = P3.X) Then
            If (P1.Y > P3.Y) Then
            '{
            ' up arrow
                L1.X = P3.X
                L1.Y = P3.Y + 8
                L2.X = P3.X - 4
                L2.Y = P3.Y
                Call setLine(relationGroup, L1, L2)
                
                L2.X = P3.X + 4
                L2.Y = P3.Y
                Call setLine(relationGroup, L1, L2)
                'Line (P3.X, P3.Y)-(P3.X - 4, P3.Y + 8)
                'Line (P3.X, P3.Y)-(P3.X + 4, P3.Y + 8)
            '}
            
                If relationType = "MTM" Then
                    L1.X = P1.X
                    L1.Y = P1.Y - 8
                    L2.X = P1.X - 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
            
                    L2.X = P1.X + 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
                End If
            ElseIf (P1.Y < P3.Y) Then
            '{
            ' down arrow
                L1.X = P3.X
                L1.Y = P3.Y - 8
                L2.X = P3.X - 4
                L2.Y = P3.Y
                Call setLine(relationGroup, L1, L2)
                
                L2.X = P3.X + 4
                L2.Y = P3.Y
                Call setLine(relationGroup, L1, L2)
                
                'Line (P3.X, P3.Y)-(P3.X - 4, P3.Y - 8)
                'Line (P3.X, P3.Y)-(P3.X + 4, P3.Y - 8)
            '}
                If relationType = "MTM" Then
                    L1.X = P1.X
                    L1.Y = P1.Y + 8
                    L2.X = P1.X - 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
            
                    L2.X = P1.X + 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
                End If
            End If
            Exit Sub
        ElseIf (P1.Y = P3.Y) Then
            If (P1.X > P3.X) Then
            '{
            ' left arrow
                L1.X = P3.X + 8
                L1.Y = P3.Y
                L2.X = P3.X
                L2.Y = P3.Y - 4
                Call setLine(relationGroup, L1, L2)
                
                L2.X = P3.X
                L2.Y = P3.Y + 4
                Call setLine(relationGroup, L1, L2)
                
                'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y - 4)
                'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y + 4)
            ')
                If relationType = "MTM" Then
                    L1.X = P1.X - 8
                    L1.Y = P1.Y
                    L2.X = P1.X
                    L2.Y = P1.Y - 4
                    Call setLine(relationGroup, L1, L2)
                
                    L2.X = P1.X
                    L2.Y = P1.Y + 4
                    Call setLine(relationGroup, L1, L2)
                End If
        
            ElseIf (P1.X < P3.X) Then
            '{
            ' right arrow
                L1.X = P3.X - 8
                L1.Y = P3.Y
                L2.X = P3.X
                L2.Y = P3.Y - 4
                Call setLine(relationGroup, L1, L2)
                L2.X = P3.X
                L2.Y = P3.Y + 4
                Call setLine(relationGroup, L1, L2)
                
                'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y - 4)
                'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y + 4)
            '}
                If relationType = "MTM" Then
                    L1.X = P1.X + 8
                    L1.Y = P1.Y
                    L2.X = P1.X
                    L2.Y = P1.Y - 4
                    Call setLine(relationGroup, L1, L2)
                    L2.X = P1.X
                    L2.Y = P1.Y + 4
                    Call setLine(relationGroup, L1, L2)
                End If
            
            End If
            Exit Sub
        End If 'p1.x=p3.x
        
      Else 'if p2.x=0,,p2.y=0
        If (P1.X > P3.X) Then
        '{
        '   left arrow
            L2.X = P3.X + 8
            L2.Y = P3.Y
            L1.X = P3.X
            L1.Y = P3.Y - 4
            Call setLine(relationGroup, L1, L2)
               
            L1.X = P3.X
            L1.Y = P3.Y + 4
            Call setLine(relationGroup, L1, L2)
                
            'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y - 4)
            'Line (P3.X, P3.Y)-(P3.X + 8, P3.Y + 4)
        '}
            
        ElseIf (P1.X < P3.X) Then
        '{
        '   right arrow
            L2.X = P3.X - 8
            L2.Y = P3.Y
            L1.X = P3.X
            L1.Y = P3.Y - 4
            Call setLine(relationGroup, L1, L2)
              
            L1.X = P3.X
            L1.Y = P3.Y + 4
            Call setLine(relationGroup, L1, L2)
                     
            'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y - 4)
            'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y + 4)
        '}
            
        End If
        If relationType = "MTM" Then
            If (P1.Y > P3.Y) Then
                '{
                ' up arrow
                    L1.X = P1.X
                    L1.Y = P1.Y - 8
                    L2.X = P1.X - 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
                
                    L2.X = P1.X + 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
                    'Line (P3.X, P3.Y)-(P3.X - 4, P3.Y + 8)
                    'Line (P3.X, P3.Y)-(P3.X + 4, P3.Y + 8)
                '}
            ElseIf (P1.Y < P3.Y) Then
                '{
                ' down arrow
                    L1.X = P1.X
                    L1.Y = P1.Y + 8
                    L2.X = P1.X - 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
                
                    L2.X = P1.X + 4
                    L2.Y = P1.Y
                    Call setLine(relationGroup, L1, L2)
                
                    'Line (P3.X, P3.Y)-(P3.X - 4, P3.Y - 8)
                    'Line (P3.X, P3.Y)-(P3.X + 4, P3.Y - 8)
                '}
        
            End If
            Exit Sub
        
        
        End If 'relationType="MTM"
      
      End If 'if p2.x=0 ,,p2.y=0
      
    End If 'if relationType
End Sub


Private Sub setLine(ByVal group As Integer, L1 As point, L2 As point)
    
    Dim Index As Integer
    
    Index = FindFreeIndex("relation")
    
    relationState(Index).loaded = True
    relationState(Index).Deleted = False
    relationState(Index).group = group
    
    Load ERform.relation(Index)
    ERform.relation(Index).Visible = True
    ERform.relation(Index).tag = "Relation" & group
    
    ERform.relation(Index).X1 = L1.X
    ERform.relation(Index).Y1 = L1.Y
    ERform.relation(Index).X2 = L2.X
    ERform.relation(Index).Y2 = L2.Y
    
End Sub


Private Sub setSelfRelationship(SP As point, DP As point)
    Dim relationGroup As Integer
    Dim Point1 As point
    Dim Point2 As point
    Dim P1 As point
    Dim P2 As point
    Dim space As Integer
    Dim relationType As String
    
    space = 9 + ((SP.X + DP.Y) Mod 15)
    relationType = Trim(queryRELtable.Columns(5).Value)
    relationGroup = queryRELtable.Columns(2).Value
    
    relationGroupState(relationGroup).Deleted = False
    relationGroupState(relationGroup).sourceIndex = sourceControl.Index
    relationGroupState(relationGroup).destinationIndex = destinationControl.Index
    relationGroupState(relationGroup).type = relationType
    relationGroupState(relationGroup).SourcePoint.X = SourcePoint.X
    relationGroupState(relationGroup).SourcePoint.Y = SourcePoint.Y
    relationGroupState(relationGroup).DestinationPoint.X = DestinationPoint.X
    relationGroupState(relationGroup).DestinationPoint.Y = DestinationPoint.Y
    
    relationGroupState(relationGroup).relationship = Trim(queryRELtable.Columns(6).Value)
    
    
    'left point
    Point1.X = sourceControl.Left + sourceControl.Width
    Point1.Y = DP.Y
    Point2.X = Point1.X + space
    Point2.Y = Point1.Y
    Call setLine(relationGroup, Point1, Point2)
    
    If (relationType = "MTM") Or (relationType = "OTM") Then
        P1.X = Point1.X + 8
        P1.Y = Point1.Y
        P2.X = Point1.X
        P2.Y = Point1.Y - 4
        Call setLine(relationGroup, P1, P2)
        
        P2.Y = Point1.Y + 4
        Call setLine(relationGroup, P1, P2)
    End If
    
    Point1 = Point2
    Point2.Y = sourceControl.Top - space
    Call setLine(relationGroup, Point1, Point2)
    
    Point1 = Point2
    Point2.X = SP.X
    Point2.Y = Point1.Y
    Call setLine(relationGroup, Point1, Point2)
    
    Point1 = Point2
    Point2.X = Point1.X
    Point2.Y = sourceControl.Top
    Call setLine(relationGroup, Point1, Point2)
    
    If relationType = "MTM" Then
        P1.X = Point1.X
        P1.Y = Point2.Y - 8
        P2.X = Point1.X - 4
        P2.Y = Point2.Y
        Call setLine(relationGroup, P1, P2)
        
        P2.X = Point1.X + 4
        Call setLine(relationGroup, P1, P2)
    End If
End Sub

