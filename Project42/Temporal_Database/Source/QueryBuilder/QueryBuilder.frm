VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Form1 
   Caption         =   "ระบบงานค้นประวัตินักศึกษา และ รายวิชา"
   ClientHeight    =   5235
   ClientLeft      =   1800
   ClientTop       =   1740
   ClientWidth     =   7095
   LinkTopic       =   "Form1"
   ScaleHeight     =   5235
   ScaleWidth      =   7095
   StartUpPosition =   2  'CenterScreen
   Begin RichTextLib.RichTextBox temp 
      Height          =   375
      Left            =   6120
      TabIndex        =   14
      Top             =   4200
      Visible         =   0   'False
      Width           =   735
      _ExtentX        =   1296
      _ExtentY        =   661
      _Version        =   393217
      TextRTF         =   $"QueryBuilder.frx":0000
   End
   Begin VB.Frame Frame1 
      Height          =   4815
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   7095
      Begin VB.CommandButton q6 
         Caption         =   "..."
         Height          =   375
         Left            =   1440
         TabIndex        =   13
         Top             =   3480
         Width           =   495
      End
      Begin VB.CommandButton q5 
         Caption         =   "..."
         Height          =   375
         Left            =   1440
         TabIndex        =   12
         Top             =   3000
         Width           =   495
      End
      Begin VB.CommandButton q4 
         Caption         =   "..."
         Height          =   375
         Left            =   1440
         TabIndex        =   11
         Top             =   2520
         Width           =   495
      End
      Begin VB.CommandButton q3 
         Caption         =   "..."
         Height          =   375
         Left            =   1440
         TabIndex        =   7
         Top             =   2040
         Width           =   495
      End
      Begin VB.CommandButton q2 
         Caption         =   "..."
         Height          =   375
         Left            =   1440
         TabIndex        =   6
         Top             =   1560
         Width           =   495
      End
      Begin VB.CommandButton q1 
         Caption         =   "..."
         Height          =   375
         Left            =   1440
         TabIndex        =   5
         Top             =   1080
         Width           =   495
      End
      Begin VB.Label Label6 
         Caption         =   "6. ข้อมูลปัจจุบันของรายวิชา"
         Height          =   375
         Left            =   2280
         TabIndex        =   10
         Top             =   3600
         Width           =   3615
      End
      Begin VB.Label Label5 
         Caption         =   "5. ข้อมูลปัจุบันของนักศึกษา ..."
         Height          =   375
         Left            =   2280
         TabIndex        =   9
         Top             =   3120
         Width           =   3615
      End
      Begin VB.Label Label4 
         Caption         =   "4. ข้อมูลปัจจุบันของการลงทะเบียนของ ... ในวิชา ..."
         Height          =   375
         Left            =   2280
         TabIndex        =   8
         Top             =   2640
         Width           =   3615
      End
      Begin VB.Label Label3 
         Caption         =   "3. ประวัติของรายวิชา ..."
         Height          =   375
         Left            =   2280
         TabIndex        =   4
         Top             =   2160
         Width           =   3255
      End
      Begin VB.Label Label2 
         Caption         =   "2. ประวัติของนักศึกษา ..."
         Height          =   375
         Left            =   2280
         TabIndex        =   3
         Top             =   1680
         Width           =   3255
      End
      Begin VB.Label Label1 
         Caption         =   "1. ประวัติของการลงทะเบียนของ ...   ในวิชา ..."
         Height          =   375
         Left            =   2280
         TabIndex        =   2
         Top             =   1200
         Width           =   3615
      End
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   360
      Left            =   0
      TabIndex        =   0
      Top             =   4875
      Width           =   7095
      _ExtentX        =   12515
      _ExtentY        =   635
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   1
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
         EndProperty
      EndProperty
   End
   Begin VB.Menu mnuFile 
      Caption         =   "&File"
      Begin VB.Menu mnuExit 
         Caption         =   "&Exit"
      End
   End
   Begin VB.Menu mnuHelp 
      Caption         =   "&Help"
      Begin VB.Menu mnuAbout 
         Caption         =   "&About"
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public wksODBCDirect As Workspace
Public cnnTemporal As Connection
Public Function cut(Command As String)
     Dim start_pos, end_pos As Long
        cut = Command
        temp.Text = Command
              end_pos = temp.Find("   ")
              If end_pos <> -1 Then
              start_pos = 0
              temp.SelStart = start_pos
              temp.SelLength = end_pos - start_pos
              cut = temp.SelText
              End If
End Function

Private Sub disconnect()
    cnnTemporal.Close
    wksODBCDirect.Close

End Sub
Private Sub Form_Load()
        
    Set wksODBCDirect = DBEngine.CreateWorkspace("ODBCDirect", "", "", dbUseODBC)
    Set cnnTemporal = wksODBCDirect.OpenConnection("TempOnServer", False, False, _
    "ODBC;DSN=student_data;UID=informix;pwd=informix;")

End Sub

Private Sub Form_Unload(Cancel As Integer)
    disconnect
    End
End Sub

Private Sub mnuAbout_Click()
    AboutForm.Show
End Sub

Private Sub mnuExit_Click()
    disconnect
    End
End Sub

Private Sub q1_Click()
    Form1.Hide
    QForm1.Show
End Sub

Private Sub q2_Click()
    Form1.Hide
    QForm2.Show
End Sub

Private Sub q3_Click()
    Form1.Hide
    QForm3.Show
End Sub

Private Sub q4_Click()
    Form1.Hide
    QForm4.Show
End Sub

Private Sub q5_Click()
    Form1.Hide
    QForm5.Show
End Sub

Private Sub q6_Click()
    Form1.Hide
    QForm6.Show
End Sub
