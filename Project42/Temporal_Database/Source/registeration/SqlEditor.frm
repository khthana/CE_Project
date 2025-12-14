VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form EditForm 
   Caption         =   "โปรแกรมค้นหาข้อมูลโดย SQL"
   ClientHeight    =   6795
   ClientLeft      =   60
   ClientTop       =   1725
   ClientWidth     =   8640
   Icon            =   "SqlEditor.frx":0000
   LinkTopic       =   "Form1"
   ScaleHeight     =   6795
   ScaleWidth      =   8640
   Begin VB.Frame Frame1 
      Height          =   5415
      Index           =   2
      Left            =   240
      TabIndex        =   3
      Top             =   840
      Width           =   8175
      Begin MSDBGrid.DBGrid TDBGridS1 
         Bindings        =   "SqlEditor.frx":1BEA
         Height          =   4575
         Left            =   120
         OleObjectBlob   =   "SqlEditor.frx":1BFE
         TabIndex        =   10
         Top             =   240
         Width           =   7935
      End
      Begin RichTextLib.RichTextBox text3 
         Height          =   735
         Left            =   5280
         TabIndex        =   9
         Top             =   360
         Visible         =   0   'False
         Width           =   1215
         _ExtentX        =   2143
         _ExtentY        =   1296
         _Version        =   393217
         TextRTF         =   $"SqlEditor.frx":25D3
      End
      Begin VB.Data Data1 
         Caption         =   "Data1"
         Connect         =   "Access"
         DatabaseName    =   ""
         DefaultCursorType=   0  'DefaultCursor
         DefaultType     =   2  'UseODBC
         Exclusive       =   0   'False
         Height          =   375
         Left            =   120
         Options         =   0
         ReadOnly        =   0   'False
         RecordsetType   =   1  'Dynaset
         RecordSource    =   ""
         Top             =   4920
         Width           =   7935
      End
   End
   Begin VB.Frame Frame1 
      Height          =   5415
      Index           =   1
      Left            =   240
      TabIndex        =   1
      Top             =   840
      Width           =   8175
      Begin RichTextLib.RichTextBox OutputSql 
         Height          =   5055
         Left            =   120
         TabIndex        =   2
         Top             =   240
         Width           =   7935
         _ExtentX        =   13996
         _ExtentY        =   8916
         _Version        =   393217
         ScrollBars      =   3
         TextRTF         =   $"SqlEditor.frx":26F7
      End
   End
   Begin VB.Frame Frame1 
      Height          =   5415
      Index           =   0
      Left            =   240
      TabIndex        =   0
      Top             =   840
      Width           =   8175
      Begin RichTextLib.RichTextBox Inputsql 
         Height          =   5055
         Left            =   120
         TabIndex        =   6
         Top             =   240
         Width           =   7935
         _ExtentX        =   13996
         _ExtentY        =   8916
         _Version        =   393217
         ScrollBars      =   3
         TextRTF         =   $"SqlEditor.frx":280F
      End
      Begin MSComctlLib.ImageList ImageList1 
         Left            =   1080
         Top             =   480
         _ExtentX        =   1005
         _ExtentY        =   1005
         BackColor       =   -2147483643
         ImageWidth      =   16
         ImageHeight     =   16
         MaskColor       =   12632256
         _Version        =   393216
         BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
            NumListImages   =   6
            BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "SqlEditor.frx":2927
               Key             =   "NewKey"
            EndProperty
            BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "SqlEditor.frx":2A39
               Key             =   "OpenKey"
            EndProperty
            BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "SqlEditor.frx":2B4B
               Key             =   "SaveKey"
            EndProperty
            BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "SqlEditor.frx":2C5D
               Key             =   "queryKey"
            EndProperty
            BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "SqlEditor.frx":30AF
               Key             =   "mapKey"
            EndProperty
            BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
               Picture         =   "SqlEditor.frx":3501
               Key             =   "builderkey"
            EndProperty
         EndProperty
      End
      Begin MSComDlg.CommonDialog Dialog1 
         Left            =   360
         Top             =   480
         _ExtentX        =   847
         _ExtentY        =   847
         _Version        =   393216
         DefaultExt      =   ".sql"
         DialogTitle     =   "Open"
         Filter          =   "Sql File(*.sql)|*.sql|Tql File(*.tql)|*.tql|All File(*.*)|*.*"
      End
   End
   Begin MSComctlLib.TabStrip tabstrip1 
      Height          =   6015
      Left            =   0
      TabIndex        =   5
      Top             =   480
      Width           =   8655
      _ExtentX        =   15266
      _ExtentY        =   10610
      _Version        =   393216
      BeginProperty Tabs {1EFB6598-857C-11D1-B16A-00C0F0283628} 
         NumTabs         =   3
         BeginProperty Tab1 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Temporal SQL"
            Key             =   "Temporal"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab2 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Standard SQL"
            Key             =   "standard"
            ImageVarType    =   2
         EndProperty
         BeginProperty Tab3 {1EFB659A-857C-11D1-B16A-00C0F0283628} 
            Caption         =   "Query"
            Key             =   "query"
            ImageVarType    =   2
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   7
      Top             =   6420
      Width           =   8640
      _ExtentX        =   15240
      _ExtentY        =   661
      Style           =   1
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.Toolbar Toolbar1 
      Align           =   1  'Align Top
      Height          =   420
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   8640
      _ExtentX        =   15240
      _ExtentY        =   741
      ButtonWidth     =   609
      ButtonHeight    =   582
      Appearance      =   1
      ImageList       =   "ImageList1"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   13
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Description     =   "New Document"
            Style           =   3
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "NewTemporal"
            Object.ToolTipText     =   "Create New Temporal SQL"
            Object.Tag             =   "NewTag"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "OpenTemporal"
            Description     =   "Open Document"
            Object.ToolTipText     =   "Open New Temporal SQL"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SaveTemporal"
            Description     =   "Save Document"
            Object.ToolTipText     =   "Save New Temporal SQL"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "NewStandard"
            Object.ToolTipText     =   "Create New SQL"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "OpenStandard"
            Object.ToolTipText     =   "Open New SQL"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "SaveStandard"
            Object.ToolTipText     =   "Save New SQL"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            ImageIndex      =   4
            Style           =   3
         EndProperty
         BeginProperty Button10 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Style           =   3
         EndProperty
         BeginProperty Button11 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "query"
            Object.ToolTipText     =   "Query Sql Command"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button12 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "map"
            Object.ToolTipText     =   "Map  Temporal SQL to SQL"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button13 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "builder"
            Object.ToolTipText     =   "Load SQL Builder Wizard"
            ImageIndex      =   6
         EndProperty
      EndProperty
   End
   Begin VB.Label Label1 
      Caption         =   "Label1"
      Height          =   375
      Left            =   5040
      TabIndex        =   8
      Top             =   600
      Width           =   1935
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuNew 
         Caption         =   "&New"
         Begin VB.Menu mnuNewstd 
            Caption         =   "New &Standard"
         End
         Begin VB.Menu mnuNewTemp 
            Caption         =   "New &Temporal"
         End
      End
      Begin VB.Menu mnuOpen 
         Caption         =   "&Open"
         Begin VB.Menu mnuOpenStd 
            Caption         =   "Open &Standard"
         End
         Begin VB.Menu mnuOpenTemp 
            Caption         =   "Open &Temporal"
         End
      End
      Begin VB.Menu mnuSave 
         Caption         =   "&Save"
         Begin VB.Menu mnuStandard_Sql 
            Caption         =   "&Standard Sql As..."
         End
         Begin VB.Menu mnuTemporal_Sql 
            Caption         =   "&Temporal Sql As..."
         End
      End
      Begin VB.Menu mnuSaveAll 
         Caption         =   "Save All"
      End
      Begin VB.Menu mnuSep1 
         Caption         =   "-"
      End
      Begin VB.Menu mnuLogin 
         Caption         =   "&Login"
      End
      Begin VB.Menu mnuExit 
         Caption         =   "&Exit"
      End
   End
   Begin VB.Menu mnuEdit 
      Caption         =   "&Edit"
      Begin VB.Menu mnuUndo 
         Caption         =   "&Undo"
      End
      Begin VB.Menu mnusep2 
         Caption         =   "-"
      End
      Begin VB.Menu mnuCut 
         Caption         =   "Cu&t"
      End
      Begin VB.Menu mnuCopy 
         Caption         =   "&Copy"
      End
      Begin VB.Menu mnuPaste 
         Caption         =   "&Paste"
      End
      Begin VB.Menu mnusep3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuFind_Replace 
         Caption         =   "&Find/Replace"
      End
   End
   Begin VB.Menu mnuSql 
      Caption         =   "&Sql"
      Begin VB.Menu mnuBuilder 
         Caption         =   "Query &Builder"
      End
      Begin VB.Menu mnuQuery 
         Caption         =   "&Query"
      End
      Begin VB.Menu mapsql 
         Caption         =   "&Map Temp SQL To SQL"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "EditForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public Change1 As Boolean
