VERSION 5.00
Object = "{00028C01-0000-0000-0000-000000000046}#1.0#0"; "DBGRID32.OCX"
Begin VB.Form Output 
   Caption         =   "Output Display"
   ClientHeight    =   5490
   ClientLeft      =   2130
   ClientTop       =   1500
   ClientWidth     =   6555
   LinkTopic       =   "Form2"
   ScaleHeight     =   5490
   ScaleWidth      =   6555
   StartUpPosition =   2  'CenterScreen
   Begin MSDBGrid.DBGrid OutputGrid 
      Bindings        =   "Output.frx":0000
      Height          =   3975
      Left            =   0
      OleObjectBlob   =   "Output.frx":0014
      TabIndex        =   2
      Top             =   0
      Width           =   6735
   End
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      Height          =   420
      Left            =   0
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   4080
      Width           =   6660
   End
   Begin VB.CommandButton okcmd 
      Caption         =   "O.K."
      Height          =   495
      Left            =   1320
      TabIndex        =   1
      Top             =   4800
      Width           =   1695
   End
   Begin VB.CommandButton printcmd 
      Caption         =   "Print"
      Height          =   495
      Left            =   3840
      TabIndex        =   0
      Top             =   4800
      Width           =   1815
   End
End
Attribute VB_Name = "Output"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private RstStudent As Recordset

Private Sub Form_Load()
    Data1.Connect = "ODBC;DSN=student_data;" & _
    "UID=informix" & ";PWD=informix" & ";"
End Sub

Private Sub Form_Resize()
    OutputGrid.Left = 75
    OutputGrid.Width = Output.Width - 275
    OutputGrid.Height = Output.Height - 1500
    Data1.Top = Output.Height - 1450
    Data1.Left = 75
    Data1.Width = Output.Width - 275
    
    okcmd.Top = Output.Height - 950
    printcmd.Top = okcmd.Top
    okcmd.Left = 1000
    printcmd.Left = Output.Width - 3000
End Sub

Private Sub ok_Click()
    Output.Hide
End Sub

Private Sub print_Click()
 'On Error GoTo Err_Enter
 Dim ename As String
 Dim SelectSql As String
    ename = """Saran"""
'SelectSql = "select * from student_tt"
'SelectSql = "select * from student_tt where std_int in (select std_serial from student where student.ename=""Saran"")"
        
            With Data1
            .RecordSource = SelectSql
            .Refresh
            .Caption = "student"
            
        End With
Err_Enter:
End Sub

