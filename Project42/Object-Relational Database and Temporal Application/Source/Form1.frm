VERSION 5.00
Object = "{BF448208-70DE-11CF-947B-0020AF75C4BA}#1.0#0"; "navctl32.ocx"
Begin VB.Form Form1 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "SNAPSHOT QUERY"
   ClientHeight    =   7680
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5895
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7680
   ScaleWidth      =   5895
   Begin VB.TextBox Text11 
      Height          =   2445
      Left            =   960
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   5
      Top             =   1320
      Width           =   4695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "CANCEL"
      Height          =   375
      Left            =   3000
      TabIndex        =   11
      Top             =   7200
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Height          =   375
      Left            =   1680
      TabIndex        =   10
      Top             =   7200
      Width           =   1215
   End
   Begin VB.TextBox Text10 
      Height          =   300
      Left            =   7155
      MaxLength       =   30
      TabIndex        =   21
      TabStop         =   0   'False
      Text            =   "metatab.tnftab"
      Top             =   1110
      Width           =   1680
   End
   Begin VB.TextBox Text9 
      Height          =   300
      Left            =   7155
      MaxLength       =   30
      TabIndex        =   19
      TabStop         =   0   'False
      Text            =   "metatab.colname"
      Top             =   720
      Width           =   1800
   End
   Begin VB.TextBox Text8 
      Height          =   300
      Left            =   7155
      MaxLength       =   30
      TabIndex        =   17
      TabStop         =   0   'False
      Text            =   "metatab.tabname"
      Top             =   315
      Width           =   1800
   End
   Begin Navctl32Lib.NavControl NavControl1 
      Height          =   300
      Left            =   6360
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   1680
      Width           =   2310
      _Version        =   65536
      _ExtentX        =   4075
      _ExtentY        =   529
      _StockProps     =   4
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   222
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      DOF             =   -1  'True
      NavigationButtonsVisible=   -1  'True
      ModelFile       =   "f:\users\project\vb\metatab.mlt"
      DataPath        =   ""
      Table           =   "metatab"
      DataGroup       =   "metatab"
      DefaultButtonSize=   1
      SaveButtonVisible=   -1  'True
      QueryButtonVisible=   -1  'True
      QBEButtonVisible=   -1  'True
      InsertButtonVisible=   -1  'True
      DeleteButtonVisible=   -1  'True
      LayoutMode      =   1
      ControlCount    =   14
      Mode01LastWidth =   154
      Mode01LastHeight=   20
      Ctrl0Visible    =   -1  'True
      Ctrl0Style      =   1
      Ctrl0Caption    =   ""
      Ctrl0Width      =   30
      Ctrl0Height     =   20
      Ctrl1ID         =   1
      Ctrl1Visible    =   -1  'True
      Ctrl1Style      =   1
      Ctrl1Caption    =   ""
      Ctrl1Left       =   30
      Ctrl1Width      =   30
      Ctrl1Height     =   20
      Ctrl2ID         =   2
      Ctrl2Visible    =   -1  'True
      Ctrl2Style      =   1
      Ctrl2Caption    =   ""
      Ctrl2Left       =   60
      Ctrl2Width      =   30
      Ctrl2Height     =   20
      Ctrl3ID         =   3
      Ctrl3Visible    =   -1  'True
      Ctrl3Style      =   1
      Ctrl3Caption    =   ""
      Ctrl3Left       =   90
      Ctrl3Width      =   30
      Ctrl3Height     =   20
      Ctrl4ID         =   4
      Ctrl4Style      =   1
      Ctrl4Caption    =   "New"
      Ctrl4Left       =   1404
      Ctrl4Width      =   30
      Ctrl4Height     =   20
      Ctrl5ID         =   5
      Ctrl5Style      =   2
      Ctrl5Caption    =   "metatab - #"
      Ctrl5Left       =   60
      Ctrl5Width      =   107
      Ctrl5Height     =   20
      Ctrl6ID         =   9
      Ctrl6Visible    =   -1  'True
      Ctrl6Style      =   2
      Ctrl6Caption    =   "Query"
      Ctrl6Left       =   120
      Ctrl6Width      =   34
      Ctrl6Height     =   20
      Ctrl7ID         =   10
      Ctrl7Style      =   2
      Ctrl7Caption    =   "Save"
      Ctrl7Left       =   129
      Ctrl7Top        =   40
      Ctrl7Width      =   128
      Ctrl7Height     =   20
      Ctrl8ID         =   11
      Ctrl8Style      =   1
      Ctrl8Caption    =   "Delete"
      Ctrl8Top        =   20
      Ctrl8Width      =   53
      Ctrl8Height     =   20
      Ctrl9ID         =   12
      Ctrl9Style      =   1
      Ctrl9Caption    =   "QBE"
      Ctrl9Left       =   1
      Ctrl9Top        =   20
      Ctrl9Width      =   64
      Ctrl9Height     =   20
      Ctrl10ID        =   100
      Ctrl10Style     =   2
      Ctrl10Caption   =   "Caption!"
      Ctrl10Width     =   22
      Ctrl10Height    =   18
      Ctrl11ID        =   6
      Ctrl11Style     =   1
      Ctrl11Caption   =   ""
      Ctrl11Left      =   1
      Ctrl11Top       =   20
      Ctrl11Width     =   85
      Ctrl11Height    =   20
      Ctrl12ID        =   7
      Ctrl12Style     =   1
      Ctrl12Caption   =   ""
      Ctrl12Left      =   1
      Ctrl12Top       =   20
      Ctrl12Width     =   128
      Ctrl12Height    =   20
      Ctrl13ID        =   8
      Ctrl13Style     =   1
      Ctrl13Caption   =   ""
      Ctrl13Left      =   206
      Ctrl13Top       =   20
      Ctrl13Width     =   51
      Ctrl13Height    =   20
   End
   Begin VB.TextBox Text7 
      Height          =   2535
      Left            =   120
      Locked          =   -1  'True
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   14
      TabStop         =   0   'False
      Top             =   4440
      Width           =   5655
   End
   Begin VB.TextBox Text6 
      Height          =   285
      Left            =   3840
      TabIndex        =   9
      Top             =   3960
      Width           =   1815
   End
   Begin VB.TextBox Text5 
      BackColor       =   &H80000004&
      Height          =   285
      Left            =   1800
      Locked          =   -1  'True
      TabIndex        =   7
      TabStop         =   0   'False
      Top             =   3960
      Width           =   855
   End
   Begin VB.TextBox Text3 
      Height          =   285
      Left            =   960
      TabIndex        =   3
      Top             =   840
      Width           =   4695
   End
   Begin VB.TextBox Text2 
      Height          =   285
      Left            =   2160
      TabIndex        =   1
      Top             =   360
      Width           =   3495
   End
   Begin VB.Label Label10 
      Caption         =   "tnftab"
      Height          =   195
      Left            =   6120
      TabIndex        =   20
      Top             =   1185
      Width           =   720
   End
   Begin VB.Label Label9 
      Caption         =   "colname"
      Height          =   195
      Left            =   6120
      TabIndex        =   18
      Top             =   795
      Width           =   840
   End
   Begin VB.Label Label8 
      Caption         =   "tabname"
      Height          =   195
      Left            =   6120
      TabIndex        =   16
      Top             =   390
      Width           =   840
   End
   Begin VB.Label Label7 
      Caption         =   "SNAPSHOT"
      Height          =   255
      Left            =   1080
      TabIndex        =   13
      Top             =   360
      Width           =   975
   End
   Begin VB.Label Label5 
      Caption         =   "VALID ("
      Height          =   255
      Left            =   1080
      TabIndex        =   12
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label Label6 
      Caption         =   ")  CONTAINS"
      Height          =   255
      Left            =   2760
      TabIndex        =   8
      Top             =   3960
      Width           =   975
   End
   Begin VB.Label Label4 
      Caption         =   "AND"
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   3960
      Width           =   615
   End
   Begin VB.Label Label3 
      Caption         =   "WHERE"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   1320
      Width           =   615
   End
   Begin VB.Label Label2 
      Caption         =   "FROM "
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   840
      Width           =   495
   End
   Begin VB.Label Label1 
      Caption         =   "SELECT"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   360
      Width           =   615
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private SQL92 As String
Private FromTable(1 To 20) As String
Private Splited(1 To 20) As String

