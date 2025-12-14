VERSION 5.00
Begin VB.MDIForm MDIForm1 
   BackColor       =   &H8000000C&
   Caption         =   "Dataflow Designer"
   ClientHeight    =   3195
   ClientLeft      =   165
   ClientTop       =   735
   ClientWidth     =   4680
   LinkTopic       =   "MDIForm1"
   StartUpPosition =   3  'Windows Default
   Begin VB.Menu menuPopup 
      Caption         =   "popup"
      Visible         =   0   'False
      Begin VB.Menu menuCreateSubprocess 
         Caption         =   "CreateSubprocess"
         Visible         =   0   'False
      End
      Begin VB.Menu menuViewDetail 
         Caption         =   "ViewDetail"
         Visible         =   0   'False
      End
      Begin VB.Menu menuDeleteSubprocess 
         Caption         =   "DeleteSubprocess"
         Visible         =   0   'False
      End
      Begin VB.Menu menuDelete 
         Caption         =   "&Delete"
      End
      Begin VB.Menu menuProp 
         Caption         =   "Prope&rties"
      End
   End
   Begin VB.Menu menuFile 
      Caption         =   "&File"
      Begin VB.Menu menuCreateProject 
         Caption         =   "&CreateProject"
         Begin VB.Menu menuCreateDFdiagram 
            Caption         =   "Create&DFdiagram"
         End
         Begin VB.Menu menuCreateERdiagram 
            Caption         =   "Create&ERdiagram"
         End
      End
      Begin VB.Menu menuOpenProject 
         Caption         =   "&OpenProject"
      End
   End
   Begin VB.Menu menuView 
      Caption         =   "&View"
      Begin VB.Menu menuViewDFdiagram 
         Caption         =   "DFdiagram"
         Enabled         =   0   'False
      End
      Begin VB.Menu menuViewERdiagram 
         Caption         =   "ERdiagram"
         Enabled         =   0   'False
      End
   End
   Begin VB.Menu menuSave 
      Caption         =   "&Save"
      Begin VB.Menu menuSaveDFdiagram 
         Caption         =   "SaveDFdiagram"
      End
      Begin VB.Menu menuSaveERdiagram 
         Caption         =   "SaveERdiagram"
      End
   End
   Begin VB.Menu menuCheck 
      Caption         =   "&Check"
      Begin VB.Menu menuCrossCheck 
         Caption         =   "ER-CrossCheck"
      End
      Begin VB.Menu menuDFMatchCheck 
         Caption         =   "DF-MatchCheck"
      End
      Begin VB.Menu menuERcheck 
         Caption         =   "ER-DiagramCheck"
      End
   End
End
Attribute VB_Name = "MDIForm1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub MDIForm_Load()
    
    Call InitializeConnect
    Call init_MDIform
        
    ' set size and position of mdiForm1
    MDIForm1.Width = Screen.Width * 0.9
    MDIForm1.Height = Screen.Height * 0.9
    Me.Left = (Screen.Width / 2) - (Me.Width / 2)
    Me.Top = (Screen.Height / 2) - (Me.Height / 2)

End Sub

Private Sub MDIForm_Unload(Cancel As Integer)
    Dim i As Integer
    
    Call Disconnect
    For i = 1 To UBound(formState)
        If formState(i).Deleted = False Then
            Unload formArray(i)
        End If
    Next
    
    If isERformLoaded = True Then
        Unload ERform
    End If
    
    End
    
End Sub

Private Sub menuCreateDFdiagram_Click()
    
    If projectId.id > 0 Then
        If formState(1).Deleted = False Then
            Call clearAllForm
        End If
    End If
    createDiagramType = "DF"
   
    If (projectId.id <= 0) Then
        createProjectForm.Show
    Else: Call createDF
    End If
    menuCreateDFdiagram.Enabled = True
End Sub

Private Sub menuCreateERdiagram_Click()
 
    If projectId.id > 0 Then
        If isERformLoaded = True Then
            clearAllForm
        End If
    End If
    
    createDiagramType = "ER"
    
    If projectId.id <= 0 Then
        createProjectForm.Show
    Else: Call createER
    End If
    
End Sub



Private Sub menuCreateSubprocess_Click()
    
    Dim complete As Boolean
    Dim findex As Integer
    Dim subProcess As Integer
    
    findex = CInt(choseItem.ofForm.tag)
    subProcess = formState(findex).isSubOf
    complete = isThisLevelComplete(findex)
    
If formState(CInt(choseItem.ofForm.tag)).saved = False Then
    If complete = True Then
        GoTo startBuild
        
    Else
        MsgBox "You must complete this level before build another one"
        Exit Sub
    End If
    
End If

