VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form2 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   Caption         =   "ER Diagram"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4680
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   ScaleHeight     =   213
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   312
   WindowState     =   2  'Maximized
   Begin VB.PictureBox entityBox 
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      Height          =   900
      Index           =   0
      Left            =   0
      Picture         =   "Form2.frx":0000
      ScaleHeight     =   60
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   90
      TabIndex        =   2
      Top             =   600
      Visible         =   0   'False
      Width           =   1350
      Begin VB.Label EtNameBox 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "klkkk"
         Height          =   195
         Index           =   0
         Left            =   495
         TabIndex        =   3
         Top             =   330
         Width           =   405
      End
   End
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   4680
      _ExtentX        =   8255
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "entity"
            Object.ToolTipText     =   "entity"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "one to one"
            Object.ToolTipText     =   "one to one"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "one to many"
            Object.ToolTipText     =   "one to many"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "many to many"
            Object.ToolTipText     =   "many to many"
            ImageIndex      =   4
         EndProperty
      EndProperty
      Begin ComctlLib.ImageList ImageList1 
         Left            =   4080
         Top             =   0
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   25
         ImageHeight     =   25
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   4
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Form2.frx":00F9
               Key             =   ""
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Form2.frx":08B7
               Key             =   ""
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Form2.frx":1075
               Key             =   ""
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "Form2.frx":1833
               Key             =   ""
            EndProperty
         EndProperty
      End
   End
   Begin VB.Label tooltipLabel 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFC0&
      Caption         =   "tt"
      Height          =   195
      Left            =   1560
      TabIndex        =   1
      Tag             =   "tip"
      Top             =   1200
      UseMnemonic     =   0   'False
      Visible         =   0   'False
      Width           =   90
      WordWrap        =   -1  'True
   End
   Begin VB.Line relation 
      Index           =   0
      Visible         =   0   'False
      X1              =   112
      X2              =   208
      Y1              =   72
      Y2              =   72
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private drawEntityClick As Boolean
Private drawOTOclick As Boolean
Private drawOTMclick As Boolean
Private drawMTMclick As Boolean
Private sourceFlag As Boolean
Private relationType As String
Private sourceControl As PictureBox
Private destinationControl As PictureBox

' variables use for dragging and dropping Object
Private ItemMoved As Boolean
Private ItemToMove As Integer
Private InitialX As Single
Private InitialY As Single

Private DestinationPoint As point
Private SourcePoint As point



