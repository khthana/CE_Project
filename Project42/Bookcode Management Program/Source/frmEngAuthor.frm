VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form frmEngAuthor 
   BackColor       =   &H000080FF&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "EngAuthor"
   ClientHeight    =   4080
   ClientLeft      =   1095
   ClientTop       =   330
   ClientWidth     =   8475
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4080
   ScaleWidth      =   8475
   Begin VB.CommandButton stopadd 
      Caption         =   "เลิกการเพิ่มข้อมูล (F1)"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   540
      Left            =   600
      TabIndex        =   5
      Top             =   2880
      Visible         =   0   'False
      Width           =   1935
   End
   Begin VB.CommandButton cmdSearch 
      Caption         =   "ค้นหาข้อมูล (F4)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   540
      Left            =   5160
      TabIndex        =   8
      Top             =   2880
      Width           =   1455
   End
   Begin VB.PictureBox picButtons 
      Appearance      =   0  'Flat
      BackColor       =   &H000080FF&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   540
      Left            =   0
      ScaleHeight     =   540
      ScaleWidth      =   8670
      TabIndex        =   11
      Top             =   2880
      Width           =   8670
      Begin VB.CommandButton cmdAdd 
         Caption         =   "เพิ่มข้อมูล (F1)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   540
         Left            =   600
         TabIndex        =   10
         Top             =   0
         Width           =   1935
      End
      Begin VB.CommandButton cmdClose 
         Caption         =   "ปิด (F5)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   540
         Left            =   6600
         TabIndex        =   9
         Top             =   0
         Width           =   1215
      End
      Begin VB.CommandButton cmdDelete 
         Caption         =   "ลบข้อมูล (F3)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   540
         Left            =   3960
         TabIndex        =   7
         Top             =   0
         Width           =   1215
      End
      Begin VB.CommandButton cmdUpdate 
         Caption         =   "Update (F2)"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   540
         Left            =   2520
         TabIndex        =   6
         Top             =   0
         Width           =   1455
      End
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Eauthorcode"
      DataSource      =   "datPrimaryRS"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   465
      Index           =   1
      Left            =   3000
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   2160
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Eauthorname"
      DataSource      =   "datPrimaryRS"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Index           =   0
      Left            =   3000
      TabIndex        =   3
      TabStop         =   0   'False
      Top             =   1560
      Width           =   3375
   End
   Begin MSAdodcLib.Adodc datPrimaryRS 
      Align           =   2  'Align Bottom
      Height          =   450
      Left            =   0
      Top             =   3630
      Width           =   8475
      _ExtentX        =   14949
      _ExtentY        =   794
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   8
      CursorOptions   =   0
      CacheSize       =   50
      MaxRecords      =   0
      BOFAction       =   0
      EOFAction       =   0
      ConnectStringType=   1
      Appearance      =   1
      BackColor       =   -2147483643
      ForeColor       =   -2147483640
      Orientation     =   0
      Enabled         =   -1
      Connect         =   "Provider=Microsoft.Jet.OLEDB.3.51;Persist Security Info=False;Data Source=EngAuthor.mdb"
      OLEDBString     =   "Provider=Microsoft.Jet.OLEDB.3.51;Persist Security Info=False;Data Source=EngAuthor.mdb"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select Eauthorname,Eauthorcode from EngAuthor"
      Caption         =   " "
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      _Version        =   393216
   End
   Begin VB.Label Label1 
      BackColor       =   &H000080FF&
      Caption         =   "โปรแกรมจัดการเลขผู้แต่ง(อังกฤษ)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   222
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H8000000D&
      Height          =   615
      Left            =   1800
      TabIndex        =   0
      Top             =   720
      Width           =   5415
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H000080FF&
      Caption         =   "รหัสผู้แต่ง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   495
      Index           =   1
      Left            =   1800
      TabIndex        =   2
      Top             =   2160
      Width           =   1095
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H000080FF&
      Caption         =   "ชื่อผู้แต่ง"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   14.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   375
      Index           =   0
      Left            =   1920
      TabIndex        =   1
      Top             =   1560
      Width           =   975
   End
End
Attribute VB_Name = "frmEngAuthor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public OrderWs     As Workspace
Public OrderDb     As Database
Public Authorsnap  As Recordset
Public ProductDyn As Recordset
Public sqlcommand  As String
Public Searchtext  As String
Public retcount As Integer
Public addflag As Boolean
Private Sub Openquery()
Set Authorsnap = OrderDb.OpenRecordset(sqlcommand, dbOpenSnapshot)
Set Data1.Recordset = Authorsnap
End Sub

Private Sub stopadd_Click()
  datPrimaryRS.Refresh
  stopadd.Enabled = False
  stopadd.Visible = False
  cmdAdd.Visible = True
  addflag = False
  CmdSearch.Enabled = True
  cmdDelete.Enabled = True
  cmdUpdate.Enabled = True
End Sub

Private Sub cmdSearch_Click()
Dim Searchtext As String
Searchtext = InputBox("กรุณาใส่ชื่อที่ต้องการค้นหา")
 If Searchtext <> "" Then
