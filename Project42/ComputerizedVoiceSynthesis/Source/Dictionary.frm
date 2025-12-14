VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form Dictionary 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "พจนานุกรมเสียงอ่าน"
   ClientHeight    =   5850
   ClientLeft      =   1095
   ClientTop       =   330
   ClientWidth     =   5820
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5850
   ScaleWidth      =   5820
   Begin VB.PictureBox picButtons 
      Align           =   2  'Align Bottom
      Appearance      =   0  'Flat
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   300
      Left            =   0
      ScaleHeight     =   300
      ScaleWidth      =   5820
      TabIndex        =   22
      Top             =   5220
      Width           =   5820
      Begin VB.CommandButton cmdClose 
         Caption         =   "&Close"
         Height          =   300
         Left            =   4675
         TabIndex        =   27
         Top             =   0
         Width           =   1095
      End
      Begin VB.CommandButton cmdRefresh 
         Caption         =   "&Refresh"
         Height          =   300
         Left            =   3521
         TabIndex        =   26
         Top             =   0
         Width           =   1095
      End
      Begin VB.CommandButton cmdDelete 
         Caption         =   "&Delete"
         Height          =   300
         Left            =   2367
         TabIndex        =   25
         Top             =   0
         Width           =   1095
      End
      Begin VB.CommandButton cmdUpdate 
         Caption         =   "&Update"
         Height          =   300
         Left            =   1213
         TabIndex        =   24
         Top             =   0
         Width           =   1095
      End
      Begin VB.CommandButton cmdAdd 
         Caption         =   "&Add"
         Height          =   300
         Left            =   59
         TabIndex        =   23
         Top             =   0
         Width           =   1095
      End
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl10"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   10
      Left            =   2040
      TabIndex        =   21
      Top             =   4095
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl9"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   9
      Left            =   2040
      TabIndex        =   19
      Top             =   3780
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl8"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   8
      Left            =   2040
      TabIndex        =   17
      Top             =   3465
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl7"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   7
      Left            =   2040
      TabIndex        =   15
      Top             =   3135
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl6"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   6
      Left            =   2040
      TabIndex        =   13
      Top             =   2820
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl5"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   5
      Left            =   2040
      TabIndex        =   11
      Top             =   2505
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl4"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   4
      Left            =   2040
      TabIndex        =   9
      Top             =   2175
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl3"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   3
      Left            =   2040
      TabIndex        =   7
      Top             =   1860
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl2"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   2
      Left            =   2040
      TabIndex        =   5
      Top             =   1545
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Slb_Dtl1"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   1
      Left            =   2040
      TabIndex        =   3
      Top             =   1215
      Width           =   3375
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Word"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   0
      Left            =   2040
      TabIndex        =   1
      Top             =   900
      Width           =   3375
   End
   Begin MSAdodcLib.Adodc datPrimaryRS 
      Align           =   2  'Align Bottom
      Height          =   330
      Left            =   0
      Top             =   5520
      Width           =   5820
      _ExtentX        =   10266
      _ExtentY        =   582
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
      Connect         =   "PROVIDER=Microsoft.Jet.OLEDB.3.51;Data Source=C:\CVS\Snd_data.mdb;"
      OLEDBString     =   "PROVIDER=Microsoft.Jet.OLEDB.3.51;Data Source=C:\CVS\Snd_data.mdb;"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select Word,Amt_Slb,Slb_Dtl1,Slb_Dtl2,Slb_Dtl3,Slb_Dtl4,Slb_Dtl5,Slb_Dtl6,Slb_Dtl7,Slb_Dtl8,Slb_Dtl9,Slb_Dtl10 from SoundMap"
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
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 10"
      Height          =   255
      Index           =   10
      Left            =   120
      TabIndex        =   20
      Top             =   4095
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 9"
      Height          =   255
      Index           =   9
      Left            =   120
      TabIndex        =   18
      Top             =   3780
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 8"
      Height          =   255
      Index           =   8
      Left            =   120
      TabIndex        =   16
      Top             =   3465
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 7"
      Height          =   255
      Index           =   7
      Left            =   120
      TabIndex        =   14
      Top             =   3135
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 6"
      Height          =   255
      Index           =   6
      Left            =   120
      TabIndex        =   12
      Top             =   2820
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 5"
      Height          =   255
      Index           =   5
      Left            =   120
      TabIndex        =   10
      Top             =   2505
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 4"
      Height          =   255
      Index           =   4
      Left            =   120
      TabIndex        =   8
      Top             =   2175
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 3"
      Height          =   255
      Index           =   3
      Left            =   120
      TabIndex        =   6
      Top             =   1860
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 2"
      Height          =   255
      Index           =   2
      Left            =   120
      TabIndex        =   4
      Top             =   1545
      Width           =   1815
   End
   Begin VB.Label lblLabels 
      Caption         =   "เสียงอ่านที่ 1"
      Height          =   255
      Index           =   1
      Left            =   120
      TabIndex        =   2
      Top             =   1215
      Width           =   1815
   End
   Begin VB.Label w 
      Caption         =   "คำศัพท์"
      Height          =   255
      Index           =   0
      Left            =   120
      TabIndex        =   0
      Top             =   900
      Width           =   1815
   End
End
Attribute VB_Name = "Dictionary"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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
  On Error GoTo AddErr
  datPrimaryRS.Recordset.AddNew

  Exit Sub
AddErr:
  MsgBox Err.Description
End Sub

Private Sub cmdDelete_Click()
  On Error GoTo DeleteErr
  With datPrimaryRS.Recordset
    .Delete
    .MoveNext
    If .EOF Then .MoveLast
  End With
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
  Dim c As Integer, i As Integer, a As String
  On Error GoTo UpdateErr
   c = 0
   For i = 1 To 10
            a = "Slb_Dtl" & CStr(i)
            If Not IsNull(datPrimaryRS.Recordset.Fields(a)) Then c = c + 1
  Next i
  datPrimaryRS.Recordset.Fields("Amt_Slb") = c
  datPrimaryRS.Recordset.UpdateBatch adAffectAll
  Exit Sub
UpdateErr:
  MsgBox "คำที่คุณกำลังจะบันทึกมีอยู่แล้วในพจนานุกรม"
End Sub

Private Sub cmdClose_Click()
  Unload Me
End Sub
