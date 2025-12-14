VERSION 5.00
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Main 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Form1"
   ClientHeight    =   6495
   ClientLeft      =   420
   ClientTop       =   7395
   ClientWidth     =   8640
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6495
   ScaleWidth      =   8640
   ShowInTaskbar   =   0   'False
   Begin VB.ListBox ListCompPin 
      Height          =   450
      Left            =   0
      TabIndex        =   14
      Top             =   5760
      Visible         =   0   'False
      Width           =   1215
   End
   Begin MSComctlLib.StatusBar StatusBar 
      Align           =   2  'Align Bottom
      Height          =   255
      Left            =   0
      TabIndex        =   13
      Top             =   6240
      Width           =   8640
      _ExtentX        =   15240
      _ExtentY        =   450
      Style           =   1
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin VB.ListBox WireProp 
      Height          =   255
      Index           =   0
      Left            =   0
      TabIndex        =   10
      Top             =   4680
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.ListBox PinTerm 
      Height          =   255
      Index           =   0
      Left            =   0
      TabIndex        =   9
      Top             =   4320
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.ListBox PinValue 
      Height          =   255
      Index           =   0
      Left            =   0
      TabIndex        =   8
      Top             =   3960
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.ListBox ListPinType 
      Height          =   255
      Index           =   0
      Left            =   0
      TabIndex        =   7
      Top             =   3600
      Visible         =   0   'False
      Width           =   1215
   End
   Begin VB.PictureBox Edit 
      AutoRedraw      =   -1  'True
      BackColor       =   &H80000009&
      Height          =   5775
      Left            =   1320
      ScaleHeight     =   5715
      ScaleWidth      =   7035
      TabIndex        =   5
      Top             =   480
      Width           =   7095
      Begin VB.TextBox GateDesc 
         BorderStyle     =   0  'None
         Height          =   255
         Index           =   0
         Left            =   840
         TabIndex        =   11
         Text            =   "U1"
         Top             =   480
         Visible         =   0   'False
         Width           =   255
      End
      Begin VB.PictureBox Gate 
         AutoRedraw      =   -1  'True
         AutoSize        =   -1  'True
         BackColor       =   &H8000000E&
         BorderStyle     =   0  'None
         Height          =   495
         Index           =   0
         Left            =   120
         ScaleHeight     =   495
         ScaleWidth      =   735
         TabIndex        =   6
         Tag             =   "0"
         Top             =   240
         Visible         =   0   'False
         Width           =   735
      End
      Begin VB.Label ValueText 
         AutoSize        =   -1  'True
         BackColor       =   &H8000000E&
         Caption         =   "0"
         ForeColor       =   &H8000000D&
         Height          =   195
         Index           =   0
         Left            =   1800
         TabIndex        =   12
         Top             =   480
         Visible         =   0   'False
         Width           =   210
      End
      Begin VB.Line Wire 
         BorderWidth     =   2
         Index           =   0
         Visible         =   0   'False
         X1              =   360
         X2              =   2160
         Y1              =   960
         Y2              =   960
      End
   End
   Begin VB.PictureBox ViewGate 
      BackColor       =   &H8000000E&
      Height          =   675
      Left            =   240
      ScaleHeight     =   615
      ScaleWidth      =   675
      TabIndex        =   4
      Top             =   2640
      Width           =   735
   End
   Begin VB.ListBox ListGateName 
      Height          =   1425
      Left            =   0
      TabIndex        =   2
      Top             =   720
      Width           =   1215
   End
   Begin MSComctlLib.ImageList GatePicContain 
      Left            =   600
      Top             =   5040
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      MaskColor       =   12632256
      _Version        =   393216
   End
   Begin MSComctlLib.Toolbar Toolbar 
      Align           =   1  'Align Top
      Height          =   405
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8640
      _ExtentX        =   15240
      _ExtentY        =   714
      ButtonWidth     =   609
      ButtonHeight    =   556
      Appearance      =   1
      ImageList       =   "ToolbarPicList"
      _Version        =   393216
      BeginProperty Buttons {66833FE8-8583-11D1-B16A-00C0F0283628} 
         NumButtons      =   9
         BeginProperty Button1 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TNewProject"
            Object.ToolTipText     =   "New Project"
            ImageIndex      =   1
         EndProperty
         BeginProperty Button2 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TOpenProject"
            Object.ToolTipText     =   "Open Project"
            ImageIndex      =   2
         EndProperty
         BeginProperty Button3 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TSaveProject"
            Object.ToolTipText     =   "Save Project"
            ImageIndex      =   3
         EndProperty
         BeginProperty Button4 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TDrawingMode"
            Object.ToolTipText     =   "Drawing Mode"
            ImageIndex      =   4
         EndProperty
         BeginProperty Button5 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TSimulateMode"
            Object.ToolTipText     =   "Simulate Mode"
            ImageIndex      =   5
         EndProperty
         BeginProperty Button6 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TCutGate"
            Object.ToolTipText     =   "Cut Gate"
            ImageIndex      =   6
         EndProperty
         BeginProperty Button7 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TMove"
            Object.ToolTipText     =   "Move Gate"
            ImageIndex      =   7
         EndProperty
         BeginProperty Button8 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TWiring"
            Object.ToolTipText     =   "Wiring"
            ImageIndex      =   8
         EndProperty
         BeginProperty Button9 {66833FEA-8583-11D1-B16A-00C0F0283628} 
            Key             =   "TGoSimulate"
            Object.ToolTipText     =   "Go Simulate"
            ImageIndex      =   9
         EndProperty
      EndProperty
   End
   Begin MSComctlLib.ImageList ToolbarPicList 
      Left            =   0
      Top             =   5040
      _ExtentX        =   1005
      _ExtentY        =   1005
      BackColor       =   -2147483643
      ImageWidth      =   16
      ImageHeight     =   15
      MaskColor       =   12632256
      _Version        =   393216
      BeginProperty Images {2C247F25-8591-11D1-B16A-00C0F0283628} 
         NumListImages   =   9
         BeginProperty ListImage1 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":0000
            Key             =   "PNewProject"
         EndProperty
         BeginProperty ListImage2 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":0542
            Key             =   "POpenProject"
         EndProperty
         BeginProperty ListImage3 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":0A84
            Key             =   "PSaveProject"
         EndProperty
         BeginProperty ListImage4 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":0FC6
            Key             =   "PDrawingMode"
         EndProperty
         BeginProperty ListImage5 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":1418
            Key             =   "PSimulate"
         EndProperty
         BeginProperty ListImage6 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":186A
            Key             =   "PCutGate"
         EndProperty
         BeginProperty ListImage7 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":1DAC
            Key             =   "PMove"
         EndProperty
         BeginProperty ListImage8 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":1FCE
            Key             =   "PWiring"
         EndProperty
         BeginProperty ListImage9 {2C247F27-8591-11D1-B16A-00C0F0283628} 
            Picture         =   "MainForm.frx":20E0
            Key             =   "PGoSimulate"
         EndProperty
      EndProperty
   End
   Begin VB.Label Label2 
      Caption         =   "View  Device:"
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   2400
      Width           =   1095
   End
   Begin VB.Label Label1 
      Caption         =   "Device Name:"
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   480
      Width           =   1095
   End
   Begin VB.Menu MProject 
      Caption         =   "&Project"
      Begin VB.Menu MNewProject 
         Caption         =   "New Project"
         Shortcut        =   ^N
      End
      Begin VB.Menu MOpenProject 
         Caption         =   "Open Project"
         Shortcut        =   ^O
      End
      Begin VB.Menu MSaveProject 
         Caption         =   "Save Project"
         Shortcut        =   ^S
      End
      Begin VB.Menu MSaveAsProject 
         Caption         =   "Save As.. Project"
      End
      Begin VB.Menu MRemProject 
         Caption         =   "&Remove Project.."
      End
      Begin VB.Menu MDescProject 
         Caption         =   "Project Description.."
      End
      Begin VB.Menu Datch 
         Caption         =   "-"
      End
      Begin VB.Menu MExit 
         Caption         =   "Exit"
         Shortcut        =   ^X
      End
   End
   Begin VB.Menu MEdit 
      Caption         =   "&Edit"
      Begin VB.Menu MDrawing 
         Caption         =   "Drawing Mode"
         Checked         =   -1  'True
         Shortcut        =   ^D
      End
      Begin VB.Menu MSimulate 
         Caption         =   "Simulate Mode"
         Checked         =   -1  'True
         Shortcut        =   ^Z
      End
   End
   Begin VB.Menu MHelp 
      Caption         =   "&Help"
      Begin VB.Menu MAbort 
         Caption         =   "About"
      End
   End
End
Attribute VB_Name = "Main"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'GUI Variables
Public EditMode As Boolean      'Status ของ Editor
Public GateNum As Integer       'จำนวน Gate บนวงจร
Public WireNum As Integer       'จำนวน Wire บนวงจร
Public LineNum As Integer       'จำนวน Line บนวงจร
Public Cansim As Boolean         'Status ว่าสามารถ Simulate ได้หรือไม่
Public ProjectDesc As String      'Project Description
Public ProjectName As String     'Project Name
Const PixelSize As Integer = 120 'เก็บระยะจุด
Public Xrel, Yrel As Integer        'เก็บต่าตำแหน่ง Mouse ที่ Click บนรูป Gate
Public Xbgn, Ybgn As Integer        'เก็บตำแหน่งเริ่มต้นของ Line
Public IndexGate As Integer          'เก็บ Index ของ Picture ที่ต้องการ Move และ Cut
Public Wiring As Boolean            'เก็บค่า Status ว่าขณะนั้นกำลังลากสายอยู่หรือไม่
Public FirstComp, FirstPin As Integer
Public SecondComp, SecondPin As Integer
Public PinInput  As Integer
Public PinOutput As Integer
Public SecondPinIndex As Integer
Public FirstPinIndex As Integer
Public NewProject As Boolean
Public ValueNum As Integer
Public WireClick As Integer
Public CheckSelect As Boolean
Public WiringMode As Boolean
Public SaveStatus As Boolean
Public ShowOutput As Boolean
Public OpenRem As Boolean
Public Environment As Boolean
Public User, Password As String

'Data Director Variables
'เอาไว้เก็บ Directory ที่เก็บไฟล์ Mlt ทุกไฟล์ที่จะใช้ใน Project
    Dim DirMlt
