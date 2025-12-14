VERSION 5.00
Object = "{00028C51-0000-0000-0000-000000000046}#1.0#0"; "TDBGS32.OCX"
Object = "{831FDD16-0C5C-11D2-A9FC-0000F8754DA1}#2.0#0"; "MSCOMCTL.OCX"
Begin VB.Form Result 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "แสดงผล"
   ClientHeight    =   6585
   ClientLeft      =   990
   ClientTop       =   1290
   ClientWidth     =   9720
   LinkTopic       =   "Form4"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6585
   ScaleWidth      =   9720
   StartUpPosition =   2  'CenterScreen
   Begin TrueDBGridStd.TDBGridS TDBGridS1 
      Height          =   4440
      Left            =   180
      OleObjectBlob   =   "result.frx":0000
      TabIndex        =   2
      Top             =   180
      Width           =   9375
   End
   Begin MSComctlLib.StatusBar StatusBar1 
      Align           =   2  'Align Bottom
      Height          =   375
      Left            =   0
      TabIndex        =   6
      Top             =   6210
      Width           =   9720
      _ExtentX        =   17145
      _ExtentY        =   661
      SimpleText      =   "Status"
      _Version        =   393216
      BeginProperty Panels {8E3867A5-8586-11D1-B16A-00C0F0283628} 
         NumPanels       =   3
         BeginProperty Panel1 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            AutoSize        =   1
            Object.Width           =   13423
            MinWidth        =   8819
         EndProperty
         BeginProperty Panel2 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   6
            Alignment       =   1
            Object.Width           =   1587
            MinWidth        =   1587
            TextSave        =   "27/3/43"
         EndProperty
         BeginProperty Panel3 {8E3867AB-8586-11D1-B16A-00C0F0283628} 
            Style           =   5
            Alignment       =   1
            Object.Width           =   1587
            MinWidth        =   1587
            TextSave        =   "15:59"
         EndProperty
      EndProperty
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.CommandButton Command2 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Back"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   1860
      Style           =   1  'Graphical
      TabIndex        =   1
      ToolTipText     =   "กลับไปหน้าค้นหา"
      Top             =   5460
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      BackColor       =   &H0080C0FF&
      Caption         =   "&Detail.."
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   435
      Left            =   6360
      Style           =   1  'Graphical
      TabIndex        =   0
      ToolTipText     =   "แสดงรายรายละเอียดที่ Curser ชี้"
      Top             =   5460
      Width           =   1335
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   300
      Left            =   5160
      TabIndex        =   5
      Top             =   4980
      Width           =   435
   End
   Begin VB.Label Label1 
      Caption         =   "Row(s)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Index           =   1
      Left            =   5700
      TabIndex        =   4
      Top             =   5040
      Width           =   675
   End
   Begin VB.Label Label1 
      Caption         =   "ผลของการค้นหามีทั้งหมด"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FF0000&
      Height          =   255
      Index           =   0
      Left            =   3060
      TabIndex        =   3
      Top             =   5040
      Width           =   2055
   End
End
Attribute VB_Name = "Result"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public oVTableDetail As ddoTable
Dim oVTableResult As ddoTable      'This Virtual Table for Result Form only
Dim SQLDetail As String
Dim ColumnName() As String
Const StatusStart As String = "Status : "

