VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form Form1 
   Caption         =   "test find componenet"
   ClientHeight    =   5520
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9015
   LinkTopic       =   "Form1"
   ScaleHeight     =   5520
   ScaleWidth      =   9015
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtsql 
      Height          =   495
      Left            =   1560
      TabIndex        =   17
      Top             =   4080
      Width           =   7335
   End
   Begin MSAdodcLib.Adodc Adodc1 
      Height          =   615
      Left            =   240
      Top             =   4800
      Visible         =   0   'False
      Width           =   8535
      _ExtentX        =   15055
      _ExtentY        =   1085
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
      Connect         =   ""
      OLEDBString     =   ""
      OLEDBFile       =   ""
      DataSourceName  =   ""
      OtherAttributes =   ""
      UserName        =   ""
      Password        =   ""
      RecordSource    =   ""
      Caption         =   "Adodc1"
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
   Begin VB.TextBox txtitemid 
      Height          =   495
      Left            =   6960
      TabIndex        =   16
      Top             =   3480
      Width           =   1215
   End
   Begin VB.TextBox txtcatid 
      Height          =   495
      Left            =   4320
      TabIndex        =   15
      Top             =   3480
      Width           =   1215
   End
   Begin VB.TextBox txtshopid 
      Height          =   495
      Left            =   1560
      TabIndex        =   14
      Top             =   3480
      Width           =   1215
   End
   Begin VB.CommandButton Command10 
      Caption         =   "FindTopProduct"
      Height          =   495
      Left            =   240
      TabIndex        =   10
      Top             =   3000
      Width           =   1575
   End
   Begin VB.CommandButton Command9 
      Caption         =   "FindTopProductFollowShop"
      Height          =   495
      Left            =   5520
      TabIndex        =   9
      Top             =   2400
      Width           =   3255
   End
   Begin VB.CommandButton Command8 
      Caption         =   "FindTableSchema"
      Height          =   495
      Left            =   3840
      TabIndex        =   8
      Top             =   2400
      Width           =   1575
   End
   Begin VB.CommandButton Command7 
      Caption         =   "FindShopName"
      Height          =   495
      Left            =   1680
      TabIndex        =   7
      Top             =   2400
      Width           =   1935
   End
   Begin VB.CommandButton Command6 
      Caption         =   "FindNewShop"
      Height          =   495
      Left            =   240
      TabIndex        =   6
      Top             =   2400
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "FindNewGood"
      Height          =   495
      Left            =   7080
      TabIndex        =   5
      Top             =   1800
      Width           =   1695
   End
   Begin VB.CommandButton Command4 
      Caption         =   "FindItemName"
      Height          =   495
      Left            =   5400
      TabIndex        =   4
      Top             =   1800
      Width           =   1455
   End
   Begin VB.CommandButton Command3 
      Caption         =   "FindItemDetail"
      Height          =   495
      Left            =   3840
      TabIndex        =   3
      Top             =   1800
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Caption         =   "FindfollowCategory"
      Height          =   495
      Left            =   1680
      TabIndex        =   2
      Top             =   1800
      Width           =   1935
   End
   Begin VB.CommandButton Command1 
      Caption         =   "FindCategory"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   1800
      Width           =   1215
   End
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "Test.frx":0000
      Height          =   1455
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   8535
      _ExtentX        =   15055
      _ExtentY        =   2566
      _Version        =   393216
      HeadLines       =   1
      RowHeight       =   15
      BeginProperty HeadFont {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ColumnCount     =   2
      BeginProperty Column00 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1054
            SubFormatType   =   0
         EndProperty
      EndProperty
      BeginProperty Column01 
         DataField       =   ""
         Caption         =   ""
         BeginProperty DataFormat {6D835690-900B-11D0-9484-00A0C91110ED} 
            Type            =   0
            Format          =   ""
            HaveTrueFalseNull=   0
            FirstDayOfWeek  =   0
            FirstWeekOfYear =   0
            LCID            =   1054
            SubFormatType   =   0
         EndProperty
      EndProperty
      SplitCount      =   1
      BeginProperty Split0 
         BeginProperty Column00 
         EndProperty
         BeginProperty Column01 
         EndProperty
      EndProperty
   End
   Begin VB.Label Label5 
      Caption         =   "Sql command"
      Height          =   375
      Left            =   240
      TabIndex        =   19
      Top             =   4200
      Width           =   1335
   End
   Begin VB.Label Label4 
      Caption         =   "Label4"
      Height          =   495
      Left            =   3960
      TabIndex        =   18
      Top             =   2520
      Width           =   1215
   End
   Begin VB.Label Label3 
      Caption         =   "ItemID"
      Height          =   495
      Left            =   5640
      TabIndex        =   13
      Top             =   3600
      Width           =   1215
   End
   Begin VB.Label Label2 
      Caption         =   "CategoryID"
      Height          =   495
      Left            =   3000
      TabIndex        =   12
      Top             =   3600
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "ShopID"
      Height          =   495
      Left            =   240
      TabIndex        =   11
      Top             =   3600
      Width           =   1215
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim FindObj As Object

Private Sub Command1_Click()
    Set Adodc1.Recordset = FindObj.FindCategory(CInt(txtshopid))
End Sub

Private Sub Command10_Click()
    Set Adodc1.Recordset = FindObj.FindTopProduct
End Sub

Private Sub Command2_Click()
    FindObj.TextSearch = txtsql.Text
    Set Adodc1.Recordset = FindObj.FindFollowCategory
End Sub

Private Sub Command3_Click()
    Set Adodc1.Recordset = FindObj.FindItemDetail(CInt(txtshopid.Text), CInt(txtcatid), CInt(txtitemid))
End Sub

Private Sub Command4_Click()
    Set Adodc1.Recordset = FindObj.FindItemName(CCInt(txtshopid.Text), CCInt(txtcatid.Text))
End Sub

Private Sub Command5_Click()
    Set Adodc1.Recordset = FindObj.FindNewGoods(CCInt(txtshopid.Text))
End Sub

Private Sub Command6_Click()
    Set Adodc1.Recordset = FindObj.FindNewShop
End Sub

Private Sub Command7_Click()
    Set Adodc1.Recordset = FindObj.FindShopName(CCInt(txtshopid.Text))
End Sub

Private Sub Command8_Click()
    Set Adodc1.Recordset = FindObj.FindTableSchema(CCInt(txtshopid.Text), CCInt(txtcatid.Text))
End Sub

Private Sub Command9_Click()
    Set Adodc1.Recordset = FindObj.FindTopProductFollowShop(CCInt(txtshopid.Text))
End Sub

Private Sub Form_Load()
    Set FindObj = CreateObject("findcomponent.find")
End Sub