'-----------------------------------------------------------------------------------------------------------------------------
Private Function IsCol(ColName As String) As Boolean
IsCol = False
If ColName = Text9.Text Then
    IsCol = True
End If
Do
NavControl1.ddoTable.NextRecord
If IsCol = False And ColName = Text9.Text Then
    IsCol = True
End If
Loop Until NavControl1.ddoTable.CurrentRecord.LastRecord Or IsCol = True
NavControl1.ddoTable.FirstRecord
End Function
'-----------------------------------------------------------------------------------------------------------------------------
Private Sub splitstr(String1 As String)
Dim i, j As Integer
String1 = Trim(String1)
j = 1
i = InStr(String1, " ")
While i <> 0
    Splited(j) = Left(String1, i - 1)
    j = j + 1
    String1 = Trim(Right(String1, Len(String1) - i))
    i = InStr(String1, " ")
    
Wend
Splited(j) = String1
End Sub
'-----------------------------------------------------------------------------------------------------------------------------
Private Function TNFTab(TabName As String, ColName As String) As String
TNFTab = ""
If TabName = Text8.Text And ColName = Text9.Text Then
    TNFTab = Text10.Text
End If
Do
NavControl1.ddoTable.NextRecord
If TNFTab = "" And TabName = Text8.Text And ColName = Text9.Text Then
    TNFTab = Text10.Text
End If
Loop Until NavControl1.ddoTable.CurrentRecord.LastRecord Or TNFTab <> ""
NavControl1.ddoTable.FirstRecord
End Function
'-----------------------------------------------------------------------------------------------------------------------------
Private Function ColName(TabName As String) As String
ColName = ""
If TabName = Text8.Text And Text10.Text = "" Then
    ColName = Text9.Text