'เอาไว้สร้าง Egine
    Public oEngine As New ddoEngine
'เอาไว้สร้าง Project
    Public oProject As ddoProject
'เอาไว้สร้าง Model
    'Model type of gate
    Public oMType As ddoModel
    'Model Project
    Public oMProject As ddoModel
    'Model Wire
    Public oMWire As ddoModel
    'Model  Component บน Edit
    Public oMComponent As ddoModel
'เอาไว้สร้าง DataGroup
    'สร้าง Group type of gate
    Public oDGType As ddoDataGroup
    'สร้าง Group Project
    Public oDGProject As ddoDataGroup
    'สร้าง Group Wire
    Public oDGWire As ddoDataGroup
    'สร้าง Group Component
    Public oDGComponent As ddoDataGroup

Public Sub clearcollection(ByRef coll1 As Collection)
        Dim i As Integer
        For i = 1 To coll1.Count
            coll1.Remove 1
        Next
End Sub
       
Public Sub ConnectPin(FirstOrSec As String)
    'เอา index ของ ListType ของ Gate ชนิดนั้น
    Dim Index As Integer
    Dim C As Integer
    Dim Xtmp, Ytmp, Xtmp1 As Integer
    Index = CInt(Gate(IndexGate).Tag)
    C = 0
    CheckSelect = False
    For i = 2 To ListPinType(Index).ListCount Step 4
        C = C + 1
        Xtmp = CInt(ListPinType(Index).List(i + 1)) * Gate(IndexGate).Width / CInt(GatePicContain.ListImages(CInt(Gate(IndexGate).Tag)).Tag)
        If ListPinType(Index).List(i) = CStr(PinInput) Then
            Xtmp1 = Xtmp + 100
        Else
            Xtmp1 = Xtmp
            Xtmp = Xtmp1 - 100
        End If
        Ytmp = CInt(ListPinType(Index).List(i + 2)) * Gate(IndexGate).Height / CInt(GatePicContain.ListImages(CInt(Gate(IndexGate).Tag)).Tag)
        If Xtmp <= Xrel And Xrel < Xtmp1 And _
            Ytmp - 50 <= Yrel And Yrel < Ytmp + 50 Then
            If FirstOrSec = "first" Then
                FirstPin = C
                FirstPinIndex = i - 1
                CheckSelect = True
                Exit For
            Else
                If FirstOrSec = "sec" And ListPinType(Index).List(i) = CStr(PinInput) Then
                    SecondPin = C
                    SecondPinIndex = i - 1
                    CheckSelect = True
                    Exit For
                End If
            End If
        End If
    Next i
End Sub

Public Sub RemoveProject()
    Dim oVproject As ddoTable
    Dim Proj_id As Integer
    Main.MousePointer = 11
    Set oVproject = oDGProject.CreateVirtualTable
    oDGProject.BeginTransaction
    oVproject.QueryCommand = "select project_id from project_tab where project_name = '" & ProjectName & "'"
    oVproject.ExecuteQueryCommand
    Proj_id = oVproject.Columns(1).Value
    oVproject.DeleteCommand = "delete from wire_tab where project_id = " + CStr(Proj_id)
    oVproject.ExecuteCommand DELETE_CMD
    oVproject.DeleteCommand = "delete from pin_tab where project_id = " + CStr(Proj_id)
    oVproject.ExecuteCommand DELETE_CMD
    oVproject.DeleteCommand = "delete from comp_tab where project_id = " + CStr(Proj_id)
    oVproject.ExecuteCommand DELETE_CMD
    oVproject.DeleteCommand = "delete from project_tab where project_id = " + CStr(Proj_id)
    oVproject.ExecuteCommand DELETE_CMD
    oDGProject.CommitTransaction
    Call DeleteAndLogoffTable(oDGProject, oVproject)
    Call SetEditMode
    Main.MousePointer = 0
End Sub

Public Sub SetSaveStatus()
    If SaveStatus Then
        Toolbar.Buttons(3).Enabled = True
        MSaveProject.Enabled = True
    Else
        Toolbar.Buttons(3).Enabled = False
        MSaveProject.Enabled = False
    End If
End Sub

Public Function sim1comp(Proj_id As Integer, compid As Integer) As Integer
    
    Dim oVproject As ddoTable
    Dim oVcomp, Vpin As ddoTable
    Dim oVpin  As ddoTable
    Dim oVtruth As ddoTable
    Dim tempcomp, comp_next As Integer
    Dim total_input, total_terminal As Integer
    Dim gen_inlis() As Integer
    Dim Gen_inlist As String
    Dim outpin As Integer
    Dim Gen_v As Integer
                
     On Error GoTo ErrorTrap:
    
                Set oVproject = oDGProject.CreateVirtualTable
                Set oVcomp = oDGComponent.CreateVirtualTable
                Set oVpin = oDGComponent.CreateVirtualTable
                Set oVtruth = oDGType.CreateVirtualTable
    
                oVcomp.QueryCommand = "SELECT gettype(comp_opaque) FROM comp_tab WHERE project_id=" & Proj_id & " and getid(comp_opaque)=" & compid
                oVcomp.ExecuteQueryCommand
                Gen_ctype = oVcomp.Columns(1).Value
                
                Gen_inlist = ""
                oVpin.QueryCommand = "SELECT getvalue(pin_opaque)  FROM pin_tab  WHERE project_id=" & Proj_id & " and getcomp(pin_opaque) =" & compid & " and getio(pin_opaque)=0"
                oVpin.ExecuteQueryCommand
                While Not oVpin.EOT
                    Gen_inlist = Gen_inlist + oVpin.Columns(1).Value + " "
                    oVpin.NextRecord
                Wend
                oVtruth.QueryCommand = "SELECT outputval  FROM truth_tab  WHERE type_id=" & Gen_ctype & " and tosequence(input_list)= '" & Trim(Gen_inlist) & "'"
                oVtruth.ExecuteQueryCommand
                Gen_v = oVtruth.Columns(1).Value
                oVpin.QueryCommand = "SELECT getid(pin_opaque)  FROM pin_tab  WHERE project_id=" & Proj_id & " and getcomp(pin_opaque) =" & compid & " and getio(pin_opaque)=1"
                oVpin.ExecuteQueryCommand
                outpin = oVpin.Columns(1).Value
                oVpin.QueryCommand = "EXECUTE PROCEDURE pinupdatevalue(" & Proj_id & "," & compid & "," & outpin & "," & Gen_v & ")"
                oVpin.ExecuteQueryCommand
                sim1comp = 0
                Exit Function
ErrorTrap:
                sim1comp = -999
End Function

Public Function simall(Proj_id As Integer) As Integer
    
    Dim oVproject As ddoTable
    Dim oVtype As ddoTable
    Dim oVcomp, Vpin As ddoTable
    Dim oVwire As ddoTable
    Dim oVpin  As ddoTable
    Dim oVtruth As ddoTable
    
    Dim current_sim As New Collection
    Dim next_sim As New Collection
    
    Dim total_input, total_terminal As Integer
    Dim insim As Boolean
    Dim gen_inlis() As Integer
    
    On Error GoTo ErrorTrap
    
    Set oVproject = oDGProject.CreateVirtualTable
    Set oVtype = oDGType.CreateVirtualTable
    Set oVcomp = oDGComponent.CreateVirtualTable
    Set oVpin = oDGComponent.CreateVirtualTable
    Set oVwire = oDGWire.CreateVirtualTable
    Set oVtruth = oDGType.CreateVirtualTable
    
    oVcomp.QueryCommand = "SELECT getid(comp_opaque),gettype(comp_opaque) FROM comp_tab WHERE project_id=" & Proj_id
    oVcomp.ExecuteQueryCommand
    oVcomp.FirstRecord
    While Not oVcomp.EOT
        oVtype.QueryCommand = "SELECT type_input_size  FROM component_type_tab WHERE type_id=" & oVcomp.Columns(2).Value
        oVtype.ExecuteQueryCommand
        total_input = oVtype.Columns(1).Value
        oVpin.QueryCommand = "SELECT count(*)  FROM pin_tab  WHERE project_id=" & Proj_id & " and checkterm(pin_opaque)=1 and getcomp(pin_opaque) = " & oVcomp.Columns(1).Value & " and getio(pin_opaque)=0"
        oVpin.ExecuteQueryCommand
        total_terminal = oVpin.Columns(1).Value
        If total_input = total_terminal Then
            current_sim.Add Item:=CInt(oVcomp.Columns(1).Value)
        End If
        oVcomp.NextRecord
    Wend
    insim = True
   While insim
        Dim tempcomp As Variant
        For Each tempcomp In current_sim             '  ??????????? Simulate ??? ? Component ????????? current_sim
            Dim foundcomp As Boolean
            foundcomp = False
            For Each cnext In next_sim                      ' ?????????????????????? Component ????????? Next_sim ???????
                If cnext = tempcomp Then                        ' ?????????????? Simulate
                    foundcomp = True
                    Exit For
                End If
            Next
            If Not foundcomp Then
                Dim d As Integer
                Dim Gen_outpin As Integer
                
              d = sim1comp(Proj_id, CInt(tempcomp))            '????? Simulate Component ??????????????????? tempcomp
                 
                Dim wireconnect_sim As New Collection
                Call clearcollection(wireconnect_sim)
                oVpin.QueryCommand = "SELECT getid(pin_opaque)  FROM pin_tab  WHERE project_id=" & Proj_id & " and getcomp(pin_opaque) =" & tempcomp & " and getio(pin_opaque)=1"
                oVpin.ExecuteQueryCommand
                Gen_outpin = oVpin.Columns(1).Value
                oVwire.QueryCommand = "SELECT getid(wire_opaque)  FROM wire_tab  WHERE project_id=" & Proj_id & " and getfirstcomp(wire_opaque)=" & tempcomp & " and getfirstpin(wire_opaque) = " & Gen_outpin
                oVwire.ExecuteQueryCommand
                If oVwire.TotalRecordCount <> 0 Then
                        oVwire.FirstRecord
                        While Not oVwire.EOT
                            wireconnect_sim.Add oVwire.Columns(1).Value
                            oVwire.NextRecord
                        Wend
                End If
                If wireconnect_sim.Count = 0 Then       ' ???????????????????????????? Ouput ???? Component ????
                    Exit For
                End If
                
                Dim wtemp As Variant
                For Each wtemp In wireconnect_sim
                    Dim outpinvalue As Integer
                    Dim sec_cid, sec_pid As Integer
                    oVpin.QueryCommand = "SELECT getvalue(pin_opaque)  FROM pin_tab  WHERE project_id=" & Proj_id & " and getcomp(pin_opaque) =" & tempcomp & " and getio(pin_opaque)=1"
                    oVpin.ExecuteQueryCommand
                    outpinvalue = oVpin.Columns(1).Value
                    oVwire.QueryCommand = "EXECUTE PROCEDURE wireupdatevalue(" & Proj_id & "," & wtemp & "," & outpinvalue & ")"
                    oVwire.ExecuteQueryCommand
                    oVwire.QueryCommand = "SELECT getseccomp(wire_opaque),getsecpin(wire_opaque)  FROM wire_tab  WHERE project_id=" & Proj_id & " and getid(wire_opaque) = " & wtemp
                    oVwire.ExecuteQueryCommand
                    sec_cid = oVwire.Columns(1).Value
                    sec_pid = oVwire.Columns(2).Value
                    If sec_cid <> 0 Then
                        oVpin.QueryCommand = "EXECUTE PROCEDURE pinupdatevalue(" & Proj_id & "," & sec_cid & "," & sec_pid & "," & outpinvalue & ")"
                        oVpin.ExecuteQueryCommand
                        Dim tc As Variant
                        Dim cfound   As Boolean
                        cfound = False
                        For Each tc In next_sim
                            If CInt(tc) = sec_cid Then
                                cfound = True
                                Exit For
                            End If
                        Next
                        If Not cfound Then       ' ???? Component ???????????????????????????? next_sim ????????????????? Insert
                            next_sim.Add sec_cid
                        End If
                    End If
                Next                    'for each wtemp
            End If                      '  if comp_next=0
        Next                        ' for each tempcomp
        If next_sim.Count = 0 Then
            insim = False
        Else
            Call clearcollection(current_sim)
            For Each innext In next_sim
                current_sim.Add innext
            Next
            Call clearcollection(next_sim)
        End If                  ' next_sim.count =0
    Wend
    simall = 0
    Exit Function