sqlcommand = " SELECT Eauthorname,Eauthorcode FROM EngAuthor "
sqlcommand = sqlcommand & "WHERE EAuthorname LIKE "
sqlcommand = sqlcommand & "'"
sqlcommand = sqlcommand & Searchtext
sqlcommand = sqlcommand & "*'"
Set ProductDyn = OrderDb.OpenRecordset(sqlcommand, dbOpenDynaset)
If Not ProductDyn.EOF Then
  datPrimaryRS.Recordset.MoveFirst
  ProductDyn.MoveFirst
  Do While Not datPrimaryRS.Recordset.EOF
    If datPrimaryRS.Recordset.Fields("Eauthorname") = ProductDyn.Fields("Eauthorname") Then
         txtFields(0) = ProductDyn.Fields("Eauthorname")
         txtFields(1) = ProductDyn.Fields("Eauthorcode")
    Exit Sub
    End If
        datPrimaryRS.Recordset.MoveNext
   Loop
End If
   datPrimaryRS.Recordset.MoveFirst
   MsgBox "ไม่พบข้อมูลที่ต้องการ"
End If
End Sub

Private Sub Command1_Click()
  On Error GoTo RefreshErr
  datPrimaryRS.Refresh
  Exit Sub
RefreshErr:
  MsgBox Err.Description
End Sub

Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF1 Then
If cmdAdd.Visible Then
     Call cmdAdd_Click
   Else
     Call stopadd_Click
   End If
End If
If KeyCode = vbKeyF5 Then
  Call cmdClose_Click
End If
If Not addflag Then
Select Case KeyCode
Case vbKeyF2
   Call cmdUpdate_Click
Case vbKeyF3
   Call cmdDelete_Click
Case vbKeyF4
   Call cmdSearch_Click
End Select
End If
End Sub

Private Sub Form_Load()
 addflag = False
 retcount = 0
 Set OrderWs = DBEngine.Workspaces(0)
 Set OrderDb = OrderWs.OpenDatabase("Engauthor.mdb", False, False)
End Sub

Private Sub Form_Unload(Cancel As Integer)
  Screen.MousePointer = vbDefault
End Sub

Private Sub datPrimaryRS_Error(ByVal ErrorNumber As Long, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, fCancelDisplay As Boolean)
'This is where you would put error handling code
  'If you want to ignore errors, comment out the next line
  'If you want to trap them, add code here to handle them
  MsgBox "Data error event hit err:" & Description
End Sub

Private Sub datPrimaryRS_MoveComplete(ByVal adReason As ADODB.EventReasonEnum, ByVal pError As ADODB.Error, adStatus As ADODB.EventStatusEnum, ByVal pRecordset As ADODB.Recordset)
  'This will display the current record position for this recordset
  datPrimaryRS.Caption = "Record: " & CStr(datPrimaryRS.Recordset.AbsolutePosition)
End Sub

Private Sub datPrimaryRS_WillChangeRecord(ByVal adReason As ADODB.EventReasonEnum, ByVal cRecords As Long, adStatus As ADODB.EventStatusEnum, ByVal pRecordset As ADODB.Recordset)
  'This is where you put validation code
  'This event gets called when the following actions occur
  Dim bCancel As Boolean

  Select Case adReason
  Case adRsnAddNew
  Case adRsnClose
  Case adRsnDelete
  Case adRsnFirstChange
  Case adRsnMove
  Case adRsnRequery
  Case adRsnResynch
  Case adRsnUndoAddNew
  Case adRsnUndoDelete
  Case adRsnUndoUpdate
  Case adRsnUpdate
  End Select

  If bCancel Then adStatus = adStatusCancel
End Sub

Private Sub cmdAdd_Click()
   CmdSearch.Enabled = False
  cmdDelete.Enabled = False
  cmdUpdate.Enabled = False
  stopadd.Enabled = True
  stopadd.Visible = True
  On Error GoTo AddErr
  datPrimaryRS.Recordset.AddNew
  txtFields(0).SetFocus
  addflag = True
  cmdAdd.Visible = False
  Exit Sub
AddErr:
  MsgBox Err.Description
End Sub

Private Sub cmdDelete_Click()
  On Error GoTo DeleteErr
  If MsgBox("คุณต้องการลบข้อมูลใช่หรือไม่?", [vbYesNo]) = vbYes Then
  With datPrimaryRS.Recordset
    .Delete
    .MoveNext
    If .EOF Then .MoveLast
  End With
  End If
  Exit Sub
DeleteErr:
  MsgBox Err.Description
End Sub

Private Sub cmdRefresh_Click()
  'This is only needed for multi user apps
  On Error GoTo RefreshErr
  datPrimaryRS.Refresh
  Exit Sub
RefreshErr:
  MsgBox Err.Description
End Sub

Private Sub cmdUpdate_Click()
  On Error GoTo UpdateErr

  datPrimaryRS.Recordset.UpdateBatch adAffectAll
  Exit Sub
UpdateErr:
  MsgBox Err.Description
End Sub

Private Sub cmdClose_Click()
If MsgBox("คุณต้องการออกจากโปรแกรมหรือไม่?", [vbYesNo]) = vbYes Then
 Unload Me
End If
End Sub

Private Sub txtFields_KeyPress(Index As Integer, KeyAscii As Integer)
 If KeyAscii = vbKeyReturn Then
    retcount = retcount + 1
 If (retcount Mod 2) = 0 Then
   If txtFields(0) <> "" And txtFields(1) <> "" Then
     If addflag = True Then
        Call cmdAdd_Click
     Else
        Call cmdUpdate_Click
     End If
   Else
     txtFields(0).SetFocus
   End If
 Else
    txtFields(1).SetFocus
 End If
 End If
End Sub