Private Sub entityBox_MouseDown(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
  Dim Duplicate As Boolean
  Dim i As Integer
  
  Duplicate = False
  
  If (drawOTOclick = True) Or (drawOTMclick = True) Or (drawMTMclick = True) Then
        If sourceFlag = True Then
            sourceControl.BackColor = White
            Set destinationControl = Me!entityBox(index)
            
            'same source and destination
            If sourceControl.index = destinationControl.index Then
                DestinationPoint.X = entityBox(index).Left + X
                DestinationPoint.Y = entityBox(index).Top + Y
                Call setSelfRelationship(index, SourcePoint, DestinationPoint)
                If isERformSaved = True Then
                    isERformModified = True
                End If
                sourceFlag = False
                drawOTOclick = False
                drawOTMclick = False
                drawMTMclick = False
                Exit Sub
            End If
            
            '{
               'get destination point
                DestinationPoint.X = entityBox(index).Left + X
                DestinationPoint.Y = entityBox(index).Top + Y
            '}
            Call LineManager(sourceControl, destinationControl, SourcePoint, DestinationPoint)
            
            If isERformSaved = True Then
                isERformModified = True
            End If
            sourceFlag = False
            drawOTOclick = False
            drawOTMclick = False
            drawMTMclick = False
            
        ElseIf sourceFlag = False Then
            entityBox(index).BackColor = Grey
            sourceFlag = True
            
            Set sourceControl = Me!entityBox(index)
            '{
                'get source point
                SourcePoint.X = entityBox(index).Left + X
                SourcePoint.Y = entityBox(index).Top + Y
            '}
        End If
            
        Exit Sub
        
  End If
  
  If Button = vbLeftButton Then
        If cantMove(index) Then Exit Sub
        Screen.MousePointer = 5
        ItemMoved = True
        ItemToMove = index
        InitialX = X
        InitialY = Y
  End If
  
End Sub

Private Sub entityBox_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If ItemMoved Then
        entityBox(ItemToMove).Left = entityBox(ItemToMove).Left - (InitialX - X)
        entityBox(ItemToMove).Top = entityBox(ItemToMove).Top - (InitialY - Y)
    End If
End Sub

Private Sub entityBox_MouseUp(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    ItemMoved = False
    ItemToMove = 0
    Screen.MousePointer = 0
    entityState(index).position.X = entityBox(index).Left
    entityState(index).position.Y = entityBox(index).Top
    
    If Button = vbRightButton Then
        choseItem.tag = "entity"
        choseItem.index = index
        
        Call entityProp.setupBeforeShow
        
        MDIForm1.menuViewDetail.Visible = False
        MDIForm1.menuDeleteSubprocess.Visible = False
        MDIForm1.menuCreateSubprocess.Visible = False
        
        PopupMenu MDIForm1.menuPopup
        Exit Sub
    End If
End Sub



Private Sub Form_Click()

    If (drawEntityClick = True) Then
        Call setEntityBox
        If isERformSaved = True Then
            isERformModified = True
        End If
        drawEntityClick = False
        Exit Sub
    End If
    
    If (drawOTOclick = True) Then
        MsgBox "Click source and destination"
        relationType = "OTO"
        drawOTOclick = False
        Exit Sub
    End If
    
    If (drawOTMclick = True) Then
        MsgBox "Click source and destination"
        relationType = "OTM"
        drawOTMclick = False
        Exit Sub
    End If
    
    If (drawMTMclick = True) Then
        MsgBox "Click source and destination"
        relationType = "MTM"
        drawMTMclick = False
        sourceFlag = False
        Exit Sub
        
    End If
    
End Sub

Private Sub Form_Load()
    
    Call init_ERform
    
End Sub



Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim i As Integer
    Dim group As Integer
    Dim showProp As Boolean
    
    showProp = False
    
    If Button = vbRightButton Then
        If UBound(relationState) > 0 Then
          For i = 1 To UBound(relationState)
            If (relationState(i).Deleted = False) And (relationState(i).Color = Red) Then
                group = relationState(i).group
                showProp = True
            End If
          Next
        End If
        If showProp Then
            choseItem.tag = "relationship"
            choseItem.index = group
            PopupMenu MDIForm1.menuPopup
        End If
        Exit Sub
    End If
    
    If relation.UBound > 0 Then
        Call WhichLineClicked(X, Y)
    End If

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
  If (UnloadMode = vbFormControlMenu) Then
    Me.Hide
    MDIForm1.menuViewERdiagram.Enabled = True
    Cancel = True
  Else: Cancel = False
  End If
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
Select Case Button.Key
        Case "entity"
            drawEntityClick = True
            drawOTOclick = False
            drawOTMclick = False
            drawMTMclick = False
            MsgBox ("entity button click")
        
        Case "one to one"
            drawOTOclick = True
            relationType = "OTO"
            drawEntityClick = False
            drawOTMclick = False
            drawMTMclick = False
            MsgBox ("1-1 button click")
            Exit Sub
            
        Case "one to many"
            drawOTMclick = True
            relationType = "OTM"
            drawEntityClick = False
            drawOTOclick = False
            drawMTMclick = False
            MsgBox ("1-m button click")
            Exit Sub
            
        Case "many to many"
            drawMTMclick = True
            relationType = "MTM"
            drawEntityClick = False
            drawOTOclick = False
            drawOTMclick = False
            MsgBox ("m-m button click")
            
            sourceFlag = False
            Exit Sub
    End Select
End Sub

Private Sub setEntityBox()

    Dim index As Integer
    
    index = FindFreeIndex("entity")
    
    
    Load entityBox(index)
    Load EtNameBox(index)
    
    entityState(index).Deleted = False
    entityState(index).loaded = True
    
    entityState(index).name = "NAME"
    entityState(index).position.X = 10
    entityState(index).position.Y = 40
    
    entityBox(index).Left = 10
    entityBox(index).Top = 40
    entityBox(index).Visible = True
    entityBox(index).tag = "entity"
    
    EtNameBox(index).Caption = entityState(index).name
    EtNameBox(index).Left = 30
    EtNameBox(index).Top = 22
    EtNameBox(index).Visible = True
    EtNameBox(index).Enabled = True
    
    Set EtNameBox(index).Container = entityBox(index)

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
    
    relationGroup = FindFreeIndex("relationGroup")
    relationGroupState(relationGroup).Deleted = False
    relationGroupState(relationGroup).sourceIndex = sourceControl.index
    relationGroupState(relationGroup).destinationIndex = destinationControl.index
    relationGroupState(relationGroup).type = relationType
    relationGroupState(relationGroup).SourcePoint.X = SourcePoint.X
    relationGroupState(relationGroup).SourcePoint.Y = SourcePoint.Y
    relationGroupState(relationGroup).DestinationPoint.X = DestinationPoint.X
    relationGroupState(relationGroup).DestinationPoint.Y = DestinationPoint.Y
    relationGroupState(relationGroup).relationship = "Entity1 - Entity2"
      
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
    
    Dim index As Integer
    
    index = FindFreeIndex("relation")

    Load relation(index)
    
    relationState(index).Deleted = False
    relationState(index).loaded = True
    
    relationState(index).group = group
    relation(index).Visible = True
    relation(index).tag = "Relation" & group
    
    relation(index).X1 = L1.X
    relation(index).Y1 = L1.Y
    relation(index).X2 = L2.X
    relation(index).Y2 = L2.Y
    
End Sub

Private Function cantMove(index As Integer) As Boolean
    Dim i As Integer
    
    cantMove = False
    If UBound(relationGroupState) <= 0 Then
        Exit Function
    ElseIf UBound(relationGroupState) >= 1 Then
        If (UBound(relationGroupState) = 1) And (relationGroupState(1).Deleted = True) Then
            Exit Function
        End If
        For i = 1 To UBound(relationGroupState)
            If relationGroupState(i).sourceIndex = index Then
                cantMove = True
            ElseIf relationGroupState(i).destinationIndex = index Then
                cantMove = True
            End If
        Next
    End If
End Function

Private Sub WhichLineClicked(ByVal X As Single, ByVal Y As Single)

    Dim i As Integer
    Dim group As String
    Dim group_int As Integer
    Dim Color As ColorConstants
    Dim temp As String
    
    ' Check Which Line is clicked
    For i = 1 To relation.UBound
      If relationState(i).Deleted = False Then
        If relationState(i).Color = Black Then
            Color = Red
        ElseIf (relationState(i).Color = Red) Then
            Color = Black
        End If
        
        If (relation(i).X1 = relation(i).X2) And (X = relation(i).X2) Then
        '{
        '   Is Y between Y1 and Y2
        '{
            If relation(i).Y2 > relation(i).Y1 Then
                If (Y >= relation(i).Y1) And (Y <= relation(i).Y2) Then
                    relation(i).BorderColor = Color
                    relationState(i).Color = Color
                End If
            ElseIf (Y >= relation(i).Y2) And (Y <= relation(i).Y1) Then
                relation(i).BorderColor = Color
                relationState(i).Color = Color
            End If
            group = relation(i).tag
        ElseIf (relation(i).Y1 = relation(i).Y2) And (Y = relation(i).Y2) Then
        '{
        '   Is X between X1 and X2
        '}
            If (relation(i).X2 > relation(i).X1) Then
                If (X >= relation(i).X1) And (X <= relation(i).X2) Then
                    relation(i).BorderColor = Color
                    relationState(i).Color = Color
                End If
            ElseIf (X >= relation(i).X2) And (X <= relation(i).X1) Then
                relation(i).BorderColor = Color
                relationState(i).Color = Color
            End If
            group = relation(i).tag
        End If
      End If
    Next
        
    For i = 1 To relation.UBound
        If relation(i).tag = group Then
            relation(i).BorderColor = Color
            relationState(i).Color = Color
        Else:
            relation(i).BorderColor = Black
            relationState(i).Color = Black
        End If
        
    Next
    If group <> "" Then
      temp = Right(group, Len(group) - 8)
      group_int = CInt(temp)
      tooltipLabel.Caption = relationGroupState(group_int).relationship
      tooltipLabel.Visible = True
      tooltipLabel.Top = Y - 15
      tooltipLabel.Left = X - 15
    Else: tooltipLabel.Visible = False
    End If
    
End Sub

Private Sub setSelfRelationship(index As Integer, SP As point, DP As point)
    Dim relationGroup As Integer
    Dim Point1 As point
    Dim Point2 As point
    Dim P1 As point
    Dim P2 As point
    Dim space As Integer
    
    space = 9 + ((SP.X + DP.Y) Mod 15)
    relationGroup = FindFreeIndex("relationGroup")
    relationGroupState(relationGroup).Deleted = False
    relationGroupState(relationGroup).sourceIndex = index
    relationGroupState(relationGroup).destinationIndex = index
    relationGroupState(relationGroup).type = relationType
    relationGroupState(relationGroup).SourcePoint.X = SP.X
    relationGroupState(relationGroup).SourcePoint.Y = SP.Y
    relationGroupState(relationGroup).DestinationPoint.X = DP.X
    relationGroupState(relationGroup).DestinationPoint.Y = DP.Y
    relationGroupState(relationGroup).relationship = "Entity1 - Entity2"
    
    
    'left point
    Point1.X = entityBox(index).Left + entityBox(index).Width
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
    Point2.Y = entityBox(index).Top - space
    Call setLine(relationGroup, Point1, Point2)
    
    Point1 = Point2
    Point2.X = SP.X
    Point2.Y = Point1.Y
    Call setLine(relationGroup, Point1, Point2)
    
    Point1 = Point2
    Point2.X = Point1.X
    Point2.Y = entityBox(index).Top
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