ErrorTrap:
    simall = -999
End Function
Public Sub AddComponent(GateIndex As Integer)
        'Load gate
        GateNum = GateNum + 1
        Load Gate(GateNum)
        Gate(GateNum).Tag = GateIndex
        Gate(GateNum).Left = PixelSize
        Gate(GateNum).Top = PixelSize
        Set Gate(GateNum).Picture = GatePicContain.ListImages(GateIndex).Picture
        Gate(GateNum).Visible = True
        'Load Pin
        Load PinValue(GateNum)
        Load PinTerm(GateNum)
        PinValue(GateNum).Tag = GateIndex
        PinTerm(GateNum).Tag = GateIndex
        'Comp_id
        PinValue(GateNum).AddItem 0, 0
        PinTerm(GateNum).AddItem 1, 0
        'Pin
        Dim i As Integer
        For i = 1 To ListPinType(GateIndex).List(0)
            PinValue(GateNum).AddItem 0, i
            PinTerm(GateNum).AddItem 1, i
        Next i
        'Gate Description
        Load GateDesc(GateNum)
        GateDesc(GateNum).Left = Gate(GateNum).Left + 100
        GateDesc(GateNum).Top = Gate(GateNum).Top - 300
        GateDesc(GateNum).Visible = True
End Sub

Public Sub BeforeDrawing()
    If Not EditMode Then
        Call UnLoadValueText
        EditMode = True
        Call SetEditMode
    Else
        Toolbar.Buttons(4).Value = tbrPressed
    End If
End Sub

Public Sub BeforeSimulate()
    If EditMode Then
        ValueNum = 0
        Call LoadValueText
        EditMode = False
        Call SetEditMode
    Else
        Toolbar.Buttons(5).Value = tbrPressed
    End If
End Sub


Public Sub BeginWiring(Index As Integer)
    'เลือก Pin
    Call ConnectPin("first")
    If CheckSelect Then
        Dim ListTypeIndex As Integer
        'เอา index ของ ListType ของ Gate ชนิดนั้น
        ListTypeIndex = GatePicContain.ListImages(CInt(Gate(Index).Tag)).Index
        FirstComp = Index
        Xbgn = Gate(Index).Left + CInt(ListPinType(ListTypeIndex).List(FirstPinIndex + 2)) * Gate(Index).Width / CInt(GatePicContain.ListImages(ListTypeIndex).Tag)
        Ybgn = Gate(Index).Top + CInt(ListPinType(ListTypeIndex).List(FirstPinIndex + 3)) * Gate(Index).Height / CInt(GatePicContain.ListImages(ListTypeIndex).Tag)
        WireNum = WireNum + 1
        LineNum = LineNum + 1
        Load Wire(LineNum)
    Else
        Wiring = False
    End If
End Sub

Public Sub CancelWire()
    Dim Ctrl As Line
    For Each Ctrl In Main.Wire
        If Ctrl.Tag = "" Then Ctrl.Tag = 0
        If Ctrl.Tag = WireNum Then Unload Wire(Ctrl.Index)
    Next Ctrl
    Wiring = False
End Sub

Public Sub ClearMainForm()
    Dim Ctrl As PictureBox
    Main.MousePointer = 11
    For Each Ctrl In Main.Gate
        If Ctrl.Index <> 0 Then
            Unload PinValue(Ctrl.Index)
            Unload PinTerm(Ctrl.Index)
            Unload GateDesc(Ctrl.Index)
            Unload Gate(Ctrl.Index)
        End If
    Next Ctrl
    Dim Ctrl1 As Line
    For Each Ctrl1 In Main.Wire
        If Ctrl1.Index <> 0 Then
            Unload Wire(Ctrl1.Index)
        End If
    Next Ctrl1
    Dim Ctrl2 As ListBox
    For Each Ctrl2 In Main.WireProp
        If Ctrl2.Index <> 0 Then
            Unload WireProp(Ctrl2.Index)
        End If
    Next Ctrl2
    If Not EditMode Then Call UnLoadValueText
    Call SetGUI
    Main.MousePointer = 0
End Sub

Public Sub ClickLine(X As Single, Y As Single)
    Dim LineTemp As Line
    Dim Count As Integer
    Dim Index As Integer
    If Toolbar.Buttons(8).Value = tbrPressed Then
        Count = 0
        For Each LineTemp In Main.Wire
            If ((X <= LineTemp.X2 And X >= LineTemp.X1) Or (X <= LineTemp.X1 And X >= LineTemp.X2)) _
                And ((Y <= LineTemp.Y2 And Y >= LineTemp.Y1) Or (Y <= LineTemp.Y1 And Y >= LineTemp.Y2)) Then
                    Count = Count + 1
                    Index = LineTemp.Tag
                    If Count > 1 Then Exit For
            End If
        Next LineTemp
        If Count = 1 Then
            WireClick = Index
            Toolbar.Buttons(6).Enabled = True
        End If
    End If
End Sub

Public Sub CreateWireLine(LocXY As String)
    Dim LocXYtemp As String
    Do While LocXY <> ""
        Trim (LocXY)
        i = InStr(LocXY, "&")
        LocXYtemp = Left(LocXY, i - 1)
        LocXY = Right(LocXY, Len(LocXY) - i)
        LineNum = LineNum + 1
        Load Wire(LineNum)
        Wire(LineNum).Tag = WireNum
        Wire(LineNum).X1 = CInt(LocXYtemp)
        Trim (LocXY)
        i = InStr(LocXY, " ")
        LocXYtemp = Left(LocXY, i - 1)
        LocXY = Right(LocXY, Len(LocXY) - i)
        Wire(LineNum).Y1 = CInt(LocXYtemp)
        Trim (LocXY)
        i = InStr(LocXY, "&")
        LocXYtemp = Left(LocXY, i - 1)
        LocXY = Right(LocXY, Len(LocXY) - i)
        Wire(LineNum).X2 = CInt(LocXYtemp)
        Trim (LocXY)
        i = InStr(LocXY, " ")
        If i = 0 Then i = Len(LocXY) + 1
        LocXYtemp = Left(LocXY, i - 1)
        If i = Len(LocXY) + 1 Then i = i - 1
        LocXY = Right(LocXY, Len(LocXY) - i)
        Wire(LineNum).Y2 = CInt(LocXYtemp)
        Wire(LineNum).Visible = True
    Loop
End Sub

Public Sub CutGateAndWire()
    If EditMode Then
        If Not WiringMode Then
            Call CutWireFromGate(IndexGate)
            Unload PinValue(IndexGate)
            Unload PinTerm(IndexGate)
            Unload GateDesc(IndexGate)
            Unload Gate(IndexGate)
            Toolbar.Buttons(6).Enabled = False
        Else
            Call CutWire(WireClick)
            Toolbar.Buttons(6).Enabled = False
        End If
        Cansim = False
        SaveStatus = True
        Call SetEditMode
    End If
End Sub
Public Sub CutWire(Index As Integer)
    'ลบ line จากหน้าจอ
    Dim Ctrl As Line
    For Each Ctrl In Main.Wire
        If Ctrl.Tag = "" Then Ctrl.Tag = 0
        If Ctrl.Tag = Index Then Unload Wire(Ctrl.Index)
    Next Ctrl
    'set ขา terminal ที่ First Component
    FirstComp = WireProp(Index).List(0)
    FirstPin = WireProp(Index).List(1)
    SecondComp = WireProp(Index).List(2)
    SecondPin = WireProp(Index).List(3)
    Unload WireProp(Index)
    If ListPinType(Gate(FirstComp).Tag).List((FirstPin - 1) * 4 + 2) = PinOutput Then
        Call UpdateTerminal("sec", 1)
    Else
        'Update First Comp
        Dim Ctrl2 As ListBox
        Dim Count As Integer
        Count = 0
        For Each Ctrl2 In Main.WireProp
            If (Ctrl2.List(0) = CStr(FirstComp) And Ctrl2.List(1) = CStr(FirstPin)) Or _
                (Ctrl2.List(2) = CStr(FirstComp) And Ctrl2.List(3) = CStr(FirstPin)) Then
                Count = Count + 1
                Exit For
            End If
        Next Ctrl2
        If Count > 0 Then
            If ThatConnectOutput("first") Then
                Call UpdateTerminal("first", 0)
            Else
                Call UpdateTerminal("first", 1)
            End If
        Else
            Call UpdateTerminal("first", 1)
        End If
        'Update Second Comp
        Count = 0
        For Each Ctrl2 In Main.WireProp
            If Ctrl2.List(0) = CStr(SecondComp) And Ctrl2.List(1) = CStr(SecondPin) Or _
                Ctrl2.List(2) = CStr(SecondComp) And Ctrl2.List(3) = CStr(SecondPin) Then
                Count = Count + 1
                Exit For
            End If
        Next Ctrl2
        If Count > 0 Then
            If ThatConnectOutput("sec") Then
                Call UpdateTerminal("sec", 0)
            Else
                Call UpdateTerminal("sec", 1)
            End If
        Else
            Call UpdateTerminal("sec", 1)
        End If
    End If
    Cansim = False
