VERSION 5.00
Object = "{67397AA1-7FB1-11D0-B148-00A0C922E820}#6.0#0"; "MSADODC.OCX"
Object = "{CDE57A40-8B86-11D0-B3C6-00A0C90AEA82}#1.0#0"; "MSDATGRD.OCX"
Begin VB.Form frmTestShoppingbag 
   Caption         =   "Form1"
   ClientHeight    =   4935
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6420
   LinkTopic       =   "Form1"
   ScaleHeight     =   4935
   ScaleWidth      =   6420
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdLoad 
      Caption         =   "Load ShoppingBag"
      Height          =   400
      Left            =   3120
      TabIndex        =   16
      Top             =   1680
      Width           =   2175
   End
   Begin VB.CommandButton cmdDelete 
      Caption         =   "Delete ShoppingBag"
      Height          =   400
      Left            =   3120
      TabIndex        =   15
      Top             =   1200
      Width           =   2175
   End
   Begin MSAdodcLib.Adodc Adodc1 
      Height          =   330
      Left            =   3480
      Top             =   3480
      Visible         =   0   'False
      Width           =   1455
      _ExtentX        =   2566
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
   Begin MSDataGridLib.DataGrid DataGrid1 
      Bindings        =   "frmTestShoppingbag.frx":0000
      Height          =   2295
      Left            =   240
      TabIndex        =   14
      Top             =   2520
      Width           =   6015
      _ExtentX        =   10610
      _ExtentY        =   4048
      _Version        =   393216
      AllowUpdate     =   0   'False
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
      Caption         =   "Current shopping bag"
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
   Begin VB.CommandButton cmdSave 
      Caption         =   "Save ShoppingBag"
      Height          =   400
      Left            =   3120
      TabIndex        =   13
      Top             =   720
      Width           =   2175
   End
   Begin VB.CommandButton cmdAppend 
      Caption         =   "Append ShoppingBag"
      Height          =   400
      Left            =   3120
      TabIndex        =   12
      Top             =   240
      Width           =   2175
   End
   Begin VB.TextBox txtPrice 
      Height          =   330
      Left            =   1560
      TabIndex        =   11
      Top             =   2040
      Width           =   1215
   End
   Begin VB.TextBox txtTaxValue 
      Height          =   330
      Left            =   1560
      TabIndex        =   9
      Top             =   1680
      Width           =   1215
   End
   Begin VB.TextBox txtDiscount 
      Height          =   330
      Left            =   1560
      TabIndex        =   7
      Top             =   1320
      Width           =   1215
   End
   Begin VB.TextBox txtAmount 
      Height          =   330
      Left            =   1560
      TabIndex        =   5
      Top             =   960
      Width           =   1215
   End
   Begin VB.TextBox txtAccountID 
      Height          =   330
      Left            =   1560
      TabIndex        =   1
      Top             =   600
      Width           =   1215
   End
   Begin VB.TextBox txtItemID 
      Height          =   330
      Left            =   1560
      TabIndex        =   0
      Top             =   240
      Width           =   1215
   End
   Begin VB.Label Label6 
      Caption         =   "Price"
      Height          =   255
      Left            =   240
      TabIndex        =   10
      Top             =   2160
      Width           =   615
   End
   Begin VB.Label Label5 
      Caption         =   "TaxValue"
      Height          =   255
      Left            =   240
      TabIndex        =   8
      Top             =   1800
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "Discount"
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   1440
      Width           =   975
   End
   Begin VB.Label Label3 
      Caption         =   "Amount"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   1080
      Width           =   975
   End
   Begin VB.Label Label2 
      Caption         =   "AccountID"
      Height          =   255
      Left            =   240
      TabIndex        =   3
      Top             =   720
      Width           =   975
   End
   Begin VB.Label Label1 
      Caption         =   "ItemID"
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   360
      Width           =   735
   End
End
Attribute VB_Name = "frmTestShoppingbag"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private PubRs As Recordset


Private Sub cmdAppend_Click()

    cmdAppend.Enabled = False
  PubRs.AddNew
  PubRs!accountid = CInt(txtAccountID.Text)
  PubRs!itemid = CInt(txtItemID.Text)
  PubRs!amount = CInt(txtAmount.Text)
  PubRs!discount = txtDiscount.Text
  PubRs!taxvalue = txtTaxValue.Text
  PubRs!price = txtPrice.Text

    txtAccountID.Text = ""
    txtItemID.Text = ""
    txtAmount.Text = ""
    txtDiscount.Text = ""
    txtTaxValue.Text = ""
    txtPrice.Text = ""
    
    Set Adodc1.Recordset = PubRs
    cmdAppend.Enabled = True

End Sub

Private Sub cmdDelete_Click()
Dim intAccountID As Integer
Dim ObjBag As Object

  intAccountID = CInt(InputBox("Enter AccountID", "Delete shopping bag"))
  
  cmdDelete.Enabled = False
On Error GoTo DeleteError
  Set ObjBag = CreateObject("Ecomm.Shoppingbag")
  
  ObjBag.deleteshoppingbag intAccountID
  
  MsgBox "Delete complete"
  
  cmdDelete.Enabled = True
  
Exit Sub
DeleteError:
    Me.Caption = Err.Description
    cmdDelete.Enabled = True

End Sub

Private Sub cmdLoad_Click()
Dim ObjBag As Object
Dim intAccountID As Integer

intAccountID = CInt(InputBox("Account ID", "Load shopping bag"))

 cmdLoad.Enabled = False
 
Set ObjBag = CreateObject("Ecomm.shoppingbag")

Set Adodc1.Recordset = ObjBag.loadshoppingbag(intAccountID)
 
 cmdLoad.Enabled = True

End Sub

Private Sub cmdSave_Click()
Dim ObjBag As Object
Dim BlnObjBag As Boolean

   cmdSave.Enabled = False
   
On Error GoTo SaveError
Set ObjBag = CreateObject("Ecomm.shoppingbag")

  BlnObjBag = ObjBag.saveshoppingbag(PubRs)
BlnObjBag = True
  
  If BlnObjBag Then
     MsgBox "Save complete"
     
     PubRs.MoveFirst
     Do
        PubRs.Delete
        PubRs.MoveFirst
     Loop Until PubRs.EOF
     
     Set Adodc1.Recordset = PubRs
  Else
     Me.Caption = Err.Description
  End If
     
     cmdSave.Enabled = True
Exit Sub
SaveError:
    Me.Caption = Err.Description
    cmdSave.Enabled = True
End Sub

Private Sub Form_Load()
  Set PubRs = New Recordset
  
  PubRs.Fields.Append "AccountID", adInteger
  PubRs.Fields.Append "ItemId", adInteger
  PubRs.Fields.Append "Amount", adInteger
  PubRs.Fields.Append "Discount", adSingle
  PubRs.Fields.Append "Taxvalue", adSingle
  PubRs.Fields.Append "price", adSingle

  PubRs.Open

End Sub