Private Sub Command1_Click()
Me.Hide
oVTableResult.GotoRecord (TDBGridS1.Row + 1)
StatusBar1.Panels(1).Text = StatusStart + "กำลังค้นหา...  โปรดรอสักครู่"
Command1.MousePointer = 11
Select Case MenuClient.TypeSearch
    Case 0
        SQLDetail = "execute function getdetailbook(""" + oVTableResult.Columns(1).Value + """)"
        MainScreen.oDataGroupBook.BeginTransaction
        Set oVTableDetail = MainScreen.oDataGroupBook.ExecuteSQLCommand(SQLDetail)
        MainScreen.oDataGroupBook.CommitTransaction
        Load DetailBook
        DetailBook.Show vbModal
     Case 1
        SQLDetail = "execute function getdetailmusic(""" + oVTableResult.Columns(1).Value + """)"
        MainScreen.oDataGroupMusic.BeginTransaction
        Set oVTableDetail = MainScreen.oDataGroupMusic.ExecuteSQLCommand(SQLDetail)
        MainScreen.oDataGroupMusic.CommitTransaction
        Load DetailSong
        DetailSong.Show vbModal
    Case 2
        SQLDetail = "execute function getdetailmovie(""" + oVTableResult.Columns(1).Value + """)"
        MainScreen.oDataGroupMovie.BeginTransaction
        Set oVTableDetail = MainScreen.oDataGroupMovie.ExecuteSQLCommand(SQLDetail)
        MainScreen.oDataGroupMovie.CommitTransaction
        Load DetailMovie
        DetailMovie.Show vbModal
End Select
End Sub

Private Sub Command2_Click()
Unload Me
Select Case MenuClient.TypeSearch
    Case 0
        SearchBook.Show
        MainScreen.oDataGroupBook.DeleteVirtualTable ("oVTableBook")
    Case 1
        SearchSong.Show
        MainScreen.oDataGroupMusic.DeleteVirtualTable ("oVTableMusic")
    Case 2
        Searchmovie.Show
        MainScreen.oDataGroupMovie.DeleteVirtualTable ("oVTableMovie")
End Select
End Sub

Private Sub Form_Activate()
StatusBar1.Panels(1).Text = StatusStart + "แสดงผลของการค้นหา"
Command1.MousePointer = 0
End Sub

Private Sub Form_Load()

StatusBar1.Panels(1).Text = StatusStart
Select Case MenuClient.TypeSearch
    Case 0
        Set oVTableResult = SearchBook.oVTableBook
        ReDim ColumnName(4)
        ColumnName(0) = "BookCode"
        ColumnName(1) = "BookName"
        ColumnName(2) = "BookCatalog"
        ColumnName(3) = "Publishing"
        ColumnName(4) = "Year"
    Case 1
        Set oVTableResult = SearchSong.oVTableMusic
        ReDim ColumnName(6)
        ColumnName(0) = "SongCode"
        ColumnName(1) = "SongName"
        ColumnName(2) = "Arthist"
        ColumnName(3) = "Album"
        ColumnName(4) = "Year"
        ColumnName(5) = "Genre"
        ColumnName(6) = "Publishing"
      Case 2
        Set oVTableResult = Searchmovie.oVTableMovie
        ReDim ColumnName(4)
        ColumnName(0) = "MovieCode"
        ColumnName(1) = "MovieName"
        ColumnName(2) = "Category"
        ColumnName(3) = "Year"
        ColumnName(4) = "Publishing"
End Select
Call ClearGrid
Label2.Caption = oVTableResult.ResultSetCount
Label2.Caption = oVTableResult.TotalRecordCount
End Sub
Private Sub TDBGridS1_UnboundReadData(ByVal RowBuf As TrueDBGridStd.RowBuffer, StartLocation As Variant, ByVal ReadPriorRows As Boolean)
  ' Display SearchBook.oVTableBook in grdResult
    Dim i, j, r As Integer
    Dim BOT As Boolean, EOT As Boolean
        'check if the oTable exist
    If oVTableResult Is Nothing Then
        RowBuf.RowCount = 0
        Exit Sub
    End If
    ' StartLocation - If NULL, then the grid is empty
    ' ReadPriorRows - If True, read in a reverse direction otherwise read in a forward direction.
     r = 0
    ' StartLocation is the row immediately before the current record when fetching
    ' in a forward direction, and immediately after when fetching in a reverse direction.
    If IsNull(StartLocation) Then
        ' StartLocation is NULL so fetching is either at end or beginning of record set. If
        ' have already fetched data (ReadPriorRows = True) then goto LastRecord. Otherwise
        ' goto FirstRecord.
        If ReadPriorRows Then
            oVTableResult.LastRecord
            BOT = False
            EOT = False
        Else
            oVTableResult.FirstRecord
            BOT = False
            EOT = False
        End If
    Else
            'Set the current record to the StartLocation
            oVTableResult.GotoRecord (StartLocation)
        ' StartLocation not NULL, update record pointer
        If ReadPriorRows Then
            If oVTableResult.PreviousRecord Then
                BOT = False
                EOT = False
            Else
                BOT = True
                EOT = False
            End If
        Else
            If oVTableResult.NextRecord Then
                EOT = False
                BOT = False
            Else
                EOT = True
                BOT = False
            End If
        End If
    End If
    ' Loop over the row buffer and add the desired rows to the grid
    For i = 0 To RowBuf.RowCount - 1
        ' Exit if at the end of the record list
       If BOT Or EOT Then
            Exit For
        End If
        ' Loop over the columns and add the column values to the grid
        For j = 0 To oVTableResult.Columns.Count - 1
            RowBuf.Value(i, j) = oVTableResult.Columns(j + 1).Value
        Next j
        ' Use the current record number as the bookmarks
        RowBuf.Bookmark(i) = oVTableResult.CurrentRecordNumber
        If ReadPriorRows Then
            If oVTableResult.PreviousRecord Then
                BOT = False
            Else
                BOT = True
            End If
        Else
            If oVTableResult.NextRecord Then
                EOT = False
            Else
                EOT = True
            End If
        End If
                r = r + 1
    Next i
   'Go back to firstRecord we
    'it is not already
    oVTableResult.FirstRecord
    RowBuf.RowCount = r
End Sub

Private Sub ClearGrid()
    Dim c As Object
    Dim i As Integer
    Dim rc As Integer
    rc = 0
   ' Remove all the columns from the grid
    For i = TDBGridS1.Columns.Count To 0 Step -1
        If i = 0 Then Exit For
        TDBGridS1.Columns.Remove (i - 1)
    Next i
    Call SetNameColumn
End Sub
Private Sub SetNameColumn()
        For i = 0 To oVTableResult.Columns.Count - 1
             Set c = TDBGridS1.Columns.Add(i)
                 With c
                     .Visible = True
                     .Caption = UCase(ColumnName(i))
                     ' Set column locking, which specifies if a column is
                     ' read-only (i.e., the user cannot edit that column)
                     .Locked = True
                 End With
        Next i
End Sub