End Sub

Public Sub CutWireFromGate(Index As Integer)
    If Not Main.WireProp Is Nothing Then
        Dim Ctrl1 As ListBox
        For Each Ctrl1 In Main.WireProp
            If Ctrl1.List(0) = CStr(Index) Or Ctrl1.List(2) = CStr(Index) Then
                Dim Ctrl2 As Line
                For Each Ctrl2 In Main.Wire
                    If Ctrl2.Tag = "" Then Ctrl2.Tag = 0
                    If Ctrl2.Tag = Ctrl1.Index Then Unload Wire(Ctrl2.Index)
                Next Ctrl2
                'Set New Terminal
                Call CutWire(Ctrl1.Index)
            End If
        Next Ctrl1
    End If
End Sub


Public Sub DeleteAndLogoffTable(ByRef oDataGroup As ddoDataGroup, ByRef oVTable As ddoTable)
    oDataGroup.DeleteVirtualTable (oVTable.Name)
    Set oVTable = Nothing
End Sub

Public Sub EndWiring(Index As Integer)
    Dim ListTypeIndex As Integer
    SecondComp = Index
    'เลือก Pin Input
    Call ConnectPin("sec")
    'เอา index ของ ListType ของ Gate ชนิดนั้น
    If CheckSelect Then
        Dim WirePropTemp As ListBox
        Dim WiringOK As Boolean
        WiringOK = True
        If PinTerm(SecondComp).List(SecondPin) = 0 And _
            ListPinType(CInt(Gate(FirstComp).Tag)).List((FirstPin - 1) * 4 + 2) = CStr(PinOutput) Then WiringOK = False
        If WiringOK Then
            ListTypeIndex = GatePicContain.ListImages(CInt(Gate(Index).Tag)).Index
            Xend = Gate(Index).Left - 10
            Yend = Gate(Index).Top + CInt(ListPinType(ListTypeIndex).List(SecondPinIndex + 3)) * Gate(Index).Height / CInt(GatePicContain.ListImages(ListTypeIndex).Tag)
            LineNum = LineNum + 1
            Load Wire(LineNum)
            Wire(LineNum).Tag = WireNum
            'Set ค่า X2,Y2 ของ Line เส้นเก่าก่อน
            If Abs(Xbgn - Xend) > Abs(Ybgn - Yend) Then
                Wire(LineNum - 1).X2 = Xend
                Wire(LineNum - 1).Y2 = Ybgn
            Else
                Wire(LineNum - 1).X2 = Xbgn
                Wire(LineNum - 1).Y2 = Yend
            End If
            Xbgn = Wire(LineNum - 1).X2
            Ybgn = Wire(LineNum - 1).Y2
            Wire(LineNum).X1 = Xbgn
            Wire(LineNum).Y1 = Ybgn
            Wire(LineNum).X2 = Xend
            Wire(LineNum).Y2 = Yend
            Wire(LineNum).Visible = True
            'Load Wire Property
            Load WireProp(WireNum)
            WireProp(WireNum).Tag = WireNum
            WireProp(WireNum).AddItem FirstComp, 0
            WireProp(WireNum).AddItem FirstPin, 1
            WireProp(WireNum).AddItem SecondComp, 2
            WireProp(WireNum).AddItem SecondPin, 3
            WireProp(WireNum).AddItem 0, 4
            'Set Un Terminal
            If ListPinType(CInt(Gate(FirstComp).Tag)).List(FirstPinIndex + 1) = PinOutput Then
                Call UpdateTerminal("first", 0)
            Else
                If PinTerm(FirstComp).List(FirstPin) = 0 Or PinTerm(SecondComp).List(SecondPin) = 0 Then
                    Call UpdateTerminal("first", 0)
                End If
            End If
            Cansim = False
            SaveStatus = True
            Call SetEditMode
        Else
            MsgBox "Can't Connect Wire (This Input have been already connect output)", vbCritical, PeojectName
            Call CancelWire
        End If
    Else
        Call CancelWire
    End If
End Sub

Public Function ExistsProject(ProjName As String) As Boolean
    Dim oVProjectName As ddoTable
    Set oVProjectName = oDGProject.CreateVirtualTable
    oVProjectName.QueryCommand = "select count(project_id) from project_tab where project_name = '" + ProjName + "'"
    oVProjectName.ExecuteCommand QUERY_CMD
    If oVProjectName.Columns(1).Value = 0 Then
        ExistsProject = False  'ไม่มีชื่อ Project นี้อยู่
    Else
        ExistsProject = True 'มีชื่ออยู่
    End If
    Call DeleteAndLogoffTable(oDGProject, oVProjectName)
End Function


Public Sub GoSimulate()
    StatusBar.SimpleText = "Simulating......."
    Main.MousePointer = 11
    'get project id
    Dim oVproject As ddoTable
    Set oVproject = oDGProject.CreateVirtualTable
    oDGProject.BeginTransaction
    oVproject.QueryCommand = "select project_id from project_tab where project_name = '" & ProjectName & "'"
    oVproject.ExecuteCommand QUERY_CMD
    'update value terminal
    Dim Comp_id As Integer
    Dim Pin_id As Integer
    Dim VTextTemp As Label
    Dim oVPinValue As ddoTable
    Set oVPinValue = oDGComponent.CreateVirtualTable
    oDGComponent.BeginTransaction
    'ก่อน simulate
    For Each VTextTemp In Main.ValueText
        If VTextTemp.Index <> 0 Then
            Trim (VTextTemp.Tag)
            i = InStr(VTextTemp.Tag, "&")
            Comp_id = CInt(Left(VTextTemp.Tag, i - 1))
            Pin_id = CInt(Right(VTextTemp.Tag, Len(VTextTemp.Tag) - i))
            If VTextTemp.Enabled Then
                oVPinValue.QueryCommand = "execute procedure pinupdatevalue(" & oVproject.Columns(1).Value _
                                                    & "," & Comp_id & "," & Pin_id & "," & CInt(VTextTemp.Caption) _
                                                    & ")"
                oVPinValue.ExecuteCommand QUERY_CMD
            End If
        End If
    Next VTextTemp
    'Simulate
    If simall(oVproject.Columns(1).Value) = -999 Then
        MsgBox "Can't Simulate", vbCritical, "Warning"
    Else
    'หลัง Simulate แล้ว
        For Each VTextTemp In Main.ValueText
            If VTextTemp.Index <> 0 Then
                Trim (VTextTemp.Tag)
                i = InStr(VTextTemp.Tag, "&")
                Comp_id = CInt(Left(VTextTemp.Tag, i - 1))
                Pin_id = CInt(Right(VTextTemp.Tag, Len(VTextTemp.Tag) - i))
                oVPinValue.QueryCommand = "select getvalue(pin_opaque) from pin_tab " _
                                                     & " where project_id = " & oVproject.Columns(1).Value _
                                                     & " and getid(pin_opaque) = " & Pin_id _
                                                     & " and getcomp(pin_opaque) = " & Comp_id
                oVPinValue.ExecuteCommand QUERY_CMD
                VTextTemp.Caption = oVPinValue.Columns(1).Value
            End If
        Next VTextTemp
        'Update ค่า Wire
        Dim WirePTemp As ListBox
        For Each WirePTemp In Main.WireProp
            If WirePTemp.Index <> 0 Then
                oVPinValue.QueryCommand = "select getvalue(wire_opaque) from wire_tab" _
                                                     & " where project_id = " & oVproject.Columns(1).Value _
                                                     & " and getid(wire_opaque) = " & WirePTemp.Index
                oVPinValue.ExecuteCommand QUERY_CMD
                WirePTemp.List(4) = oVPinValue.Columns(1).Value
                WirePTemp.Tag = oVPinValue.Columns(1).Value
            End If
        Next WirePTemp
    End If
    oDGProject.CommitTransaction
    oDGComponent.CommitTransaction
    Call SetEditMode
    StatusBar.SimpleText = "Simulate Mode"
    Main.MousePointer = 0
End Sub


