VERSION 5.00
Begin VB.Form buildSubForm 
   BackColor       =   &H80000001&
   Caption         =   "Dataflow Designer"
   ClientHeight    =   1200
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   3495
   LinkTopic       =   "Form2"
   ScaleHeight     =   1200
   ScaleWidth      =   3495
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton OKcmd 
      Caption         =   "O.K."
      Height          =   255
      Left            =   840
      TabIndex        =   2
      Top             =   720
      Width           =   735
   End
   Begin VB.CommandButton CancleCmd 
      Caption         =   "Cancel"
      Height          =   255
      Left            =   1920
      TabIndex        =   1
      Top             =   720
      Width           =   735
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H00C0FFC0&
      BackStyle       =   0  'Transparent
      Caption         =   "CLICK O.K. FOR BUILDING SUB-PROCESS"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000E&
      Height          =   555
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   3285
      WordWrap        =   -1  'True
   End
End
Attribute VB_Name = "buildSubForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private gcount As Integer
Private findex As Integer

Private Type buffType
    tag As String
    index As Integer
    tooltiptext As String
End Type


Private Sub CancleCmd_Click()
    MDIForm1.menuCreateSubprocess.Visible = False
    MDIForm1.menuViewDetail.Visible = False
    MDIForm1.menuDeleteSubprocess.Visible = False
    Me.Hide
End Sub

Private Sub Form_Load()
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)
End Sub

Private Sub OKcmd_Click()
    
    pushQueue (CInt(choseItem.ofForm.tag))
    processState(choseItem.index).haveSub = True
    formArray(CInt(choseItem.ofForm.tag)).PcIdBox(choseItem.index).ForeColor = Green
    
    findex = FindFreeIndex("form")
    Set formArray(findex) = New Form1
    
    formState(findex).Deleted = False
    formState(findex).modified = False
    formState(findex).isSubOf = choseItem.index
    formState(findex).saved = False
    
    formArray(findex).tag = findex
    formArray(findex).Caption = "Design Form"
    formArray(findex).Label1.Caption = "Process" & choseItem.index
    formArray(findex).Label1.Visible = True
    formArray(findex).Line1.Visible = True
    formArray(findex).cmdGoBack.Visible = True
    formArray(findex).cmdGoTop.Visible = True
    formArray(findex).Visible = True
    
    Call buildGate
    
    MDIForm1.menuCreateSubprocess.Visible = False
    MDIForm1.menuViewDetail.Visible = False
    MDIForm1.menuDeleteSubprocess.Visible = False
    Me.Hide
    
    formArray(CInt(choseItem.ofForm.tag)).Hide
End Sub

Private Sub buildGate()
    
    Dim i As Integer
    Dim j As Integer
    
    Dim num1 As Integer
    Dim num2 As Integer
    Dim gIndex As Integer
    Dim pindex As Integer
  
    Dim tagTmp As String
    Dim indexTmp As Integer
    Dim colindex As New Collection
    Dim coltag As New Collection
    
    Dim buffer1(20) As buffType
    Dim buffer2(20) As buffType
    
    num1 = 0
    num2 = 0
    pindex = choseItem.index
    
    For i = 1 To UBound(lineGroupState)
      tagTmp = lineGroupState(i).sourceType
      indexTmp = lineGroupState(i).sourceID
      If (tagTmp = "P") And (indexTmp = pindex) Then
        num1 = num1 + 1
        buffer1(num1).tag = lineGroupState(i).destinationType
        buffer1(num1).index = lineGroupState(i).destinationID
        
        colindex.Add buffer1(num1).index
        coltag.Add buffer1(num1).tag
      End If
    Next
    
    For i = 1 To UBound(lineGroupState)
      tagTmp = lineGroupState(i).destinationType
      indexTmp = lineGroupState(i).destinationID
      If (tagTmp = "P") And (indexTmp = pindex) Then
        num2 = num2 + 1
        buffer2(num2).tag = lineGroupState(i).sourceType
        buffer2(num2).index = lineGroupState(i).sourceID
      End If
    Next

    If (num1 > 0) And (num2 > 0) Then
        For i = 1 To num1
            For j = 1 To num2
                If (buffer1(i).tag = buffer2(j).tag) And (buffer1(i).index = buffer2(j).index) Then
                 buffer2(j).tooltiptext = "repeat"
                End If
           Next
        Next

    End If
  
    If num2 > 0 Then
        For j = 1 To num2
          If (buffer2(j).tooltiptext <> "repeat") Then
            colindex.Add buffer2(j).index
            coltag.Add buffer2(j).tag
            
          End If
        Next
    End If
    
    'count number of Gate
    gcount = 0
    If colindex.Count > 0 Then
        For i = 1 To colindex.Count
            gIndex = FindFreeIndex("gate")
            gateState(gIndex).Deleted = False
            gateState(gIndex).isSubOf = choseItem.index
            gateState(gIndex).modelIndex = colindex.item(i)
            gateState(gIndex).modelTag = coltag.item(i)
            
            If (coltag.item(i) = "GP") Or (coltag.item(i) = "GE") Or (coltag.item(i) = "GD") Then
                gateState(gIndex).modelName = gateState(colindex.item(i)).modelName
               
            Else
                
                Select Case coltag.item(i)
                 Case "P"
                    gateState(gIndex).modelName = processState(colindex.item(i)).name
                 Case "D"
                    gateState(gIndex).modelName = datastoreState(colindex.item(i)).name
                 Case "E"
                    gateState(gIndex).modelName = externalState(colindex.item(i)).name
                End Select
            End If
            gcount = gcount + 1
            Call setGBox(gIndex)
        Next
    End If
    