Public Change2 As Boolean
Dim chkhavetable As Boolean
Public Sub resize()
On Error Resume Next
tabstrip1.Width = EditForm.Width - 120
tabstrip1.Height = EditForm.Height - 1550

Frame1(0).Width = EditForm.Width - 240
Frame1(0).Height = EditForm.Height - 2000
Frame1(1).Width = EditForm.Width - 240
Frame1(1).Height = EditForm.Height - 2000
Frame1(2).Width = EditForm.Width - 240
Frame1(2).Height = EditForm.Height - 2000

Inputsql.Width = Frame1(0).Width - 240
Inputsql.Height = Frame1(0).Height - 350


OutputSql.Width = Frame1(1).Width - 240
OutputSql.Height = Frame1(1).Height - 350

TDBGridS1.Width = Frame1(2).Width - 240
TDBGridS1.Height = Frame1(2).Height - 920

Data1.Width = TDBGridS1.Width
Data1.Top = TDBGridS1.Top + TDBGridS1.Height + 200
End Sub
Private Sub changeTableName()
    Inputsql.Text = Inputsql.Text
    If Inputsql.Find("student_tt") = "-1" And Inputsql.Find("subject_tt") = "-1" And Inputsql.Find("registeration_tt") = "-1" Then
        If Inputsql.Find("student") <> "-1" Then
            Inputsql.SelText = "student_tt"
            chkhavetable = True
        ElseIf Inputsql.Find("subject") <> "-1" Then
            Inputsql.SelText = "subject_tt"
            chkhavetable = True
        ElseIf Inputsql.Find("registeration") <> "-1" Then
            Inputsql.SelText = "registeration_tt"
            chkhavetable = True
        End If
    Else: chkhavetable = True
    End If
    Inputsql.Text = Inputsql.Text