Private Sub LoadAboutType()
    'ประกาศตัวแปรเอาไว้ใช้ในการเก็บรูปลง imagelist
    Dim PicTemp As ListImage
    Dim DirTemp As String
    Dim oVTypeDesc As ddoTable
    Dim oVTypePic As ddoTable
    Dim oVPinType As ddoTable
    Dim Count As Integer
    'Clear ข้อมูลใน Gate Type List Box
    ListGateName.Clear
    '*************ดึงข้อมูลเกี่ยวกับ Type*******************************************
    Set oVTypeDesc = oDGType.CreateVirtualTable
    Set oVTypePic = oDGType.CreateVirtualTable
    Set oVPinType = oDGType.CreateVirtualTable
    oVTypeDesc.QueryCommand = "select count(*) from component_type_tab"
    oVTypeDesc.ExecuteCommand QUERY_CMD
    Count = oVTypeDesc.Columns(1).Value
    oVTypeDesc.QueryCommand = "select type_id,type_name,type_size from component_type_tab"
    oVTypeDesc.ExecuteCommand QUERY_CMD
    If oVTypeDesc.TotalRecordCount = 0 Then
        MsgBox "oVTypeDesc No results were returned."
        Exit Sub
    Else
        oVTypeDesc.FirstRecord
        'เริ่ม Loop เก้บข้อมูลเกี่ยวกับภาพ
        For i = 0 To Count - 1
            'ใส่ค่า Gate Type Name ลงใน List Box
            ListGateName.AddItem (oVTypeDesc.Columns(2).Value), i
            'เตรียม directory เอาไว้เก็บภาพ gate
            DirTemp = DirMlt & oVTypeDesc.Columns(2).Value & ".jpg!"
            'เตรียม sql statement ในการ select รูปพร้อมทั้ง convert กลับเป็น file ให้
            Trim (DirTemp)
            oVTypePic.QueryCommand = "select Lotofile(picture, '" & DirTemp & "' ,'client') from component_type_tab where type_id = " & oVTypeDesc.Columns(1).Value
            oVTypePic.ExecuteCommand QUERY_CMD
            'ตัด '!' ออกจาก DirTemp
            DirTemp = Left(DirTemp, Len(DirTemp) - 1)
            'ใส่ property ของ gate ลง images list box
            Set PicTemp = GatePicContain.ListImages.Add(oVTypeDesc.Columns(1).Value, oVTypeDesc.Columns(2).Value, LoadPicture(DirTemp))
            GatePicContain.ListImages(oVTypeDesc.Columns(2).Value).Tag = oVTypeDesc.Columns(3).Value
            '**********************เก็บลง GridPinType****************************************************
            oVPinType.QueryCommand = "select pin_type_id,pin_spec,getxpos(pin_type_loc),getypos(pin_type_loc) from pin_type_tab where type_id = " & oVTypeDesc.Columns(1).Value
            oVPinType.ExecuteCommand QUERY_CMD
            If oVPinType.TotalRecordCount = 0 Then
                MsgBox "oVPinType No results were returned."
                Exit Sub
            Else
                oVPinType.FirstRecord
                Load ListPinType(oVTypeDesc.Columns(1).Value)
                ListPinType(oVTypeDesc.Columns(1).Value).Tag = oVTypeDesc.Columns(2).Value
                ListPinType(oVTypeDesc.Columns(1).Value).AddItem oVPinType.TotalRecordCount, 0
                For row = 1 To oVPinType.TotalRecordCount
                    ListPinType(oVTypeDesc.Columns(1).Value).AddItem oVPinType.Columns(1).Value, (row - 1) * 4 + 1
                    ListPinType(oVTypeDesc.Columns(1).Value).AddItem oVPinType.Columns(2).Value, (row - 1) * 4 + 2
                    ListPinType(oVTypeDesc.Columns(1).Value).AddItem oVPinType.Columns(3).Value, (row - 1) * 4 + 3
                    ListPinType(oVTypeDesc.Columns(1).Value).AddItem oVPinType.Columns(4).Value, (row - 1) * 4 + 4
                    oVPinType.NextRecord
                Next row
            End If
            '*************************************************************************
            oVTypeDesc.NextRecord
        Next i
    End If
    'Delete และ ประกาศไม่ใช้ oVTable แล้ว
    Call DeleteAndLogoffTable(oDGType, oVTypeDesc)
    Call DeleteAndLogoffTable(oDGType, oVTypePic)
    Call DeleteAndLogoffTable(oDGType, oVPinType)
End Sub

Public Sub LoadProjectNameAndDesc()
    Dim oVAboutProject As ddoTable
    Dim oVLoadTable As ddoTable
    OpenProjForm.ProjName.Clear
    OpenProjForm.ProjDescList.Clear
    OpenProjForm.ProjDesc.Text = ""
    Set oVAboutProject = oDGProject.CreateVirtualTable
    Set oVLoadTable = oDGProject.CreateVirtualTable
    oVAboutProject.QueryCommand = "select count(project_id) from project_tab"
    oVAboutProject.ExecuteQueryCommand
    Dim Count As Integer
    Count = oVAboutProject.Columns(1).Value
    oVLoadTable.QueryCommand = "select project_name,project_desc from project_tab order by project_name asc"
    oVLoadTable.ExecuteCommand QUERY_CMD
    oVLoadTable.FirstRecord
    For i = 0 To Count - 1
        OpenProjForm.ProjName.List(i) = oVLoadTable.Columns(1).Value
        OpenProjForm.ProjDescList.List(i) = oVLoadTable.Columns(2).Value
        oVLoadTable.NextRecord
    Next i
    Call DeleteAndLogoffTable(oDGProject, oVAboutProject)
    Call DeleteAndLogoffTable(oDGProject, oVLoadTable)
End Sub

Public Sub LoadValueText()
    For Each GateTemp In Main.Gate
        Index = GateTemp.Index
        If Index <> 0 Then
            For i = 1 To CInt(ListPinType(CInt(GateTemp.Tag)).List(0))
                ValueNum = ValueNum + 1
                Load ValueText(ValueNum)
                ValueText(ValueNum).Tag = CStr(Index) & "&" & CStr(i)
                If ListPinType(CInt(GateTemp.Tag)).List((i - 1) * 4 + 2) = 1 Then
                    'OutPut
                    ValueText(ValueNum).ForeColor = QBColor(1)
                    ValueText(ValueNum).Caption = "Idle"
                    ValueText(ValueNum).Enabled = False
                    ValueText(ValueNum).Left = Gate(Index).Left + Gate(Index).Width + 50
                    ValueText(ValueNum).Top = Gate(Index).Top + (CInt(ListPinType(CInt(GateTemp.Tag)).List((i - 1) * 4 + 4)) * GateTemp.Height / CInt(GatePicContain.ListImages(CInt(GateTemp.Tag)).Tag)) - 200
                Else
                    If PinTerm(Index).List(i) = 0 Then
                        'Unterminal
                        ValueText(ValueNum).ForeColor = QBColor(1)
                        ValueText(ValueNum).Caption = "Idle"
                        ValueText(ValueNum).Enabled = False
                        ValueText(ValueNum).Left = Gate(Index).Left - ValueText(ValueNum).Width - 50
                        ValueText(ValueNum).Top = Gate(Index).Top + (CInt(ListPinType(CInt(GateTemp.Tag)).List((i - 1) * 4 + 4)) * GateTemp.Height / CInt(GatePicContain.ListImages(CInt(GateTemp.Tag)).Tag)) - 100
                    Else
                        'terminal
                        ValueText(ValueNum).ForeColor = QBColor(4)
                        ValueText(ValueNum).Caption = "0"
                        ValueText(ValueNum).Left = Gate(Index).Left - ValueText(ValueNum).Width - 50
                        ValueText(ValueNum).Top = Gate(Index).Top + (CInt(ListPinType(CInt(GateTemp.Tag)).List((i - 1) * 4 + 4)) * GateTemp.Height / CInt(GatePicContain.ListImages(CInt(GateTemp.Tag)).Tag)) - 100
                    End If
                End If
                ValueText(ValueNum).Visible = True
            Next i
        End If
    Next GateTemp
End Sub



Public Sub SaveProject()
    StatusBar.SimpleText = "Saving Project......."
    Main.MousePointer = 11
    'Clear Project
    Dim ProjID As Integer
    Dim oVproject As ddoTable
    Set oVproject = oDGProject.CreateVirtualTable
    Dim oVProjectOne As ddoTable
    Dim oVProjectTwo As ddoTable
    Set oVProjectOne = oDGProject.CreateVirtualTable
    Set oVProjectTwo = oDGProject.CreateVirtualTable
    oDGProject.BeginTransaction
    oVproject.QueryCommand = "select project_id from project_tab where project_name = '" & ProjectName & "'"
    oVproject.ExecuteCommand QUERY_CMD
    If oVproject.TotalRecordCount <> 0 Then
        ProjID = oVproject.Columns(1).Value
        oDGProject.BeginTransaction
        oVProjectOne.DeleteCommand = "delete from wire_tab where project_id = " + CStr(ProjID)
        oVProjectOne.ExecuteCommand DELETE_CMD
        oVProjectOne.DeleteCommand = "delete from pin_tab where project_id = " + CStr(ProjID)
        oVProjectOne.ExecuteCommand DELETE_CMD
        oVProjectOne.DeleteCommand = "delete from comp_tab where project_id = " + CStr(ProjID)
        oVProjectOne.ExecuteCommand DELETE_CMD
        oVProjectOne.DeleteCommand = "delete from project_tab where project_id = " + CStr(ProjID)
        oVProjectOne.ExecuteCommand DELETE_CMD
    'Insert Project ก่อน
        oVProjectTwo.InsertCommand = "insert into project_tab values (" & ProjID & ",'" & ProjectName & "','" & ProjectDesc & "')"
        oVProjectTwo.ExecuteCommand INSERT_CMD
        oDGProject.CommitTransaction
    Else
    'Insert Project ก่อน
        oVProjectOne.QueryCommand = "select count(project_id) from project_tab"
        oVProjectOne.ExecuteCommand QUERY_CMD
        Max = oVProjectOne.Columns(1).Value
        oVProjectOne.QueryCommand = "select project_id from project_tab order by project_id asc"
        oVProjectOne.ExecuteCommand QUERY_CMD
        If oVProjectOne.TotalRecordCount <> 0 Then
            i = 1
            oVProjectOne.FirstRecord
            Do While i = CInt(oVProjectOne.Columns(1).Value)
                i = i + 1
                oVProjectOne.NextRecord
            Loop
        Else
            i = 1
        End If
        oVProjectOne.QueryCommand = "insert into project_tab values (" & i & " ,'" & ProjectName & "','" & ProjectDesc & "')"
        oVProjectOne.ExecuteCommand QUERY_CMD
    'get project id
        oVProjectOne.QueryCommand = "select project_id from project_tab where project_name = '" & ProjectName & "'"
        oVProjectOne.ExecuteCommand QUERY_CMD
        ProjID = oVProjectOne.Columns(1).Value
    End If

