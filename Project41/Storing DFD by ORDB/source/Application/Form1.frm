VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form1 
   BackColor       =   &H80000005&
   Caption         =   "Dataflow Diagram"
   ClientHeight    =   4950
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5640
   FillColor       =   &H80000005&
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   330
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   376
   Visible         =   0   'False
   WindowState     =   2  'Maximized
   Begin VB.TextBox PcDescBox 
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      Enabled         =   0   'False
      Height          =   735
      Index           =   0
      Left            =   120
      MaxLength       =   30
      MultiLine       =   -1  'True
      TabIndex        =   16
      Text            =   "Form1.frx":0000
      Top             =   960
      Visible         =   0   'False
      Width           =   1095
   End
   Begin VB.CommandButton cmdGoBack 
      Caption         =   "<<Go Back"
      Height          =   255
      Left            =   120
      TabIndex        =   15
      Top             =   2880
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.CommandButton cmdGoTop 
      Caption         =   "Goto Top"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   2520
      Visible         =   0   'False
      Width           =   975
   End
   Begin ComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   555
      Left            =   0
      TabIndex        =   5
      Top             =   0
      Width           =   5640
      _ExtentX        =   9948
      _ExtentY        =   979
      ButtonWidth     =   847
      ButtonHeight    =   820
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   4
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "process"
            Object.ToolTipText     =   "process"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "datastore"
            Object.ToolTipText     =   "datastore"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "external"
            Object.ToolTipText     =   "external entity"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "dataflow"
            Object.ToolTipText     =   "dataflow"
            ImageIndex      =   4
         EndProperty
      EndProperty
   End
   Begin VB.PictureBox GateBox 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   1095
      Index           =   0
      Left            =   2160
      ScaleHeight     =   73
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   81
      TabIndex        =   4
      Top             =   720
      Visible         =   0   'False
      Width           =   1215
      Begin VB.Label gNameBox 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Label2"
         ForeColor       =   &H000000FF&
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   7
         Top             =   480
         Width           =   480
      End
      Begin VB.Label gIdBox 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "P2"
         ForeColor       =   &H000000FF&
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   195
      End
   End
   Begin VB.PictureBox externalBox 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   900
      Index           =   0
      Left            =   0
      Picture         =   "Form1.frx":000E
      ScaleHeight     =   60
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   60
      TabIndex        =   2
      Top             =   480
      Visible         =   0   'False
      Width           =   900
      Begin VB.Label EsNameBox 
         Alignment       =   2  'Center
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "NAME"
         Height          =   195
         Index           =   0
         Left            =   180
         TabIndex        =   8
         Top             =   330
         Width           =   480
      End
   End
   Begin VB.PictureBox datastoreBox 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   600
      Index           =   0
      Left            =   0
      Picture         =   "Form1.frx":00DD
      ScaleHeight     =   40
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   110
      TabIndex        =   1
      Top             =   600
      Visible         =   0   'False
      Width           =   1650
      Begin VB.Label DsNameBox 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "dsfsfd"
         Height          =   195
         Index           =   0
         Left            =   405
         TabIndex        =   10
         Top             =   180
         Width           =   420
      End
      Begin VB.Label DsIdBox 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "D11"
         Height          =   195
         Index           =   0
         Left            =   45
         TabIndex        =   9
         Top             =   180
         Width           =   270
      End
   End
   Begin VB.PictureBox ProcessBox 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BorderStyle     =   0  'None
      FillColor       =   &H80000005&
      ForeColor       =   &H80000008&
      Height          =   1350
      Index           =   0
      Left            =   0
      Picture         =   "Form1.frx":01D0
      ScaleHeight     =   90
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   90
      TabIndex        =   0
      Top             =   600
      Visible         =   0   'False
      Width           =   1350
      Begin VB.Label PcNameBox 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "sfdsf"
         Height          =   195
         Index           =   0
         Left            =   495
         TabIndex        =   12
         Top             =   90
         Width           =   330
      End
      Begin VB.Label PcIdBox 
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "P11"
         ForeColor       =   &H80000008&
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   11
         Top             =   120
         Width           =   255
      End
   End
   Begin ComctlLib.ImageList ImageList1 
      Left            =   4440
      Top             =   600
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
            Picture         =   "Form1.frx":0322
            Key             =   ""
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":0AE0
            Key             =   ""
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":129E
            Key             =   ""
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "Form1.frx":1A5C
            Key             =   ""
         EndProperty
      EndProperty
   End
   Begin VB.Label tooltipLabel 
      Alignment       =   2  'Center
      AutoSize        =   -1  'True
      BackColor       =   &H00FFFFC0&
      Caption         =   "tooltip"
      Height          =   195
      Left            =   1560
      TabIndex        =   13
      Tag             =   "tip"
      Top             =   1800
      Visible         =   0   'False
      Width           =   420
   End
   Begin VB.Line Line1 
      BorderColor     =   &H80000002&
      BorderWidth     =   2
      Visible         =   0   'False
      X1              =   72
      X2              =   780
      Y1              =   152
      Y2              =   152
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H8000000D&
      Caption         =   "Process"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   2160
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.Line flowLine 
      Index           =   0
      Visible         =   0   'False
      X1              =   72
      X2              =   176
      Y1              =   136
      Y2              =   136
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

