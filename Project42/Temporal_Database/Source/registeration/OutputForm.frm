VERSION 5.00
Begin VB.Form OutputForm 
   Caption         =   "Form1"
   ClientHeight    =   5715
   ClientLeft      =   870
   ClientTop       =   2100
   ClientWidth     =   6810
   LinkTopic       =   "Form1"
   ScaleHeight     =   5715
   ScaleWidth      =   6810
   Begin VB.Data Data1 
      Caption         =   "Data1"
      Connect         =   "ODBC;DSN=student_dsn;DATABASE=database_student;UID=informix;PWD=informix"
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
      Top             =   5280
      Width           =   6615
   End
   Begin VB.PictureBox TDBGridS1 
      Height          =   5055
      Left            =   120
      ScaleHeight     =   4995
      ScaleWidth      =   6555
      TabIndex        =   0
      Top             =   120
      Width           =   6615
   End
End
Attribute VB_Name = "OutputForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
