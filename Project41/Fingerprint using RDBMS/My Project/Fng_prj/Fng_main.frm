VERSION 5.00
Begin VB.Form FrmImage 
   Caption         =   "Fingerprint "
   ClientHeight    =   6285
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6975
   LinkTopic       =   "Form1"
   ScaleHeight     =   6285
   ScaleWidth      =   6975
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command10 
      Caption         =   "Oriented Field"
      Height          =   495
      Left            =   4680
      TabIndex        =   14
      Top             =   2880
      Width           =   1575
   End
   Begin VB.CommandButton Command9 
      Caption         =   "Open File"
      Height          =   495
      Left            =   4680
      TabIndex        =   13
      Top             =   2280
      Width           =   1575
   End
   Begin VB.TextBox Text2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4680
      TabIndex        =   11
      Top             =   360
      Width           =   1575
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   222
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   4680
      TabIndex        =   9
      Top             =   1200
      Width           =   1575
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Extracting image"
      Height          =   495
      Left            =   2760
      TabIndex        =   8
      Top             =   5280
      Width           =   1575
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Thinning image"
      Height          =   495
      Left            =   720
      TabIndex        =   7
      Top             =   5280
      Width           =   1575
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Post Porcessing 3"
      Height          =   495
      Left            =   4680
      TabIndex        =   6
      Top             =   4680
      Width           =   1575
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Post Processing"
      Height          =   495
      Left            =   4680
      TabIndex        =   5
      Top             =   3480
      Width           =   1575
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Smooth gray image"
      Height          =   495
      Left            =   720
      TabIndex        =   4
      Top             =   4680
      Width           =   1575
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Binary image"
      Height          =   495
      Left            =   2760
      TabIndex        =   3
      Top             =   4680
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Post Processing 2"
      Height          =   495
      Left            =   4680
      TabIndex        =   2
      Top             =   4080
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Post Processing 4"
      Height          =   495
      Left            =   4680
      TabIndex        =   1
      Top             =   5280
      Width           =   1575
   End
   Begin VB.PictureBox picImage 
      AutoRedraw      =   -1  'True
      AutoSize        =   -1  'True
      Height          =   3900
      Left            =   480
      ScaleHeight     =   256
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   256
      TabIndex        =   0
      Top             =   240
      Width           =   3900
   End
   Begin VB.Label Label2 
      Caption         =   "Ride width"
      Height          =   255
      Left            =   4680
      TabIndex        =   12
      Top             =   120
      Width           =   1215
   End
   Begin VB.Label Label1 
      Caption         =   "Ride Counter"
      Height          =   255
      Left            =   4680
      TabIndex        =   10
      Top             =   960
      Width           =   1215
   End
End
Attribute VB_Name = "FrmImage"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private m_cImage As CImageProcess

Public Sub SmoothImage(ByVal eType As EFilterTypes)
    With m_cImage
    .FilterType = eType
    .ProcessImage picImage
    End With
End Sub

Public Sub ThinImage(ByVal eType As EFilterTypes)
    With m_cImage
    .FilterType = eType
    .ProcessImage picImage
    End With
End Sub

Public Sub BinImage(ByVal eType As EFilterTypes)
    With m_cImage
    .FilterType = eType
    .ProcessImage picImage
    End With
End Sub
Public Sub ExtractImage(ByVal eType As EFilterTypes)
    With m_cImage
    .FilterType = eType
    .ProcessImage picImage
    End With
End Sub
Private Sub Command1_Click() ' Post Processing 4
Dim sFile As String
Dim i, j, ex As Integer

sFile = "c:\fng_prj\thin_f0.bmp"
picImage = LoadPicture(sFile)
m_cImage.Post_Pro (4)
For i = 0 To m_cImage.xMax
    For j = 0 To m_cImage.yMax
        ex = m_cImage.feature(i, j)
        If ex <> 0 Then
            'picImage.PSet (i, m_cImage.yMax - j), 254
            picImage.Circle (i, m_cImage.yMax - j), 3, QBColor(11) 'Red
        End If
    Next j
Next i
Text1.Text = m_cImage.RideCount

End Sub

Private Sub Command10_Click()
'Dim block(16, 16) As Integer
Dim i, j As Integer
Dim angle As Double
Dim pi As Double
pi = 3.14159265358979
m_cImage.FilterType = eOriented
m_cImage.OrientedFilter picImage
For i = 1 To 16
    For j = 1 To 16
    angle = m_cImage.OrientedField(i, j) * pi / 180
    If m_cImage.OrientedField(i, j) <= 90 Then
        picImage.Line ((i - 1) * 16, 256 - (j - 1) * 16)-(Int(16 * Cos(angle)) + (i - 1) * 16, 256 - (Int(16 * Sin(angle)) + (j - 1) * 16)), QBColor(14)
   Else
        picImage.Line (i * 16, 256 - (j - 1) * 16)-(Int(16 * Cos(angle)) + i * 16, 256 - (Int(16 * Sin(angle)) + (j - 1) * 16)), QBColor(14)
    End If
    Text2.Text = Text2.Text + " " + Str(m_cImage.OrientedField(i, j))
    Next j