'Save Component
    'เตรียม Component
    Dim GateTemp As PictureBox
    Dim Count As Integer
    Dim oVSave As ddoTable
    Set oVSave = oDGComponent.CreateVirtualTable
    oDGComponent.BeginTransaction
    Count = 0
    For Each GateTemp In Main.Gate
        If GateTemp.Index <> 0 Then
            Count = Count + 1
            oVSave.QueryCommand = "{ call insertnewcomp( " _
                                              & ProjID & "," _
                                              & Count & "," _
                                              & CInt(GateTemp.Tag) & "," _
                                              & GateTemp.Left & "," _
                                              & GateTemp.Top & ",'" _
                                              & GateDesc(GateTemp.Index).Text & "', '') }"
            oVSave.ExecuteCommand QUERY_CMD
            For i = 1 To PinTerm(GateTemp.Index).ListCount - 1
                oVSave.QueryCommand = "{ call pinupdateterm(" _
                                                & ProjID & "," _
                                                & Count & "," _
                                                & i & "," _
                                                & CInt(PinTerm(GateTemp.Index).List(i)) _
                                                & ") }"
                oVSave.ExecuteCommand QUERY_CMD
            Next i
        End If
        Dim CtrlWireProp As ListBox
        For Each CtrlWireProp In Main.WireProp
            If CtrlWireProp.Index <> 0 Then
                If CInt(CtrlWireProp.List(0)) = GateTemp.Index Then
                    CtrlWireProp.List(0) = Count
                Else
                    If CInt(CtrlWireProp.List(2)) = GateTemp.Index Then
                        CtrlWireProp.List(2) = Count
                    End If
                End If
            End If
        Next CtrlWireProp
    Next GateTemp
    'Save Wire
    Dim oVSaveOne As ddoTable
    Dim WirePropTemp As ListBox
    Set oVSaveOne = oDGWire.CreateVirtualTable
    oDGWire.BeginTransaction
    Count = 0
    For Each WirePropTemp In Main.WireProp
        If WirePropTemp.Index <> 0 Then
            oVSaveOne.QueryCommand = " { call insertnewwire(" _
                                                    & ProjID & "," _
                                                    & Count & "," _
                                                    & WirePropTemp.List(0) & "," _
                                                    & WirePropTemp.List(1) & "," _
                                                    & WirePropTemp.List(2) & "," _
                                                    & WirePropTemp.List(3) _
                                                    & ") }"
            oVSaveOne.ExecuteCommand QUERY_CMD
            oVSaveOne.QueryCommand = "{call clearwireloc(" & ProjID & "," & Count & ")}"
            oVSaveOne.ExecuteCommand QUERY_CMD
            Dim CtrlWire As Line
            For Each CtrlWire In Main.Wire
                If CtrlWire.Tag = "" Then CtrlWire.Tag = 0
                If CInt(CtrlWire.Tag) = WirePropTemp.Index Then
                    oVSaveOne.QueryCommand = "{call insertwireloc(" & ProjID & "," & Count & "," & CtrlWire.X1 & "," & CtrlWire.Y1 & ")}"
                    oVSaveOne.ExecuteCommand QUERY_CMD
                    oVSaveOne.QueryCommand = "{call insertwireloc(" & ProjID & "," & Count & "," & CtrlWire.X2 & "," & CtrlWire.Y2 & ")}"
                    oVSaveOne.ExecuteCommand QUERY_CMD
                End If
            Next CtrlWire
        End If
        Count = Count + 1
    Next WirePropTemp
    'Exit
    NewProject = False
    oDGProject.CommitTransaction
    oDGComponent.CommitTransaction
    oDGWire.CommitTransaction
    If Count > 1 Then
        Call DeleteAndLogoffTable(oDGProject, oVproject)
        Call DeleteAndLogoffTable(oDGProject, oVProjectOne)
        Call DeleteAndLogoffTable(oDGProject, oVProjectTwo)
        Call DeleteAndLogoffTable(oDGComponent, oVSave)
        Call DeleteAndLogoffTable(oDGWire, oVSaveOne)
    End If
    PnameTemp = ProjectName
    PdescTemp = ProjectDesc
    Call ClearMainForm
    ProjectName = PnameTemp
    ProjectDesc = PdescTemp
    SaveStatus = False
    Call OpenProjectForm
    Main.MousePointer = 0
End Sub

Public Sub SetDataDirector()
    'สร้าง ddo Engine
    Set oEngine = CreateObject("DataDirector.Engine")
    Set oEngine = New ddoEngine
    'สร้าง Project Object
    Set oProject = oEngine.CreateProject
    oProject.Name = "Logic"
    'สร้าง Model Object
    oEngine.CreateModel ("AboutProject.mlt")
    oEngine.CreateModel ("AboutComponent.mlt")
    oEngine.CreateModel ("AboutWire.mlt")
    oEngine.CreateModel ("AboutType.mlt")
    Set oMProject = oEngine.Models(1)
    Set oMComponent = oEngine.Models(2)
    Set oMWire = oEngine.Models(3)
    Set oMType = oEngine.Models(4)
    'Create และ Logon แต่ละ Group
    UserPwForm.Show vbModal
    If Environment Then
        Call CreateAndLogonDG(oDGProject, "project_tab", "DGProject", DirMlt & "AboutProject.mlt")
        Call CreateAndLogonDG(oDGComponent, "comp_tab", "DGComponent", DirMlt & "AboutComponent.mlt")
        Call CreateAndLogonDG(oDGWire, "wire_tab", "DGWire", DirMlt & "AboutWire.mlt")
        Call CreateAndLogonDG(oDGType, "component_type_tab", "DGType", DirMlt & "AboutType.mlt")
    Else
        MsgBox "No Connection to Database. Program will terminate!!!", vbCritical, ""
        Unload Main
    End If
End Sub

Public Sub CreateAndLogonDG(ByRef oDataGroup As ddoDataGroup, TableName As String, DGName As String, Filename As String)
On Error GoTo ErrorDatabase
    'สร้าง DataGroup Object
    Set oDataGroup = oProject.CreateDataGroup(TableName, DGName, Filename)
    'Logon Database
    oDataGroup.Logon User, Password
    Exit Sub
ErrorDatabase:
    MsgBox "No Connection to Database. Program will terminate!!!", vbCritical, ""
    Environment = False
    Unload Main
    End
End Sub

Public Sub SetMoveGate(MoveOk As Boolean)
    If MoveOk Then
        WiringMode = False
        Toolbar.Refresh
        Toolbar.Buttons(4).Value = tbrPressed
        Toolbar.Buttons(7).Value = tbrPressed
        Toolbar.Buttons(8).Value = tbrUnpressed
        Toolbar.Buttons(6).Enabled = False
        StatusBar.SimpleText = "Drawing Gate Mode"
        If Wiring Then
            Call CancelWire
            Wiring = False
        End If
    Else
        WiringMode = True
        Toolbar.Refresh
        Toolbar.Buttons(4).Value = tbrPressed
        Toolbar.Buttons(7).Value = tbrUnpressed
        Toolbar.Buttons(8).Value = tbrPressed
        Toolbar.Buttons(6).Enabled = False
        Wiring = False
        StatusBar.SimpleText = "Drawing Wire Mode"
    End If
End Sub

Public Function ThatConnectOutput(FirstOrSec As String) As Boolean
    ThatConnectOutput = False
    Dim Count As Integer
    Dim WirePropTemp As ListBox
    Dim i As Integer
    Dim Found As Boolean
    ListCompPin.Clear
    Count = 0
    If FirstOrSec = "first" Then
        ListCompPin.AddItem FirstComp, Count * 2
        ListCompPin.AddItem FirstPin, Count * 2 + 1
    Else
        ListCompPin.AddItem SecondComp, Count * 2
        ListCompPin.AddItem SecondPin, Count * 2 + 1
    End If
    Do
        For Each WirePropTemp In Main.WireProp
            If WirePropTemp.Index <> 0 Then
                If WirePropTemp.List(0) = ListCompPin.List(Count * 2) And WirePropTemp.List(1) = ListCompPin.List(Count * 2 + 1) Then
                    i = 0
                    Found = False
                    Do
                        If WirePropTemp.List(2) = ListCompPin.List(i) And WirePropTemp.List(3) = ListCompPin.List(i + 1) Then
                            Found = True
                            Exit Do
                        End If
                        i = i + 2
                    Loop While i < ListCompPin.ListCount
                    If Not Found Then
                        ListCompPin.AddItem WirePropTemp.List(2), ListCompPin.ListCount
                        ListCompPin.AddItem WirePropTemp.List(3), ListCompPin.ListCount
                        If ListPinType(CInt(Gate(WirePropTemp.List(2)).Tag)).List((CInt(WirePropTemp.List(3)) - 1) * 4 + 2) = CStr(PinOutput) Then
                            ThatConnectOutput = True
                            Exit Function
                        End If
                    End If
                Else
                    If WirePropTemp.List(2) = ListCompPin.List(Count * 2) And WirePropTemp.List(3) = ListCompPin.List(Count * 2 + 1) Then
                        i = 0
                        Found = False
                        Do
                            If WirePropTemp.List(0) = ListCompPin.List(i) And WirePropTemp.List(1) = ListCompPin.List(i + 1) Then
                                Found = True
                                Exit Do
                            End If
                            i = i + 2
                        Loop While i < ListCompPin.ListCount
                        If Not Found Then
                            ListCompPin.AddItem WirePropTemp.List(0), ListCompPin.ListCount
                            ListCompPin.AddItem WirePropTemp.List(1), ListCompPin.ListCount
                            If ListPinType(CInt(Gate(WirePropTemp.List(0)).Tag)).List((CInt(WirePropTemp.List(1)) - 1) * 4 + 2) = CStr(PinOutput) Then
                                ThatConnectOutput = True
                                Exit Function
                            End If
                        End If
                    End If
                End If
            End If
        Next WirePropTemp
        Count = Count + 1
    Loop While Count < ListCompPin.ListCount / 2
End Function

Public Sub UnLoadValueText()
    Dim ValueTextTemp As Label
    For Each ValueTextTemp In Main.ValueText
        If ValueTextTemp.Index <> 0 Then Unload ValueText(ValueTextTemp.Index)
    Next ValueTextTemp
End Sub