End Sub

Private Sub mapTsqlToSql()

Dim pos1 As Long
Dim pos2 As Long
Dim string1 As String
Dim where As String
Dim chk, chk2, chk3 As Integer
    chk = 0
    chkhavetable = False
    Inputsql.Text = Inputsql.Text
    OutputSql.Text = ""
    where = "where"
    'If Check1.Value = 0 Then
    '    MsgBox "This statement is not a temporal SQL", vbOKOnly + vbExclamation, "Warning"
    'Else
        'sequence valid query
        If Inputsql.Find("validtime") = "-1" Then
        Else: Inputsql.Text = Inputsql.Text
              pos1 = Inputsql.Find("validtime")
              changeTableName
              Inputsql.SelStart = pos1 + 11
              Inputsql.SelLength = 10000
              Inputsql.SetFocus
              string1 = Inputsql.SelText
              If Inputsql.Find("*") = "-1" Then
                                            text3.Text = Inputsql.SelText
                                            pos2 = text3.Find("from")
                                            text3.SelStart = 0
                                            text3.SelLength = pos2 - 1
                                            OutputSql.Text = text3.SelText
                                            OutputSql.Text = OutputSql.Text + " ,valid_from,valid_to " + Chr(10)
                                            text3.SelStart = pos2
                                            text3.SelLength = 10000
                                            OutputSql.Text = OutputSql.Text + text3.SelText
                                            Temp = True
              Else: OutputSql.Text = string1
                    Temp = True
              End If
        chk = 1
        End If
        'nonsequence valid query
        If Inputsql.Find("nonsequencevalid") = "-1" Then
        Else: Inputsql.Text = Inputsql.Text
              pos1 = Inputsql.Find("nonsequencevalid")
              changeTableName
              Inputsql.SelStart = pos1 + 18
              Inputsql.SelLength = 10000
              Inputsql.SetFocus
              OutputSql.Text = Inputsql.SelText
              Temp = True
              chk = 1
        End If
        'current valid query
        text3.Text = Inputsql.Find(where)
        Inputsql.Text = Inputsql.Text
        chk2 = Inputsql.Find("currentvalid")
        Inputsql.Text = Inputsql.Text
        If (chk2 <> -1) Then
            If text3.Text = "-1" Then
                pos1 = Inputsql.Find("currentvalid")
                changeTableName
                Inputsql.SelStart = pos1 + 14
                Inputsql.SelLength = 10000
                Inputsql.SetFocus
                OutputSql.Text = Inputsql.SelText
                OutputSql.Text = OutputSql.Text + " where valid_to = #12/31/9456# "
                chk = 1
            Else
               pos1 = Inputsql.Find("currentvalid")
               changeTableName
               Inputsql.SelStart = pos1 + 14
               Inputsql.SelLength = 10000
               Inputsql.SetFocus
               OutputSql.Text = Inputsql.SelText
               OutputSql.Text = OutputSql.Text + " and valid_to = #12/31/9456# "
               chk = 1
            End If
        End If
        'sequence transaction query
        If Inputsql.Find("transactiontime") = "-1" Then
        Else: Inputsql.Text = Inputsql.Text
              pos1 = Inputsql.Find("transactiontime")
              changeTableName
              Inputsql.SelStart = pos1 + 16
              Inputsql.SelLength = 10000
              Inputsql.SetFocus
              string1 = Inputsql.SelText
              If Inputsql.Find("*") = "-1" Then
                                            text3.Text = Inputsql.SelText
                                            pos2 = text3.Find("from")
                                            text3.SelStart = 0
                                            text3.SelLength = pos2 - 1
                                            OutputSql.Text = text3.SelText
                                            OutputSql.Text = OutputSql.Text + " ,txstart,txstop " + Chr(10)
                                            text3.SelStart = pos2
                                            text3.SelLength = 10000
                                            OutputSql.Text = OutputSql.Text + text3.SelText
                                            Temp = True
              Else: OutputSql.Text = string1
                    Temp = True
              End If
        chk = 1
        End If
        'nonsequence transaction query
        If Inputsql.Find("nonsequencetransaction") = "-1" Then
        Else: Inputsql.Text = Inputsql.Text
              pos1 = Inputsql.Find("nonsequencetransaction")
              changeTableName
              Inputsql.SelStart = pos1 + 24
              Inputsql.SelLength = 10000
              Inputsql.SetFocus
              OutputSql.Text = Inputsql.SelText
              Temp = True
              chk = 1
        End If
        'current transaction query
        text3.Text = Inputsql.Find(where)
        Inputsql.Text = Inputsql.Text
        chk3 = Inputsql.Find("currenttransaction")
        Inputsql.Text = Inputsql.Text
        If (chk3 <> -1) Then
            If text3.Text = "-1" Then
                pos1 = Inputsql.Find("currenttransaction")
                changeTableName
                Inputsql.SelStart = pos1 + 20
                Inputsql.SelLength = 10000
                Inputsql.SetFocus
                OutputSql.Text = Inputsql.SelText
                OutputSql.Text = OutputSql.Text + " where txstop = #12/31/9456# "
                chk = 1
            Else
               pos1 = Inputsql.Find("currenttransaction")
               changeTableName
               Inputsql.SelStart = pos1 + 20
               Inputsql.SelLength = 10000
               Inputsql.SetFocus
               OutputSql.Text = Inputsql.SelText
               OutputSql.Text = OutputSql.Text + " and txstop = #12/31/9456# "
               chk = 1
            End If
        End If
    
    
        If chk <> 1 Then
            MsgBox "This Statement is not format of temporal SQL", vbOKOnly + vbExclamation, "Warnning"
        ElseIf chkhavetable = False Then
            MsgBox "Table that you refer not have in database", vbOKOnly + vbExclamation, "Table"
            OutputSql.Text = ""
        Else: tabstrip1.Tabs(2).Selected = True
              Frame1(1).ZOrder 0
              OutputSql.SetFocus
        End If
        
    'End If
    
