VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Begin VB.Form HeaderMain 
   BackColor       =   &H0000FF00&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "tblMain"
   ClientHeight    =   8130
   ClientLeft      =   1800
   ClientTop       =   330
   ClientWidth     =   8415
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   8130
   ScaleWidth      =   8415
   Begin VB.TextBox txtFields 
      DataField       =   "Descript"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   14
      Left            =   4320
      TabIndex        =   35
      Top             =   960
      Width           =   3375
   End
   Begin VB.ComboBox ChooseHead 
      Height          =   315
      ItemData        =   "HeaderMain.frx":0000
      Left            =   4320
      List            =   "HeaderMain.frx":000A
      TabIndex        =   34
      Text            =   "กรุณาเลือก"
      Top             =   6000
      Width           =   1935
   End
   Begin VB.PictureBox picButtons 
      Align           =   2  'Align Bottom
      Appearance      =   0  'Flat
      BackColor       =   &H0000FF00&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   660
      Left            =   0
      ScaleHeight     =   660
      ScaleWidth      =   8415
      TabIndex        =   28
      Top             =   7140
      Width           =   8415
      Begin VB.CommandButton cmdClose 
         Caption         =   "ปิด(F5)"
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
         Left            =   6840
         TabIndex        =   33
         Top             =   0
         Width           =   1095
      End
      Begin VB.CommandButton cmdRefresh 
         Caption         =   "เลิกการเพิ่มข้อมูล(F1)"
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
         Left            =   2400
         TabIndex        =   32
         Top             =   0
         Width           =   1935
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
         Left            =   5520
         TabIndex        =   31
         Top             =   0
         Width           =   1335
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
         Left            =   4320
         TabIndex        =   30
         Top             =   0
         Width           =   1215
      End
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
         Left            =   480
         TabIndex        =   29
         Top             =   0
         Width           =   1935
      End
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Subheader_1"
      DataSource      =   "datPrimaryRS"
      Height          =   315
      Index           =   13
      Left            =   4320
      TabIndex        =   27
      Top             =   6000
      Width           =   1935
   End
   Begin VB.TextBox txtFields 
      DataField       =   "SeeAdd"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   12
      Left            =   4320
      TabIndex        =   25
      Top             =   5640
      Width           =   1935
   End
   Begin VB.TextBox txtFields 
      DataField       =   "LC_5"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   11
      Left            =   4320
      TabIndex        =   23
      Top             =   5040
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "LC_4"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   10
      Left            =   4320
      TabIndex        =   21
      Top             =   4680
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "LC_3"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   9
      Left            =   4320
      TabIndex        =   19
      Top             =   4320
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "LC_2"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   8
      Left            =   4320
      TabIndex        =   17
      Top             =   3960
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "LC_1"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   7
      Left            =   4320
      TabIndex        =   15
      Top             =   3600
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "DEWEY_5"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   6
      Left            =   4320
      TabIndex        =   13
      Top             =   3000
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "DEWEY_4"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   5
      Left            =   4320
      TabIndex        =   11
      Top             =   2640
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "DEWEY_3"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   4
      Left            =   4320
      TabIndex        =   9
      Top             =   2280
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "DEWEY_2"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   3
      Left            =   4320
      TabIndex        =   7
      Top             =   1920
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "DEWEY_1"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   2
      Left            =   4320
      TabIndex        =   5
      Top             =   1560
      Width           =   975
   End
   Begin VB.TextBox txtFields 
      DataField       =   "TranEng"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   1
      Left            =   4320
      TabIndex        =   3
      Top             =   600
      Width           =   1935
   End
   Begin VB.TextBox txtFields 
      DataField       =   "Header"
      DataSource      =   "datPrimaryRS"
      Height          =   330
      Index           =   0
      Left            =   4320
      TabIndex        =   1
      Top             =   240
      Width           =   1935
   End
   Begin MSAdodcLib.Adodc datPrimaryRS 
      Align           =   2  'Align Bottom
      Height          =   330
      Left            =   0
      Top             =   7800
      Width           =   8415
      _ExtentX        =   14843
      _ExtentY        =   582
      ConnectMode     =   0
      CursorLocation  =   3
      IsolationLevel  =   -1
      ConnectionTimeout=   15
      CommandTimeout  =   30
      CursorType      =   3
      LockType        =   3
      CommandType     =   1
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
      Connect         =   "Provider=Microsoft.Jet.OLEDB.3.51;Persist Security Info=False;Data Source=HeaderDB.mdb"
      OLEDBString     =   "Provider=Microsoft.Jet.OLEDB.3.51;Persist Security Info=False;Data Source=HeaderDB.mdb"
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   "select Header,TranEng,DEWEY_1,DEWEY_2,DEWEY_3,DEWEY_4,DEWEY_5,LC_1,LC_2,LC_3,LC_4,LC_5,SeeAdd,Subheader_1,Descript from tblMain"
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
      BackColor       =   &H0000FF00&
      Caption         =   "รายละเอียดหัวเรื่อง:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   14
      Left            =   1800
      TabIndex        =   36
      Top             =   960
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "หัวเรื่องย่อย1:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   13
      Left            =   1800
      TabIndex        =   26
      Top             =   6000
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "ดูเพิ่มเติม:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   12
      Left            =   1800
      TabIndex        =   24
      Top             =   5640
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่LC_5:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   11
      Left            =   1800
      TabIndex        =   22
      Top             =   5040
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่LC_4:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   10
      Left            =   1800
      TabIndex        =   20
      Top             =   4680
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่LC_3:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   9
      Left            =   1800
      TabIndex        =   18
      Top             =   4320
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่LC_2:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   8
      Left            =   1800
      TabIndex        =   16
      Top             =   3960
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่LC_1:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   7
      Left            =   1800
      TabIndex        =   14
      Top             =   3600
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่DEWEY_5:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   6
      Left            =   1800
      TabIndex        =   12
      Top             =   3000
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่DEWEY_4:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   5
      Left            =   1800
      TabIndex        =   10
      Top             =   2640
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่DEWEY_3:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   4
      Left            =   1800
      TabIndex        =   8
      Top             =   2280
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่DEWEY_2:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   3
      Left            =   1800
      TabIndex        =   6
      Top             =   1920
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "เลขหมู่DEWEY_1:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   2
      Left            =   1800
      TabIndex        =   4
      Top             =   1560
      Width           =   3120
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "คำแปลภาษาอังกฤษหัวเรื่อง:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   1
      Left            =   1800
      TabIndex        =   2
      Top             =   600
      Width           =   3000
   End
   Begin VB.Label lblLabels 
      BackColor       =   &H0000FF00&
      Caption         =   "หัวเรื่อง:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Index           =   0
      Left            =   1800
      TabIndex        =   0
      Top             =   240
      Width           =   3000
   End
