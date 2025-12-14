VERSION 5.00
Begin VB.Form MainScreen 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   0  'None
   Caption         =   "Virtual Library 1.0"
   ClientHeight    =   5565
   ClientLeft      =   2955
   ClientTop       =   2070
   ClientWidth     =   6750
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   MousePointer    =   4  'Icon
   ScaleHeight     =   5565
   ScaleWidth      =   6750
   ShowInTaskbar   =   0   'False
   Begin VB.Frame Frame1 
      Height          =   5475
      Left            =   120
      TabIndex        =   0
      Top             =   0
      Width           =   6495
      Begin VB.Label Label7 
         Caption         =   "Warning : ËéÒÁ·Ó¡ÒÃ´Ñ´á»Å§á¡éä¢ã¹ÊèÇ¹¢Í§â¤é´ã´ æ "
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00C000C0&
         Height          =   315
         Left            =   480
         TabIndex        =   5
         Top             =   4620
         Width           =   4395
      End
      Begin VB.Image Image1 
         BorderStyle     =   1  'Fixed Single
         Height          =   2535
         Left            =   180
         Picture         =   "MainScreen.frx":0000
         Stretch         =   -1  'True
         Top             =   540
         Width           =   3375
      End
      Begin VB.Label Label4 
         Alignment       =   2  'Center
         Caption         =   "Version 1.0"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   14.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   495
         Index           =   0
         Left            =   3900
         TabIndex        =   4
         Top             =   3780
         Width           =   1695
      End
      Begin VB.Label Label3 
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Kingmongkut's Institute of Technology Ladkrabang"
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
         Height          =   675
         Left            =   3720
         TabIndex        =   3
         Top             =   1800
         Width           =   2655
      End
      Begin VB.Label Label2 
         Caption         =   "Virtual Library"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   14.25
            Charset         =   222
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FF0000&
         Height          =   435
         Left            =   480
         TabIndex        =   2
         Top             =   3780
         Width           =   2535
      End
      Begin VB.Label Label1 
         Caption         =   "License To :"
         BeginProperty Font 
            Name            =   "MS Serif"
            Size            =   13.5
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   255
         Left            =   4020
         TabIndex        =   1
         Top             =   780
         Width           =   1815
      End
   End
   Begin VB.Menu Logon 
      Caption         =   "&Log on"
      Begin VB.Menu User 
         Caption         =   "&User"
         Shortcut        =   ^U
      End
      Begin VB.Menu Administrator 
         Caption         =   "&Administrator"
         Shortcut        =   ^A
      End
   End
End
Attribute VB_Name = "MainScreen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim oEngine1 As ddoEngine
Dim oProject1 As ddoProject
Dim oModel1 As ddoModel
Public oDataGroupBook As ddoDataGroup
Public oDataGroupMusic As ddoDataGroup
Public oDataGroupMovie As ddoDataGroup
Const PathModel As String = "E:\Project\ProjectVB\VirtualLibrary\Model\VirtualLibraryN.mlt"

Private Sub Administrator_Click()
Login.Show vbModal
End Sub

Private Sub Form_Load()
Set oEngine1 = CreateObject("DataDirector.Engine")
Set oEngine1 = New ddoEngine
Set oProject1 = oEngine1.CreateProject
oProject1.Name = "Virtual Library2.0"
Set oModel1 = oEngine1.CreateModel(PathModel)
'Create DataGroup for Book Parameter ->(Master table,Name DataGroup,Name Model)
Set oDataGroupBook = oProject1.CreateDataGroup("BOOK", "BOOK1", PathModel)
'Create DataGroup for Music Parameter ->(Master table,Name DataGroup,Name Model)
Set oDataGroupMusic = oProject1.CreateDataGroup("MUSIC", "MUSIC1", PathModel)
'Create DataGroup for Movie Parameter ->(Master table,Name DataGroup,Name Model)
Set oDataGroupMovie = oProject1.CreateDataGroup("MOVIE", "MOVIE1", PathModel)
End Sub

Private Sub User_Click()
Unload MainScreen
MenuClient.Show
End Sub