End Sub


Private Sub Form_Load()
'Data1.Connect = "ODBC;DSN=student_dsn;DATABASE=student_data;UID=informix;PWD=informix;HOST=island;SERVER=ol_island;SERVICE=turbo;PROTOCOL=olsoctcp;"

LoginForm.Show
EditForm.Hide
Change1 = False
Change2 = False
Dim i As Integer
resize

   ' The name of the TabStrip is "tabstrip1."
   ' The Frame control is named "frame1."
   For i = 0 To Frame1.Count - 1
   With Frame1(i)
      .Move tabstrip1.ClientLeft, _
      tabstrip1.ClientTop, _
      tabstrip1.ClientWidth, _
      tabstrip1.ClientHeight
   End With
   Next i
   
   ' Bring the first fraTab control to the front.
   Frame1(0).ZOrder 0
   
   Unload frmSplash
   frmSplash.Hide
   
End Sub

Private Sub Form_Resize()
resize
End Sub

Private Sub Form_Unload(Cancel As Integer)
If CheckSave() = False Then End
End Sub

Private Sub InputSql_Change()
  Change2 = True
End Sub

Private Sub mapsql_Click()
    mapTsqlToSql
End Sub

Private Sub mnuAbout_Click()
AboutForm.Show
End Sub

Private Sub mnuBuilder_Click()
    Wizard.Show
End Sub