'----------------------------
' declare private variables
'----------------------------
Private drawProcessClick As Boolean
Private drawExternalClick As Boolean
Private drawDataStoreClick As Boolean
Private drawDataflowClick As Boolean
Private sourceFlag As Boolean

' variables use for dragging and dropping Object
Private ItemMoved As Boolean
Private ItemToMove As Integer
Private InitialX As Single
Private InitialY As Single

Private destinationControl As PictureBox
Private sourceControl As PictureBox
Private MoveControl As PictureBox

Private DestinationPoint As point
Private SourcePoint As point


Private Sub cmdGoBack_Click()
    Dim complete As Boolean
    Dim findex As Integer
    Dim index As Integer
    Dim subProcess As Integer
    Dim passSaveAndMod As Boolean
    
    passSaveAndMod = False
    findex = CInt(Me.tag)
    If formState(findex).saved = True Then
        If formState(findex).modified = True Then
            passSaveAndMod = True
            GoTo saveForm
        ElseIf formState(findex).modified = False Then
            GoTo continueLoad
        End If
    End If
    
    If formState(findex).saved = False Then
        GoTo saveForm
    End If

saveForm:
        subProcess = formState(findex).isSubOf
        complete = isThisLevelComplete(findex)
        If complete = True Then
                If passSaveAndMod = True Then
                    Call deleteSubFromDB(subProcess)
                End If
                
                Call saveThisLevel(findex, subProcess)
                GoTo continueLoad
                
        Else
            If askYesNo("Warning!", "This level is not complete,Do you want to complete it before?") = "Y" Then
                    formState(findex).saved = False
                    Exit Sub
            Else:
                    If passSaveAndMod = True Then
                        Call deleteSubFromDB(subProcess)
                    End If
                    Call saveThisLevel(findex, subProcess)
                    GoTo continueLoad
            End If
        End If

continueLoad:
    index = popQueue()
    If index = 0 Then
        MsgBox "You are already on top-level"
        Exit Sub
    ElseIf findex > 0 Then
        Me.Hide
        formArray(index).WindowState = 2
        formArray(index).Show
        Exit Sub
    End If
End Sub

Private Sub cmdGoTop_Click()
    Dim complete As Boolean
    Dim findex As Integer
    Dim subProcess As Integer
    Dim passSaveAndMod As Boolean
    
    passSaveAndMod = False
    findex = CInt(Me.tag)
    If formState(findex).saved = True Then
        If formState(findex).modified = True Then
            passSaveAndMod = True
            GoTo saveForm
            
        ElseIf formState(findex).modified = False Then
            GoTo continueLoad
        End If
    End If
    If formState(findex).saved = False Then
        GoTo saveForm
    End If
    
saveForm:
        subProcess = formState(findex).isSubOf
        complete = isThisLevelComplete(findex)
        If complete = True Then
            If passSaveAndMod = True Then
                Call deleteSubFromDB(subProcess)
            End If
            
            Call saveThisLevel(findex, subProcess)
            GoTo continueLoad
            
        Else
            If askYesNo("Warning!", "This level is not complete,Do you want to complete it before?") = "Y" Then
                    Exit Sub
            Else:
                If passSaveAndMod = True Then
                    Call deleteSubFromDB(subProcess)
                End If
                Call saveThisLevel(findex, subProcess)
                GoTo continueLoad
            End If
        End If
        
