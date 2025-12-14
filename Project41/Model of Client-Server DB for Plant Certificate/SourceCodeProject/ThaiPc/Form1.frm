VERSION 5.00
Object = "{00025600-0000-0000-C000-000000000046}#4.6#0"; "CRYSTL32.OCX"
Begin VB.Form Form1 
   Caption         =   "Form1"
   ClientHeight    =   3480
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5220
   LinkTopic       =   "Form1"
   ScaleHeight     =   3480
   ScaleWidth      =   5220
   StartUpPosition =   3  'Windows Default
   Begin Crystal.CrystalReport crpt1 
      Left            =   3240
      Top             =   1680
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   262150
      ReportFileName  =   "final1.rpt"
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
   End
   Begin VB.TextBox txtEnd 
      Height          =   495
      Left            =   2160
      TabIndex        =   2
      Top             =   480
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Command1"
      Height          =   495
      Left            =   840
      TabIndex        =   1
      Top             =   1440
      Width           =   1215
   End
   Begin VB.TextBox txtDate 
      Height          =   495
      Left            =   720
      TabIndex        =   0
      Top             =   480
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private mcon As rdoConnection
Private Sub Command1_Click()
    Test
End Sub
Private Sub Form_Load()
    OpenConnect
End Sub
Private Sub OpenConnect()
    Set mcon = rdoEnvironments(0).OpenConnection("DBProject")
End Sub
Private Sub Test()
    Dim strSQL As String
    Dim rs As rdoResultset
    Dim ChkDate1, ChkDate2, rcount
    
    ChkDate1 = Format(txtDate.Text, "mm/dd/yyyy")
    ChkDate2 = Format(txtEnd.Text, "mm/dd/yyyy")
    strSQL = "Select * From ExportPlants Where ((ExportDate >= '" & ChkDate1 & "') and  " & _
             " (ExportDate <= '" & ChkDate2 & "'))"
    Set rs = mcon.OpenResultset(strSQL, 1)
    rcount = rs.RowCount
    
    'crpt1.SelectionFormula = {exportplants.exportdate} =
End Sub