Private Sub mnuExit_Click()
If CheckSave() = False Then End
End Sub


Private Sub mnuLogin_Click()
    EditForm.Hide
    LoginForm.Show
End Sub

Private Sub mnuNewstd_Click()
    Inputsql.Text = ""
End Sub

Private Sub mnuOpenStd_Click()
    Dialog1.DialogTitle = "Open Standard SQL"
    Dialog1.ShowOpen
    OutputSql.FileName = Dialog1.FileName
End Sub

Private Sub mnuOpenTemp_Click()
    Dialog1.DialogTitle = "Open Temporal SQL"
    Dialog1.ShowOpen
    Inputsql.FileName = Dialog1.FileName
End Sub

Private Sub mnuQuery_Click()
  On Error GoTo Err_Enter

    If Len(OutputSql.Text) = 0 Then
        MsgBox "ไม่มี Statement ใด ๆ เลย", vbOKOnly, "Eror SQL"
        OutputSql.SetFocus
        Exit Sub
    Else
        
        With Data1
            .RecordSource = OutputSql.Text
            .Refresh
            .Caption = "Return " & str(.Recordset.RecordCount) & " records"
            
        End With
        
        tabstrip1.Tabs(3).Selected = True
        Frame1(2).ZOrder 0
        
        Exit Sub
    End If
    

    
Err_Enter:
    If Err.Description = "Object required" Then

    Else: MsgBox Err.Description, vbOKOnly + vbExclamation, "Error in SQL"
          OutputSql.SetFocus
    End If
    
End Sub

Private Sub mnuStandard_Sql_Click()
'Create NewFile
    Dialog1.DialogTitle = "Save as Standard SQL"
    Dialog1.DefaultExt = ".sql"
    Dialog1.ShowSave
 Dim filename1 As String
    filename1 = Dialog1.FileName
 
 Dim fso As New FileSystemObject
 Dim objFil As File
 Dim objts As TextStream
 On Error GoTo Error_Hand
    fso.CreateTextFile (filename1)
    Set objFil = fso.GetFile(filename1)
    Set objts = objFil.OpenAsTextStream(ForWriting)
    objts.Write OutputSql.Text
    objts.Close
Error_Hand:
End Sub

Private Sub mnuNewTemp_Click()
    OutputSql.Text = ""
End Sub

Private Sub mnuTemporal_Sql_Click()
    Dialog1.DialogTitle = "Save as Temporal SQL"
    Dialog1.DefaultExt = ".tql"
    Dialog1.ShowSave
 Dim filename1 As String
    filename1 = Dialog1.FileName
 
 Dim fso As New FileSystemObject
 Dim objFil As File
 Dim objts As TextStream
On Error GoTo Error_Hand
    fso.CreateTextFile (filename1)
    Set objFil = fso.GetFile(filename1)
    Set objts = objFil.OpenAsTextStream(ForWriting)
    objts.Write Inputsql.Text
    objts.Close
Error_Hand:
End Sub

Private Sub OutputSql_Change()
    Change1 = True
End Sub
Private Function CheckSave() As Boolean
Dim Response
CheckSave = False
If Change1 Then
   Response = MsgBox("Do you want to save Standard Sql?", vbYesNoCancel, "Save Comfirm")
    If Response = vbYes Then
    mnuStandard_Sql_Click
    ElseIf Response = vbNo Then
    ElseIf Response = vbCancel Then
      CheckSave = True
    End If
End If


If Change2 Then
    Response = MsgBox("Do you want to save Temporal Sql?", vbYesNoCancel, "Save Comfirm")
    If Response = vbYes Then
    mnuTemporal_Sql_Click
    ElseIf Response = vbNo Then
    ElseIf Response = vbCancel Then
      CheckSave = True
    End If
End If


endd:
End Function

Private Sub TabStrip1_Click()
    Frame1(tabstrip1.SelectedItem.Index - 1).ZOrder 0
End Sub

Private Sub Toolbar1_ButtonClick(ByVal Button As MSComctlLib.Button)
    
   Select Case Button.Key
    Case "NewTemporal"
            mnuNewTemp_Click
    Case "OpenTemporal"
            mnuOpenTemp_Click
    Case "SaveTemporal"
            mnuTemporal_Sql_Click
    Case "NewStandard"
            mnuNewstd_Click
    Case "OpenStandard"
            mnuOpenStd_Click
    Case "SaveStandard"
            mnuStandard_Sql_Click
    Case "query"
            mnuQuery_Click
    Case "map"
            mapsql_Click
    Case "builder"
            mnuBuilder_Click
   End Select
End Sub