Next i

End Sub

Private Sub Command2_Click() ' Post Processing 2
Dim sFile As String
Dim i, j, ex As Integer

sFile = "c:\fng_prj\thin_f0.bmp"
picImage = LoadPicture(sFile)
m_cImage.Post_Pro (2)
For i = 0 To m_cImage.xMax
    For j = 0 To m_cImage.yMax
        ex = m_cImage.feature(i, j)
        If ex <> 0 Then
            'picImage.PSet (i, m_cImage.yMax - j), 254
            picImage.Circle (i, m_cImage.yMax - j), 3, QBColor(11) 'Red
        End If
    Next j
Next i
Text1.Text = m_cImage.RideCount
End Sub

Private Sub Command3_Click() ' Post Processing 1
Dim sFile As String
Dim i, j, ex As Integer

sFile = "c:\fng_prj\thin_f0.bmp"
picImage = LoadPicture(sFile)
m_cImage.Post_Pro (1)
For i = 0 To m_cImage.xMax
    For j = 0 To m_cImage.yMax
        ex = m_cImage.feature(i, j)
        If ex <> 0 Then
            'picImage.PSet (i, m_cImage.yMax - j), 254
            picImage.Circle (i, m_cImage.yMax - j), 3, QBColor(11) 'Red
        End If
    Next j
Next i
Text1.Text = m_cImage.RideCount
End Sub

Private Sub Command4_Click() 'post processing 3
Dim sFile As String
Dim i, j, ex As Integer

sFile = "c:\fng_prj\thin_f0.bmp"
picImage = LoadPicture(sFile)
m_cImage.Post_Pro (3)
For i = 0 To m_cImage.xMax
    For j = 0 To m_cImage.yMax
        ex = m_cImage.feature(i, j)
        If ex <> 0 Then
            'picImage.PSet (i, m_cImage.yMax - j), 254
            picImage.Circle (i, m_cImage.yMax - j), 3, QBColor(11) 'Red
        End If
    Next j
Next i
Text1.Text = m_cImage.RideCount
End Sub


Private Sub Command5_Click() 'smooth gray image


Dim sFile As String
Dim gray As Boolean

sFile = "c:\fng_prj\_f0.bmp"
picImage = LoadPicture(sFile)
FrmImage.SmoothImage eSmooth

SavePicture picImage, "c:\fng_prj\smg_f0.bmp"
picImage = LoadPicture("c:\fng_prj\smg_f0.bmp")
picImage.Refresh
End Sub

Private Sub Command6_Click() 'binary gray image
Dim sFile As String
Dim gray As Boolean

sFile = "c:\fng_prj\smg_f0.bmp"
picImage = LoadPicture(sFile)

FrmImage.BinImage eBinary

SavePicture picImage, "c:\fng_prj\bin_f0.bmp"
picImage = LoadPicture("c:\fng_prj\bin_f0.bmp")
picImage.Refresh
End Sub

Private Sub Command7_Click() 'thinnig image

Dim sFile As String

sFile = "c:\fng_prj\bin_f0.bmp"
picImage = LoadPicture(sFile)

FrmImage.ThinImage eThin

SavePicture picImage, "c:\fng_prj\thin_f0.bmp"
picImage = LoadPicture("c:\fng_prj\thin_f0.bmp")
picImage.Refresh
End Sub

Private Sub Command8_Click() 'extract image
Dim sFile As String
Dim i, j, ex As Integer

sFile = "c:\fng_prj\thin_f0.bmp"
picImage = LoadPicture(sFile)

m_cImage.RideWidth = Val(Text2.Text)
FrmImage.ExtractImage eExtract
picImage.Cls

For i = 0 To m_cImage.xMax
    For j = 0 To m_cImage.yMax
        ex = m_cImage.feature(i, j)
        If ex <> 0 Then
            'picImage.PSet (i, m_cImage.yMax - j), 254
            picImage.Circle (i, m_cImage.yMax - j), 3, QBColor(11) 'Red
        End If
    Next j
Next i

Text1.Text = m_cImage.RideCount
'SavePicture picImage, "d:\fng_prj\ext_f0.bmp"
'picImage = LoadPicture("d:\fng_prj\ext_f0.bmp")
'picImage.Refresh
End Sub

Private Sub Command9_Click()
    picImage.Picture = LoadPicture("c:\fng_prj\_f1.bmp")
End Sub

Private Sub Form_Load()
    Set m_cImage = New CImageProcess
End Sub