Public Sub UpdateTerminal(FirstOrSec As String, VLogic As Integer)
    Dim Count As Integer
    Dim WirePropTemp As ListBox
    Dim i As Integer
    Dim Found As Boolean
    ListCompPin.Clear
    Count = 0
    If FirstOrSec = "first" Then
        ListCompPin.AddItem FirstComp, Count * 2
        ListCompPin.AddItem FirstPin, Count * 2 + 1
    Else
        ListCompPin.AddItem SecondComp, Count * 2
        ListCompPin.AddItem SecondPin, Count * 2 + 1
    End If
    Do
        For Each WirePropTemp In Main.WireProp
            If WirePropTemp.Index <> 0 Then
                If WirePropTemp.List(0) = ListCompPin.List(Count * 2) And WirePropTemp.List(1) = ListCompPin.List(Count * 2 + 1) Then
                    i = 0
                    Found = False
                    Do
                        If WirePropTemp.List(2) = ListCompPin.List(i) And WirePropTemp.List(3) = ListCompPin.List(i + 1) Then
                            Found = True
                            Exit Do
                        End If
                        i = i + 2
                    Loop While i < ListCompPin.ListCount
                    If Not Found Then
                        ListCompPin.AddItem WirePropTemp.List(2), ListCompPin.ListCount
                        ListCompPin.AddItem WirePropTemp.List(3), ListCompPin.ListCount
                    End If
                Else
                    If WirePropTemp.List(2) = ListCompPin.List(Count * 2) And WirePropTemp.List(3) = ListCompPin.List(Count * 2 + 1) Then
                        i = 0
                        Found = False
                        Do
                            If WirePropTemp.List(0) = ListCompPin.List(i) And WirePropTemp.List(1) = ListCompPin.List(i + 1) Then
                                Found = True
                                Exit Do
                            End If
                            i = i + 2
                        Loop While i < ListCompPin.ListCount
                        If Not Found Then
                            ListCompPin.AddItem WirePropTemp.List(0), ListCompPin.ListCount
                            ListCompPin.AddItem WirePropTemp.List(1), ListCompPin.ListCount
                        End If
                    End If
                End If
            End If
        Next WirePropTemp
        Count = Count + 1
    Loop While Count < ListCompPin.ListCount / 2
    i = 0
    Do
        PinTerm(ListCompPin.List(i)).List(ListCompPin.List(i + 1)) = VLogic
        i = i + 2
    Loop While i < ListCompPin.ListCount
End Sub

Public Sub UpdateValuetext(CompPin As String)
    Dim Count As Integer
    Dim WirePropTemp As ListBox
    Dim i As Integer
    Dim Found As Boolean
    ListCompPin.Clear
    Count = 0
    ListCompPin.AddItem Left(CompPin, InStr(CompPin, "&") - 1), Count * 2
    ListCompPin.AddItem Right(CompPin, Len(CompPin) - InStr(CompPin, "&")), Count * 2 + 1
    Do
        For Each WirePropTemp In Main.WireProp
            If WirePropTemp.Index <> 0 Then
                If WirePropTemp.List(0) = ListCompPin.List(Count * 2) And WirePropTemp.List(1) = ListCompPin.List(Count * 2 + 1) Then
                    i = 0
                    Found = False
                    Do
                        If WirePropTemp.List(2) = ListCompPin.List(i) And WirePropTemp.List(3) = ListCompPin.List(i + 1) Then
                            Found = True
                            Exit Do
                        End If
                        i = i + 2
                    Loop While i < ListCompPin.ListCount
                    If Not Found Then
                        ListCompPin.AddItem WirePropTemp.List(2), ListCompPin.ListCount
                        ListCompPin.AddItem WirePropTemp.List(3), ListCompPin.ListCount
                    End If
                Else
                    If WirePropTemp.List(2) = ListCompPin.List(Count * 2) And WirePropTemp.List(3) = ListCompPin.List(Count * 2 + 1) Then
                        i = 0
                        Found = False
                        Do
                            If WirePropTemp.List(0) = ListCompPin.List(i) And WirePropTemp.List(1) = ListCompPin.List(i + 1) Then
                                Found = True
                                Exit Do
                            End If
                            i = i + 2
                        Loop While i < ListCompPin.ListCount
                        If Not Found Then
                            ListCompPin.AddItem WirePropTemp.List(0), ListCompPin.ListCount
                            ListCompPin.AddItem WirePropTemp.List(1), ListCompPin.ListCount
                        End If
                    End If
                End If
            End If
        Next WirePropTemp
        Count = Count + 1
    Loop While Count < ListCompPin.ListCount / 2
    Dim VTextTmp As Label
    i = 0
    Do
        For Each VTextTmp In Main.ValueText
            If VTextTmp.Index <> 0 Then
                If Left(VTextTmp.Tag, InStr(VTextTmp.Tag, "&") - 1) = ListCompPin.List(i) And _
                    Right(VTextTmp.Tag, Len(VTextTmp.Tag) - InStr(VTextTmp.Tag, "&")) = ListCompPin.List(i + 1) Then
                    If VTextTmp.Caption = "0" Then
                        VTextTmp.Caption = "1"
                    Else
                        VTextTmp.Caption = "0"
                    End If
                End If
            End If
        Next VTextTmp
        i = i + 2
    Loop While i < ListCompPin.ListCount
End Sub


Private Sub WriteBackEdit()
    Dim row, column As Integer
    For row = 1 To Edit.Height / PixelSize Step 1
     For column = 1 To Edit.Width / PixelSize Step 1
       Edit.PSet (column * PixelSize, row * PixelSize), QBColor(0)
     Next column
    Next row
End Sub
Public Sub EndProgram()
    Dim Msg As String
    If SaveStatus Then
        Msg = MsgBox("Do you want to save this project?", vbYesNo, "")
        If Msg = vbYes Then
            Call SaveProjectForm
            oDGProject.Logoff
            oDGComponent.Logoff
            oDGWire.Logoff
            oDGType.Logoff
            End
        Else
            If Msg = vbNo Then
                oDGProject.Logoff
                oDGComponent.Logoff
                oDGWire.Logoff
                oDGType.Logoff
                End
            End If
        End If
    Else
        If Environment Then
            oDGProject.Logoff
            oDGComponent.Logoff
            oDGWire.Logoff
            oDGType.Logoff
            End
        Else
            End
        End If
    End If
End Sub

Public Sub LoadGateOnEdit(GateIndex As Integer)
    If EditMode Then
        If Not WiringMode Then
            Cansim = False
            SaveStatus = True
            Call SetEditMode
            Toolbar.Buttons(6).Enabled = False
            Call AddComponent(GateIndex)
        Else
        End If
    End If
End Sub

Public Sub NewProjectForm()
    Dim Msg As String
    If SaveStatus Then
        Msg = MsgBox("Do you want to save this project?", vbYesNoCancel, "")
        If Msg = vbYes Then
            Call SaveProjectForm
            Call ClearMainForm
            NewProject = True
        Else
            If Msg = vbNo Then
                Call ClearMainForm
                NewProject = True
            End If
        End If
    Else
        Call ClearMainForm
        NewProject = True
    End If
End Sub

Public Sub OpenProjectForm()
    Main.MousePointer = 11
    Dim HaveComponent As Boolean
    HaveComponent = False
    'Load Component
    Dim ProjID As Integer
    Dim oVOpen As ddoTable
    Set oVOpen = oDGProject.CreateVirtualTable
    oVOpen.QueryCommand = "select project_id from project_tab where project_name = '" & ProjectName & "'"
    oVOpen.ExecuteCommand QUERY_CMD
    ProjID = oVOpen.Columns(1).Value
    Dim oVOpenComp As ddoTable
    Dim Count As Integer
    Set oVOpenComp = oDGComponent.CreateVirtualTable
    oVOpenComp.QueryCommand = "select count(*) from comp_tab where project_id = " & ProjID
    oVOpenComp.ExecuteCommand QUERY_CMD
    Count = oVOpenComp.Columns(1).Value
    oVOpenComp.QueryCommand = "select getid(comp_opaque),gettype(comp_opaque),getxpos(comp_opaque)," _
                                      & "getypos(comp_opaque),comp_name from comp_tab where project_id = " & ProjID
    oVOpenComp.ExecuteCommand QUERY_CMD
    oVOpenComp.FirstRecord
    For i = 0 To Count - 1
        GateNum = oVOpenComp.Columns(1).Value
        Load Gate(GateNum)
        Gate(GateNum).Tag = oVOpenComp.Columns(2).Value
        Gate(GateNum).Left = oVOpenComp.Columns(3).Value
        Gate(GateNum).Top = oVOpenComp.Columns(4).Value
        Set Gate(GateNum).Picture = GatePicContain.ListImages(CInt(oVOpenComp.Columns(2).Value)).Picture
        Gate(GateNum).Visible = True
        Load GateDesc(GateNum)
        GateDesc(GateNum).Text = oVOpenComp.Columns(5).Value
        GateDesc(GateNum).Left = Gate(GateNum).Left + 100
        GateDesc(GateNum).Top = Gate(GateNum).Top - 300
        GateDesc(GateNum).Visible = True
        Load PinValue(GateNum)
        Load PinTerm(GateNum)
        PinValue(GateNum).Tag = oVOpenComp.Columns(2).Value
        PinTerm(GateNum).Tag = oVOpenComp.Columns(2).Value
        PinValue(GateNum).AddItem GateNum, 0
        PinTerm(GateNum).AddItem GateNum, 0
        Dim oVOpenPin As ddoTable
        Set oVOpenPin = oDGComponent.CreateVirtualTable
        oVOpenPin.QueryCommand = "select checkterm(pin_opaque) from pin_tab where project_id = " & ProjID & " and getcomp(pin_opaque) = " & GateNum
        oVOpenPin.ExecuteCommand QUERY_CMD
        If oVOpenPin.TotalRecordCount <> 0 Then HaveComponent = True
        For j = 1 To oVOpenPin.TotalRecordCount
            PinValue(GateNum).AddItem 0, j
            PinTerm(GateNum).AddItem oVOpenPin.Columns(1).Value, j
            oVOpenPin.NextRecord
        Next j
        oVOpenComp.NextRecord
    Next i
    'Load Wire
    Dim oVOpenWire As ddoTable
    Set oVOpenWire = oDGWire.CreateVirtualTable
    oVOpenWire.QueryCommand = "select count(*) from wire_tab where project_id = " & ProjID
    oVOpenWire.ExecuteCommand QUERY_CMD
    Count = oVOpenWire.Columns(1).Value
    oVOpenWire.QueryCommand = "select getid(wire_opaque),getfirstcomp(wire_opaque),getfirstpin(wire_opaque),getseccomp(wire_opaque),getsecpin(wire_opaque) from wire_tab where project_id = " & ProjID
    oVOpenWire.ExecuteCommand QUERY_CMD
    For i = 0 To Count - 1
        WireNum = oVOpenWire.Columns(1).Value
        Load WireProp(WireNum)
        WireProp(WireNum).AddItem oVOpenWire.Columns(2).Value, 0
        WireProp(WireNum).AddItem oVOpenWire.Columns(3).Value, 1
        WireProp(WireNum).AddItem oVOpenWire.Columns(4).Value, 2
        WireProp(WireNum).AddItem oVOpenWire.Columns(5).Value, 3
        WireProp(WireNum).AddItem 0, 4
        Dim oVOpenWireLine As ddoTable
        Set oVOpenWireLine = oDGWire.CreateVirtualTable
        oVOpenWireLine.QueryCommand = "select getwireloc(project_id,getid(wire_opaque)) from wire_tab where project_id = " & ProjID & " and getid(wire_opaque) = " & WireNum
        oVOpenWireLine.ExecuteCommand QUERY_CMD
        Call CreateWireLine(oVOpenWireLine.Columns(1).Value)
        oVOpenWire.NextRecord
    Next i
    'Exit
    NewProject = False
    If HaveComponent Then
        Call DeleteAndLogoffTable(oDGProject, oVOpen)
        Call DeleteAndLogoffTable(oDGComponent, oVOpenComp)
        Call DeleteAndLogoffTable(oDGComponent, oVOpenPin)
    End If
    Main.Caption = ProjectName
    Cansim = True
    Call SetEditMode
    Main.MousePointer = 0