End
Attribute VB_Name = "HeaderMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public retcount As Integer
Public addflag As Boolean
Private Enum OSType
ไม่มีหัวข้อย่อย = 0
มีหัวข้อย่อย = 1
End Enum
Dim OSId As OSType
Private Sub ChooseHead_KeyPress(KeyAscii As Integer)
 If KeyAscii = vbKeyReturn Then
 If Back1 = False Then
If retcount = 15 And txtFields(0) <> "" And addflag = True Then
        If ChooseHead.ListIndex = 0 Then
             txtFields(13).Text = "ไม่มีหัวข้อย่อย"
            datPrimaryRS.Recordset.UpdateBatch adAffectAll
            Call cmdAdd_Click
        End If
        If ChooseHead.ListIndex = 1 Then
            txtFields(13).Text = "มีหัวข้อย่อย"
            datPrimaryRS.Recordset.UpdateBatch adAffectAll
            HeaderMain.Hide
            HeaderSub1.Show
        End If
    End If
Else
Back1 = False
Call cmdAdd_Click
End If
End If
End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
If KeyCode = vbKeyF1 Then
If addflag = False Then
     Call cmdAdd_Click
   Else
     Call cmdRefresh_Click
   End If
End If
If KeyCode = vbKeyF5 Then
  Call cmdclose_Click