If formState(CInt(choseItem.ofForm.tag)).saved = True Then
        If formState(CInt(choseItem.ofForm.tag)).modified = True Then
            If complete = True Then
                Call deleteSubFromDB(subProcess)
                GoTo startBuild
                
            Else
                MsgBox "You must complete this level before build another one"
                Exit Sub
            End If
              
        ElseIf formState(CInt(choseItem.ofForm.tag)).modified = False Then
            If complete = True Then
                buildSubForm.Show
                Exit Sub
                
            Else
                MsgBox "You must complete this level before build another one"
                Exit Sub
            End If
        End If
End If

startBuild:
    Call saveThisLevel(findex, subProcess)
    buildSubForm.Show

End Sub

Private Sub menuCrossCheck_Click()
    Dim crossCheck As ddoTable
    
    If isERformLoaded = False Then
        MsgBox "This project doesn't have ERdiagram"
        Exit Sub
    End If
    
    If isERformSaved = True Then
        Set crossCheck = oDatagroup.CreateVirtualTable()
        crossCheck.QueryCommand = "{call checkDataER(?)}"
        crossCheck.SetParam QUERY_CMD, 1, projectId.id
        crossCheck.ExecuteCommand QUERY_CMD
        
        If crossCheck.Columns(1).Value = "N" Then
            MsgBox "Not Pass!!"
        Else: MsgBox "Pass!!"
        End If
        oDatagroup.DeleteVirtualTable ("crossCheck")
        
    ElseIf isERformSaved = False Then
        MsgBox "please save ERdiagram before doing check!"
    End If
    
End Sub

Private Sub menuDelete_Click()
    Dim mess As String
    
    If askYesNo("Warning!", "Do you really want to delete?") = "N" Then
        Exit Sub
    End If
    
    Select Case choseItem.tag
        Case "P"
            If isCompConnect(choseItem.index, choseItem.tag) = True Then
                MsgBox "can't delete ,because it's linked"
            Else
                processState(choseItem.index).Deleted = True
                formArray(CInt(choseItem.ofForm.tag)).ProcessBox(choseItem.index).Visible = False
            End If
            If formState(CInt(choseItem.ofForm.tag)).saved = True Then
                formState(CInt(choseItem.ofForm.tag)).modified = True
            End If
            
        Case "D"
            If isCompConnect(choseItem.index, choseItem.tag) = True Then
                MsgBox "can't delete ,because it's linked"
            Else
                datastoreState(choseItem.index).Deleted = True
                formArray(CInt(choseItem.ofForm.tag)).datastoreBox(choseItem.index).Visible = False
            End If
            If formState(CInt(choseItem.ofForm.tag)).saved = True Then
                formState(CInt(choseItem.ofForm.tag)).modified = True
            End If
            
        Case "E"
            If isCompConnect(choseItem.index, choseItem.tag) = True Then
                MsgBox "can't delete ,because it's linked"
            Else
                externalState(choseItem.index).Deleted = True
                formArray(CInt(choseItem.ofForm.tag)).externalBox(choseItem.index).Visible = False
            End If
            If formState(CInt(choseItem.ofForm.tag)).saved = True Then
                formState(CInt(choseItem.ofForm.tag)).modified = True
            End If
            
        Case "dataflow"
            mess = CanDeleteLine(choseItem.index)
            If mess = "Y" Then
                Call deleteLine(choseItem.index)
            Else: MsgBox mess
            End If
            If formState(CInt(choseItem.ofForm.tag)).saved = True Then
                formState(CInt(choseItem.ofForm.tag)).modified = True
            End If
            
        Case "entity"
             If isEntityConnect(choseItem.index) = True Then
                MsgBox "can't delete ,because it's linked"
             Else
                entityState(choseItem.index).Deleted = True
                ERform.entityBox(choseItem.index).Visible = False
             End If
             If isERformSaved = True Then
                isERformModified = True
             End If
             
        Case "relationship"
            Call deleteRelation(choseItem.index)
            If isERformSaved = True Then
                isERformModified = True
            End If
    End Select


End Sub

Private Sub menuDeleteSubprocess_Click()
    If isThereAnotherSub(choseItem.index) = True Then
        MsgBox "can't delete ,Subprocess Of this process is complex"
        Exit Sub
    Else
        If askYesNo("Warning!", "Do you really want to delete subProcess of P" & choseItem.index) = "Y" Then
            Call deleteSub(choseItem.index)
            processState(choseItem.index).haveSub = False
            formArray(CInt(choseItem.ofForm.tag)).PcIdBox(choseItem.index).ForeColor = Black
            Exit Sub
        Else: Exit Sub
        End If
    End If
End Sub

Private Sub menuDFMatchCheck_Click()
    Dim Ftag As String
    Dim Fi As Integer
    
    Ftag = MDIForm1.ActiveForm.tag
    If Ftag = "ERform" Then
        MsgBox "This check is avaiable for DFdiagram only"
        Exit Sub
    Else
        Fi = CInt(Ftag)
        If formState(Fi).isSubOf > 0 Then
            If checkDFmatch(formState(Fi).isSubOf) = "Y" Then
                MsgBox "DataFlow matches upper-level"
            Else
                MsgBox "ERROR:: DataFlow doesn't match upper-level"
            End If
        Else
            MsgBox "there isn't upper-level for check"
        End If
    End If
    