continueLoad:
    If findex = 1 Then
        MsgBox "You are already on top-level"
        Exit Sub
    ElseIf findex > 1 Then
        Me.Hide
        Call emptyQueue
        formArray(1).WindowState = 2
        formArray(1).Show
        Exit Sub
    End If
End Sub

Private Sub datastoreBox_MouseDown(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    If (drawDataflowClick = True) Then
        If sourceFlag = True Then
            If (sourceControl.tag = "D") And (sourceControl.index = index) Then
                MsgBox "The same Source and Destination is not allowed"
                sourceControl.BackColor = White
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
            
            If (sourceControl.tag = "P") Or (sourceControl.tag = "GP") Then
                sourceControl.BackColor = White
                Set destinationControl = Me!datastoreBox(index)
            
                '{
                    'get destination point
                    DestinationPoint.X = datastoreBox(index).Left + X
                    DestinationPoint.Y = datastoreBox(index).Top + Y
                '}
                Call LineManager(sourceControl, destinationControl, SourcePoint, DestinationPoint)
                                        
                sourceFlag = False
                drawDataflowClick = False
                If formState(CInt(Me.tag)).saved = True Then
                    formState(CInt(Me.tag)).modified = True
                End If
                
            Else
                MsgBox "illegal link"
                sourceControl.BackColor = White
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
        ElseIf (sourceFlag = False) Then
            datastoreBox(index).BackColor = Grey
            sourceFlag = True
            Set sourceControl = Me!datastoreBox(index)
            '{
                'get source point
                SourcePoint.X = datastoreBox(index).Left + X
                SourcePoint.Y = datastoreBox(index).Top + Y
            '}
        End If
            
        Exit Sub
        
    End If
    
    
    If Button = vbLeftButton Then
        If cantMove("D", index) Then Exit Sub
        Screen.MousePointer = 5
        ItemMoved = True
        ItemToMove = index
        InitialX = X
        InitialY = Y
    End If

End Sub

Private Sub datastoreBox_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If ItemMoved Then
        datastoreBox(ItemToMove).Left = datastoreBox(ItemToMove).Left - (InitialX - X)
        datastoreBox(ItemToMove).Top = datastoreBox(ItemToMove).Top - (InitialY - Y)
    End If
End Sub

Private Sub datastoreBox_MouseUp(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = vbRightButton Then
        choseItem.tag = datastoreBox(index).tag
        choseItem.index = index
        Set choseItem.ofForm = Me
        MDIForm1.menuViewDetail.Visible = False
        MDIForm1.menuDeleteSubprocess.Visible = False
        MDIForm1.menuCreateSubprocess.Visible = False
        
        Call storeProp.setupBeforeShow
        PopupMenu MDIForm1.menuPopup
        Exit Sub
    End If
        
    datastoreState(index).position.X = datastoreBox(index).Left
    datastoreState(index).position.Y = datastoreBox(index).Top
    If ItemMoved Then
        If formState(CInt(Me.tag)).saved = True Then
            formState(CInt(Me.tag)).modified = True
        End If
    End If
    ItemMoved = False
    ItemToMove = 0
    Screen.MousePointer = 0
End Sub

Private Sub externalBox_MouseDown(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    If (drawDataflowClick = True) Then
        If sourceFlag = True Then
            If (sourceControl.tag = "E") And (sourceControl.index = index) Then
                MsgBox "The same Source and Destination is not allowed"
                sourceControl.BackColor = White
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
            
            If (sourceControl.tag = "P") Or (sourceControl.tag = "GP") Then
                
                sourceControl.BackColor = White
                Set destinationControl = Me!externalBox(index)
                '{
                    'get destination point
                    DestinationPoint.X = externalBox(index).Left + X
                    DestinationPoint.Y = externalBox(index).Top + Y
                '}
                Call LineManager(sourceControl, destinationControl, SourcePoint, DestinationPoint)
                
                sourceFlag = False
                drawDataflowClick = False
                If formState(CInt(Me.tag)).saved = True Then
                    formState(CInt(Me.tag)).modified = True
                End If
                
            Else
                MsgBox "illegal link"
                sourceControl.BackColor = White
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
        ElseIf sourceFlag = False Then
            externalBox(index).BackColor = Grey
            sourceFlag = True
            
            Set sourceControl = Me!externalBox(index)
            '{
                'get source point
                SourcePoint.X = externalBox(index).Left + X
                SourcePoint.Y = externalBox(index).Top + Y
            '}
        End If
            
        Exit Sub
        
  End If
    
  If Button = vbLeftButton Then
        If cantMove("E", index) Then Exit Sub
        Screen.MousePointer = 5
        ItemMoved = True
        ItemToMove = index
        InitialX = X
        InitialY = Y
  End If
End Sub

Private Sub externalBox_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If ItemMoved Then
        externalBox(ItemToMove).Left = externalBox(ItemToMove).Left - (InitialX - X)
        externalBox(ItemToMove).Top = externalBox(ItemToMove).Top - (InitialY - Y)
    End If
End Sub

Private Sub externalBox_MouseUp(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = vbRightButton Then
        choseItem.tag = externalBox(index).tag
        choseItem.index = index
        Set choseItem.ofForm = Me
        MDIForm1.menuViewDetail.Visible = False
        MDIForm1.menuDeleteSubprocess.Visible = False
        MDIForm1.menuCreateSubprocess.Visible = False
        
        Call storeProp.setupBeforeShow
        PopupMenu MDIForm1.menuPopup
        Exit Sub
    End If
    
    externalState(index).position.X = externalBox(index).Left
    externalState(index).position.Y = externalBox(index).Top
    If ItemMoved Then
        If formState(CInt(Me.tag)).saved = True Then
            formState(CInt(Me.tag)).modified = True
        End If
    End If
    ItemMoved = False
    ItemToMove = 0
    Screen.MousePointer = 0
End Sub

Private Sub Form_Click()
    
    If (drawProcessClick = True) Then
        Call setProcessBox
        If formState(CInt(Me.tag)).saved = True Then
            formState(CInt(Me.tag)).modified = True
        End If
        drawProcessClick = False
        Exit Sub
    End If
    
    If (drawExternalClick = True) Then
        Call setExternalBox
        If formState(CInt(Me.tag)).saved = True Then
            formState(CInt(Me.tag)).modified = True
        End If
        drawExternalClick = False
        Exit Sub
    End If
    
    If (drawDataStoreClick = True) Then
        Call setDatastoreBox
        If formState(CInt(Me.tag)).saved = True Then
            formState(CInt(Me.tag)).modified = True
        End If
        drawDataStoreClick = False
        Exit Sub
    End If
    
    If (drawDataflowClick = True) Then
        MsgBox "Click source and destination"
        drawDataflowClick = False
        If sourceFlag = True Then sourceControl.BackColor = White
        Exit Sub
    End If
    
End Sub


Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Dim i As Integer
    Dim group As Integer
    Dim showProp As Boolean
    
    showProp = False
    
    If Button = vbRightButton Then
        If UBound(lineState) > 0 Then
          
          For i = 1 To UBound(lineState)
            If (lineState(i).Deleted = False) And (lineState(i).Color = Red) Then
                group = lineState(i).group
                showProp = True
            End If
          Next
          
        End If
        If showProp Then
            Set choseItem.ofForm = Me
            choseItem.tag = "dataflow"
            choseItem.index = group
            
            Call dataflowProp.setupBeforeShow
            PopupMenu MDIForm1.menuPopup
        End If
        Exit Sub
    End If
    
    If flowLine.UBound > 0 Then
        Call WhichLineClicked(X, Y)
    End If

End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
    On Error Resume Next
    'there are UnloadMode cons. below
    'vbFormCode
    'vbAppWindows
    'vbAppTaskManager
    'vbFormMDIForm
    
    If (UnloadMode = vbFormControlMenu) Then
            
            pushQueue (CInt(Me.tag))
            Me.Hide
            MDIForm1.menuViewDFdiagram.Enabled = True
            Cancel = True
    Else: Cancel = False
    End If
    
End Sub


Private Sub GateBox_MouseDown(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If (drawDataflowClick = True) Then
        If sourceFlag = True Then
            If (sourceControl.tag = "GP") Or (sourceControl.tag = "GE") Or (sourceControl.tag = "GD") Then
                MsgBox "illegal link"
                sourceControl.BackColor = White
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
            
            sourceControl.BackColor = White
            Set destinationControl = Me!GateBox(index)
            
            '{
                'get destination point
                DestinationPoint.X = GateBox(index).Left + X
                DestinationPoint.Y = GateBox(index).Top + Y
            '}
            Call LineManager(sourceControl, destinationControl, SourcePoint, DestinationPoint)
            
            sourceFlag = False
            drawDataflowClick = False
            If formState(CInt(Me.tag)).saved = True Then
                    formState(CInt(Me.tag)).modified = True
            End If
            
        ElseIf (sourceFlag = False) Then
            GateBox(index).BackColor = Grey
            sourceFlag = True
            Set sourceControl = Me!GateBox(index)
            '{
                'get source point
                SourcePoint.X = GateBox(index).Left + X
                SourcePoint.Y = GateBox(index).Top + Y
            '}
        End If
            
        Exit Sub
        
    End If
    
    If Button = vbLeftButton Then
        
        If cantMove("GP", index) Then Exit Sub
        If cantMove("GE", index) Then Exit Sub
        If cantMove("GD", index) Then Exit Sub
        
        Screen.MousePointer = 5
        ItemMoved = True
        ItemToMove = index
        InitialX = X
        InitialY = Y
        
    End If
    
End Sub

Private Sub GateBox_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If ItemMoved Then
        GateBox(ItemToMove).Left = GateBox(ItemToMove).Left - (InitialX - X)
        GateBox(ItemToMove).Top = GateBox(ItemToMove).Top - (InitialY - Y)
    
    End If

End Sub

Private Sub GateBox_MouseUp(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    
    gateState(index).position.X = GateBox(index).Left
    gateState(index).position.Y = GateBox(index).Top
    
    If ItemMoved Then
        If formState(CInt(Me.tag)).saved = True Then
            formState(CInt(Me.tag)).modified = True
        End If
    End If
    ItemMoved = False
    ItemToMove = 0
    Screen.MousePointer = 0
End Sub


Private Sub ProcessBox_MouseDown(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If (drawDataflowClick = True) Then
        If sourceFlag = True Then
            If (sourceControl.tag = "P") And (sourceControl.index = index) Then
                MsgBox "The same Source and Destination is not allowed"
                sourceControl.BackColor = White
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
            
            If processState(index).haveSub = True Then
                MsgBox "can't modify because this process have subProcess.  "
                sourceControl.BackColor = White
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
            
            sourceControl.BackColor = White
            Set destinationControl = Me!ProcessBox(index)
            '{
                'get destination point
                DestinationPoint.X = ProcessBox(index).Left + X
                DestinationPoint.Y = ProcessBox(index).Top + Y
            '}
            Call LineManager(sourceControl, destinationControl, SourcePoint, DestinationPoint)
            
            sourceFlag = False
            drawDataflowClick = False
            If formState(CInt(Me.tag)).saved = True Then
                    formState(CInt(Me.tag)).modified = True
            End If
            
        ElseIf (sourceFlag = False) Then
            If processState(index).haveSub = True Then
                MsgBox "can't modify because this process have subProcess.  "
                sourceFlag = False
                drawDataflowClick = False
                Exit Sub
            End If
            
            ProcessBox(index).BackColor = Grey
            sourceFlag = True
            
            
            Set sourceControl = Me!ProcessBox(index)
            '{
                'get source point
                SourcePoint.X = ProcessBox(index).Left + X
                SourcePoint.Y = ProcessBox(index).Top + Y
            '}
        End If
            
        Exit Sub
        
  End If
        
  
  If Button = vbLeftButton Then
        
        If cantMove("P", index) Then Exit Sub
        Screen.MousePointer = 5
        ItemMoved = True
        ItemToMove = index
        InitialX = X
        InitialY = Y
        
  End If

End Sub

Private Sub ProcessBox_MouseMove(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If ItemMoved Then
        ProcessBox(ItemToMove).Left = ProcessBox(ItemToMove).Left - (InitialX - X)
        ProcessBox(ItemToMove).Top = ProcessBox(ItemToMove).Top - (InitialY - Y)
        
    End If
End Sub

Private Sub ProcessBox_MouseUp(index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If Button = vbRightButton Then
        choseItem.tag = ProcessBox(index).tag
        choseItem.index = index
        Set choseItem.ofForm = Me
    
        If processState(index).haveSub = False Then
            MDIForm1.menuCreateSubprocess.Visible = True
            MDIForm1.menuViewDetail.Visible = False
            MDIForm1.menuDeleteSubprocess.Visible = False
        ElseIf processState(index).haveSub = True Then
            MDIForm1.menuCreateSubprocess.Visible = False
            MDIForm1.menuViewDetail.Visible = True
            MDIForm1.menuDeleteSubprocess.Visible = True
        End If
        
        Call processPropForm.setupBeforeShow
        PopupMenu MDIForm1.menuPopup
        Exit Sub
    End If
    
    processState(index).position.X = ProcessBox(index).Left
    processState(index).position.Y = ProcessBox(index).Top
    If ItemMoved Then
        If formState(CInt(Me.tag)).saved = True Then
            formState(CInt(Me.tag)).modified = True
        End If
    End If
    ItemMoved = False
    ItemToMove = 0
    Screen.MousePointer = 0

End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As ComctlLib.Button)
  
    Select Case Button.Key
        Case "process"
            drawProcessClick = True
            drawDataStoreClick = False
            drawExternalClick = False
            drawDataflowClick = False
            MsgBox ("process button click")
        
        Case "datastore"
            drawDataStoreClick = True
            drawProcessClick = False
            drawExternalClick = False
            drawDataflowClick = False
            MsgBox ("datastore button click")
            Exit Sub
            
        Case "external"
            drawExternalClick = True
            drawProcessClick = False
            drawDataStoreClick = False
            drawDataflowClick = False
            MsgBox ("external button click")
            Exit Sub
            
        Case "dataflow"
            drawDataflowClick = True
            drawProcessClick = False
            drawDataStoreClick = False
            drawExternalClick = False
            MsgBox ("dataflow button click")
            
            sourceFlag = False
            Exit Sub
    End Select
End Sub

Private Sub setExternalBox()
    
    Dim index As Integer
    
    index = FindFreeIndex("external")
    
    Load externalBox(index)
    Load EsNameBox(index)
    
    externalState(index).Deleted = False
    externalState(index).loaded = True
    ' set isSubOf Property
    externalState(index).isSubOf = formState(CInt(Me.tag)).isSubOf
    externalState(index).name = "NAME"
    externalState(index).position.X = 10
    externalState(index).position.Y = 40
    
    externalBox(index).Left = 10
    externalBox(index).Top = 40
    externalBox(index).Visible = True
    externalBox(index).tag = "E"
    
    EsNameBox(index).Caption = "NAME"
    EsNameBox(index).Left = 14
    EsNameBox(index).Top = 22
    EsNameBox(index).Visible = True
    
    Set EsNameBox(index).Container = externalBox(index)

End Sub

Private Sub setProcessBox()

    Dim index As Integer
    
    index = FindFreeIndex("process")
    
    Load ProcessBox(index)
    Load PcIdBox(index)
    Load PcNameBox(index)
    Load PcDescBox(index)
   
    processState(index).Deleted = False
    processState(index).loaded = True
    processState(index).name = "NAME"
    processState(index).description = "description"
    processState(index).haveSub = False
    
    ' set isSubOf Property
    processState(index).isSubOf = formState(CInt(Me.tag)).isSubOf
    processState(index).position.X = 10
    processState(index).position.Y = 40
    
    ProcessBox(index).Left = 10
    ProcessBox(index).Top = 40
    ProcessBox(index).Visible = True
    ProcessBox(index).tag = "P"
    
    PcIdBox(index).Caption = "P" & index
    PcIdBox(index).Left = 6
    PcIdBox(index).Top = 5
    PcIdBox(index).Visible = True
    
    PcNameBox(index).Caption = "NAME"
    PcNameBox(index).Left = 33
    PcNameBox(index).Top = 6
    PcNameBox(index).Visible = True
    
    PcDescBox(index).Text = "Description"
    PcDescBox(index).Left = 7
    PcDescBox(index).Top = 35
    PcDescBox(index).Visible = True
    
    Set PcIdBox(index).Container = ProcessBox(index)
    Set PcNameBox(index).Container = ProcessBox(index)
    Set PcDescBox(index).Container = ProcessBox(index)
    
End Sub

Private Sub setDatastoreBox()
    
    Dim index As Integer
    
    index = FindFreeIndex("datastore")
    
    Load datastoreBox(index)
    Load DsIdBox(index)
    Load DsNameBox(index)
  
    datastoreState(index).Deleted = False
    datastoreState(index).loaded = True
    
    datastoreState(index).name = "NAME"
    
    ' set isSubOf Property
    datastoreState(index).isSubOf = formState(CInt(Me.tag)).isSubOf
    datastoreState(index).position.X = 10
    datastoreState(index).position.Y = 40
    
    datastoreBox(index).Left = 10
    datastoreBox(index).Top = 40
    datastoreBox(index).Visible = True
    datastoreBox(index).tag = "D"
    
    DsIdBox(index).Caption = "D" & index
    DsIdBox(index).Left = 3
    DsIdBox(index).Top = 12
    DsIdBox(index).Visible = True
    
    DsNameBox(index).Caption = "NAME"
    DsNameBox(index).Left = 27
    DsNameBox(index).Top = 12
    DsNameBox(index).Visible = True
    
    Set DsIdBox(index).Container = datastoreBox(index)
    Set DsNameBox(index).Container = datastoreBox(index)

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
    Dim lineGroup As Integer
    Dim L1 As point
    Dim L2 As point
    
    lineGroup = FindFreeIndex("linegroup")
    lineGroupState(lineGroup).Deleted = False
    
    ' set isSubOf Property
    lineGroupState(lineGroup).isSubOf = formState(CInt(Me.tag)).isSubOf
    
    lineGroupState(lineGroup).sourceID = sourceControl.index
    lineGroupState(lineGroup).sourceType = sourceControl.tag
    lineGroupState(lineGroup).destinationID = destinationControl.index
    lineGroupState(lineGroup).destinationType = destinationControl.tag
    
    lineGroupState(lineGroup).data = "data"
    lineGroupState(lineGroup).SourcePoint = SourcePoint
    lineGroupState(lineGroup).DestinationPoint = DestinationPoint
    
    If (P2.X = 0) And (P2.Y = 0) Then
        L1.X = P1.X
        L1.Y = P1.Y
        L2.X = P3.X
        L2.Y = P3.Y
        Call setLine(lineGroup, L1, L2)
        
        If (P1.X = P3.X) Then
            If (P1.Y > P3.Y) Then
            '{
            ' up arrow
                L2.X = P3.X
                L2.Y = P3.Y
                L1.X = P3.X - 4
                L1.Y = P3.Y + 8
                Call setLine(lineGroup, L1, L2)
                
                L1.X = P3.X + 4
                L1.Y = P3.Y + 8
                Call setLine(lineGroup, L1, L2)
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
                Call setLine(lineGroup, L1, L2)
                
                L1.X = P3.X + 4
                L1.Y = P3.Y - 8
                Call setLine(lineGroup, L1, L2)
                
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
                Call setLine(lineGroup, L1, L2)
                
                L1.X = P3.X + 8
                L1.Y = P3.Y + 4
                Call setLine(lineGroup, L1, L2)
                
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
                Call setLine(lineGroup, L1, L2)
                L1.X = P3.X - 8
                L1.Y = P3.Y + 4
                Call setLine(lineGroup, L1, L2)
                
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
            Call setLine(lineGroup, L1, L2)
            
            L1.X = P2.X
            L1.Y = P2.Y
            L2.X = P3.X
            L2.Y = P2.Y
            Call setLine(lineGroup, L1, L2)
        'Line (P1.X, P1.Y)-(P1.X, P2.Y)
        'Line (P2.X, P2.Y)-(P3.X, P2.Y)
        If (P1.X > P3.X) Then
        '{
        '   left arrow
            L2.X = P3.X
            L2.Y = P3.Y
            L1.X = P3.X + 8
            L1.Y = P3.Y - 4
            Call setLine(lineGroup, L1, L2)
               
            L1.X = P3.X + 8
            L1.Y = P3.Y + 4
            Call setLine(lineGroup, L1, L2)
                
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
            Call setLine(lineGroup, L1, L2)
              
            L1.X = P3.X - 8
            L1.Y = P3.Y + 4
            Call setLine(lineGroup, L1, L2)
                     
            'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y - 4)
            'Line (P3.X, P3.Y)-(P3.X - 8, P3.Y + 4)
        '}
        End If
        
    End If
End Sub


Private Sub setLine(ByVal group As Integer, L1 As point, L2 As point)
    
    Dim index As Integer
    
    index = FindFreeIndex("line")
    
    Load flowLine(index)
   
    lineState(index).Deleted = False
    lineState(index).loaded = True
    lineState(index).group = group
    lineState(index).isSubOf = formState(CInt(Me.tag)).isSubOf
    
    flowLine(index).Visible = True
    flowLine(index).tag = "Line" & group
    flowLine(index).X1 = L1.X
    flowLine(index).Y1 = L1.Y
    flowLine(index).X2 = L2.X
    flowLine(index).Y2 = L2.Y
    
End Sub

Private Function cantMove(compName As String, index As Integer) As Boolean
    Dim i As Integer
    
    cantMove = False
    If UBound(lineGroupState) <= 0 Then
        Exit Function
    ElseIf UBound(lineGroupState) >= 1 Then
        If (UBound(lineGroupState) = 1) And (lineGroupState(1).Deleted = True) Then
            Exit Function
        End If
        For i = 1 To UBound(lineGroupState)
            If (lineGroupState(i).sourceType = compName) And (lineGroupState(i).sourceID = index) Then
                cantMove = True
            ElseIf (lineGroupState(i).destinationType = compName) And (lineGroupState(i).destinationID = index) Then
                cantMove = True
            End If
        Next
    End If
End Function

Private Sub WhichLineClicked(ByVal X As Single, ByVal Y As Single)

    Dim i As Integer
    Dim group As String
    Dim Color As ColorConstants
    Dim group_int As Integer
    Dim temp As String
    
    ' Check Which Line is clicked
    For i = 1 To flowLine.UBound
        
     '''check if the line is on this form
     If (lineState(i).isSubOf = formState(CInt(Me.tag)).isSubOf) Then
     
        If lineState(i).Color = Black Then
            Color = Red
        ElseIf (lineState(i).Color = Red) Then
            Color = Black
        End If
        
        If (flowLine(i).X1 = flowLine(i).X2) And (X = flowLine(i).X2) Then
        '{
        '   Is Y between Y1 and Y2
        '{
            If flowLine(i).Y2 > flowLine(i).Y1 Then
                If (Y >= flowLine(i).Y1) And (Y <= flowLine(i).Y2) Then
                    flowLine(i).BorderColor = Color
                    lineState(i).Color = Color
                End If
            ElseIf (Y >= flowLine(i).Y2) And (Y <= flowLine(i).Y1) Then
                flowLine(i).BorderColor = Color
                lineState(i).Color = Color
            End If
            group = flowLine(i).tag
        ElseIf (flowLine(i).Y1 = flowLine(i).Y2) And (Y = flowLine(i).Y2) Then
        '{
        '   Is X between X1 and X2
        '}
            If (flowLine(i).X2 > flowLine(i).X1) Then
                If (X >= flowLine(i).X1) And (X <= flowLine(i).X2) Then
                    flowLine(i).BorderColor = Color
                    lineState(i).Color = Color
                End If
            ElseIf (X >= flowLine(i).X2) And (X <= flowLine(i).X1) Then
                flowLine(i).BorderColor = Color
                lineState(i).Color = Color
            End If
            group = flowLine(i).tag
        End If
     End If
    Next
        
    For i = 1 To flowLine.UBound
      If (lineState(i).isSubOf = formState(CInt(Me.tag)).isSubOf) Then
        If flowLine(i).tag = group Then
            flowLine(i).BorderColor = Color
            lineState(i).Color = Color
        Else:
            flowLine(i).BorderColor = Black
            lineState(i).Color = Black
        End If
      End If
    Next
    If group <> "" Then
      temp = Right(group, Len(group) - 4)
      group_int = CInt(temp)
      tooltipLabel.Caption = lineGroupState(group_int).data
      tooltipLabel.Visible = True
      tooltipLabel.Top = Y - 3
      tooltipLabel.Left = X - 3
    Else: tooltipLabel.Visible = False
    End If
End Sub