End If
If KeyCode = vbKeyF2 Then
        Call cmdUpdate_Click
 End If
 If KeyCode = vbKeyF3 Then
        Call cmdDelete_Click
 End If
End Sub

Private Sub Form_Load()
Back1 = False
ChooseHead.Visible = False
  txtFields(13).Visible = True
  retcount = 0
  addflag = False
  cmdAdd.Enabled = True
  cmdRefresh.Enabled = False
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
  On Error GoTo AddErr
  addflag = True
  cmdAdd.Enabled = False
  cmdRefresh.Enabled = True
  retcount = 0
  txtFields(0).SetFocus
  datPrimaryRS.Recordset.AddNew
  ChooseHead.Visible = True
  txtFields(13).Visible = False
  Exit Sub
AddErr:
  MsgBox Err.Description
End Sub

Private Sub cmdDelete_Click()
  On Error GoTo DeleteErr
  If addflag = False Then
  If MsgBox("คุณต้องการลบข้อมูลใช่หรือไม่?", [vbYesNo]) = vbYes Then
  With datPrimaryRS.Recordset
    .Delete
    .MoveNext
    If .EOF Then .MoveLast
  End With
  End If
  Else
  MsgBox ("คุณต้องเลิกการเพิ่มข้อมูลก่อน!")
  End If
  Exit Sub
DeleteErr:
  MsgBox Err.Description
End Sub

Private Sub cmdRefresh_Click()
  'This is only needed for multi user apps
  On Error GoTo RefreshErr
  addflag = False
  cmdAdd.Enabled = True
  cmdRefresh.Enabled = False
  datPrimaryRS.Refresh
  ChooseHead.Visible = False
  txtFields(13).Visible = True
  Exit Sub
RefreshErr:
  MsgBox Err.Description
End Sub

Private Sub cmdUpdate_Click()
  On Error GoTo UpdateErr
If txtFields(0) <> "" Then
  datPrimaryRS.Recordset.UpdateBatch adAffectAll
  MsgBox ("Updateข้อมูลแล้ว")
         If addflag = True Then
             If MsgBox("คุณต้องการเลิกการเพิ่มข้อมูลใช่หรือไม่?", [vbYesNo]) = vbYes Then
                Call cmdRefresh_Click
                txtFields(0).SetFocus
             Else
              retcount = 0
              txtFields(0).SetFocus
            End If
        End If
    Else
        MsgBox ("คุณต้องกรอกหัวเรื่องก่อน")
        retcount = 0
        txtFields(0).SetFocus
End If
    Exit Sub
UpdateErr:
  MsgBox Err.Description
End Sub

Private Sub cmdclose_Click()
  Unload Me
End Sub

Private Sub txtFields_KeyPress(Index As Integer, KeyAscii As Integer)
  If KeyAscii = vbKeyReturn Then
    retcount = retcount + 1
    If retcount = 1 Then
        txtFields(0).SetFocus
    End If
     If retcount = 2 Then
        txtFields(1).SetFocus
    End If
      If retcount = 3 Then
        txtFields(14).SetFocus
    End If
     If retcount = 4 Then
        txtFields(2).SetFocus
    End If
     If retcount = 5 Then
        txtFields(3).SetFocus
    End If
     If retcount = 6 Then
        txtFields(4).SetFocus
    End If
       If retcount = 7 Then
        txtFields(5).SetFocus
    End If
     If retcount = 8 Then
        txtFields(6).SetFocus
    End If
     If retcount = 9 Then
        txtFields(7).SetFocus
    End If
     If retcount = 10 Then
        txtFields(8).SetFocus
    End If
     If retcount = 11 Then
        txtFields(9).SetFocus
    End If
       If retcount = 12 Then
        txtFields(10).SetFocus
    End If
     If retcount = 13 Then
        txtFields(11).SetFocus
    End If
     If retcount = 14 Then
        txtFields(12).SetFocus
    End If
     If retcount = 15 Then
        ChooseHead.SetFocus
    End If
 End If
 End Sub