End Sub

Private Sub menuERcheck_Click()
    Dim erCheck As ddoTable
    
    If isERformLoaded = False Then
        MsgBox "This project doesn't have ERdiagram"
        Exit Sub
    End If
    
    If isERformSaved = True Then
        Set erCheck = oDatagroup.CreateVirtualTable()
    
        erCheck.QueryCommand = "{call checkERdiagram(?)}"
        erCheck.SetParam QUERY_CMD, 1, projectId.id
        erCheck.ExecuteCommand QUERY_CMD
        
        If erCheck.Columns(1).Value = "N" Then
            MsgBox "Warning!! Your ERdiagram is incorrect!!"
        Else: MsgBox "Your ERdiagram is correct!!"
        End If
        oDatagroup.DeleteVirtualTable ("erCheck")
        
    ElseIf isERformSaved = False Then
        MsgBox "please save ERdiagram before doing check!"
    End If
        
End Sub

Private Sub menuOpenProject_Click()
    
    If (isERformLoaded = True) And (isERformSaved = False) Then
        If askYesNo("ERdiagram isn't saved yet", "Do you want to save it?") = "Y" Then
            Call saveERdiagram
            Exit Sub
        End If
    End If
    
    If projectId.id > 0 Then
        Call clearAllForm
    End If
    OpenProjectForm.Show
End Sub

Private Sub menuProp_Click()
    Select Case choseItem.tag
        Case "P"
            processPropForm.Show
        Case "D"
            storeProp.Show
        Case "E"
            storeProp.Show
        Case "dataflow"
            dataflowProp.Show
        Case "entity"
            entityProp.Show
        Case "relationship"
            relationProp.Show
    End Select
End Sub

Private Sub menuSaveDFdiagram_Click()
    Dim i As Integer
    Dim complete As Boolean
    
    If UBound(formState) = 1 Then
        If formState(1).Deleted = False Then
            If isThisLevelComplete(1) = True Then
                GoTo saveDF
            Else
                MsgBox "your context level diagram is not complete,saving not allowed"
                Exit Sub
            End If
        End If
    End If
    
saveDF:
    For i = 1 To UBound(formState)
        If formState(i).Deleted = False Then
            If formState(i).saved = False Then
                Call saveThisLevel(i, formState(i).isSubOf)
            ElseIf formState(i).saved = True Then
                If formState(i).modified = True Then
                    Call deleteSubFromDB(formState(i).isSubOf)
                    Call saveThisLevel(i, formState(i).isSubOf)
                End If
            End If
        End If
    Next
    MsgBox "finish saving DFdiagram"
    
End Sub

Private Sub menuSaveERdiagram_Click()
    If isERformLoaded = False Then
        MsgBox "This project doesn't have ERdiagram"
        Exit Sub
   
    ElseIf isERformLoaded = True Then
        If isERformSaved = True Then
            If isERformModified = True Then
                If isERformComplete = True Then
                    Call clearExistingER
                    Call saveERdiagram
        
                Else
                    MsgBox "ERROR:: SAVING failed!! ERform is not complete"
                End If
                Exit Sub
                
            ElseIf isERformModified = False Then
                Exit Sub
            End If
        End If
        
        If isERformSaved = False Then
            If isERformComplete = True Then
                Call saveERdiagram
        
            Else
                MsgBox "ERROR:: SAVING failed!! ERform is not complete"
            End If
            Exit Sub
            
        End If
    End If
    
End Sub

Private Sub menuViewDetail_Click()
    Dim i As Integer
    Dim index As Integer
    Dim processIndex As Integer
    
    processIndex = choseItem.index
   
    For i = 1 To UBound(formState)
            If (formState(i).isSubOf = processIndex) Then
                index = i
                Exit For
            End If
    Next
    
    If index > 0 Then
        formArray(CInt(choseItem.ofForm.tag)).Hide
        pushQueue (CInt(choseItem.ofForm.tag))
        formArray(index).WindowState = 2
        formArray(index).Show
        Exit Sub
    Else
        MsgBox "impossible"
    End If
    
    menuViewDetail.Visible = False
    menuDeleteSubprocess.Visible = False
    menuCreateSubprocess.Visible = False
End Sub

Private Sub menuViewDFdiagram_Click()
    Dim Fi As Integer
    If UBound(formArray) > 0 Then
        If formState(1).Deleted = False Then
            Fi = popQueue()
            formArray(Fi).Show
            menuViewDFdiagram.Enabled = False
        End If
    End If
End Sub

Private Sub menuViewERdiagram_Click()
    If isERformLoaded = True Then
        ERform.Show
        menuViewERdiagram.Enabled = False
    End If
End Sub