End Sub

Private Sub setGBox(gi As Integer)
  Dim GType As String
  Dim temp As Integer
  
  GType = gateState(gi).modelTag
  
  gateState(gi).loaded = True
  Load formArray(findex).GateBox(gi)
  formArray(findex).GateBox(gi).Visible = True
  formArray(findex).GateBox(gi).Top = 50
  Load formArray(findex).gIdBox(gi)
  Load formArray(findex).gNameBox(gi)
    
  temp = search_Gindex(gi)
  
  If (GType = "P") Or (GType = "GP") Then
        formArray(findex).GateBox(gi).tag = "GP"
        formArray(findex).GateBox(gi).Width = 90
        formArray(findex).GateBox(gi).Height = 90
        formArray(findex).GateBox(gi).Picture = LoadPicture(processPic)
        
        'formArray(findex).gIdBox(gi).Caption = "P" & gateState(i).modelIndex
        formArray(findex).gIdBox(gi).Caption = "P" & temp
        
        formArray(findex).gIdBox(gi).Left = 20
        formArray(findex).gIdBox(gi).Top = 40
        formArray(findex).gIdBox(gi).Visible = True
        formArray(findex).gNameBox(gi).Caption = gateState(gi).modelName
        formArray(findex).gNameBox(gi).Left = 20
        formArray(findex).gNameBox(gi).Top = 50
        formArray(findex).gNameBox(gi).Visible = True
        Set formArray(findex).gNameBox(gi).Container = formArray(findex).GateBox(gi)
        Set formArray(findex).gIdBox(gi).Container = formArray(findex).GateBox(gi)
  End If
  
  If (GType = "E") Or (GType = "GE") Then
        formArray(findex).GateBox(gi).tag = "GE"
        formArray(findex).GateBox(gi).Width = 60
        formArray(findex).GateBox(gi).Height = 60
        formArray(findex).GateBox(gi).Picture = LoadPicture(externalPic)
        
        'formArray(findex).gIdBox(gi).Caption = "E" & gateState(gi).modelIndex
        formArray(findex).gIdBox(gi).Caption = "E" & temp
        
        formArray(findex).gIdBox(gi).Left = 8
        formArray(findex).gIdBox(gi).Top = 15
        formArray(findex).gIdBox(gi).Visible = True
        formArray(findex).gNameBox(gi).Caption = gateState(gi).modelName
        formArray(findex).gNameBox(gi).Left = 8
        formArray(findex).gNameBox(gi).Top = 25
        formArray(findex).gNameBox(gi).Visible = True
        Set formArray(findex).gNameBox(gi).Container = formArray(findex).GateBox(gi)
        Set formArray(findex).gIdBox(gi).Container = formArray(findex).GateBox(gi)
  End If
  
  If (GType = "D") Or (GType = "GD") Then
        formArray(findex).GateBox(gi).tag = "GD"
        formArray(findex).GateBox(gi).Width = 110
        formArray(findex).GateBox(gi).Height = 40
        formArray(findex).GateBox(gi).Picture = LoadPicture(datastorePic)
        
        'formArray(findex).gIdBox(gi).Caption = "D" & gateState(gi).modelIndex
        formArray(findex).gIdBox(gi).Caption = "D" & temp
        
        formArray(findex).gIdBox(gi).Left = 3
        formArray(findex).gIdBox(gi).Top = 12
        formArray(findex).gIdBox(gi).Visible = True
        formArray(findex).gNameBox(gi).Caption = gateState(gi).modelName
        formArray(findex).gNameBox(gi).Left = 27
        formArray(findex).gNameBox(gi).Top = 12
        formArray(findex).gNameBox(gi).Visible = True
        Set formArray(findex).gNameBox(gi).Container = formArray(findex).GateBox(gi)
        Set formArray(findex).gIdBox(gi).Container = formArray(findex).GateBox(gi)
  End If
  
  If gcount = 1 Then
    formArray(findex).GateBox(gi).Left = 100
  ElseIf gcount > 1 Then
    formArray(findex).GateBox(gi).Left = formArray(findex).GateBox(gi - 1).Left + formArray(findex).GateBox(gi - 1).Width + 5
  End If
  
  gateState(gi).position.X = formArray(findex).GateBox(gi).Left
  gateState(gi).position.Y = formArray(findex).GateBox(gi).Top
  
End Sub