End If
Do
NavControl1.ddoTable.NextRecord
If ColName = "" And TabName = Text8.Text And Text10.Text = "" Then
    ColName = Text9.Text
End If
Loop Until NavControl1.ddoTable.CurrentRecord.LastRecord Or ColName <> ""
NavControl1.ddoTable.FirstRecord
End Function
'-----------------------------------------------------------------------------------------------------------------------------
Private Sub Main()
Dim i, j As Integer
Dim TMPStr As String
On Error GoTo EndMain

NavControl1.ddoDataGroup.QueryData

SQL92 = ""
Erase FromTable

SQL92 = "SELECT " & Text2.Text & vbCrLf & "FROM " & Text3.Text

j = 1

FromTable(1) = Trim(Text3.Text)

i = 2

splitstr (Text11.Text)
' find from clause
While Splited(j) <> ""
    TMPStr = TNFTab(Text3.Text, Splited(j))
    If IsCol(Splited(j)) And TMPStr <> "" Then
       SQL92 = SQL92 & "," & TMPStr
       FromTable(i) = TMPStr
    End If
    j = j + 1
Wend
SQL92 = SQL92 & vbCrLf & "WHERE "
j = 1
While Splited(j) <> ""
    TMPStr = TNFTab(Text3.Text, Splited(j))
    If IsCol(Splited(j)) And TMPStr <> "" Then
        SQL92 = SQL92 & Text3.Text & "." & ColName(Text3.Text) & " = " & TMPStr & "." & ColName(Text3.Text) & vbCrLf & "AND "
        Splited(j) = TMPStr & "." & Splited(j)
    ElseIf IsCol(Splited(j)) And TMPStr = "" Then
        Splited(j) = Trim(Text3.Text) & "." & Splited(j)
    End If
    j = j + 1
Wend
j = 1
While Splited(j) <> ""
    If UCase(Splited(j)) = "AND" Then
        SQL92 = SQL92 & vbCrLf
    End If
    SQL92 = SQL92 & Splited(j) & " "
    j = j + 1
Wend

SQL92 = SQL92 & vbCrLf
j = 1
While FromTable(j) <> ""
    SQL92 = SQL92 & "AND " & FromTable(j) & ".VALIDTIMESTART <= " & Text6.Text & vbCrLf _
            & "AND " & FromTable(j) & ".VALIDTIMEEND >= " & Text6.Text & vbCrLf
    j = j + 1
Wend

SQL92 = SQL92 & "AND " & Text3.Text & ".VALIDTIMESTART <= " & Text6.Text & vbCrLf _
        & "AND " & Text3.Text & ".VALIDTIMEEND >= " & Text6.Text & ";"


Text7.Text = SQL92


EndMain:

End Sub
'-----------------------------------------------------------------------------------------------------------------------------
Private Sub Command1_Click()
Main
End Sub
'-----------------------------------------------------------------------------------------------------------------------------
Private Sub Command2_Click()
Unload Form1
End Sub
'-----------------------------------------------------------------------------------------------------------------------------
Private Sub Text3_Change()
Text5.Text = Text3.Text
End Sub
'-----------------------------------------------------------------------------------------------------------------------------
'Private Sub DataDirector_Info()
'[DataDirectorInfoStart]
'NumDataLinks=3
'[DataLink]
'GroupName=metatab
'ControlName=Text10
'ClassId=9
'Synchronize=0
'GetAllData=1
'StoreSelect=1
'SortOrder=0
'SortFlag=0
'DefaultType=0
'TrimTrailingBlanks=0
'[DataLinkButtonInfo]
'[EndDataLinkButtonInfo]
'[DataLinkPath]
'NumElements=1
'[DataLinkPathInfo]
'TableName=metatab
'NumColumns=1
'ColumnName=tnftab
'[EndDataLinkPathInfo]
'[EndDataLinkPath]
'[EndDataLink]
'[DataLink]
'GroupName=metatab
'ControlName=Text8
'ClassId=9
'Synchronize=0
'GetAllData=1
'StoreSelect=1
'SortOrder=0
'SortFlag=0
'DefaultType=1
'TrimTrailingBlanks=0
'[DataLinkButtonInfo]
'[EndDataLinkButtonInfo]
'[DataLinkPath]
'NumElements=1
'[DataLinkPathInfo]
'TableName=metatab
'NumColumns=1
'ColumnName=tabname
'[EndDataLinkPathInfo]
'[EndDataLinkPath]
'[EndDataLink]
'[DataLink]
'GroupName=metatab
'ControlName=Text9
'ClassId=9
'Synchronize=0
'GetAllData=1
'StoreSelect=1
'SortOrder=0
'SortFlag=0
'DefaultType=1
'TrimTrailingBlanks=0
'[DataLinkButtonInfo]
'[EndDataLinkButtonInfo]
'[DataLinkPath]
'NumElements=1
'[DataLinkPathInfo]
'TableName=metatab
'NumColumns=1
'ColumnName=colname
'[EndDataLinkPathInfo]
'[EndDataLinkPath]
'[EndDataLink]
'[DataDirectorInfoEnd]
'End Sub