End Sub
Public Sub SaveProjectForm()
    If NewProject Then
        NewProjForm.Show vbModal
    Else
        Call SaveProject
    End If
End Sub
Public Sub SetEditMode()
    Call SetSimMode(Cansim)
    Call SetSaveStatus
    If EditMode Then 'Drawing Mode
        Toolbar.Buttons(4).Value = tbrPressed
        MDrawing.Checked = True
        Toolbar.Buttons(5).Value = tbrUnpressed
        MSimulate.Checked = False
        Toolbar.Buttons(6).Enabled = False
        Toolbar.Buttons(7).Enabled = True
        Toolbar.Buttons(8).Enabled = True
        If WiringMode Then
            Toolbar.Buttons(7).Value = tbrUnpressed
            Toolbar.Buttons(8).Value = tbrPressed
        Else
            Toolbar.Buttons(7).Value = tbrPressed
            Toolbar.Buttons(8).Value = tbrUnpressed
            StatusBar.SimpleText = "Drawing Gate Mode"
        End If
        Toolbar.Buttons(9).Enabled = False
    Else            'Simulate Mode
        If Cansim Then
            Toolbar.Buttons(4).Value = tbrUnpressed
            MDrawing.Checked = False
            Toolbar.Buttons(5).Value = tbrPressed
            MSimulate.Checked = True
            Toolbar.Buttons(6).Enabled = False
            Toolbar.Buttons(7).Enabled = False
            Toolbar.Buttons(8).Enabled = False
            Toolbar.Buttons(9).Enabled = True
            StatusBar.SimpleText = "Simulate Mode"
        End If
    End If
End Sub



Public Sub SetGUI()
    GateNum = 0
    WireNum = 0
    LineNum = 0
    NewProject = True
    ProjectName = "Project1"
    Main.Caption = ProjectName
    ProjectDesc = ""
    WiringMode = False
    EditMode = True
    Cansim = False
    SaveStatus = False
    Call SetEditMode
    Call WriteBackEdit
    PinInput = 0
    PinOutput = 1
End Sub
Public Sub SetSimMode(SimSet As Boolean)
    If SimSet Then
        Toolbar.Refresh
        Toolbar.Buttons(5).Enabled = True
        MSimulate.Enabled = True
        Toolbar.Buttons(9).Enabled = True
    Else
        Toolbar.Refresh
        Toolbar.Buttons(5).Enabled = False
        MSimulate.Enabled = False
        Toolbar.Buttons(9).Enabled = False
    End If
End Sub

Private Sub Edit_DragDrop(Source As Control, X As Single, Y As Single)
    If EditMode Then
        If Not WiringMode Then
            Cansim = False
            SaveStatus = True
            Call SetEditMode
            i = 0
            Do
                i = i + 1
                If CStr(0) = PinTerm(Source.Index).List(i) Then Exit Do
            Loop While i < PinTerm(Source.Index).ListCount - 1
            If i = PinTerm(Source.Index).ListCount - 1 And PinTerm(Source.Index).List(i) = CStr(1) Then
                Source.Move X - Xrel - ((X - Xrel) Mod PixelSize), Y - Yrel - ((Y - Yrel) Mod PixelSize)
                GateDesc(Source.Index).Left = X - Xrel - ((X - Xrel) Mod PixelSize) + 100
                GateDesc(Source.Index).Top = Y - Yrel - ((Y - Yrel) Mod PixelSize) - 300
            End If
        End If
    End If
End Sub


Private Sub Edit_KeyDown(KeyCode As Integer, Shift As Integer)
    If KeyCode = 46 And Toolbar.Buttons(6).Enabled = True Then
        Call CutGateAndWire
    End If
End Sub


Private Sub Edit_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Toolbar.Buttons(6).Enabled = False
    If EditMode Then
        If Wiring Then
            If Button = vbLeftButton Then
                LineNum = LineNum + 1
                Load Wire(LineNum)
                Wire(LineNum).Tag = WireNum
                Xbgn = Wire(LineNum - 1).X2
                Ybgn = Wire(LineNum - 1).Y2
            Else
                Call CancelWire
            End If
        Else
            If Button = vbLeftButton Then
                Call ClickLine(X, Y)
            End If
        End If
    Else
        Call ClickLine(X, Y)
    End If
End Sub

Private Sub Edit_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If EditMode Then
        If Wiring Then
            Wire(LineNum).X1 = Xbgn
            Wire(LineNum).Y1 = Ybgn
            If Abs(Xbgn - X) > Abs(Ybgn - Y) Then
                Wire(LineNum).X2 = X
                Wire(LineNum).Y2 = Ybgn
            Else
                Wire(LineNum).X2 = Xbgn
                Wire(LineNum).Y2 = Y
            End If
            Wire(LineNum).Tag = WireNum
            Wire(LineNum).Visible = True
        End If
    End If
End Sub


Private Sub Form_Activate()
    Call SetEditMode
End Sub













Private Sub Form_Load()
    DirMlt = CurDir + "\"
    Main.Left = (Screen.Width - Main.Width) / 2
    Main.Top = (Screen.Height - Main.Height) / 2
    'Set GUI
    Call SetGUI
    Environment = True
    'Set Data Director
    Call SetDataDirector
    'Set Type For Used After
    Call LoadAboutType
End Sub

Private Sub Form_Unload(Cancel As Integer)
    Call EndProgram
End Sub


Private Sub Gate_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode = 46 And Toolbar.Buttons(6).Enabled = True Then
        Call CutGateAndWire
    End If
End Sub

Private Sub Gate_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    If EditMode Then
         If Button <> vbLeftButton Then
            If Wiring Then Call CancelWire
            Exit Sub
         End If
        IndexGate = Index
        If Not WiringMode Then
            Toolbar.Buttons(6).Enabled = True
            Xrel = X: Yrel = Y
            Gate(Index).Drag vbBeginDrag
        Else
            Toolbar.Buttons(6).Enabled = False
            If Not Wiring Then
                Wiring = True
                Xrel = X: Yrel = Y
                Call BeginWiring(Index)
            Else
                Wiring = False
                Xrel = X: Yrel = Y
                Call EndWiring(Index)
            End If
        End If
    End If
End Sub






Private Sub GateDesc_LostFocus(Index As Integer)
    GateDesc(Index).Width = Len(GateDesc(Index).Text) * 120
    Cansim = False
    SaveStatus = True
    Call SetEditMode
End Sub


Private Sub ListGateName_Click()
    Set ViewGate.Picture = GatePicContain.ListImages(ListGateName.ListIndex + 1).Picture
    ViewGate.Tag = ListGateName.ListIndex + 1
End Sub

Private Sub ListGateName_DblClick()
    Call LoadGateOnEdit(ListGateName.ListIndex + 1)
End Sub



Private Sub MAbort_Click()
    aboutform.Show
End Sub

Private Sub MDescProject_Click()
    ProjectDesc = InputBox("Enter Project Description", "Project Description", ProjectDesc)
    SaveStatus = True
    Call SetEditMode
End Sub

Private Sub MDrawing_Click()
    Call BeforeDrawing
End Sub


Private Sub MExit_Click()
    Unload Main
End Sub

Private Sub MNewProject_Click()
    Call NewProjectForm
End Sub

Private Sub MOpenProject_Click()
    OpenRem = True
    OpenProjForm.Show vbModal
End Sub


Private Sub MRemProject_Click()
    OpenRem = False
    OpenProjForm.Show vbModal
End Sub

Private Sub MSaveAsProject_Click()
    NewProjForm.Show vbModal
End Sub

Private Sub MSaveProject_Click()
    Call SaveProjectForm
End Sub


Private Sub MSimulate_Click()
    Call BeforeSimulate
End Sub



Private Sub Toolbar_ButtonClick(ByVal Button As MSComctlLib.Button)
    Select Case Button.Key
        Case "TNewProject"
            Call NewProjectForm
        Case "TOpenProject"
            OpenRem = True
            OpenProjForm.Show vbModal
        Case "TSaveProject"
            Call SaveProjectForm
        Case "TDrawingMode"
            Call BeforeDrawing
        Case "TSimulateMode"
            Call BeforeSimulate
        Case "TCutGate"
            Call CutGateAndWire
        Case "TMove"
            Call SetMoveGate(True)
        Case "TWiring"
            Call SetMoveGate(False)
        Case "TGoSimulate"
            Call GoSimulate
    End Select
End Sub

Private Sub ValueText_Click(Index As Integer)
    Call UpdateValuetext(ValueText(Index).Tag)
End Sub



Private Sub ViewGate_DblClick()
    If Len(ViewGate.Tag) <> 0 Then
        Call LoadGateOnEdit(ViewGate.Tag)
    End If
End Sub

